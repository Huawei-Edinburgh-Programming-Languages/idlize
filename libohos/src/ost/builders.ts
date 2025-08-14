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

import { D, DD, E, S, T } from "./builder"
import { CallExpression, ClassDeclaration, FunctionDeclaration, LWExpression, LWStatement, LWType, Modifier, StructureDeclaration } from "./lws"
import { Md, Ts } from "./stdlib";

const id = <T>(it: T) => it

function check(desc: string, ...data: any[]) {
    if (data.find(it => it === undefined))
        throw new Error(desc + "not fully initialized: " + data.join(", "))
}

class CallBuilder<P> {
    constructor(private _cont: (expr: CallExpression) => P) {}
    private _object?: string
    private _function?: string
    private _args: LWExpression[] = []
    object(name: string) { this._object = name; return this }
    function(name: string) { this._function = name; return this }
    args(args: LWExpression[]) { this._args.push(...args); return this }
    $(): P {
        check("Call", this._function)
        const callee = this._object ? E.get(E.v(this._object), this._function!) : E.s(this._function!)
        return this._cont(E.call(callee, this._args))
    }
}

class ReturnBuilder<P> {
    constructor(private _cont: (stmt: LWStatement) => P, private _type?: LWType) {}
    private _expr?: LWExpression
    call(): CallBuilder<ReturnBuilder<P>> {
        return new CallBuilder(expr => {
            this._expr = expr
            return this
        })
    }
    $(): P {
        if (this._expr) {
            // either `return e` or just `e`
            const wrap = this._type === Ts.prim.void ? S.e : S.return
            return this._cont(wrap(this._expr!))
        }
        // plain `return`
        return this._cont(S.return())
    }
}

class BlockBuilder<P> {
    constructor(private _cont: (stmts: LWStatement[]) => P) {}
    private _stmts: LWStatement[] = []
    call(): CallBuilder<BlockBuilder<P>> {
        return new CallBuilder(stmt => {
            this._stmts.push(S.e(stmt))
            return this
        })
    }
    return(type?: LWType): ReturnBuilder<BlockBuilder<P>> {
        return new ReturnBuilder(stmt => {
            this._stmts.push(stmt)
            return this
        }, type)
    }
    $(): P {
        return this._cont(this._stmts)
    }
}

class ParamBuilder<P> {
    constructor(private _cont: (name: string, type: LWType) => P) {}
    private _name?: string
    private _type?: LWType
    name(name: string) { this._name = name; return this }
    type(type: string) { this._type = T.cc(type); return this }
    $(): P {
        check("Parameter", this._name, this._type)
        return this._cont(this._name!, this._type!)
    }
}

class FunctionBuilder<P> {
    constructor(private _cont: (decl: FunctionDeclaration) => P) {}
    private _name?: string
    private _modifiers: Modifier[] = []
    private _parameters: { name: string, type: LWType }[] = []
    private _returnType?: LWType
    private _body?: LWStatement

    static() { this._modifiers.push(Md.static); return this }
    name(name: string) { this._name = name; return this }
    returns(type: LWType) { this._returnType = type; return this }
    body(body: LWStatement) { this._body = body; return this }
    parameters(params: {name: string, type: LWType}[]) { this._parameters.push(...params); return this }
    param(): ParamBuilder<FunctionBuilder<P>> {
        return new ParamBuilder((name, type) => {
            this._parameters.push({name, type})
            return this
        })
    }
    block(): BlockBuilder<FunctionBuilder<P>> {
        return new BlockBuilder(stmts => {
            this._body = S.block(stmts)
            return this
        })
    }
    $(): P {
        check("Function", this._name, this._returnType, this._body)
        return this._cont(
            DD({generics: [], modifiers: this._modifiers})
                .func(this._name!, this._parameters, this._returnType!, this._body!))
    }
}

class FieldBuilder<P> {
    constructor(private _cont: (name: string, type: LWType, modifiers?: Modifier[]) => P) {}
    private _name?: string ///superclass
    private _type?: LWType
    private _modifiers: Modifier[] = []
    static() { this._modifiers.push(Md.static); return this }
    optional() { this._modifiers.push(Md.optional); return this }
    readonly() { this._modifiers.push(Md.readonly); return this }
    name(name: string) { this._name = name; return this }
    type(type: LWType) { this._type = type; return this }
    modifiers(modifiers: Modifier[]) { this._modifiers.push(...modifiers); return this }
    $(): P {
        check("Field", this._name, this._type)
        return this._cont(this._name!, this._type!, this._modifiers)
    }
}

class StructBuilder {
    private _name?: string
    private _fields: { name: string, type: LWType, modifiers?: Modifier[] }[] = []
    name(name: string) { this._name = name; return this }
    field(): FieldBuilder<StructBuilder> {
        return new FieldBuilder((name, type, modifiers) => {
            this._fields.push({name, type, modifiers})
            return this
        })
    }
    $(): StructureDeclaration {
        check("Struct", this._name)
        return D.struct(this._name!, this._fields)
    }
}

class ClassBuilder {///extend StructB
    private _name?: string
    private _fields: { name: string, type: LWType, modifiers?: Modifier[] }[] = []
    private _methods: FunctionDeclaration[] = []
    name(name: string) { this._name = name; return this }
    field(): FieldBuilder<ClassBuilder> {
        return new FieldBuilder((name, type, modifiers) => {
            this._fields.push({name, type, modifiers})
            return this
        })
    }
    method(): FunctionBuilder<ClassBuilder> {
        return new FunctionBuilder(func => {
            this._methods.push(func)
            return this
        })
    }
    $(): ClassDeclaration {
        check("Class", this._name)
        return D.class(this._name!, this._fields, this._methods)
    }
}

export class Builders {
    static struct(): StructBuilder { return new StructBuilder() }
    static class(): ClassBuilder { return new ClassBuilder() }
    static function(): FunctionBuilder<FunctionDeclaration> { return new FunctionBuilder(id) }
}
