import * as core from "@idlizer/core"
import { PeersConstructions } from "../constuctions/PeersConstructions"
import { Config } from "./Config"

export interface UnchangedBody {
    creates: Readonly<core.Method>[],
    updates: Readonly<core.Method>[],
    getters: Readonly<core.Method>[],
    regular: Readonly<core.Method>[],
}

export interface Body {
    creates: Readonly<core.Method>[],
    updates: Readonly<core.Method>[],
    getters: Readonly<core.Method>[],
    regular: Readonly<core.Method>[],
}

export interface Resolver extends core.ReferenceResolver {
    isHeir(type: core.IDLReferenceType | core.IDLInterface, name: string): boolean
    isPeer(type: core.IDLReferenceType | core.IDLInterface): boolean
}

export interface Importer {
    importEnum(name: string): string
    importPeer(name: string): string
    importReexport(name: string): string
}

export class SimpleConverter extends core.TSTypeNameConvertor {
    constructor(resolver: core.ReferenceResolver) {
        super(resolver)
    }

    private dropNsAndDataPrefix(node: core.IDLNamedNode): string {
        const prefix = Config.dataClassPrefix
        let result = node.name.split('.').at(-1)! // drop namespace
        result = result.startsWith(prefix) ? result.slice(prefix.length) : result
        //console.log(`convert ${node.name} => ${result}`);
        return result
    }

    override convertInterface(node: core.IDLInterface): string {
        return this.dropNsAndDataPrefix(node)
    }

    override convertTypeReference(node: core.IDLReferenceType): string {
        return this.dropNsAndDataPrefix(node)
    }

   override convertContainer(type: core.IDLContainerType): string {
       if (core.IDLContainerUtils.isSequence(type)) {
            return `readonly ${super.convert(type.elementType[0])}[]`
       }
       return super.convertContainer(type)
   }

    override convertPrimitiveType(type: core.IDLPrimitiveType): string {
        switch (type) {
            case core.IDLI8Type:
            case core.IDLU8Type:
            case core.IDLI16Type:
            case core.IDLU16Type:
            case core.IDLU32Type:
            case core.IDLI64Type:
            case core.IDLU64Type:
            case core.IDLF64Type:
            case core.IDLNumberType:
            case core.IDLI32Type:
            case core.IDLF32Type:
                return 'number'
            case core.IDLPointerType:
                return 'KNativePointer'
       }
       return super.convertPrimitiveType(type)
   }
}

export class ImporterResolverProxy implements Resolver, Importer {
    constructor(
        private resolver: Resolver,
        private _seen?: string[]
    ) {}

    resolveTypeReference(type: core.IDLReferenceType, terminalImports?: boolean): core.IDLEntry | undefined {
        const entry = this.resolver.resolveTypeReference(type, terminalImports)
        if (!entry) {
            return undefined
        }

        if (core.isEnum(entry)) {
            this.importEnum(entry.name)

        } else if (core.isInterface(entry) && this.resolver.isPeer(entry)) {
            this.importPeer(entry.name)
        }

        return entry
    }

    toDeclaration = this.resolver.toDeclaration.bind(this.resolver)
    isHeir = this.resolver.isHeir.bind(this.resolver)
    isPeer = this.resolver.isPeer.bind(this.resolver)

    importEnum(name: string): string {
        return this.import(name, '../Es2PandaEnums')
    }

    importPeer(name: string): string {
        return this.import(name, name)
    }

    importReexport(name: string): string {
        return this.import(name, '../reexport')
    }

    public asStrings(): string[] {
        return this.imports.sort()
    }

    private import(name: string, from: string): string {
        if (this.seen.has(name)) {
            return name
        }

        this.seen.add(name);
        this.imports.push(PeersConstructions.import(name, from))
        return name
    }

    private seen = new Set<string>([
        Config.astNodeCommonAncestor,
        Config.defaultAncestor,
        ...(this._seen ?? [])
    ])

    private imports: string[] = []
}

export class InteropConvertor extends core.CppInteropArgConvertor {
    constructor(
        private resolver: Resolver,
        public undefined = 'UNDEFINED*'
    ) { super() }

    override convertTypeReference(ref: core.IDLReferenceType): string {
        const type = this.resolver.resolveTypeReference(ref)
        if (!type) {
           throw `Unresolved reference: ${ref.name}!`
        } else if (core.isInterface(type)) {
           return `KNativePointer`
        } else if (core.isEnum(type)) {
           return `KInt`
        }
        return this.undefined
    }

    override convertContainer(type: core.IDLContainerType): string {
        if (core.IDLContainerUtils.isSequence(type)) {
            return `KNativePointerArray`
        }
        return this.undefined
    }

   override convertOptional(type: core.IDLOptionalType): string {
        return `KNativePointer`
    }

    override convertPrimitiveType(type: core.IDLPrimitiveType): string {
        switch (type) {
            case core.IDLU64Type: return "KULong"
            case core.IDLU32Type: return "KUInt"
            case core.IDLF64Type: return "KDouble"
            case core.IDLF32Type: return "KFloat"
            case core.IDLF16Type: return "short float"
            case core.IDLVoidType: return "void"
            default:
        }
        return super.convertPrimitiveType(type)
    }
}
