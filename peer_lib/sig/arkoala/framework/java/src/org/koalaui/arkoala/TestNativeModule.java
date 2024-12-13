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

public class TestNativeModule {
// test
    static native int _TestCallIntNoArgs(int arg0);
    static native int _TestCallIntIntArraySum(int arg0, int[] arg1, int arg2);
    static native void _TestCallVoidIntArrayPrefixSum(int arg0, int[] arr, int arg2);
    static native int _TestCallIntRecursiveCallback(int arg0, byte[] arr, int arg2);
    static native int _TestCallIntMemory(int arg0, int arg1);
    static native void _Test_SetEventsApi();
    static native void _Test_Common_OnChildTouchTest(byte[] arr, int arg);
    static native void _Test_List_OnScrollVisibleContentChange(byte[] arr, int arg);
    static native void _Test_TextPicker_OnAccept(byte[] arr, int arg);
    static native void _TestWithBuffer(byte[] buffer);
    static native void _TestSetArkoalaCallbackCaller();
    static native void _TestSetArkoalaCallbackCallerSync();
    static native long _TestGetManagedCaller(int kind);
    static native long _TestGetManagedCallerSync(int kind);
    static native long _TestGetManagedHolder();
    static native long _TestGetManagedReleaser();
    static native void _TestCallbackSyncCall(byte[] arr, int len);
}

