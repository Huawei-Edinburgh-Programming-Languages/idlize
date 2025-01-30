import * as idl from "./idl"
import { Language } from "./Language";
import { IdlNameConvertor } from "./LanguageWriters";
import { ArgConvertor } from "./LanguageWriters/ArgConvertors";
import { ReferenceResolver } from "./peer-generation/ReferenceResolver";

export interface LibraryFileInterface {
    get entries(): idl.IDLEntry[]
}

// todo: TypeProcessor? LibraryBase?
export interface LibraryInterface extends ReferenceResolver {
    language: Language
    get files(): LibraryFileInterface[]
    typeConvertor(param: string, type: idl.IDLType, isOptionalParam?: boolean): ArgConvertor
    createTypeNameConvertor(language: Language): IdlNameConvertor
    getInteropName(node: idl.IDLNode): string
    createContinuationCallbackReference(continuationType: idl.IDLType): idl.IDLReferenceType
    getCurrentContext(): string | undefined
    /**
     * todo: is it really needed?
     */
    libraryPrefix: string
}