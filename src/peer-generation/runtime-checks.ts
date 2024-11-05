import { generateTypeCheckerName, LanguageExpression, LanguageWriter } from "./LanguageWriters";
import { ArgConvertor, RuntimeType } from "./ArgConvertors";

const builtInInterfaceTypes = new Map<string,
    (writer: LanguageWriter, value: string) => LanguageExpression>([
        ["Resource",
            (writer: LanguageWriter, value: string) => writer.makeCallIsResource(value)],
        ["Object",
            (writer: LanguageWriter, value: string) => writer.makeCallIsObject(value)],
        ["ArrayBuffer",
            (writer: LanguageWriter, value: string) => writer.makeCallIsArrayBuffer(value)]
    ],
)

export function makeInterfaceTypeCheckerCall(
    valueAccessor: string,
    interfaceName: string,
    allFields: string[],
    duplicates: Set<string>,
    writer: LanguageWriter,
): LanguageExpression {
    if (builtInInterfaceTypes.has(interfaceName)) {
        return builtInInterfaceTypes.get(interfaceName)!(writer, valueAccessor)
    }
    return writer.makeMethodCall(
        "TypeChecker",
        generateTypeCheckerName(interfaceName),
        [
            writer.makeString(valueAccessor),
            ...allFields.map(it => {
                return writer.makeString(duplicates.has(it) ? "true" : "false")
            })
        ]
    )
}

export class UnionRuntimeTypeChecker {
    private conflictingConvertors: Set<ArgConvertor> = new Set()
    private allMembers: Set<string> = new Set()
    private duplicateMembers: Set<string> = new Set()
    private discriminators: [LanguageExpression | undefined, ArgConvertor, number][] = []

    constructor(private convertors: ArgConvertor[]) {
        this.checkConflicts()
    }
    private checkConflicts() {
        const runtimeTypeConflicts: Map<RuntimeType, ArgConvertor[]> = new Map()
        this.convertors.forEach(conv => {
            conv.runtimeTypes.forEach(rtType => {
                const convertors = runtimeTypeConflicts.get(rtType)
                if (convertors) convertors.push(conv)
                else runtimeTypeConflicts.set(rtType, [conv])
            })
        })
        runtimeTypeConflicts.forEach((convertors, rtType) => {
            if (convertors.length > 1) {
                if (rtType === RuntimeType.OBJECT) {
                    convertors.forEach(convertor => {
                        convertor.getMembers().forEach(member => {
                            if (this.allMembers.has(member)) this.duplicateMembers.add(member)
                            this.allMembers.add(member)
                        })
                    })
                }
                convertors.forEach(convertor => {
                    this.conflictingConvertors.add(convertor)
                })
            }
        })
    }
    makeDiscriminator(value: string, index: number, writer: LanguageWriter): LanguageExpression {
        const convertor = this.convertors[index]
        if (this.conflictingConvertors.has(convertor) && writer.language.needsUnionDiscrimination) {
            const discriminator = convertor.unionDiscriminator(value, index, writer, this.duplicateMembers)
            this.discriminators.push([discriminator, convertor, index])
            if (discriminator) return discriminator
        }
        return writer.makeNaryOp("||", convertor.runtimeTypes.map(it =>
            writer.makeNaryOp("==", [
                writer.makeUnionVariantCondition(
                    convertor,
                    value,
                    `${value}_type`,
                    RuntimeType[it],
                    index)])))
    }
    reportConflicts(context: string | undefined) {
        if (this.discriminators.filter(([discriminator, _, __]) => discriminator === undefined).length > 1) {
            console.log(`WARNING: runtime type conflict in "${context}`)
            this.discriminators.forEach(([discr, conv, n]) =>
                console.log(`   ${n} : ${conv.constructor.name} : ${discr ? discr.asString() : "<undefined>"}`))
        }
    }
}