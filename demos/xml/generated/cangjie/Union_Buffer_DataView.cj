package idlize

import std.collection.*

public class DataView {
    
}

public open class Union_Buffer_DataView <: Ark_ObjectBase {
    private var selector: Int32
    public func getSelector(): Int32 {
        return selector
    }
    private var value0: Option<ArrayList<UInt8>> = None<ArrayList<UInt8>>
    init(param: ArrayList<UInt8>) {
        value0 = param
        selector = 0
    }
    public func getValue0(): ArrayList<UInt8> {
        if (let Some(value0) <- value0) {
            return value0
            } else { throw Exception("Wrong selector value inside Union Union_Buffer_DataView") }
    }
    private var value1: Option<DataView> = None<DataView>
    init(param: DataView) {
        value1 = param
        selector = 1
    }
    public func getValue1(): DataView {
        if (let Some(value1) <- value1) {
            return value1
            } else { throw Exception("Wrong selector value inside Union Union_Buffer_DataView") }
    }
}