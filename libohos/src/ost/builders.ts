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
import { AccessorExpression, BinaryExpression, CallExpression, ClassDeclaration, ConstType, DeclarationStatement, FunctionDeclaration, IfStatement, LWExpression, LWStatement, LWType, Modifier, StructureDeclaration } from "./lws"
import { Md, Ts } from "./stdlib";

const id = <T>(it: T) => it

function check(desc: string, ...data: any[]) {
    if (data.find(it => it === undefined))
        throw new Error(desc + "not fully initialized: " + data.join(", "))
}

class AccessorBuilder<P> {
    constructor(private _cont: (expr: AccessorExpression) => P, private object: LWExpression) {
        this._base = object
    }
    private _base?: LWExpression
    private _member?: string
    member(name: string) { this._member = name; return this }
    $(): P {
        check("Accessor", this._base, this._member)
        return this._cont(E.get(this._base!, this._member!))
    }
}

class BinaryBuilder<P> {
    constructor(private _cont: (expr: BinaryExpression) => P, private op: string) {}
    private _lhs?: LWExpression
    private _rhs?: LWExpression
    leftExpr(value: LWExpression) { this._lhs = value; return this }
    leftStr(str: string) { this._lhs = E.v(str); return this }
    rightExpr(value: LWExpression) { this._rhs = value; return this }
    rightStr(str: string | number) { this._rhs = E.c(str); return this }
    left(): ExpressionBuilder<BinaryBuilder<P>> {
        return new ExpressionBuilder(expr => {
            this._lhs = expr
            return this
        })
    }
    right(): ExpressionBuilder<BinaryBuilder<P>> {
        return new ExpressionBuilder(expr => {
            this._rhs = expr
            return this
        })
    }
    $(): P {
        check("Binary", this._lhs, this._rhs)
        return this._cont(E.bin(this.op, this._lhs!, this._rhs!))
    }
}

class ArgBuilder<P> {
    constructor(private _cont: (args: LWExpression[]) => P) {}
    private _args: LWExpression[] = []
    arg(value: LWExpression) { this._args.push(value); return this }
    $(): P {
        return this._cont(this._args)
    }
}

class CallBuilder<P> {
    constructor(private _cont: (expr: CallExpression) => P) {}
    private _object?: LWExpression
    private _function?: string
    private _args: LWExpression[] = []
    objectName(name: string) { this._object = E.v(name); return this }
    object(object: LWExpression) { this._object = object; return this }
    function(name: string) { this._function = name; return this }
    arguments(args: LWExpression[]) { this._args.push(...args); return this }
    args(): ArgBuilder<CallBuilder<P>> {
        return new ArgBuilder(args => {
            this._args.push(...args)
            return this
        })
    }
    $(): P {
        check("Call", this._function)
        const callee = this._object ? E.get(this._object, this._function!) : E.s(this._function!)
        return this._cont(E.call(callee, this._args))
    }
}

class ExpressionBuilder<P> {
    constructor(private _cont: (expr: LWExpression) => P) {}
    private _expr?: LWExpression
    access(object: LWExpression): AccessorBuilder<ExpressionBuilder<P>> {
        return new AccessorBuilder(expr => {
            this._expr = expr
            return this
        }, object)
    }
    binary(op: string): BinaryBuilder<ExpressionBuilder<P>> {
        return new BinaryBuilder(expr => {
            this._expr = expr
            return this
        }, op)
    }
    call(): CallBuilder<ExpressionBuilder<P>> {
        return new CallBuilder(expr => {
            this._expr = expr
            return this
        })
    }
    instanceof(name: string, type: ConstType) { this._expr = E.bin("instanceof", E.v(name), E.c(type.name))} ///need InstanceofExpression
    $(): P {
        check("Expression", this._expr)
        return this._cont(this._expr!)
    }
}

class DeclarationBuilder<P> {
    constructor(private _cont: (stmt: DeclarationStatement) => P, private _name: string, private _type: LWType) {}
    private _mutable: boolean = false
    private _expression?: LWExpression
    mutable() { this._mutable = true; return this }
    valueExpr(expr: LWExpression) { this._expression = expr; return this }
    valueStr(str: string) { this._expression = E.s(str); return this }
    value(): ExpressionBuilder<DeclarationBuilder<P>> {
        return new ExpressionBuilder(expr => {
            this._expression = expr
            return this
        })
    }
    $(): P {
        return this._cont(S.declaration(this._name, this._type, this._mutable, this._expression))
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

class IfBuilder<P> {
    constructor(private _cont: (stmt: IfStatement) => P) {}
    private _cond?: LWExpression
    private _then?: LWStatement
    private _else?: LWStatement
    condition(cond: LWExpression) { this._cond = cond; return this }
    cond(): ExpressionBuilder<IfBuilder<P>> {
        return new ExpressionBuilder(expr => {
            this._cond = expr
            return this
        })
    }
    then(): StatementBuilder<IfBuilder<P>> {
        return new StatementBuilder(stmt => {
            this._then = stmt
            return this
        })
    }
    else(): StatementBuilder<IfBuilder<P>> {
        return new StatementBuilder(stmt => {
            this._else = stmt
            return this
        })
    }
    $(): P {
        check("If", this._cond, this._then)
        return this._cont(S.if(this._cond!, this._then!, this._else))
    }
}

class StatementBuilder<P> {
    constructor(private _cont: (stmt: LWStatement) => P) {}
    private _stmt?: LWStatement
    statements(stmts: LWStatement[]) { this._stmt = S.block(stmts); return this }
    binary(op: string): BinaryBuilder<StatementBuilder<P>> {
        return new BinaryBuilder(stmt => {
            this._stmt = S.e(stmt)
            return this
        }, op)
    }
    block(): BlockBuilder<StatementBuilder<P>> {
        return new BlockBuilder(stmts => {
            this._stmt = S.block(stmts)
            return this
        })
    }
    call(): CallBuilder<StatementBuilder<P>> {
        return new CallBuilder(stmt => {
            this._stmt = S.e(stmt)
            return this
        })
    }
    decl(name: string, type: LWType): DeclarationBuilder<StatementBuilder<P>> {
        return new DeclarationBuilder(stmt => {
            this._stmt = stmt
            return this
        }, name, type)
    }
    if(): IfBuilder<StatementBuilder<P>> {
        return new IfBuilder(stmt => {
            this._stmt = stmt
            return this
        })
    }
    $(): P {
        check("Statement", this._stmt)
        return this._cont(this._stmt!)
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
    static expr(): ExpressionBuilder<LWExpression> { return new ExpressionBuilder(id) }
    static stmt(): StatementBuilder<LWStatement> { return new StatementBuilder(id) }
    static function(): FunctionBuilder<FunctionDeclaration> { return new FunctionBuilder(id) }
    static struct(): StructBuilder { return new StructBuilder() }
    static class(): ClassBuilder { return new ClassBuilder() }
}
