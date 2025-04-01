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

import * as webidl2 from "webidl2"
import * as fs from "fs"
import {
    isAttribute, isCallback, isClass, isConstant, isConstructor, isDictionary, isEnum, isInterface, isOperation, isOptional,
    isPromiseTypeDescription,
    isRecordTypeDescription,
    isSequenceTypeDescription,
    isSingleTypeDescription, isTypedef, isUnionTypeDescription,
    isUnspecifiedGenericTypeDescription
} from "./webidl2-utils"
import { toString } from "./toString"
import * as idl from "../idl"
import * as lib from "../library"
import { isDefined, stringOrNone, warn } from "../util"
import { generateSyntheticUnionName } from "../peer-generation/idl/common"

export type WebIDLTokenCollection = Record<string, webidl2.Token | null | undefined>
export type IDLTokenInfoMap = Map<unknown, WebIDLTokenCollection>

function getTokens(node:webidl2.AbstractBase): WebIDLTokenCollection {
    return (node as any).tokens
}
function withInfo<T>(info:IDLTokenInfoMap, from:webidl2.AbstractBase, result:T): T {
    info.set(result, getTokens(from))
    return result
}

const syntheticTypes = new Map<string, idl.IDLEntry>()

export function addSyntheticType(name: string, type: idl.IDLEntry) {
    if (syntheticTypes.has(name))
        warn(`duplicate synthetic type name "${name}"`) ///throw?
    syntheticTypes.set(name, type)
} // check

export function resolveSyntheticType(type: idl.IDLReferenceType): idl.IDLEntry | undefined {
    return syntheticTypes.get(type.name)
}

function toIDLNode(file: string, node: webidl2.IDLRootType, info:IDLTokenInfoMap): idl.IDLEntry {
    return toIDLNodeForward(file, node, info)
}

function toIDLNodeForward(file: string, node: webidl2.IDLRootType, info: IDLTokenInfoMap): idl.IDLEntry {
    if (isEnum(node)) {
        return toIDLEnum(file, node, info)
    }
    if (isImport(node)) {
        return toIDLImport(node, info)
    }
    if (isClass(node)) {
        return toIDLInterface(file, node, info)
    }
    if (isInterface(node)) {
        return toIDLInterface(file, node, info)
    }
    if (isCallback(node)) {
        return toIDLCallback(file, node, info)
    }
    if (isTypedef(node)) {
        return toIDLTypedef(file, node, info)
    }
    if (isDictionary(node)) {
        return toIDLDictionary(file, node, info)
    }
    if (isNamespace(node)) {
        return toIDLNamespace(file, node, info)
    }
    if (isVersion(node)) {
        return toIDLVersion(file, node, info)
    }
    if (isAttribute(node as webidl2.IDLNamespaceMemberType)) {
        return toIDLProperty(file, node as webidl2.AttributeMemberType, info)
    }
    if (isOperation(node as webidl2.IDLNamespaceMemberType)) {
        return toIDLMethod(file, node as webidl2.OperationMemberType, true, info)
    }
    if (isConstant(node)) {
        return toIDLConstant(file, node, info)
    }
    throw new Error(`unexpected node type: ${toString(node)}`)
}

function isNamespace(node: webidl2.IDLRootType): node is webidl2.NamespaceType {
    return node.type === 'namespace'
}

function isVersion(node: webidl2.IDLRootType): node is webidl2.NamespaceType {
    return node.type === 'version'
}

function isPackage(node: webidl2.IDLRootType): node is webidl2.PackageType {
    return node.type === 'package'
}

function isImport(node: webidl2.IDLRootType): node is webidl2.ImportType {
    return node.type === 'import'
}

function isCallable(node: webidl2.IDLInterfaceMemberType): boolean {
    return node.extAttrs.some(it => it.name == "Invoke")
}

function toIDLImport(node: webidl2.ImportType, info:IDLTokenInfoMap): idl.IDLImport {
    // console.log(node)
    return withInfo(info, node, idl.createImport(node.clause.split("."), node.alias||undefined))
}


function interfaceSubkind(node: webidl2.InterfaceType): idl.IDLInterfaceSubkind {
    const nodeIDLEntity = node.extAttrs.find(it => it.name === "Entity")?.rhs?.value
    if (nodeIDLEntity == idl.IDLEntity.Class) return idl.IDLInterfaceSubkind.Class
    if (nodeIDLEntity == idl.IDLEntity.Interface) return idl.IDLInterfaceSubkind.Interface
    if (nodeIDLEntity == idl.IDLEntity.Tuple) return idl.IDLInterfaceSubkind.Tuple
    return idl.IDLInterfaceSubkind.Interface
}

function toIDLInterface(file: string, node: webidl2.InterfaceType, info:IDLTokenInfoMap): idl.IDLInterface {
    const result = idl.createInterface(
        node.name,
        interfaceSubkind(node),
        (()=>{
            if (!node.inheritance)
                return []
            const parentTypeArgs = extractTypeArguments(file, node.inheritanceExtAttrs ?? [], idl.IDLExtendedAttributes.TypeArguments)
            const parentType = idl.createReferenceType(node.inheritance, parentTypeArgs)
            parentType.fileName = file
            if (node.inheritanceExtAttrs)
                parentType.extendedAttributes = toExtendedAttributes(node.inheritanceExtAttrs, info)?.filter(it => it.name !== idl.IDLExtendedAttributes.TypeArguments)
            return [parentType]
        })(),
        node.members
            .filter(isConstructor)
            .map(it => toIDLConstructor(file, it, info)),
        [],
        node.members
            .filter(isAttribute)
            .map(it => toIDLProperty(file, it, info)),
        node.members
            .filter(isOperation)
            .filter(it => !isCallable(it))
            .map(it => toIDLMethod(file, it, false, info)),
        node.members
            .filter(isOperation)
            .filter(it => isCallable(it))
            .map(it => toIDLCallable(file, it, info)),
        findExtendedAttribute(node.extAttrs, idl.IDLExtendedAttributes.TypeParameters)?.split(","),
        {
            fileName: file,
            documentation: makeDocs(node),
            extendedAttributes: toExtendedAttributes(node.extAttrs, info),
        }
    )
    info.set(result, getTokens(node))
    if (node.extAttrs.find(it => it.name === "Synthetic"))
        addSyntheticType(node.name, result)
    return result
}

function extractTypeArguments(file: string,
    extAttrs: webidl2.ExtendedAttribute[] | undefined,
    attribute: idl.IDLExtendedAttributes
): idl.IDLType[] | undefined {
    const attr = extAttrs?.find(it => it.name === attribute)
    if (!attr)
        return undefined
    let value = toExtendedAttributeValue(attr)!
    return value
        ?.split(",")  // TODO need real parsing here. What about "<T, Map<K, Callback<K,R>>, U>"
        ?.map(it => toIDLType(file, it))
}

function toIDLType(file: string, type: webidl2.IDLTypeDescription | string, extAttrs?: webidl2.ExtendedAttribute[], info?:IDLTokenInfoMap): idl.IDLType {
    if (typeof type === "string") {
        // is it IDLStringType?
        const refType = idl.createReferenceType(type)
        refType.fileName = file
        refType.typeArguments = extractTypeArguments(file, extAttrs, idl.IDLExtendedAttributes.TypeArguments)
        return refType
    }
    if (type.nullable) {
        return withInfo(info ?? new Map(), type,
            idl.createOptionalType(
                toIDLType(file, { ...type, nullable: false }, extAttrs, info)
            )
        )
    }
    if (isUnionTypeDescription(type)) {
        const types = type.idlType
            .map(it => toIDLType(file, it, undefined, info))
            .filter(isDefined)
        const name = generateSyntheticUnionName(types)
        return withInfo(info ?? new Map(), type, idl.createUnionType(types, name))
    }
    if (isSingleTypeDescription(type)) {
        // must match with primitive types in idl.ts
        switch (type.idlType) {
            case idl.IDLPointerType.name: return idl.IDLPointerType
            case idl.IDLVoidType.name: return idl.IDLVoidType
            case idl.IDLBooleanType.name: return idl.IDLBooleanType
            case idl.IDLObjectType.name: return idl.IDLObjectType
            case idl.IDLI8Type.name: return idl.IDLI8Type
            case idl.IDLU8Type.name: return idl.IDLU8Type
            case idl.IDLI16Type.name: return idl.IDLI16Type
            case idl.IDLU16Type.name: return idl.IDLU16Type
            case idl.IDLI32Type.name: return idl.IDLI32Type
            case idl.IDLU32Type.name: return idl.IDLU32Type
            case idl.IDLI64Type.name: return idl.IDLI64Type
            case idl.IDLU64Type.name: return idl.IDLU64Type
            case idl.IDLF32Type.name: return idl.IDLF32Type
            case idl.IDLF64Type.name: return idl.IDLF64Type
            case idl.IDLBigintType.name: return idl.IDLBigintType
            case idl.IDLNumberType.name: return idl.IDLNumberType
            case idl.IDLStringType.name: return idl.IDLStringType
            case idl.IDLAnyType.name: return idl.IDLAnyType
            case idl.IDLUndefinedType.name: return idl.IDLUndefinedType
            case idl.IDLUnknownType.name: return idl.IDLUnknownType
            case idl.IDLObjectType.name: return idl.IDLObjectType
            case idl.IDLThisType.name: return idl.IDLThisType
            case idl.IDLDate.name: return idl.IDLDate
            case idl.IDLBufferType.name: return idl.IDLBufferType
            case idl.IDLSerializerBuffer.name: return idl.IDLSerializerBuffer
        }
        const combinedExtAttrs = (type.extAttrs ?? []).concat(extAttrs ?? [])
        const idlRefType = idl.createReferenceType(type.idlType)
        idlRefType.fileName = file
        idlRefType.typeArguments = extractTypeArguments(file, combinedExtAttrs, idl.IDLExtendedAttributes.TypeArguments)
        idlRefType.extendedAttributes = toExtendedAttributes(combinedExtAttrs, info)
        return withInfo(info ?? new Map(), type, idlRefType)
    }
    if (isSequenceTypeDescription(type) || isPromiseTypeDescription(type) || isRecordTypeDescription(type)) {
        return withInfo(info ?? new Map(), type,
            idl.createContainerType(
                type.generic,
                type.idlType.map(it => toIDLType(file, it, undefined, info))
            )
        )
    }

    if (isUnspecifiedGenericTypeDescription(type)) {
        return withInfo(info ?? new Map(), type,
            idl.createUnspecifiedGenericType(
                type.generic,
                type.idlType.map(it => toIDLType(file, it, undefined, info))
            )
        )
    }

    throw new Error(`unexpected type: ${toString(type)}`)
}


function toIDLCallable(file: string, node: webidl2.OperationMemberType, info:IDLTokenInfoMap): idl.IDLCallable {
    if (!node.idlType) {
        throw new Error(`method with no type ${toString(node)}`)
    }
    const returnType = toIDLType(file, node.idlType, node.extAttrs, info)
    if (idl.isReferenceType(returnType)) {
        const returnTypeArgs = extractTypeArguments(file, node.extAttrs, idl.IDLExtendedAttributes.TypeArguments)
        returnType.typeArguments = returnTypeArgs
    }
    return withInfo(info, node, idl.createCallable(
        node.name ?? "",
        node.arguments.map(it => toIDLParameter(file, it, info)),
        returnType,
        {
            isStatic: node.special === "static",
            isAsync: node.async,
        }, {
            documentation: makeDocs(node),
            extendedAttributes: toExtendedAttributes(node.extAttrs, info),
        }, findExtendedAttribute(node.extAttrs, idl.IDLExtendedAttributes.TypeParameters)?.split(","),
    ))
}

function toIDLMethod(file: string, node: webidl2.OperationMemberType, isFree:boolean = false, info?:IDLTokenInfoMap): idl.IDLMethod {
    if (!node.idlType) {
        throw new Error(`method with no type ${toString(node)}`)
    }
    const returnType = toIDLType(file, node.idlType, node.extAttrs, info)
    if (idl.isReferenceType(returnType))
        returnType.typeArguments = extractTypeArguments(file, node.extAttrs, idl.IDLExtendedAttributes.TypeArguments)
    return withInfo(info ?? new Map(), node, idl.createMethod(
        node.name ?? "",
        node.arguments.map(it => toIDLParameter(file, it, info ?? new Map())),
        returnType,
        {
            isStatic: node.special === "static",
            isAsync: node.async,
            isOptional: isOptional(node),
            isFree
        }, {
            documentation: makeDocs(node),
            extendedAttributes: toExtendedAttributes(node.extAttrs, info),
        }, findExtendedAttribute(node.extAttrs, idl.IDLExtendedAttributes.TypeParameters)?.split(","),
    ))
}

function toIDLConstructor(file: string, node: webidl2.ConstructorMemberType, info:IDLTokenInfoMap): idl.IDLConstructor {
    return withInfo(info, node, idl.createConstructor(
        node.arguments.map(it => toIDLParameter(file, it, info)),
        undefined, {
        documentation: makeDocs(node),
    }))
}

function toIDLParameter(file: string, node: webidl2.Argument, info:IDLTokenInfoMap): idl.IDLParameter {
    return withInfo(info, node, idl.createParameter(
        node.name,
        toIDLType(file, node.idlType, node.extAttrs, info),
        node.optional,
        node.variadic, {
        fileName: file,
    }))
}

function toIDLCallback(file: string, node: webidl2.CallbackType, info:IDLTokenInfoMap): idl.IDLCallback {
    const result = idl.createCallback(
        node.name,
        node.arguments.map(it => toIDLParameter(file, it, info)),
        toIDLType(file, node.idlType, undefined, info), {
        fileName: file,
        extendedAttributes: toExtendedAttributes(node.extAttrs, info),
        documentation: makeDocs(node),
    })
    if (node.extAttrs.find(it => it.name === "Synthetic"))
        addSyntheticType(node.name, result)
    return withInfo(info, node, result)
}

function toIDLTypedef(file: string, node: webidl2.TypedefType, info:IDLTokenInfoMap): idl.IDLTypedef {
    return withInfo(info, node, idl.createTypedef(
        node.name,
        toIDLType(file, node.idlType, undefined, info),
        findExtendedAttribute(node.extAttrs, idl.IDLExtendedAttributes.TypeParameters)?.split(","), {
        extendedAttributes: toExtendedAttributes(node.extAttrs, info),
        documentation: makeDocs(node),
        fileName: file,
    }))
}

function toIDLConstant(file: string, node: webidl2.ConstantMemberType, info:IDLTokenInfoMap) {
    return withInfo(info, node, idl.createConstant(node.name, toIDLType(file, node.idlType, undefined, info), constantValue(node)))
}

function constantValue(node: webidl2.ConstantMemberType): string {
    switch (node.value.type) {
        case "string":
            return `"${(node.value as webidl2.ValueDescriptionString).value}"`
        case "number":
            return (node.value as webidl2.ValueDescriptionNumber).value
        case "boolean":
            return (node.value as webidl2.ValueDescriptionBoolean).value.toString()
        case "null":
            return "null"
        case "Infinity":
            return "Infinity"
        case "NaN":
            return "NaN"
        case "sequence":
            return `[${(node.value as webidl2.ValueDescriptionSequence).value.join(',')}]`
        case "dictionary":
            return `new Map()`
        default:
            return "undefined"
    }
}

function toIDLDictionary(file: string, node: webidl2.DictionaryType, info:IDLTokenInfoMap): idl.IDLEnum {
    const result = idl.createEnum(
        node.name,
        [], {
        documentation: makeDocs(node),
        extendedAttributes: toExtendedAttributes(node.extAttrs, info),
        fileName: file,
    })
    result.elements = node.members.map(it => toIDLEnumMember(file, it, result, info))
    return withInfo(info, node, result)
}

function toIDLNamespace(file: string, node: webidl2.NamespaceType, info:IDLTokenInfoMap): idl.IDLNamespace {
    const namespace = idl.createNamespace(
        node.name,
        [],
        {
            extendedAttributes: toExtendedAttributes(node.extAttrs, info),
            fileName: file
        }
    )
    namespace.members = node.members.map(it => toIDLNodeForward(file, it, info))
    return withInfo(info, node, namespace)
}

function toIDLVersion(file: string, node: webidl2.VersionType, info:IDLTokenInfoMap): idl.IDLVersion {
    return withInfo(info, node, idl.createVersion(
        node.value,
        {
            extendedAttributes: toExtendedAttributes(node.extAttrs, info),
            fileName: file
        }
    ))
}
function toIDLProperty(file: string, node: webidl2.AttributeMemberType, info:IDLTokenInfoMap): idl.IDLProperty {
    return withInfo(info, node, idl.createProperty(
        node.name,
        toIDLType(file, node.idlType, undefined, info),
        node.readonly,
        node.special === "static",
        isOptional(node), {
        documentation: makeDocs(node),
        fileName: file,
        extendedAttributes: toExtendedAttributes(node.extAttrs, info)
    }))
}

function unescapeString(value: string): string {
    if (!value.length || value[0] !== '"')
        return value
    value = value.slice(1,-1)
    value = value.replace(/\\((['"\\bfnrtv])|([0-7]{1-3})|x([0-9a-fA-F]{2})|u([0-9a-fA-F]{4}))/g, (_, all, c, oct, h2, u4) => {
        if (c !== undefined) {
            switch (c) {
                case "'": return "'";
                case '"': return '"';
                case "\\": return "\\";
                case "b": return "\b";
                case "f": return "\f";
                case "n": return "\n";
                case "r": return "\r";
                case "t": return "\t";
                case "v": return "\v";
            }
        } else if (oct !== undefined) {
            return String.fromCharCode(parseInt(oct, 8));
        } else if (h2 !== undefined) {
            return String.fromCharCode(parseInt(h2, 16));
        } else if (u4 !== undefined) {
            return String.fromCharCode(parseInt(u4, 16));
        }
        throw new Error(`unknown escape sequence: ${_}`);
    });

    return value;
}

function toIDLEnumMember(file: string, node: webidl2.DictionaryMemberType, parent: idl.IDLEnum, info:IDLTokenInfoMap): idl.IDLEnumMember {
    let initializer = undefined
    if (node.default?.type == "string") {
        initializer = unescapeString(node.default.value)
    } else if (node.default?.type == "number") {
        initializer = +(node.default?.value)
    } else if (node.default == null) {
        initializer = undefined
    } else {
        throw new Error(`Not representable enum initializer: ${node.default}`)
    }
    return withInfo(info, node, idl.createEnumMember(
        node.name,
        parent,
        toIDLType(file, node.idlType, undefined, info) as idl.IDLPrimitiveType,
        initializer, {
        extendedAttributes: toExtendedAttributes(node.extAttrs, info),
    }))
}

function toExtendedAttributes(extAttrs: webidl2.ExtendedAttribute[], info?:IDLTokenInfoMap): idl.IDLExtendedAttribute[] | undefined {
    return extAttrs.map(it => {
        return withInfo(info ?? new Map(), it, { name: it.name, value: toExtendedAttributeValue(it) })
    })
}

function toExtendedAttributeValue(attr: webidl2.ExtendedAttribute): stringOrNone {
    // TODO: be smarter about RHS.
    if (attr.rhs?.value instanceof Array)
        return attr.rhs.value.map(v => v.value).join(",")
    if (typeof(attr.rhs?.value) === 'string')
        return unescapeString(attr.rhs.value)
    return
}

function makeDocs(node: webidl2.AbstractBase): stringOrNone {
    let docs = undefined
    node.extAttrs.forEach(it => {
        if (it.name == "Documentation") docs = it.rhs?.value
    })
    return docs
}

function toIDLEnum(file: string, node: webidl2.EnumType, info:IDLTokenInfoMap): idl.IDLEnum {
    const result = idl.createEnum(
        node.name,
        [], {
        fileName: file,
        documentation: makeDocs(node),
        extendedAttributes: toExtendedAttributes(node.extAttrs, info),
    })
    result.elements = node.values.map((it: { value: string }) => idl.createEnumMember(
        it.value,
        result,
        idl.IDLNumberType,
        undefined
    ))
    return withInfo(info, node, result)
}

function findExtendedAttribute(extAttrs: webidl2.ExtendedAttribute[], name: idl.IDLExtendedAttributes): stringOrNone {
    const attr = extAttrs.find(it => it.name === name)
    return attr ? toExtendedAttributeValue(attr) : undefined
}

export function toIDLFile(fileName: string, content?: string): [idl.IDLFile, IDLTokenInfoMap] {
    if (undefined === content)
        content = fs.readFileSync(fileName).toString()
    let packageClause: string[] = []
    const info:IDLTokenInfoMap = new Map()
    const entries = webidl2.parse(content)
        .filter(it => {
            if (!it.type)
                return false
            if (isPackage(it)) {
                packageClause = it.clause.split(".")
                return false
            }
            return true
        })
        .map(it => toIDLNode(fileName, it, info))
    const file = idl.createFile(entries, fileName, packageClause)
    file.text = content
    return [idl.linkParentBack(file), info]
}
