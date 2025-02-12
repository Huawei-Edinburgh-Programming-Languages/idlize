/*
 * Copyright (c) 2024-2025 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


// WARNING! THIS FILE IS AUTO-GENERATED, DO NOT MAKE CHANGES, THEY WILL BE LOST ON NEXT GENERATION!

package idlize

import Interop.*

import std.collection.*

public open class EventType {
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
