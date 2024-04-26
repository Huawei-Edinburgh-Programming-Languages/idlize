
import {
    int32,
    float32
} from "@koalaui/common"
import {
    KInt,
    KBoolean,
    KStringPtr,
    KPointer,
    KNativePointer,
    KInt32ArrayPtr,
    KUint8ArrayPtr,
    pointer
} from "@types"

export type NodePointer = pointer

let theModule: NativeModule | undefined = undefined

export interface NativeModule {
  _GetGroupedLog(index: KInt): KPointer;
  _ClearGroupedLog(index: KInt): void;
  _GetStringFinalizer(): KPointer;
  _InvokeFinalizer(ptr: KPointer, finalizer: KPointer): void;
  _StringLength(ptr: KPointer): KInt;
  _StringData(ptr: KPointer, buffer: KUint8ArrayPtr, length: KInt): void;
  _StringMake(value: KStringPtr): KPointer;

  _BlankAttribute_color(ptr: KPointer, valueArray: Uint8Array, valueSerializerLength: int32): void
  _BlankInterface__setBlankOptions(ptr: KPointer, minArray: Uint8Array, minSerializerLength: int32): void
  _ButtonAttribute_labelStyle(ptr: KPointer, valueArray: Uint8Array, valueSerializerLength: int32): void
  _ButtonAttribute_type(ptr: KPointer, value: KInt): void
  _ButtonInterface__setButtonOptions(ptr: KPointer): void
  _CalendarPickerAttribute_altEdgeAlign(ptr: KPointer, alignType: KInt, offsetArray: Uint8Array, offsetSerializerLength: int32): void
  _CalendarPickerAttribute_edgeAlign(ptr: KPointer, alignType: KInt, offsetArray: Uint8Array, offsetSerializerLength: int32): void
  _ColumnAttribute_alignItems(ptr: KPointer, value: KInt): void
  _CommonMethod_backgroundBlurStyle(ptr: KPointer, value: KInt, optionsArray: Uint8Array, optionsSerializerLength: int32): void
  _CommonMethod_bindSheet(ptr: KPointer, isShow: KInt, builderArray: Uint8Array, builderSerializerLength: int32, optionsArray: Uint8Array, optionsSerializerLength: int32): void
  _CommonMethod_dragPreviewOptions(ptr: KPointer, valueArray: Uint8Array, valueSerializerLength: int32, optionsArray: Uint8Array, optionsSerializerLength: int32): void
  _CommonMethod_height(ptr: KPointer, valueArray: Uint8Array, valueSerializerLength: int32): void
  _CommonMethod_stateStyles(ptr: KPointer, valueArray: Uint8Array, valueSerializerLength: int32): void
  _CommonMethod_width(ptr: KPointer, valueArray: Uint8Array, valueSerializerLength: int32): void
  _CommonShapeMethod_stroke(ptr: KPointer, valueArray: Uint8Array, valueSerializerLength: int32): void
  _FormComponentAttribute_size(ptr: KPointer, valueArray: Uint8Array, valueSerializerLength: int32): void
  _ListAttribute_onScrollVisibleContentChange(ptr: KPointer, handlerArray: Uint8Array, handlerSerializerLength: int32): void
  _ListAttribute_someOptional(ptr: KPointer, paramArray: Uint8Array, paramSerializerLength: int32): void
  _NavigationAttribute_backButtonIcon(ptr: KPointer, valueArray: Uint8Array, valueSerializerLength: int32): void
  _NavigationAttribute_testTuple(ptr: KPointer, valueArray: Uint8Array, valueSerializerLength: int32): void
  _ParticleAttribute_emitter(ptr: KPointer, valueArray: Uint8Array, valueSerializerLength: int32): void
  _ScrollableCommonMethod_scrollBarWidth(ptr: KPointer, valueArray: Uint8Array, valueSerializerLength: int32): void
  _TabsAttribute_barMode(ptr: KPointer, value: KInt): void
  _TestAttribute_testArrayMix(ptr: KPointer, v1Array: Uint8Array, v1SerializerLength: int32, v2Array: Uint8Array, v2SerializerLength: int32, v3Array: Uint8Array, v3SerializerLength: int32): void
  _TestAttribute_testArrayRefBoolean(ptr: KPointer, valueArray: Uint8Array, valueSerializerLength: int32): void
  _TestAttribute_testArrayRefNumber(ptr: KPointer, valueArray: Uint8Array, valueSerializerLength: int32): void
  _TestAttribute_testArrayRefNumberInterface(ptr: KPointer, valueArray: Uint8Array, valueSerializerLength: int32): void
  _TestAttribute_testBasicMix(ptr: KPointer, v1Array: Uint8Array, v1SerializerLength: int32, v2: KStringPtr, v3Array: Uint8Array, v3SerializerLength: int32): void
  _TestAttribute_testBoolean(ptr: KPointer, value: KInt): void
  _TestAttribute_testBooleanArray(ptr: KPointer, valueArray: Uint8Array, valueSerializerLength: int32): void
  _TestAttribute_testBooleanInterface(ptr: KPointer, valueArray: Uint8Array, valueSerializerLength: int32): void
  _TestAttribute_testBooleanInterfaceArray(ptr: KPointer, valueArray: Uint8Array, valueSerializerLength: int32): void
  _TestAttribute_testBooleanInterfaceArrayRef(ptr: KPointer, valueArray: Uint8Array, valueSerializerLength: int32): void
  _TestAttribute_testBooleanInterfaceOption(ptr: KPointer, valueArray: Uint8Array, valueSerializerLength: int32): void
  _TestAttribute_testBooleanInterfaceTuple(ptr: KPointer, valueArray: Uint8Array, valueSerializerLength: int32): void
  _TestAttribute_testBooleanUndefined(ptr: KPointer, valueArray: Uint8Array, valueSerializerLength: int32): void
  _TestAttribute_testEnum(ptr: KPointer, value: KInt): void
  _TestAttribute_testEnumArray(ptr: KPointer, valueArray: Uint8Array, valueSerializerLength: int32): void
  _TestAttribute_testEnumUndefined(ptr: KPointer, valueArray: Uint8Array, valueSerializerLength: int32): void
  _TestAttribute_testFunction(ptr: KPointer, valueArray: Uint8Array, valueSerializerLength: int32): void
  _TestAttribute_testFunctionUndefined(ptr: KPointer, valueArray: Uint8Array, valueSerializerLength: int32): void
  _TestAttribute_testInterfaceMixed(ptr: KPointer, v1Array: Uint8Array, v1SerializerLength: int32, v2Array: Uint8Array, v2SerializerLength: int32, v3Array: Uint8Array, v3SerializerLength: int32): void
  _TestAttribute_testNumber(ptr: KPointer, valueArray: Uint8Array, valueSerializerLength: int32): void
  _TestAttribute_testNumberArray(ptr: KPointer, valueArray: Uint8Array, valueSerializerLength: int32): void
  _TestAttribute_testNumberInterface(ptr: KPointer, valueArray: Uint8Array, valueSerializerLength: int32): void
  _TestAttribute_testNumberUndefined(ptr: KPointer, valueArray: Uint8Array, valueSerializerLength: int32): void
  _TestAttribute_testOptionInterface(ptr: KPointer, valueArray: Uint8Array, valueSerializerLength: int32): void
  _TestAttribute_testString(ptr: KPointer, value: KStringPtr): void
  _TestAttribute_testStringArray(ptr: KPointer, valueArray: Uint8Array, valueSerializerLength: int32): void
  _TestAttribute_testStringInterface(ptr: KPointer, valueArray: Uint8Array, valueSerializerLength: int32): void
  _TestAttribute_testStringUndefined(ptr: KPointer, valueArray: Uint8Array, valueSerializerLength: int32): void
  _TestAttribute_testTupleBooleanNumber(ptr: KPointer, valueArray: Uint8Array, valueSerializerLength: int32): void
  _TestAttribute_testTupleInterface(ptr: KPointer, valueArray: Uint8Array, valueSerializerLength: int32): void
  _TestAttribute_testTupleNumberStringEnum(ptr: KPointer, valueArray: Uint8Array, valueSerializerLength: int32): void
  _TestAttribute_testTupleOptional(ptr: KPointer, valueArray: Uint8Array, valueSerializerLength: int32): void
  _TestAttribute_testTupleUnion(ptr: KPointer, valueArray: Uint8Array, valueSerializerLength: int32): void
  _TestAttribute_testUnionBooleanString(ptr: KPointer, valArray: Uint8Array, valSerializerLength: int32): void
  _TestAttribute_testUnionBooleanStringNumberUndefined(ptr: KPointer, valArray: Uint8Array, valSerializerLength: int32): void
  _TestAttribute_testUnionInterface(ptr: KPointer, valueArray: Uint8Array, valueSerializerLength: int32): void
  _TestAttribute_testUnionNumberEnum(ptr: KPointer, valArray: Uint8Array, valSerializerLength: int32): void
  _TestAttribute_testUnionOptional(ptr: KPointer, valueArray: Uint8Array, valueSerializerLength: int32): void
  _TestAttribute_testUnionStringNumber(ptr: KPointer, valArray: Uint8Array, valSerializerLength: int32): void
  _TextPickerAttribute_canLoop(ptr: KPointer, value: KInt): void
  _TextPickerAttribute_defaultPickerItemHeight(ptr: KPointer, valueArray: Uint8Array, valueSerializerLength: int32): void
  _TextPickerAttribute_divider(ptr: KPointer, valueArray: Uint8Array, valueSerializerLength: int32): void
  _TextPickerAttribute_gradientHeight(ptr: KPointer, valueArray: Uint8Array, valueSerializerLength: int32): void
  _TextPickerAttribute_onAccept(ptr: KPointer, callbackArray: Uint8Array, callbackSerializerLength: int32): void
  _TextPickerAttribute_onCancel(ptr: KPointer, callbackArray: Uint8Array, callbackSerializerLength: int32): void
  _TextPickerAttribute_onChange(ptr: KPointer, callbackArray: Uint8Array, callbackSerializerLength: int32): void
  _TextPickerAttribute_selectedIndex(ptr: KPointer, valueArray: Uint8Array, valueSerializerLength: int32): void
  _TextPickerDialog_show(optionsArray: Uint8Array, optionsSerializerLength: int32): void
  _TextPickerInterface__setTextPickerOptions(ptr: KPointer, optionsArray: Uint8Array, optionsSerializerLength: int32): void
  _VectorAttribute_testUnionVector1Number(ptr: KPointer, valueArray: Uint8Array, valueSerializerLength: int32): void
  _VectorAttribute_testUnionVector2Number(ptr: KPointer, valueArray: Uint8Array, valueSerializerLength: int32): void
  _VectorAttribute_testVector1(ptr: KPointer, valueArray: Uint8Array, valueSerializerLength: int32): void
  _VectorAttribute_testVector2(ptr: KPointer, valueArray: Uint8Array, valueSerializerLength: int32): void
}
