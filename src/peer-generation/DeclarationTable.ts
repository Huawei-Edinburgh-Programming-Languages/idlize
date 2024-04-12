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

import * as ts from "typescript"
import { asString, getDeclarationsByNode, identName } from "../util"

type DeclarationTarget = ts.ClassDeclaration | ts.InterfaceDeclaration | ts.UnionTypeNode | ts.TypeLiteralNode | ts.ImportTypeNode

class DeclarationRecord {
    public nameBasic: string = ""
    public nameOptional: string = ""

    constructor (public target: DeclarationTarget) {}
    requestVariant(name: string, optional: boolean) {
        if (optional) {
            if (this.nameOptional.length == 0)
                this.nameOptional = name
        } else  {
            if (this.nameBasic.length == 0) {
                this.nameBasic = name
            }
        }
    }
    getVariantName(optional: boolean): string {
        if (optional) {
            if (this.nameOptional.length == 0)
                throw new Error("Not defined optional name")
            return this.nameOptional
        } else {
            if (this.nameBasic.length == 0)
                throw new Error("Not defined basic name")
            return this.nameBasic
        }
    }
}

export class DeclarationTable {
    declarations = new Set<DeclarationTarget>()
    typeMap = new Map<ts.TypeNode, DeclarationRecord>()
    typeChecker: ts.TypeChecker | undefined = undefined
    constructor() {}

    getTypeName(type: ts.TypeNode, optional: boolean = false) {
        let declaration: DeclarationRecord|undefined = this.typeMap.get(type)
        if (!declaration) {
            this.requestType(undefined, type, optional)
        }
        declaration = this.typeMap.get(type)!
        return declaration.getVariantName(optional)
    }

    requestType(name: string|undefined, type: ts.TypeNode, optional: boolean = false) {
        let declaration: DeclarationRecord|undefined = this.typeMap.get(type)
        if (!name) name = this.computeTypeName(type, optional)
        if (declaration) {
            declaration.requestVariant(name, optional)
            return
        }
        let target = this.findDeclaration(type)
        if (!target) throw new Error(`Cannot find declaration: ${type.getText()}`)
        this.declarations.add(target)
        let record = new DeclarationRecord(target)
        record.requestVariant(name, optional)
        this.typeMap.set(type, record)
    }

    findDeclaration(type: ts.TypeNode): DeclarationTarget | undefined {
        if (ts.isUnionTypeNode(type)) return type
        if (ts.isTypeLiteralNode(type)) return type
        if (ts.isImportTypeNode(type)) return type
        if (ts.isTypeReferenceNode(type)) {
            let declarations = getDeclarationsByNode(this.typeChecker!, type.typeName)
            while (declarations.length > 0 && ts.isTypeAliasDeclaration(declarations[0])) {
                type = declarations[0].type
                declarations = getDeclarationsByNode(this.typeChecker!, declarations[0].type) ?? []
            }
            let decl = declarations[0]
            if (ts.isClassDeclaration(decl) || ts.isInterfaceDeclaration(decl)) return decl
            throw new Error(`Wrong declaration: ${decl.getText()}`)
        }
        throw new Error(`Unknown type: ${type.getText()} ${asString(type)}`)
    }

    computeTypeName(type: ts.TypeNode, optional: boolean = false): string {
        let name = this.computeTypeNameImpl(type, optional)
        this.requestType(name, type, optional)
        return name
    }

    private computeTypeNameImpl(type: ts.TypeNode, optional: boolean): string {
        const prefix = optional ? "Optional_" : ""
        if (ts.isImportTypeNode(type)) {
            return prefix + identName(type.qualifier)!
        }
        if (ts.isTypeReferenceNode(type)) {
            return prefix + identName(type.typeName)!
        }
        if (ts.isUnionTypeNode(type)) {
            return prefix + `Union_${type.types.map(it => this.computeTypeNameImpl(it, optional)).join("_")}`
        }
        if (ts.isOptionalTypeNode(type)) {
            return "Optional_" +  this.computeTypeNameImpl(type.type, false)
        }
        if (ts.isTupleTypeNode(type)) {
            return prefix + `Tuple_${type.elements.map(it => this.computeTypeNameImpl(it, optional)).join("_")}`
        }
        if (ts.isParenthesizedTypeNode(type)) {
            return this.computeTypeNameImpl(type.type!, optional)
        }
        if (ts.isTypeLiteralNode(type)) {
            return prefix + `Literal_${type.members.map(member => {
                if (ts.isPropertySignature(member)) {
                    return this.computeTypeNameImpl(member.type!, member.questionToken != undefined)
                } else {
                    return undefined
                }
            })
            .filter(it => it != undefined)
            .join("_")}`
        }
        if (ts.isFunctionTypeNode(type)) {
            return prefix + "Function"
        }
        if (ts.isArrayTypeNode(type)) {
            return prefix + `Array_` + this.computeTypeNameImpl(type.elementType, false)
        }
        if (type.kind == ts.SyntaxKind.NumberKeyword) {
            return prefix + `Number`
        }
        if (type.kind == ts.SyntaxKind.UndefinedKeyword) {
            return `Undefined`
        }
        if (type.kind == ts.SyntaxKind.StringKeyword) {
            return prefix + `String`
        }
        if (type.kind == ts.SyntaxKind.BooleanKeyword) {
            return prefix + `Boolean`
        }
        throw new Error(`Cannot compute type name: ${type.getText()}`)
    }

}