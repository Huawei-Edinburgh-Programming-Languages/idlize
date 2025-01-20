import { 
    CJLanguageWriterCore, 
    JavaLanguageWriterCore, 
    LanguageExpression
} from "@idlize/core"

export class CJLanguageWriter extends CJLanguageWriterCore {
    override makeRuntimeTypeGetterCall(value: string): LanguageExpression {
        let methodCall = this.makeMethodCall("Ark_Object", "getRuntimeType", [this.makeString(value)])
        return this.makeString(methodCall.asString() + '.ordinal')
    }
}

export class JavaLanguageWriter extends JavaLanguageWriterCore {
    override makeRuntimeTypeGetterCall(value: string): LanguageExpression {
        return this.makeMethodCall("Ark_Object", "getRuntimeType", [this.makeString(value)])
    }
}