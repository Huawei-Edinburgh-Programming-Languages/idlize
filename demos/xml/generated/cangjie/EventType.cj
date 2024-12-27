package idlize

import std.collection.*

public open class EventType <: Ark_ObjectBase {
    public static var START_DOCUMENT: EventType = EventType(0)
    public static var END_DOCUMENT: EventType = EventType(1)
    public static var START_TAG: EventType = EventType(2)
    public static var END_TAG: EventType = EventType(3)
    public static var TEXT: EventType = EventType(4)
    public static var CDSECT: EventType = EventType(5)
    public static var COMMENT: EventType = EventType(6)
    public static var DOCDECL: EventType = EventType(7)
    public static var INSTRUCTION: EventType = EventType(8)
    public static var ENTITY_REFERENCE: EventType = EventType(9)
    public static var WHITESPACE: EventType = EventType(10)
    public var value: Int32
    EventType(arg0: Int32) {
        value = arg0
    }
}