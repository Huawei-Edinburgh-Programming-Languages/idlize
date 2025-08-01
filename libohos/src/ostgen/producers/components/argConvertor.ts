/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
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

import * as idl from "@idlizer/core/idl";
import { E, lw, Op, S, Ts } from "../../../ost/main";
import { AdvancedGeneratorContext } from "../common";

function selectPrimitiveTypeName(type: idl.IDLPrimitiveType): string {
    switch (type) {
        case idl.IDLBooleanType: return 'boolean'
        case idl.IDLBufferType: return 'buffer'
        case idl.IDLI8Type: return 'i8'
        case idl.IDLI32Type: return 'i32'
        case idl.IDLI64Type: return 'i64'
        case idl.IDLF32Type: return 'f32'
        case idl.IDLF64Type: return 'f64'
        case idl.IDLNumberType: return 'number'
        case idl.IDLPointerType: return 'pointer'
        case idl.IDLSerializerBuffer: return 'buffer'
        case idl.IDLStringType: return 'string'
        case idl.IDLU8Type: return 'u8'
        case idl.IDLU32Type: return 'u32'
        case idl.IDLU64Type: return 'u64'
        default: throw new Error(`Can not convert "${idl.DebugUtils.debugPrintType(type)}"`)
    }
}
function selectWriteName(type:idl.IDLPrimitiveType): string {
    return "write" + selectPrimitiveTypeName(type)
}
function selectReadName(type:idl.IDLPrimitiveType): string {
    return "read" + selectPrimitiveTypeName(type)
}

export class ArgConvertor {
    constructor(
        private ctx: AdvancedGeneratorContext,
        private sName: lw.LWExpression,
        private isNative: boolean
    ) {}

    private getSerializer(node:idl.IDLNode) {
        return this.isNative
            ? this.ctx.useNativeSerializer(node)
            : this.ctx.useManagedSerializer(node)
    }

    //////////////////////

    write(accessor:lw.LWExpression, type:idl.IDLType): lw.LWStatement {
        if (idl.isPrimitiveType(type)) {
            return S.e(E.call(E.get(this.sName, selectWriteName(type)), [accessor]))
        }
        if (idl.isContainerType(type)) {
            if (idl.IDLContainerUtils.isSequence(type)) {
                return S.block([
                    S.declaration('ii', Ts.prim.i32, true, E.c(0)),
                    S.loop(E.bin(Op.lt, E.v('ii'), E.get(accessor, 'length')), S.block([
                        this.write(E.call(E.get(accessor, 'get'), [E.v('ii')]), type.elementType[0]),
                        S.e(E.bin('=', E.v('ii'), E.bin(Op.add, E.v('ii'), E.c(1))))
                    ]))
                ])
            }
        }
        if (idl.isReferenceType(type)) {
            return S.e(E.call(
                E.get(this.getSerializer(type).name(), 'write'),
                [this.sName, accessor]
            ))
        }
        throw new Error(`Can not process "${idl.DebugUtils.debugPrintType(type)}"`)
    }

    //////////////////////

    read(accessor:lw.LWExpression, type:idl.IDLType): [lw.LWStatement[], lw.LWExpression] {
        if (idl.isPrimitiveType(type)) {
            return [
                [],
                E.call(E.get(this.sName, selectReadName(type)), [accessor])
            ]
        }
        if (idl.isReferenceType(type)) {
            return [
                [],
                E.call(
                    E.get(this.getSerializer(type).name(), 'write'),
                    [this.sName, accessor]
                )
            ]
        }
        throw new Error(`Can not process "${idl.DebugUtils.debugPrintType(type)}"`)
    }

}

export function makeArgConvert() {}
