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
import { GeneratorContext } from "../../context";
import { E, lw, S } from "lws";

function selectWriteName(type:idl.IDLPrimitiveType): string {
    switch (type) {
        case idl.IDLI32Type: return 'writeInt32'
        case idl.IDLStringType: return 'writeString'
        default: throw new Error(`Can not convert "${idl.DebugUtils.debugPrintType(type)}"`)
    }
}
function selectReadName(type:idl.IDLPrimitiveType): string {
    switch (type) {
        case idl.IDLI32Type: return 'readInt32'
        case idl.IDLStringType: return 'readString'
        default: throw new Error(`Can not convert "${idl.DebugUtils.debugPrintType(type)}"`)
    }
}

export class ArgConvertor {
    constructor(
        private ctx: GeneratorContext,
        private sName: lw.LWExpression,
    ) {}

    //////////////////////

    write(accessor:lw.LWExpression, type:idl.IDLType): lw.LWStatement {
        if (idl.isPrimitiveType(type)) {
            return S.e(E.call(E.get(this.sName, selectWriteName(type)), [accessor]))
        }
        if (idl.isReferenceType(type)) {
            return S.e(E.call(
                E.get(this.ctx.use({ node: type, role: 'serializer' }).name(), 'write'),
                [this.sName, accessor]
            ))
        }
        throw new Error(`Can not process "${idl.DebugUtils.debugPrintType(type)}"`)
    }

    //////////////////////


}

export function makeArgConvert() {}
