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
import { E, lw, Op, S, T, Ts } from "../../../ost/main";
import { AdvancedGeneratorContext } from "../common";
import { Builders } from "../../../ost/builders";
import { IfStatement } from "../../../ost/lws";

function selectPrimitiveTypeName(type: idl.IDLPrimitiveType): string {
    switch (type) {
        case idl.IDLBooleanType: return 'Boolean'
        case idl.IDLBufferType: return 'Buffer'
        case idl.IDLI8Type: return 'Int8'
        case idl.IDLI32Type: return 'Int32'
        case idl.IDLI64Type: return 'Int64'
        case idl.IDLF32Type: return 'Float32'
        case idl.IDLF64Type: return 'Float64'
        case idl.IDLNumberType: return 'Number'
        case idl.IDLPointerType: return 'Pointer'
        case idl.IDLSerializerBuffer: return 'Buffer'
        case idl.IDLStringType: return 'String'
        case idl.IDLU8Type: return 'Int8'
        case idl.IDLU32Type: return 'Int32'
        case idl.IDLU64Type: return 'Int64'
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
        if (idl.isUnionType(type)) {
            return type.types
                .map((ty, i) => {
                    const cond = this.isNative
                        ? Builders.expr().binary(Op.eq)
                            .left().access(accessor).member('selector').$().$()
                            .rightStr(i).$().$()
                        : Builders.expr().binary('instanceof').leftExpr(accessor).rightStr('///TYPE').$().$()
                    const value = this.isNative
                        ? Builders.expr().access(accessor).member('value' + i).$().$()
                        : accessor /// cast to `ty`
                    return Builders.stmt().if()
                        .condition(cond)
                        .then().block()
                            .call().object(this.sName).function('writeInt8').arguments([E.c(i)]).$().$()
                            .call().object(this.sName).function('write///TYPE').arguments([value]).$().$()
                        .$().$()
                })
                .reduceRight((a, b) => (a as IfStatement).elseBody = b)
        }
        if (idl.isReferenceType(type)) {
            const decl = this.ctx.base.resolver.toDeclaration(type)
            if (decl && idl.isEnum(decl))
                return S.e(E.call(E.get(this.sName, 'writeInt32'), [accessor]))///cast
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
            return [[],
                E.call(E.get(this.sName, selectReadName(type)), [accessor])]
        }
        if (idl.isUnionType(type)) {
            const selectorDecl = Builders.stmt().decl('selector', Ts.prim.i8)
                .value().call().object(this.sName).function('readInt8').$().$().$().$()
            const tmpDecl = this.isNative
                ? Builders.stmt().decl('tmp', T.c('///UNION')).valueStr('{}').$().$()
                : Builders.stmt().decl('tmp', T.c('///UNION')).$().$()
            const ifs = type.types.map((ty, i) => {
                const call = Builders.expr().call().object(this.sName).function('read///TYPE').$().$()
                const assignments = this.isNative
                    ? [ Builders.stmt().binary(Op.eq)
                            .left().access(E.v('tmp')).member('selector').$().$()
                            .rightStr(i).$().$(),
                        Builders.stmt().binary(Op.eq)
                            .left().access(E.v('tmp')).member('value' + i).$().$()
                            .rightExpr(call).$().$()]
                    : [ Builders.stmt().binary(Op.eq).leftStr('tmp').rightExpr(call).$().$()]
                return Builders.stmt().if()
                    .cond().binary(Op.eq).leftStr('selector').rightStr(i.toString()).$().$()
                    .then().statements(assignments).$().$().$()
            })
            return [ [selectorDecl, tmpDecl, ...ifs], E.v('tmp!')]
        }
        if (idl.isReferenceType(type)) {
            const decl = this.ctx.base.resolver.toDeclaration(type)
            if (decl && idl.isEnum(decl))
                return [[],
                    E.call(E.get(this.sName, 'readInt32'), [accessor])]///cast
            return [[],
                E.call(
                    E.get(this.getSerializer(type).name(), 'write'),
                    [this.sName, accessor])]
        }
        throw new Error(`Can not process "${idl.DebugUtils.debugPrintType(type)}"`)
    }

}

export function makeArgConvert() {}
