import { int32 } from "@koalaui/common"
import { KPointer, KInt, KStringPtr, pointer } from "@koalaui/interop"
import { RuntimeType, runtimeType, unsafeCast } from "./SerializerBase"
import { Serializer } from "%SERIALIZER_PATH%"
import { Finalizable } from "%FINALIZABLE_PATH%"

%PEER_CONTENT%
