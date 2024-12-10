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

import {
    IDLPrimitiveType,
    IDLReferenceType,
    IDLType,
    isPrimitiveType,
    isReferenceType,
} from "../idl"

export function isValidType(node: IDLType | undefined): node is (IDLReferenceType | IDLPrimitiveType) {
    if ((node === undefined) || (!isReferenceType(node) && !isPrimitiveType(node))) {
        throw new Error(`Type expected to be reference: ${node?.kind}`)
    }
    return true
}

export const enumNames: readonly string[] = [
    'Es2pandaClassDefinitionModifiers',
    'Es2pandaModifierFlags',
    'es2panda_ContextState',
    'Es2pandaScriptFunctionFlags',
    'Es2pandaTSOperatorType',
    'Es2pandaAstNodeType',
    'Es2pandaPrivateFieldKind',
    'Es2pandaVariableDeclarationKind',
    'Es2pandaMemberExpressionKind',
    'Es2pandaTypeRelationFlag',
    'Es2pandaPropertyKind',
    'Es2pandaVariableDeclaratorFlag',
    'Es2pandaTokenType',
    'Es2pandaMetaPropertyKind',
    'Es2pandaTSSignatureDeclarationKind',
    'Es2pandaTSIndexSignatureKind',
    'Es2pandaImportKinds',
    'Es2pandaMethodDefinitionKind',
    'Es2pandaRegExpFlags',
    'Es2pandaMappedOption',
    'Es2pandaPrimitiveType',
    'Es2pandaAccessibilityOption',
    'Es2pandaObjectTypeKind',
    'Es2pandaObjectFlags',
    'Es2pandaRelationResult',
    'Es2pandaTypeFlag',
    'Es2pandaSignatureFlags',
    'Es2pandaTypeFacts',
    'Es2pandaEnumLiteralTypeKind',
    'Es2pandaETSObjectFlags',

    'Es2pandaPropertySearchFlags',
    'Es2pandaCheckerStatus',
    'Es2pandaOverrideErrorCode',
    'Es2pandaVariableFlags',
    'Es2pandaBoxingUnboxingFlags',
    'Es2pandaResolveBindingOptions',
    'Es2pandaResolvedKind',
    'Es2pandaScopeType',
    'Es2pandaScopeFlags',
    'Es2pandaDeclType',
    'Es2pandaRecordTableFlags',
    'Es2pandaExpressionParseFlags',
    'Es2pandaStatementParsingFlags',
]

export function getIrType(type: IDLReferenceType | IDLPrimitiveType): string {
    const tags: readonly string[] = type.extendedAttributes?.map((tag => tag.name)) ?? []

    const getSuffix = function(): string {
        if (tags.includes('ptr_1')) {
            return '*'
        }
        if (tags.includes('ptr_2')) {
            return '**'
        }
        if (tags.includes('ptr_3')) {
            return '***'
        }
        return ''
    }

    const getType = function(): string {
        switch (type.name) {
            case 'es2panda_AstNode':
            case 'es2panda_Context':
            case 'es2panda_Config':
            case 'es2panda_Program':
            case 'es2panda_ExternalSource':
            case 'es2panda_Scope':
            case 'es2panda_Type':
            case 'es2panda_Variable':
            case 'es2panda_FunctionSignature':
            case 'es2panda_ValidationInfo':
            case 'es2panda_Signature':
            case 'es2panda_ImportSource':
            case 'es2panda_CodeGen':
            case 'es2panda_VReg':
            case 'es2panda_LabelPair':
            case 'es2panda_SourceRange':
            case 'es2panda_SourcePosition':
            case 'es2panda_AstDumper':
            case 'es2panda_SrcDumper':
            case 'es2panda_AstVisitor':
            case 'es2panda_IndexInfo':
            case 'es2panda_ObjectDescriptor':
            case 'es2panda_TypeRelation':
            case 'es2panda_GlobalTypesHolder':
            case 'es2panda_SignatureInfo':
            case 'es2panda_CheckerContext':
            case 'es2panda_ErrorLogger':
            case 'es2panda_ResolveResult':
            case 'es2panda_RecordTable':
            case 'es2panda_Declaration':
            case 'es2panda_IRNode':
            case 'es2panda_ScopeFindResult':
            case 'es2panda_BindingProps':
            case 'es2panda_DynamicImportData':
            case 'es2panda_BoundContext': return '_'

            case 'bool': return 'bool'
            case 'int': return 'int'
            case 'int8_t': return 'int8_t'
            case 'uint8_t': return 'uint8_t'
            case 'int16_t': return 'int16_t'
            case 'uint16_t': return 'uint16_t'
            case 'int32_t': return 'int32_t'
            case 'uint32_t': return 'uint32_t'
            case 'int64_t': return 'int64_t'
            case 'uint64_t': return 'uint64_t'
            case 'char16_t': return 'char16_t'
            case 'double': return 'double'
            case 'float': return 'float'
            case 'size_t': return 'size_t'
            case 'char': return 'char'
            case 'void': return 'void'
            case 'void_ptr': return 'void_ptr'
        }
        if (enumNames.includes(type.name)) {
            return type.name
        }
        throw new Error(`Unsupported type: ${type.name}`)
    }

    return getType() + getSuffix()
}
