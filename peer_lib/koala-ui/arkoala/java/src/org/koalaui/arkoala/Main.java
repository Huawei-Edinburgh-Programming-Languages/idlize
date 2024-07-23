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

package org.koalaui.arkoala;

import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.nio.IntBuffer;
import java.util.Arrays;
import java.util.Map;
import java.util.function.Function;

public class Main {
    public static void main(String[] args) {
        long str = NativeModule._StringMake("Hello");
        System.out.println(NativeModule._StringLength(str));
        //Main.checkPerf(10*1000*1000);
        //NativeModule._StartGroupedLog(1);
        Main.checkPerf2(5*1000*1000);
        Main.checkPerf3(5*1000*1000);
        Main.checkPeers();
        Main.checkCallback();
        Main.checkNativeCallback();
        //NativeModule._StopGroupedLog(1);
    }

    static void checkPerf(int count) {
        long start = System.currentTimeMillis();
        for (int i = 0; i < count; i++) {
            NativeModule._TestPerfNumber(i);
        }
        long passed = System.currentTimeMillis() - start;
        System.out.println("NUMBER: " + String.valueOf(passed) + "ms for " + count + " iteration, " + Math.round((double)passed / count * 1000000) + "ms per 1M iterations");

        start = System.currentTimeMillis();
        for (int i = 0; i < count; i++) {
            byte[] data = new byte[5];
            data[0] = 1;
            data[1] = (byte)(i >> 24);
            data[2] = (byte)(i >> 16);
            data[3] = (byte)(i >> 8);
            data[4] = (byte)(i >> 0);
            NativeModule._TestPerfNumberWithArray(data, data.length);
        }
        passed = System.currentTimeMillis() - start;
        System.out.println("ARRAY: " + String.valueOf(passed) + "ms for " + count + " iteration, " + Math.round((double)passed / count * 1000000) + "ms per 1M iterations");
    }

    static void checkPerf2(int count) {
        var peer = new ArkButtonPeer(ArkUINodeType.Root, null, 0);
        long start = System.currentTimeMillis();
        for (int i = 0; i < count; i++) {
            if (i % 2 == 0) {
                peer.backdropBlurAttribute(i, null);
            }
            else {
                BlurOptions options = new BlurOptions();
                options.grayscale = new Tuple_double_double(1.0, 2.0);
                peer.backdropBlurAttribute(i, options);
            }
        }
        long passed = System.currentTimeMillis() - start;
        System.out.println("backdropBlur: " + String.valueOf(passed) + "ms for " + count + " iteration, " + Math.round((double)passed / count * 1000000) + "ms per 1M iterations");
    }
    
    static void checkPerf3(int count) {
        var peer = new ArkButtonPeer(ArkUINodeType.Root, null, 0);
        var testLength_10_lpx = new Ark_Length("10lpx");
        long start = System.currentTimeMillis();
        for (int i = 0; i < count; i++) {
            peer.widthAttribute(testLength_10_lpx);
        }
        long passed = System.currentTimeMillis() - start;
        System.out.println("widthAttributeString: " + String.valueOf(passed) + "ms for " + count + " iteration, " + Math.round((double)passed / count * 1000000) + "ms per 1M iterations");
    }

    static void checkPeers() {
        // interface
        var buttonPeer = new ArkButtonPeer(ArkUINodeType.Root, null, 0);
        var labelStyle = new LabelStyle();
        labelStyle.maxLines = new Opt_Number(5);
        buttonPeer.labelStyleAttribute(labelStyle);
        System.out.println("Interface tests done");

        // union
        buttonPeer.fontColorAttribute(new Union_Ark_Color_double_String_Ark_Resource(5.5));
        buttonPeer.fontColorAttribute(new Union_Ark_Color_double_String_Ark_Resource(Ark_Color.White)); // +enum
        buttonPeer.fontColorAttribute(new Union_Ark_Color_double_String_Ark_Resource(new Ark_Resource())); // +import
        System.out.println("Union tests done");

        // enum
        buttonPeer.typeAttribute(Ark_ButtonType.Capsule);
        System.out.println("Enum tests done");

        // tuple
        var peer = new ArkTestPeer(ArkUINodeType.Root /* ArkUINodeType.Test */, null, 0);
        var options = new BlurOptions();
        options.grayscale = new Tuple_double_double(1.0, 2.0);
        peer.backdropBlurAttribute(42, options);
        var tuple1 = new Tuple_double_String_Ark_EnumDTS(5.5, "test", Ark_EnumDTS.ELEM_1);
        peer.testTupleNumberStringEnumAttribute(tuple1); // +enum
        System.out.println("Tuple tests done");

        // optional
        peer.someOptionalBoolAttribute(new Opt_Boolean(false));
        peer.someOptionalEnumAttribute(Ark_EnumDTS.ELEM_1); // +enum
        var optionalInterface = new OptionalTestInterface();
        optionalInterface.optNumber = new Opt_Number(10);
        peer.testOptionInterface_OptionalTestInterfaceAttribute(optionalInterface); // +interface
        System.out.println("Optional tests done");

        // array
        BooleanInterfaceDTS[] booleanInterface = { new BooleanInterfaceDTS(), new BooleanInterfaceDTS() };
        booleanInterface[0].valBool = true;
        peer.testBooleanInterfaceArrayAttribute(booleanInterface); // no interface
        peer.testBooleanInterfaceArrayRefAttribute(booleanInterface); // no interface
        var dragPreviewOptions = new DragPreviewOptions();
        Ark_DragPreviewMode[] modes = { Ark_DragPreviewMode.DISABLE_SCALE, Ark_DragPreviewMode.ENABLE_DEFAULT_RADIUS };
        dragPreviewOptions.mode = new Union_Ark_DragPreviewMode_Array_Ark_DragPreviewMode(modes);
        dragPreviewOptions.numberBadge = new Union_boolean_double(false);
        var dragInteractionOptions = new DragInteractionOptions();
        dragInteractionOptions.defaultAnimationBeforeLifting = new Opt_Boolean(true);
        buttonPeer.dragPreviewOptionsAttribute(dragPreviewOptions, dragInteractionOptions); // +interface +union
        System.out.println("Array tests done");

        // map
        var dataInfo = new NativeEmbedDataInfo();
        dataInfo.info = new NativeEmbedInfo();
        dataInfo.info.params = Map.of("k1", "v1", "k2", "v2");
        var webPeer = new ArkWebPeer(ArkUINodeType.Root /* ArkUINodeType.Web */, null, 0);
        webPeer.testMethodAttribute(dataInfo);
        System.out.println("Map tests done");
        var doubleStringMap = Map.of(1.0, "v1", 2.0, "v2");
        var unionWithMap = new Union_double_Map_Double_String(doubleStringMap);
        peer.testUnionWithMapAttribute(unionWithMap); // +union
        peer.testMapAttribute(doubleStringMap); // +map in peer method
    }

    static void checkCallback() {
        Integer id1 = CallbackRegistry.wrap(new CallbackType() {
            @Override
            public int apply(byte[] args, int length) {
                return 2024;
            }
        });
        Integer id2 = CallbackRegistry.wrap(new CallbackType() {
            @Override
            public int apply(byte[] args, int length) {
                return 2025;
            }
        });

        TestUtils.assertEquals("Call callback 1", 2024, CallbackRegistry.call(id1, new byte[] {}, 0));
        TestUtils.assertEquals("Call callback 2", 2025, CallbackRegistry.call(id2, new byte[] {}, 0));
        TestUtils.assertThrows("Call disposed callback 1", new Function<Void, Integer>() {
            @Override
            public Integer apply(Void v) {
                return CallbackRegistry.call(id1, new byte[] { }, 0);
            }
        });
        TestUtils.assertThrows("Call callback 0", new Function<Void, Integer>() {
            @Override
            public Integer apply(Void v) {
                return CallbackRegistry.call(0, new byte[] { 2, 4, 6, 8 }, 4);
            }
        });
    }

    static void checkNativeCallback() {
        Integer id1 = CallbackRegistry.wrap(new CallbackType() {
            @Override
            public int apply(byte[] args, int length) {
                return 123456;
            }
        });
        TestUtils.assertEquals("NativeCallback without args", 123456, NativeModule._TestCallIntNoArgs(id1));
        TestUtils.assertThrows("NativeCallback without args called again", new Function<Void, Integer>() {
            @Override
            public Integer apply(Void v) {
                return CallbackRegistry.call(id1, new byte[] { }, 0);
            }
        });
        TestUtils.assertThrows("NativeCallback without args called again from native", new Function<Void, Integer>() {
            @Override
            public Integer apply(Void v) {
                return NativeModule._TestCallIntNoArgs(id1);
            }
        });

        Integer id2 = CallbackRegistry.wrap(new CallbackType() {
            @Override
            public int apply(byte[] args, int length) {
                ByteBuffer buffer = ByteBuffer.wrap(args);
                buffer.order(ByteOrder.LITTLE_ENDIAN);
                IntBuffer intBuffer = buffer.asIntBuffer();
                int sum = 0;
                for (int i = 0; i < length / 4; i++) {
                    sum += intBuffer.get(i);
                }
                return sum;
            }
        });
        int[] arr2 = new int[] { 100, 200, 300, -1000 };
        TestUtils.assertEquals("NativeCallback Int32Array sum", -400, NativeModule._TestCallIntInt32ArraySum(id2, arr2, arr2.length));

        Integer id3 = CallbackRegistry.wrap(new CallbackType() {
            @Override
            public int apply(byte[] args, int length) {
                ByteBuffer buffer = ByteBuffer.wrap(args);
                buffer.order(ByteOrder.LITTLE_ENDIAN);
                IntBuffer intBuffer = buffer.asIntBuffer();
                for (int i = 1; i < length / 4; i++) {
                    intBuffer.put(i, intBuffer.get(i) + intBuffer.get(i - 1));
                }
                return 0;
            }
        });
        int[] arr3 = new int[] { 100, 200, 300, -1000 };
        NativeModule._TestCallVoidInt32ArrayPrefixSum(id3, arr3, arr3.length);
        TestUtils.assertEquals("NativeCallback Int32Array PrefixSum [0]", 100, arr3[0]);
        TestUtils.assertEquals("NativeCallback Int32Array PrefixSum [1]", 300, arr3[1]);
        TestUtils.assertEquals("NativeCallback Int32Array PrefixSum [2]", 600, arr3[2]);
        TestUtils.assertEquals("NativeCallback Int32Array PrefixSum [3]", -400, arr3[3]);

        long start = System.currentTimeMillis();
        Integer id4 = CallbackRegistry.wrap(new CallbackType() {
            @Override
            public int apply(byte[] args, int length) {
                ByteBuffer buffer = ByteBuffer.wrap(args);
                buffer.order(ByteOrder.LITTLE_ENDIAN);
                IntBuffer intBuffer = buffer.asIntBuffer();
                intBuffer.put(1, intBuffer.get(1) + 1);
                if (intBuffer.get(0) + intBuffer.get(1) < intBuffer.get(2)) {
                    return NativeModule._TestCallIntRecursiveCallback(id3 + 1, args, args.length);
                }
                return 1;
            }
        }, false);
        TestUtils.assertEquals("NativeCallback prepare recursive callback test", id4, id3 + 1);
        int depth = 500;
        int count = 100;
        for (int i = 0; i < count; i++) {
            int length = 12;
            byte[] args = new byte[length];
            IntBuffer args32 = ByteBuffer.wrap(args).order(ByteOrder.LITTLE_ENDIAN).asIntBuffer();
            args32.put(2, depth);
            NativeModule._TestCallIntRecursiveCallback(id4, args, args.length);
            if (i == 0) {
                TestUtils.assertEquals("NativeCallback Recursive [0]", (depth + 1) / 2, args32.get(0));
                TestUtils.assertEquals("NativeCallback Recursive [1]", depth / 2, args32.get(1));
            }
        }
        long passed = System.currentTimeMillis() - start;
        System.out.println("recursive native callback: " + String.valueOf(passed) + "ms for " + depth * count + " callbacks, " + Math.round((double)passed / (depth * count) * 1000000) + "ms per 1M callbacks");

        Integer id5 = CallbackRegistry.wrap(new CallbackType() {
            @Override
            public int apply(byte[] args, int length) {
                int sum = 0;
                for (int i = 0; i < length; i++) {
                    sum += args[i];
                }
                return sum;
            }
        }, false);
        NativeModule._TestCallIntMemory(id5, 1000);
    }
}

// Old: JS 167ms per 1M, Java 15 ms per 1M
