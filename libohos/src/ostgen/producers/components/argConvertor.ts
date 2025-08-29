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
import { An, E, lw, Op, S, std, T, Ts } from "../../../ost";
import { AdvancedGeneratorContext, bridgeName } from "../common";
import { Builders } from "../../../ost/builders";
import { ConstType, IfStatement, LWExpression, LWKind, LWType } from "../../../ost/lws";

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
        private native: boolean
    ) {}

    private getSerializer(node:idl.IDLNode) {
        return this.native
            ? this.ctx.useNativeSerializer(node)
            : this.ctx.useManagedSerializer(node)
    }

    //////////////////////

    write(accessor:lw.LWExpression, type:idl.IDLType): lw.LWStatement {
        if (idl.isPrimitiveType(type)) {
            return S.e(E.call(E.get(this.sName, selectWriteName(type)), [accessor]))
        }
        if (idl.isReferenceType(type)) {
            const decl = this.ctx.base.resolver.toDeclaration(type)
            return decl && idl.isEnum(decl)
                ? Builders.expr().call()
                    .receiverExpr(this.sName)
                    .functionName('writeInt32')
                    .args([accessor]).$().$stmt()
                : Builders.expr().call().function()
                    .access(this.getSerializer(type).name())
                    .member('write')
                    .static().$().$()
                    .args([this.sName, accessor]).$().$stmt()
        }
        if (idl.isContainerType(type)) {
            if (idl.IDLContainerUtils.isSequence(type)) {
                return Builders.block()
                    .call().receiverExpr(this.sName).functionName('writeInt32')
                        .arg().access(accessor).member('length').$().$().$()
                    .loop()
                        .init().decl('i', Ts.prim.i32).mutable().valueStr('0').$().$()
                        .cond().binary(Op.lt).leftStr('i').right().access(accessor).member('length').$().$().$().$()
                        .step().binary('=').leftStr('i').right().binary(Op.add).leftStr('i').rightStr(1).$().$().$().$()
                        .bodyStmt(
                            this.write(
                                Builders.access(accessor).indexStr('i').$(),
                                type.elementType[0]))
                        .$().$()
            }
        }
        if (idl.isUnionType(type)) {
            return type.types
                .map((ty, i) => {
                    const cond = this.native
                        ? Builders.binary(Op.eq)
                            .left().access(accessor).member('selector').$().$()
                            .rightStr(i).$()
                        : Builders.binary('instanceof').leftExpr(accessor).rightStr('///TYPE').$()
                    const value = this.native
                        ? Builders.access(accessor).member('value' + i).$()
                        : accessor /// cast to `ty`
                    return Builders.if()
                        .condition(cond)
                        .then().block()
                            .call().receiverExpr(this.sName).functionName('writeInt8').args([E.c(i)]).$().$()
                            .call().receiverExpr(this.sName).functionName('write///TYPE').args([value]).$().$()
                        .$()
                })
                .reduceRight((a, b) => (a as IfStatement).elseBody = b)
        }
        throw new Error(`Can not process "${idl.DebugUtils.debugPrintType(type)}"`)
    }

    //////////////////////

    read(accessor:lw.LWExpression, type:idl.IDLType): [lw.LWStatement[], lw.LWExpression] {
        if (idl.isPrimitiveType(type)) {
            const expr = Builders.expr().call()
                .receiverExpr(this.sName)
                .functionName(selectReadName(type)).$()
            if (!this.native && type === idl.IDLNumberType) // ugh
                expr.cast(Ts.prim.number)
            return [[], expr.$()]
        }
        if (idl.isReferenceType(type)) {
            const decl = this.ctx.base.resolver.toDeclaration(type)
            return [[],
                decl && idl.isEnum(decl)
                    ? Builders.call().receiverExpr(this.sName).functionName('readInt32').$()///cast
                    : Builders.call()
                        .function()
                            .access(this.getSerializer(type).name())
                            .member('read')
                            .static().$().$()
                        .args([this.sName])
                        .$()
            ]
        }
        if (idl.isContainerType(type)) {
            if (idl.IDLContainerUtils.isSequence(type)) {
                const elemType = (this.native ? this.ctx.useCApi : this.ctx.useManaged)(type.elementType[0]).reference()
                const lengthDecl = Builders.decl('length', Ts.prim.i32).value()
                    .call().receiverExpr(this.sName).functionName('readInt32').$().$().$()
                const bufferDecl = Builders.decl('buffer', T.c('idlize.Array', elemType)).value()///std name?
                    .ctor().args([E.v('length')]).$().$().$()///pass type to ctor
                const loop = Builders.loop()
                    .init().decl('i', Ts.prim.i32).valueStr(0).$().$()
                    .cond().binary(Op.lt).leftStr('i').rightStr('length').$().$()
                    ///.step()
                    .body().binary('=')
                        .left().access(E.v('buffer')).indexStr('i').$().$()
                        .rightExpr(this.read(accessor, type.elementType[0])[1]).$().$()///read() may return stmts, accommodate!
                    .$()
                return [[lengthDecl, bufferDecl, loop], E.v('buffer')]
            }
        }
        if (idl.isUnionType(type)) {
            const selectorDecl = Builders.decl('selector', Ts.prim.i8)
                .value().call().receiverExpr(this.sName).functionName('readInt8').$().$().$()
            const tmpDecl = this.native
                ? Builders.decl('tmp', T.c('///UNION')).valueStr('{}').$()
                : Builders.decl('tmp', T.c('///UNION')).$()
            const ifs = type.types.map((ty, i) => {
                const call = Builders.call().receiverExpr(this.sName).functionName('read///TYPE').$()
                const assignments = this.native
                    ? [ Builders.stmt().binary(Op.eq)
                            .left().access(E.v('tmp')).member('selector').$().$()
                            .rightStr(i).$().$(),
                        Builders.stmt().binary(Op.eq)
                            .left().access(E.v('tmp')).member('value' + i).$().$()
                            .rightExpr(call).$().$()]
                    : [ Builders.stmt().binary(Op.eq).leftStr('tmp').rightExpr(call).$().$()]
                return Builders.if()
                    .cond().binary(Op.eq).leftStr('selector').rightStr(i).$().$()
                    .then().statements(assignments).$().$()
            })
            return [ [selectorDecl, tmpDecl, ...ifs], E.v('tmp!')]
        }
        throw new Error(`Can not process "${idl.DebugUtils.debugPrintType(type)}"`)
    }

}

export function materializedToPtr(value: string, native: boolean): LWExpression {
    return native
        ? E.v(value)
        : Builders.call().functionName('toPeerPtr').arg(value).$().$()
}

export function ptrToMaterialized(value: string, type: LWType, native: boolean): LWExpression {
    return native
        ? {
            kind: LWKind.CastExpression,
            expression: E.v(value),
            type,
            hints: [An.staticMethod()]
        }
        : Builders.call()
            .receiverExpr(E.v((type as ConstType).name + 'Internal', [An.isType()]))
            .functionName('fromPtr').arg(value).$().$()
}
