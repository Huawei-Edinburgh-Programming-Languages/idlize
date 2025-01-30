package idlize

import Interop.*

public type Callback_RangeUpdate = (index: Int32, mark: pointer, end: Int32) -> Unit
public type Callback_String_Void = (str: String) -> Unit
public type Callback_Extender_OnProgress = (value: Float32) -> Unit
public type Callback_Extender_OnFinish = () -> Unit
public type Callback_Extender_OnAnimation = () -> UInt8
public type NavExtender_OnUpdateStack = (str: String) -> Unit