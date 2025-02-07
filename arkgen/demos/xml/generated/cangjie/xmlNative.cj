package idlize

import Interop.*
import std.collection.*

public open class CallbackKind {
    public static var Kind_Callback_Boolean_Void: CallbackKind = CallbackKind(313269291)
    public static var Kind_Callback_EventType_ParseInfo_Boolean: CallbackKind = CallbackKind(240036623)
    public static var Kind_Callback_String_String_Boolean: CallbackKind = CallbackKind(923368928)
    public var value: Int32
    CallbackKind(arg0: Int32) {
        value = arg0
    }
}

foreign {
    func _XmlSerializer_ctor(thisArray: CPointer<UInt8>, thisLength: Int32): UInt64
    func _XmlSerializer_getFinalizer(): UInt64
    func _XmlSerializer_setAttributes(self: UInt64, name: CString, value: CString): Unit
    func _XmlSerializer_addEmptyElement(self: UInt64, name: CString): Unit
    func _XmlSerializer_setDeclaration(self: UInt64): Unit
    func _XmlSerializer_startElement(self: UInt64, name: CString): Unit
    func _XmlSerializer_endElement(self: UInt64): Unit
    func _XmlSerializer_setNamespace(self: UInt64, prefix: CString, namespace: CString): Unit
    func _XmlSerializer_setComment(self: UInt64, text: CString): Unit
    func _XmlSerializer_setCDATA(self: UInt64, text: CString): Unit
    func _XmlSerializer_setText(self: UInt64, text: CString): Unit
    func _XmlSerializer_setDocType(self: UInt64, text: CString): Unit
    func _ParseInfo_ctor(): UInt64
    func _ParseInfo_getFinalizer(): UInt64
    func _ParseInfo_getColumnNumber(self: UInt64): Float64
    func _ParseInfo_getDepth(self: UInt64): Float64
    func _ParseInfo_getLineNumber(self: UInt64): Float64
    func _ParseInfo_getName(self: UInt64): CString
    func _ParseInfo_getNamespace(self: UInt64): CString
    func _ParseInfo_getPrefix(self: UInt64): CString
    func _ParseInfo_getText(self: UInt64): CString
    func _ParseInfo_isEmptyElementTag(self: UInt64): Bool
    func _ParseInfo_isWhitespace(self: UInt64): Bool
    func _ParseInfo_getAttributeCount(self: UInt64): Float64
    func _XmlPullParser_ctor(thisArray: CPointer<UInt8>, thisLength: Int32): UInt64
    func _XmlPullParser_getFinalizer(): UInt64
    func _XmlPullParser_parse(self: UInt64, thisArray: CPointer<UInt8>, thisLength: Int32): Unit
    func _XmlPullParser_parseXml(self: UInt64, thisArray: CPointer<UInt8>, thisLength: Int32): Unit
}

public class XMLNativeModule {
    static func callCallbackFromNative(id: KInt, args: KPointer, length: KInt): KInt {
        // TODO implement callCallbackFromNative
        return 0
    }    

    static func _XmlSerializer_ctor(thisArray: ArrayList<UInt8>, thisLength: Int32): UInt64 {
        unsafe {
            let handle_0 = acquireArrayRawData(thisArray.toArray())
            let result = XmlSerializer_ctor(handle_0.pointer, thisLength)
            releaseArrayRawData(handle_0)
            return result
        }
    }
    static func _XmlSerializer_getFinalizer(): UInt64 {
        unsafe {
            let result = XmlSerializer_getFinalizer()
            return result
        }
    }
    static func _XmlSerializer_setAttributes(self: UInt64, name: String, value: String): Unit {
        unsafe {
            let name =  LibC.mallocCString(name)
            let value =  LibC.mallocCString(value)
            XmlSerializer_setAttributes(self, name, value)
            LibC.free(name)
            LibC.free(name)
        }
    }
    static func _XmlSerializer_addEmptyElement(self: UInt64, name: String): Unit {
        unsafe {
            let name =  LibC.mallocCString(name)
            XmlSerializer_addEmptyElement(self, name)
            LibC.free(name)
        }
    }
    static func _XmlSerializer_setDeclaration(self: UInt64): Unit {
        unsafe {
            XmlSerializer_setDeclaration(self)
        }
    }
    static func _XmlSerializer_startElement(self: UInt64, name: String): Unit {
        unsafe {
            let name =  LibC.mallocCString(name)
            XmlSerializer_startElement(self, name)
            LibC.free(name)
        }
    }
    static func _XmlSerializer_endElement(self: UInt64): Unit {
        unsafe {
            XmlSerializer_endElement(self)
        }
    }
    static func _XmlSerializer_setNamespace(self: UInt64, prefix: String, namespace: String): Unit {
        unsafe {
            let prefix =  LibC.mallocCString(prefix)
            let namespace =  LibC.mallocCString(namespace)
            XmlSerializer_setNamespace(self, prefix, namespace)
            LibC.free(prefix)
            LibC.free(prefix)
        }
    }
    static func _XmlSerializer_setComment(self: UInt64, text: String): Unit {
        unsafe {
            let text =  LibC.mallocCString(text)
            XmlSerializer_setComment(self, text)
            LibC.free(text)
        }
    }
    static func _XmlSerializer_setCDATA(self: UInt64, text: String): Unit {
        unsafe {
            let text =  LibC.mallocCString(text)
            XmlSerializer_setCDATA(self, text)
            LibC.free(text)
        }
    }
    static func _XmlSerializer_setText(self: UInt64, text: String): Unit {
        unsafe {
            let text =  LibC.mallocCString(text)
            XmlSerializer_setText(self, text)
            LibC.free(text)
        }
    }
    static func _XmlSerializer_setDocType(self: UInt64, text: String): Unit {
        unsafe {
            let text =  LibC.mallocCString(text)
            XmlSerializer_setDocType(self, text)
            LibC.free(text)
        }
    }
    static func _ParseInfo_getFinalizer(): UInt64 {
        unsafe {
            let result = ParseInfo_getFinalizer()
            return result
        }
    }
    static func _ParseInfo_getColumnNumber(self: UInt64): Float64 {
        unsafe {
            let result = ParseInfo_getColumnNumber(self)
            return result
        }
    }
    static func _ParseInfo_getDepth(self: UInt64): Float64 {
        unsafe {
            let result = ParseInfo_getDepth(self)
            return result
        }
    }
    static func _ParseInfo_getLineNumber(self: UInt64): Float64 {
        unsafe {
            let result = ParseInfo_getLineNumber(self)
            return result
        }
    }
    static func _ParseInfo_getName(self: UInt64): String {
        unsafe {
            let result = ParseInfo_getName(self).toString()
            return result
        }
    }
    static func _ParseInfo_getNamespace(self: UInt64): String {
        unsafe {
            let result = ParseInfo_getNamespace(self).toString()
            return result
        }
    }
    static func _ParseInfo_getPrefix(self: UInt64): String {
        unsafe {
            let result = ParseInfo_getPrefix(self).toString()
            return result
        }
    }
    static func _ParseInfo_getText(self: UInt64): String {
        unsafe {
            let result = ParseInfo_getText(self).toString()
            return result
        }
    }
    static func _ParseInfo_isEmptyElementTag(self: UInt64): Bool {
        unsafe {
            let result = ParseInfo_isEmptyElementTag(self)
            return result
        }
    }
    static func _ParseInfo_isWhitespace(self: UInt64): Bool {
        unsafe {
            let result = ParseInfo_isWhitespace(self)
            return result
        }
    }
    static func _ParseInfo_getAttributeCount(self: UInt64): Float64 {
        unsafe {
            let result = ParseInfo_getAttributeCount(self)
            return result
        }
    }
    static func _XmlPullParser_ctor(thisArray: ArrayList<UInt8>, thisLength: Int32): UInt64 {
        unsafe {
            let handle_0 = acquireArrayRawData(thisArray.toArray())
            let result = XmlPullParser_ctor(handle_0.pointer, thisLength)
            releaseArrayRawData(handle_0)
            return result
        }
    }
    static func _XmlPullParser_getFinalizer(): UInt64 {
        unsafe {
            let result = XmlPullParser_getFinalizer()
            return result
        }
    }
    static func _XmlPullParser_parse(self: UInt64, thisArray: ArrayList<UInt8>, thisLength: Int32): Unit {
        unsafe {
            let handle_1 = acquireArrayRawData(thisArray.toArray())
            XmlPullParser_parse(self, handle_1.pointer, thisLength)
            releaseArrayRawData(handle_1)
        }
    }
    static func _XmlPullParser_parseXml(self: UInt64, thisArray: ArrayList<UInt8>, thisLength: Int32): Unit {
        unsafe {
            let handle_1 = acquireArrayRawData(thisArray.toArray())
            XmlPullParser_parseXml(self, handle_1.pointer, thisLength)
            releaseArrayRawData(handle_1)
        }
    }
}
