/*
 * Copyright (c) 2024 Huawei Device Co., Ltd.
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

package idlize

import std.time.DateTime
import std.math.round
import std.collection.*


public func getNativeString(ptr: Int64): String {
    let length = NativeModule._StringLength(ptr)
    var data = ArrayList<UInt8>(Array<UInt8>(Int64(length), item: 0))
    data = NativeModule._StringData(ptr, data, length)
    var result = StringBuilder()
    for (i in 0..length) {
        result.append(Rune(data[Int64(i)]))
    }
    return result.toString()
}

public func checkResult(name: String, test: () -> Unit, expected: String) {
    NativeModule._StartGroupedLog(1)
    test()
    NativeModule._StopGroupedLog(1)
    let actual = getNativeString(NativeModule._GetGroupedLog(1))
    if (actual != expected) {
        println("TEST ${name} FAIL:\n  EXPECTED \"${expected}\"\n  ACTUAL   \"${actual}\"")
        throw Exception("TEST ${name} FAIL")
    } else {
        println("TEST ${name} PASS")
    }
}

func checkPerf2(count: Int64) {
    var peer = ArkBlankPeer.create(ArkUINodeType.Button, None<ComponentBase>, 0)
    var start = DateTime.now().nanosecond
    for (i in 0..count) {
        if (i % 2 == 0) {
            peer.backdropBlurAttribute(Float64(i), Option.None)
        }
        else {
            let options: BlurOptions = BlurOptions(Tuple_Float64_Float64(1.0, 2.0))
            peer.backdropBlurAttribute(Float64(i), options);
        }
    }
    var passed = DateTime.now().nanosecond - start;
    println("backdropBlur: ${passed} ns for ${count} iteration,  ${Int32(round(Float64(passed) / Float64(count)))} ms per 1M iterations");
}

func checkPerf3(count: Int32): Unit {
    var peer = ArkButtonPeer.create(ArkUINodeType.Button, None<ComponentBase>, 0)
    var testLength_10_lpx = Ark_Length("10lpx")
    let start = DateTime.now().nanosecond
    for (i in 0..count) {
        peer.widthAttribute(testLength_10_lpx);
    }
    let passed = DateTime.now().nanosecond - start;
    println("widthAttributeString: ${passed} ms for ${count} iteration")
}

func peersTest(): Unit {
    println("CJ peer tests")
    // interface
    let buttonPeer = ArkButtonPeer.create(ArkUINodeType.Button, Option.None, 0)
    let labelStyle = LabelStyle(None<TextOverflow>, 5.0, None<Union_Float64_ResourceStr>, None<Union_Float64_ResourceStr>, None<TextHeightAdaptivePolicy>, None<Font>)
    checkResult("[Interface + Optional] ButtonPeer.labelStyle",
        { => buttonPeer.labelStyleAttribute(labelStyle) },
        "labelStyle({.overflow={.tag=ARK_TAG_UNDEFINED, .value={}}, .maxLines={.tag=ARK_TAG_OBJECT, .value={.tag=102, .i32=5}}, .minFontSize={.tag=ARK_TAG_UNDEFINED, .value={}}, .maxFontSize={.tag=ARK_TAG_UNDEFINED, .value={}}, .heightAdaptivePolicy={.tag=ARK_TAG_UNDEFINED, .value={}}, .font={.tag=ARK_TAG_UNDEFINED, .value={}}})")
    labelStyle.maxLines = None<Float64>
    labelStyle.font = Font(None<Ark_Length>, Union_FontWeight_Float64_String("param"), None<Union_String_Resource>, None<FontStyle>)
    checkResult("[Union] ButtonPeer.labelStyle",
        { => buttonPeer.labelStyleAttribute(labelStyle) },
        "labelStyle({.overflow={.tag=ARK_TAG_UNDEFINED, .value={}}, .maxLines={.tag=ARK_TAG_UNDEFINED, .value={}}, .minFontSize={.tag=ARK_TAG_UNDEFINED, .value={}}, .maxFontSize={.tag=ARK_TAG_UNDEFINED, .value={}}, .heightAdaptivePolicy={.tag=ARK_TAG_UNDEFINED, .value={}}, .font={.tag=ARK_TAG_OBJECT, .value={.size={.tag=ARK_TAG_UNDEFINED, .value={}}, .weight={.tag=ARK_TAG_OBJECT, .value={.selector=2, .value2={.chars=\"param\", .length=5}}}, .family={.tag=ARK_TAG_UNDEFINED, .value={}}, .style={.tag=ARK_TAG_UNDEFINED, .value={}}}}})");
    labelStyle.font = Font(None<Ark_Length>, Union_FontWeight_Float64_String(FontWeight.BOLD), None<Union_String_Resource>, None<FontStyle>)
    checkResult("[Union + Enum] ButtonPeer.labelStyle",
        { => buttonPeer.labelStyleAttribute(labelStyle) },
        "labelStyle({.overflow={.tag=ARK_TAG_UNDEFINED, .value={}}, .maxLines={.tag=ARK_TAG_UNDEFINED, .value={}}, .minFontSize={.tag=ARK_TAG_UNDEFINED, .value={}}, .maxFontSize={.tag=ARK_TAG_UNDEFINED, .value={}}, .heightAdaptivePolicy={.tag=ARK_TAG_UNDEFINED, .value={}}, .font={.tag=ARK_TAG_OBJECT, .value={.size={.tag=ARK_TAG_UNDEFINED, .value={}}, .weight={.tag=ARK_TAG_OBJECT, .value={.selector=0, .value0=Ark_FontWeight(4)}}, .family={.tag=ARK_TAG_UNDEFINED, .value={}}, .style={.tag=ARK_TAG_UNDEFINED, .value={}}}}})");
    let resource = Resource("bundle_name", "module_name", 10.0, None, 2000.0)   
    labelStyle.font = Font(None<Ark_Length>, None<Union_FontWeight_Float64_String>, Union_String_Resource(resource), None<FontStyle>)
    checkResult("[Union + Resource] ButtonPeer.labelStyle",
        { => buttonPeer.labelStyleAttribute(labelStyle) },
        "labelStyle({.overflow={.tag=ARK_TAG_UNDEFINED, .value={}}, .maxLines={.tag=ARK_TAG_UNDEFINED, .value={}}, .minFontSize={.tag=ARK_TAG_UNDEFINED, .value={}}, .maxFontSize={.tag=ARK_TAG_UNDEFINED, .value={}}, .heightAdaptivePolicy={.tag=ARK_TAG_UNDEFINED, .value={}}, .font={.tag=ARK_TAG_OBJECT, .value={.size={.tag=ARK_TAG_UNDEFINED, .value={}}, .weight={.tag=ARK_TAG_UNDEFINED, .value={}}, .family={.tag=ARK_TAG_OBJECT, .value={.selector=1, .value1={.bundleName={.chars=\"bundle_name\", .length=11}, .moduleName={.chars=\"module_name\", .length=11}, .id={.tag=102, .i32=10}, .params={.tag=ARK_TAG_UNDEFINED, .value={}}, .type_={.tag=ARK_TAG_OBJECT, .value={.tag=102, .i32=2000}}}}}, .style={.tag=ARK_TAG_UNDEFINED, .value={}}}}})"
        )
    // tuple
    // let peer = ArkTestPeer.create(ArkUINodeType.Test, null, 0)
    // var options = new BlurOptions()
    // options.grayscale = new Tuple_double_double(1.0, 2.0)
    // TestUtils.checkResult("[Tuple] TestPeer.backdropBlur",
    //     () -> { peer.backdropBlurAttribute(42, options); },
    //     "backdropBlur({.tag=102, .i32=42}, {.tag=ARK_TAG_OBJECT, .value={.grayscale={.value0={.tag=102, .i32=1}, .value1={.tag=102, .i32=2}}}})");
    // var tuple1 = new Tuple_double_String_EnumDTS(5.5, "test", EnumDTS.ELEM_1)
    // TestUtils.checkResult("[Tuple + Enum] TestPeer.testTupleNumberStringEnum",
    //     () -> { peer.testTupleNumberStringEnumAttribute(tuple1); },
    //     "testTupleNumberStringEnum({.value0={.tag=103, .f32=5.5}, .value1={.chars=\"test\", .length=4}, .value2=Ark_EnumDTS(1)})")
}


main(): Unit {
    checkPerf2(100)
    checkPerf3(100)
    peersTest()
}