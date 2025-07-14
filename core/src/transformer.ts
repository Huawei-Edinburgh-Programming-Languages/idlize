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

import * as idl from './idl'

export class IDLIdentityTransformer {

    private cloneNodeInitializer(node:idl.IDLNode): idl.IDLNodeInitializer | undefined {
        return {
            documentation: node.documentation,
            extendedAttributes: node.extendedAttributes?.map(e => ({ name: e.name, value: e.value })),
            fileName: node.fileName,
        }
    }

    visitInterface(node:idl.IDLInterface): idl.IDLInterface {
        return idl.createInterface(
            node.name,
            node.subkind,
            node.inheritance.map(x => this.visitReferenceType(x)),
            node.constructors.map(x => this.visitConstructor(x)),
            node.constants.map(x => this.visitConstant(x)),
            node.properties.map(x => this.visitProperty(x)),
            node.methods.map(x => this.visitMethod(x)),
            node.callables.map(x => this.visitCallable(x)),
            node.typeParameters,
            this.cloneNodeInitializer(node)
        )
    }
    visitImport(node:idl.IDLImport): idl.IDLImport {
        return idl.createImport(
            node.clause,
            node.name,
            this.cloneNodeInitializer(node)
        )
    }
    visitCallback(node:idl.IDLCallback): idl.IDLCallback {
        return idl.createCallback(
            node.name,
            node.parameters.map(x => this.visitParameter(x)),
            this.visitType(node.returnType),
            this.cloneNodeInitializer(node),
            node.typeParameters
        )
    }
    visitConstant(node:idl.IDLConstant): idl.IDLConstant {
        return idl.createConstant(
            node.name,
            this.visitType(node.type),
            node.value,
            this.cloneNodeInitializer(node)
        )
    }
    visitProperty(node:idl.IDLProperty): idl.IDLProperty {
        return idl.createProperty(
            node.name,
            this.visitType(node.type),
            node.isReadonly,
            node.isStatic,
            node.isOptional,
            this.cloneNodeInitializer(node)
        )
    }
    visitParameter(node:idl.IDLParameter): idl.IDLParameter {
        return idl.createParameter(
            node.name,
            this.visitType(node.type),
            node.isOptional,
            node.isVariadic,
            this.cloneNodeInitializer(node),
        )
    }
    visitMethod(node:idl.IDLMethod): idl.IDLMethod {
        return idl.createMethod(
            node.name,
            node.parameters.map(x => this.visitParameter(x)),
            this.visitType(node.returnType),
            {
                isAsync: node.isAsync,
                isFree: node.isFree,
                isOptional: node.isOptional,
                isStatic: node.isStatic
            },
            this.cloneNodeInitializer(node),
            node.typeParameters
        )
    }
    visitCallable(node:idl.IDLCallable): idl.IDLCallable {
        return idl.createCallable(
            node.name,
            node.parameters.map(x => this.visitParameter(x)),
            this.visitType(node.returnType),
            {
                isAsync: node.isAsync,
                isStatic: node.isStatic
            },
            this.cloneNodeInitializer(node),
            node.typeParameters
        )
    }
    visitConstructor(node:idl.IDLConstructor): idl.IDLConstructor {
        return idl.createConstructor(
            node.parameters.map(x => this.visitParameter(x)),
            this.visitType(node.returnType ?? idl.IDLVoidType),
            this.cloneNodeInitializer(node)
        )
    }
    visitEnum(node:idl.IDLEnum): idl.IDLEnum {
        return idl.createEnum(
            node.name,
            node.elements.map(x => this.visitEnumMember(x)),
            this.cloneNodeInitializer(node) ?? {}
        )
    }
    visitEnumMember(node:idl.IDLEnumMember): idl.IDLEnumMember {
        return idl.createEnumMember(
            node.name,
            /* because parent will we reset to real parent during linkParentBack */
            idl.createEnum('$FAKE$', [], {}),
            this.visitPrimitiveType(node.type),
            node.initializer,
            this.cloneNodeInitializer(node)
        )
    }
    visitTypedef(node:idl.IDLTypedef): idl.IDLEntry {
        return idl.createTypedef(
            node.name,
            this.visitType(node.type),
            node.typeParameters,
            this.cloneNodeInitializer(node)
        )
    }
    visitPrimitiveType(node:idl.IDLPrimitiveType): idl.IDLPrimitiveType {
        return node
    }
    visitContainerType(node:idl.IDLContainerType): idl.IDLType {
        return idl.createContainerType(
            node.containerKind,
            node.elementType.map(x => this.visitType(x)),
            this.cloneNodeInitializer(node)
        )
    }
    visitUnspecifiedGenericType(node:idl.IDLUnspecifiedGenericType): idl.IDLUnspecifiedGenericType {
        return idl.createUnspecifiedGenericType(
            node.name,
            node.typeArguments.map(x => this.visitType(x)),
            this.cloneNodeInitializer(node)
        )
    }
    visitReferenceType(node:idl.IDLReferenceType): idl.IDLReferenceType {
        return idl.createReferenceType(
            node.name,
            node.typeArguments?.map(x => this.visitType(x)),
            this.cloneNodeInitializer(node)
        )
    }
    visitUnionType(node:idl.IDLUnionType): idl.IDLType {
        return idl.createUnionType(
            node.types.map(x => this.visitType(x)),
            node.name,
            this.cloneNodeInitializer(node)
        )
    }
    visitTypeParameterType(node:idl.IDLTypeParameterType): idl.IDLType {
        return idl.createTypeParameterReference(
            node.name,
            this.cloneNodeInitializer(node)
        )
    }
    visitOptionalType(node:idl.IDLOptionalType): idl.IDLType {
        return idl.createOptionalType(
            this.visitType(node.type),
            this.cloneNodeInitializer(node)
        )
    }
    visitVersion(node:idl.IDLVersion): idl.IDLVersion {
        return idl.createVersion(
            node.value,
            this.cloneNodeInitializer(node)
        )
    }
    visitNamespace(node:idl.IDLNamespace): idl.IDLNamespace {
        return idl.createNamespace(
            node.name,
            node.members.map(x => this.visitEntry(x)),
            this.cloneNodeInitializer(node)
        )
    }
    visitFile(node:idl.IDLFile): idl.IDLFile {
        return idl.createFile(
            node.entries.map(x => this.visitEntry(x)),
            node.fileName,
            node.packageClause,
            this.cloneNodeInitializer(node)
        )
    }

    ////

    visitEntry(node:idl.IDLEntry): idl.IDLEntry {
        if (idl.isInterface(node)) {
            return this.visitInterface(node)
        }
        if (idl.isImport(node)) {
            return this.visitImport(node)
        }
        if (idl.isCallback(node)) {
            return this.visitCallback(node)
        }
        if (idl.isConstant(node)) {
            return this.visitConstant(node)
        }
        if (idl.isProperty(node)) {
            return this.visitProperty(node)
        }
        if (idl.isParameter(node)) {
            return this.visitParameter(node)
        }
        if (idl.isMethod(node)) {
            return this.visitMethod(node)
        }
        if (idl.isCallable(node)) {
            return this.visitCallable(node)
        }
        if (idl.isConstructor(node)) {
            return this.visitConstructor(node)
        }
        if (idl.isEnum(node)) {
            return this.visitEnum(node)
        }
        if (idl.isEnumMember(node)) {
            return this.visitEnumMember(node)
        }
        if (idl.isTypedef(node)) {
            return this.visitTypedef(node)
        }
        if (idl.isVersion(node)) {
            return this.visitVersion(node)
        }
        if (idl.isNamespace(node)) {
            return this.visitNamespace(node)
        }
        throw new Error(`Not exhaustive "${idl.IDLKind[node.kind]}"`)
    }
    visitType(node:idl.IDLType): idl.IDLType {
        if (idl.isPrimitiveType(node)) {
            return this.visitPrimitiveType(node)
        }
        if (idl.isContainerType(node)) {
            return this.visitContainerType(node)
        }
        if (idl.isUnspecifiedGenericType(node)) {
            return this.visitUnspecifiedGenericType(node)
        }
        if (idl.isReferenceType(node)) {
            return this.visitReferenceType(node)
        }
        if (idl.isUnionType(node)) {
            return this.visitUnionType(node)
        }
        if (idl.isTypeParameterType(node)) {
            return this.visitTypeParameterType(node)
        }
        if (idl.isOptionalType(node)) {
            return this.visitOptionalType(node)
        }
        throw new Error(`Not exhaustive "${idl.IDLKind[node.kind]}"`)
    }
}

export function applyTransformer(transformer:IDLIdentityTransformer, files:idl.IDLFile[]): idl.IDLFile[] {
    return files.map(file => idl.linkParentBack(transformer.visitFile(file)))
}
