import * as ts from "typescript"
import { IndentedPrinter } from "../IndentedPrinter"
import { ArgConvertor, FunctionConvertor } from "./Convertors"
import { DeclarationTable, PrimitiveType } from "./DeclarationTable"
import { LanguageWriter, Method, MethodModifier, NamedMethodSignature, StringExpression, TSLanguageWriter, Type } from "./LanguageWriters"
import { PeerClass } from "./PeerClass"
import { PeerLibrary } from "./PeerLibrary"
import { PeerMethod } from "./PeerMethod"
import { makePeerEvents } from "./FileGenerators"

export const PeerEventKind = "PeerEventKind"
const PeerNodeType = new Type('number')
const BufferType = new Type('DeserializerBase')
export const EventDeserializeMethodName = "deserialize"

function tempGenerateDeserializer(varName: string, type: ts.TypeNode) {
    // TODO here is ArgConvertors should do their work
    switch (type.getText()) {
        case "number":
            return `${varName}.readNumber()!`
        case "string":
            return `${varName}.readString()!`
        default:
            console.log(type.getText())
            throw new Error(`Not implemented`)
    }
}

export type CallbackInfo = {
    componentName: string,
    methodName: string,
    args: {name: string, type: ts.TypeNode, nullable: boolean}[],
    returnTarget: ts.TypeNode,
}

export function collectCallbacks(library: PeerLibrary): CallbackInfo[] {
    let callbacks: CallbackInfo[] = []
    for (const file of library.files) {
        for (const peer of file.peers.values()) {
            for (const method of peer.methods) {
                for (const conv of method.argConvertors) {
                    const info = convertToCallback(peer, method, conv)
                    if (info && canProcessCallback(library.declarationTable, info))
                        callbacks.push(info)
                }
            }
        }
    }
    return callbacks
}

export function canProcessCallback(declarationTable: DeclarationTable, callback: CallbackInfo): boolean {
    return callback.args.every(it => {
        // TODO waiting for ArgConvertor supports ts deserialization and C serialization
        return ['number', 'string'].includes(it.type.getText())
    })
}

export function convertToCallback(peer: PeerClass, method: PeerMethod, conv: ArgConvertor): CallbackInfo | undefined {
    if (method.method.modifiers?.includes(MethodModifier.STATIC))
        return
    if (!(conv instanceof FunctionConvertor))
        return
    return {
        componentName: peer.componentName,
        methodName: method.method.name,
        args: conv.args,
        returnTarget: conv.returnType,
    }
}

export function callbackIdByInfo(info: CallbackInfo): string {
    return `${info.componentName}_${info.methodName}`
}

export function callbackEventNameByInfo(info: CallbackInfo): string {
    return `${callbackIdByInfo(info)}_event`
}

class EventsVisitor {
    readonly writer: LanguageWriter = new TSLanguageWriter(new IndentedPrinter())
    readonly eventsWriter: LanguageWriter = new TSLanguageWriter(new IndentedPrinter())

    constructor(
        private readonly library: PeerLibrary,
    ) {}

    private printEventsClasses(infos: CallbackInfo[]) {
        for (const info of infos) {
            const eventClassName = callbackEventNameByInfo(info)
            this.eventsWriter.writeClass(eventClassName, (writer) => {
                const constructorSignature = new NamedMethodSignature(
                    Type.Void,
                    [PeerNodeType, ...info.args.map(it => new Type(it.type.getText(), it.nullable))],
                    ['nodeId', ...info.args.map(it => it.name)],
                )
                info.args.forEach(arg => {
                    writer.writeFieldDeclaration(
                        arg.name, 
                        new Type(arg.type.getText(), arg.nullable),
                        ["public", "readonly"],
                        arg.nullable,
                    )
                })
                writer.writeConstructorImplementation(eventClassName, constructorSignature, (writer) => {
                    writer.writeSuperCall([`${PeerEventKind}.${callbackIdByInfo(info)}`, 'nodeId'])
                    info.args.forEach((arg) => {
                        writer.print(`this.${arg.name} = ${arg.name}`)
                    })
                })
                const deserializeSignature = new NamedMethodSignature(
                    new Type(callbackEventNameByInfo(info)),
                    [BufferType],
                    ['buffer'],
                )
                writer.writeMethodImplementation(new Method(EventDeserializeMethodName, deserializeSignature, [MethodModifier.STATIC]), writer => {
                    writer.print(`return new ${eventClassName}(`)
                    writer.pushIndent()
                    writer.print(`buffer.readInt32(),`)
                    info.args.forEach((arg) => {
                        writer.print(`${tempGenerateDeserializer('buffer', arg.type)},`)
                    })
                    writer.popIndent()
                    writer.print(`)`)
                })
            }, 'PeerEvent')
        }
    }

    private printEventsEnum(infos: CallbackInfo[]) {
        this.eventsWriter.print(`enum ${PeerEventKind} {`)
        this.eventsWriter.pushIndent()

        infos.forEach((value, index) => {
            this.eventsWriter.print(`${callbackIdByInfo(value)} = ${index},`)
        })

        this.eventsWriter.popIndent()
        this.eventsWriter.print(`}`)
    }

    private printNameByKindRetriever(infos: CallbackInfo[]) {
        this.eventsWriter.print(`export function getEventNameByKind(kind: ${PeerEventKind}): string {`)
        this.eventsWriter.pushIndent()
        this.eventsWriter.print(`switch (kind) {`)
        this.eventsWriter.pushIndent()
        for (const info of infos) {
            this.eventsWriter.print(`case ${PeerEventKind}.${callbackIdByInfo(info)}: return "${info.methodName}"`)
        }
        this.eventsWriter.popIndent()
        this.eventsWriter.print('}')
        this.eventsWriter.popIndent()
        this.eventsWriter.print('}')
    }

    private printParseFunction(infos: CallbackInfo[]) {
        this.eventsWriter.print(`export function deserializePeerEvent(buffer: DeserializerBase): PeerEvent {`)
        this.eventsWriter.pushIndent()
        this.eventsWriter.writeStatement(this.eventsWriter.makeAssign(
            'kind', 
            new Type(PeerEventKind), 
            new StringExpression(`buffer.readInt32()`),
            true,
        ))

        this.eventsWriter.print(`switch (kind) {`)
        this.eventsWriter.pushIndent()
        for (const info of infos) {
            this.eventsWriter.print(`case ${PeerEventKind}.${callbackIdByInfo(info)}: return ${callbackEventNameByInfo(info)}.deserialize(buffer)`)
        }
        this.eventsWriter.popIndent()
        this.eventsWriter.print('}')

        this.eventsWriter.popIndent()
        this.eventsWriter.print('}')
    }

    private printProperties(infos: CallbackInfo[]) {
        const getTextOrVoid = (type: ts.TypeNode): string => {
            if (this.library.declarationTable.toTarget(type) === PrimitiveType.Undefined)
                return 'void'
            return type.getText()
        }
        this.eventsWriter.writeInterface('PeerEventsProperties', writer => {
            for (const info of infos) {
                const signature = new NamedMethodSignature(
                    new Type('void'),
                    info.args.map(it => new Type(getTextOrVoid(it.type))),
                    info.args.map(it => it.name),
                )
                writer.writeMethodDeclaration(info.methodName, signature)
            }
        })
    }

    print(): void {
        const callbacks = collectCallbacks(this.library)
        this.printEventsClasses(callbacks)
        this.printEventsEnum(callbacks)
        this.printNameByKindRetriever(callbacks)
        this.printParseFunction(callbacks)
        this.printProperties(callbacks)
    }
}

export function printEvents(library: PeerLibrary): string {
    const visitor = new EventsVisitor(library)
    visitor.print()
    return makePeerEvents(visitor.eventsWriter.getOutput().join("\n"))
}