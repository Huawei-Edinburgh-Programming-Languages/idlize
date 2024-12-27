package idlize

public interface XmlSerializerInterface {
    public func setAttributes(name: String, value: String): Unit
    public func addEmptyElement(name: String): Unit
    public func setDeclaration(): Unit
    public func startElement(name: String): Unit
    public func endElement(): Unit
    public func setNamespace(prefix: String, namespace: String): Unit
    public func setComment(text: String): Unit
    public func setCDATA(text: String): Unit
    public func setText(text: String): Unit
    public func setDocType(text: String): Unit
}
public interface ParseInfoInterface {
    public func getColumnNumber(): Float64
    public func getDepth(): Float64
    public func getLineNumber(): Float64
    public func getName(): String
    public func getNamespace(): String
    public func getPrefix(): String
    public func getText(): String
    public func isEmptyElementTag(): Bool
    public func isWhitespace(): Bool
    public func getAttributeCount(): Float64
}
public interface XmlPullParserInterface {
    public func parse(option: ParseOptions): Unit
}
public open class XmlSerializer <: XmlSerializerInterface {
    var peer: Finalizable
    XmlSerializer(buffer: String, encoding: Option<String>) {
        let thisSerializer: Serializer = Serializer.hold()
        var encoding_type: Int32 = RuntimeType.UNDEFINED.ordinal
        encoding_type = Ark_Object.getRuntimeType(encoding).ordinal
        thisSerializer.writeInt8(Int8(encoding_type))
        if (let Some(encoding) <- encoding) {
            let encoding_value = encoding
            thisSerializer.writeString(encoding_value)
        }
        this.peer = Finalizable(NativeModule._XmlSerializer_ctor(thisSerializer.asArray(), thisSerializer.length()), XmlSerializer.getFinalizer())
        thisSerializer.release();
    }
    static func getFinalizer(): UInt64 {
        return NativeModule._XmlSerializer_getFinalizer()
    }
    func getPeer(): Option<Finalizable> {
        return this.peer
    }
    public func setAttributes(name: String, value: String): Unit {
        NativeModule._XmlSerializer_setAttributes(this.peer.ptr, name, value);
    }
    public func addEmptyElement(name: String): Unit {
        NativeModule._XmlSerializer_addEmptyElement(this.peer.ptr, name);
    }
    public func setDeclaration(): Unit {
        NativeModule._XmlSerializer_setDeclaration(this.peer.ptr);
    }
    public func startElement(name: String): Unit {
        NativeModule._XmlSerializer_startElement(this.peer.ptr, name);
    }
    public func endElement(): Unit {
        NativeModule._XmlSerializer_endElement(this.peer.ptr);
    }
    public func setNamespace(prefix: String, namespace: String): Unit {
        NativeModule._XmlSerializer_setNamespace(this.peer.ptr, prefix, namespace);
    }
    public func setComment(text: String): Unit {
        NativeModule._XmlSerializer_setComment(this.peer.ptr, text);
    }
    public func setCDATA(text: String): Unit {
        NativeModule._XmlSerializer_setCDATA(this.peer.ptr, text);
    }
    public func setText(text: String): Unit {
        NativeModule._XmlSerializer_setText(this.peer.ptr, text);
    }
    public func setDocType(text: String): Unit {
        NativeModule._XmlSerializer_setDocType(this.peer.ptr, text);
    }
}
public open class ParseInfo <: ParseInfoInterface {
    var peer: Finalizable = Finalizable(0, 0)
    static func getFinalizer(): UInt64 {
        return NativeModule._ParseInfo_getFinalizer()
    }
    func getPeer(): Finalizable {
        return this.peer
    }
    static func construct(ptr: UInt64): ParseInfo {
        let objParseInfo: ParseInfo = ParseInfo()
        objParseInfo.peer = Finalizable(ptr, ParseInfo.getFinalizer())
        return objParseInfo
    }
    public func getColumnNumber(): Float64 {
        let result = NativeModule._ParseInfo_getColumnNumber(this.peer.ptr)
        return result
    }
    public func getDepth(): Float64 {
        let result = NativeModule._ParseInfo_getDepth(this.peer.ptr)
        return result
    }
    public func getLineNumber(): Float64 {
        let result = NativeModule._ParseInfo_getLineNumber(this.peer.ptr)
        return result
    }
    public func getName(): String {
        let result = NativeModule._ParseInfo_getName(this.peer.ptr)
        return result
    }
    public func getNamespace(): String {
        let result = NativeModule._ParseInfo_getNamespace(this.peer.ptr)
        return result
    }
    public func getPrefix(): String {
        let result = NativeModule._ParseInfo_getPrefix(this.peer.ptr)
        return result
    }
    public func getText(): String {
        let result = NativeModule._ParseInfo_getText(this.peer.ptr)
        return result
    }
    public func isEmptyElementTag(): Bool {
        let result = NativeModule._ParseInfo_isEmptyElementTag(this.peer.ptr)
        return result
    }
    public func isWhitespace(): Bool {
        let result = NativeModule._ParseInfo_isWhitespace(this.peer.ptr)
        return result
    }
    public func getAttributeCount(): Float64 {
        let result = NativeModule._ParseInfo_getAttributeCount(this.peer.ptr)
        return result
    }
}
public open class ParseInfoInternal {
    public static func fromPtr(ptr: UInt64): ParseInfo {
        let obj: ParseInfo = ParseInfo()
        obj.peer = Finalizable(ptr, ParseInfo.getFinalizer())
        return obj
    }
}
public open class XmlPullParser <: XmlPullParserInterface {
    var peer: Finalizable
    XmlPullParser(buffer: String, encoding: Option<String>) {
        let thisSerializer: Serializer = Serializer.hold()
        var encoding_type: Int32 = RuntimeType.UNDEFINED.ordinal
        encoding_type = Ark_Object.getRuntimeType(encoding).ordinal
        thisSerializer.writeInt8(Int8(encoding_type))
        if (let Some(encoding) <- encoding) {
            let encoding_value = encoding
            thisSerializer.writeString(encoding_value)
        }
        this.peer = Finalizable(NativeModule._XmlPullParser_ctor(buffer, thisSerializer.asArray(), thisSerializer.length()), XmlPullParser.getFinalizer())
        thisSerializer.release();
    }
    static func getFinalizer(): UInt64 {
        return NativeModule._XmlPullParser_getFinalizer()
    }
    func getPeer(): Option<Finalizable> {
        return this.peer
    }
    public func parse(option: ParseOptions): Unit {
        let thisSerializer: Serializer = Serializer.hold()
        thisSerializer.writeParseOptions(option)
        NativeModule._XmlPullParser_parse(this.peer.ptr, thisSerializer.asArray(), thisSerializer.length());
        thisSerializer.release();
    }
}
