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

public class ArkUINativeModule {
// node
    static native long _CreateNode(int node_t, int arg0, int arg1);
    static native long _GetNodeFinalizer();
    static native long _GetNodeByViewStack();
    static native void _DisposeNode(long ptr0);
    static native void _DumpTreeNode(long ptr0);
    static native int  _AddChild(long ptr1, long ptr2);
    static native void _RemoveChild(long ptr0, long ptr2);
    static native int _InsertChildAfter(long ptr0, long ptr1, long ptr2);
    static native int _InsertChildBefore(long ptr0, long ptr1, long ptr2);
    static native int _InsertChildAt(long ptr0, long ptr1, int arg);
    static native void _ApplyModifierFinish(long ptr0);
    static native void _MarkDirty(long ptr0, int arg);
    static native boolean _IsBuilderNode(long ptr0);
    static native float _ConvertLengthMetricsUnit(float arg0, int arg1, int arg2);
    static native void _SetCustomCallback(long ptr0, int arg);
    static native void _MeasureLayoutAndDraw(long ptr0);
    static native int _MeasureNode(long ptr0, float[] arr);
    static native int _LayoutNode(long ptr0, float[] arr);
    static native int _DrawNode(long ptr0, float[] arr);
    static native void _SetMeasureWidth(long ptr0, int arg);
    static native int _GetMeasureWidth(long ptr0);
    static native void _SetMeasureHeight(long ptr0, int arg);
    static native int _GetMeasureHeight(long ptr0);
    static native void _SetX(long ptr0, int arg);
    static native int _GetX(long ptr0);
    static native void _SetY(long ptr0, int arg);
    static native int _GetY(long ptr0);
    static native void _SetAlignment(long ptr0, int arg);
    static native int _GetAlignment(long ptr0);
    static native int _IndexerChecker(long ptr0);
    static native void _SetRangeUpdater(long ptr0, int arg);
    static native void _SetLazyItemIndexer(long ptr0, int arg);
    static native long _GetPipelineContext(long ptr0);
    static native Object _VSyncAwait(long pipeline);
    static native void _SetVsyncCallback(long pipeline);
    static native void _UnblockVsyncWait(long pipeline);
    static native void _SetChildTotalCount(long ptr0, int arg);
    static native void _ShowCrash(String message);
    static native int _CheckArkoalaGeneratedEvents(byte[] result, int size);
    static native int _InjectEvent(byte[] data, int size);
    static native void _StartPerf(String str1);
    static native void _EndPerf(String str1);
    static native long _DumpPerf(int arg);
    static native int _CheckArkoalaCallbackEvent(byte[] buffer, int bufferLength);
    static native void _HoldArkoalaResource(int resourceId);
    static native void _ReleaseArkoalaResource(int resourceId);
    static native Object _LoadUserView(String userClass, String params);
}

