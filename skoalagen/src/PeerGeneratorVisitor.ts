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

import * as idl from '@idlizer/core/idl'
import { ArgConvertor, ArgumentModifier, capitalize, createOutArgConvertor, Field, FieldModifier, generatorConfiguration, getInternalClassName, getSuper, getSuperType, isInCurrentModule, isInIdlize, isInIdlizeInternal, isMaterialized, isStaticMaterialized, Language, LibraryInterface, MaterializedClass, MaterializedField, MaterializedMethod, Method, MethodModifier, NamedMethodSignature, PeerMethodArg, PeerMethodSignature, qualifiedName } from "@idlizer/core"
import { getMethodModifiers, getUniquePropertiesFromSuperTypes, isComponentDeclaration, peerGeneratorConfiguration } from '@idlizer/libohos'

export class PeerProcessor {
    constructor(
        private readonly library: LibraryInterface,
    ) { }

    private processMaterialized(decl: idl.IDLInterface, isStaticMaterialized: boolean = false) {
        if (!isInCurrentModule(decl)) {
            return
        }
        if (peerGeneratorConfiguration().isHandWritten(decl.name)) {
            return
        }
        const fullCName = qualifiedName(decl, "_", "namespace.name")
        if (this.library.materializedClasses.has(fullCName)) {
            return
        }

        const isDeclInterface = idl.isInterfaceSubkind(decl) && !isStaticMaterialized
        const implemenationParentName = isDeclInterface ? getInternalClassName(decl.name) : decl.name
        const resolvedDecl = getSuper(decl, this.library)
        const interfaces: idl.IDLReferenceType[] = []
        const propertiesFromInterface: idl.IDLProperty[] = []
        let superType: idl.IDLReferenceType | undefined = undefined
        if (resolvedDecl) {
            superType = getSuperType(decl, this.library)
            if (!resolvedDecl || !idl.isInterface(resolvedDecl) || !isMaterialized(resolvedDecl, this.library)) {
                propertiesFromInterface.push(...getUniquePropertiesFromSuperTypes(decl, this.library))
                interfaces.push(superType!)
                superType = undefined
            }
        }

        let constructors: idl.IDLConstructor[] = decl.constructors
        if (constructors.length == 0 && !isStaticMaterialized) {
            if (decl.callables.length > 0) {
                const first = decl.callables[0]
                const constructor = idl.createConstructor(
                    [...first.parameters],
                    first.returnType,
                    {
                        documentation: first.documentation,
                        extendedAttributes: first.extendedAttributes,
                        fileName: first.fileName
                    }
                )
                constructors = [constructor]
            } else {
                constructors = [idl.createConstructor([], idl.IDLVoidType)]
            }
        }
        const mConstructors = isStaticMaterialized ? [] : constructors.map(c => this.makeMaterializedMethod(decl, c, fullCName, implemenationParentName))
        if (mConstructors.length > 1) mConstructors.forEach((c, i) => { c.setOverloadIndex(i) })
        const mFinalizer = isStaticMaterialized ? undefined : new MaterializedMethod(
            new PeerMethodSignature(
                PeerMethodSignature.GET_FINALIZER,
                idl.getFQName(decl).split('.').concat(PeerMethodSignature.GET_FINALIZER).join('_'),
                [],
                idl.IDLPointerType,
            ),
            fullCName, implemenationParentName, idl.IDLPointerType, false,
            new Method("getFinalizer", new NamedMethodSignature(idl.IDLPointerType, [], [], []), [MethodModifier.STATIC]))
        const mFields = propertiesFromInterface.concat(decl.properties)
            // TODO what to do with setter accessors? Do we need FieldModifier.WRITEONLY? For now, just skip them
            .filter(it => idl.getExtAttribute(it, idl.IDLExtendedAttributes.Accessor) !== idl.IDLAccessorAttribute.Setter)
            .map(it => this.makeMaterializedField(it))
        const mMethods = decl.methods
            // TODO: Properly handle methods with return Promise<T> type
            .map(method => this.makeMaterializedMethod(decl, method, fullCName, implemenationParentName))
            .filter(it => !idl.isNamedNode(it.method.signature.returnType) || !peerGeneratorConfiguration().materialized.ignoreReturnTypes.includes(it.method.signature.returnType.name))

        const taggedMethods = decl.methods.filter(m => m.extendedAttributes?.find(it => it.name === idl.IDLExtendedAttributes.DtsTag))

        mFields.forEach(f => {
            const field = f.field
            const idlType = field.type
            const isStatic = field.modifiers.includes(FieldModifier.STATIC)
            const getSignature = new NamedMethodSignature(idl.maybeOptional(field.type, f.isNullableOriginalTypeField), [], [])
            const sameNamedGetters = mFields.filter(it => it.field.name === f.field.name)
            const overloadPostfix = sameNamedGetters.length > 1 ? sameNamedGetters.indexOf(f).toString() : ``
            const getAccessor = new MaterializedMethod(
                new PeerMethodSignature(
                    `get${capitalize(field.name)}${overloadPostfix}`,
                    idl.getFQName(decl).split('.').concat(`get${capitalize(field.name)}${overloadPostfix}`).join('_'),
                    [],
                    idl.maybeOptional(idlType, f.isNullableOriginalTypeField),
                    isStatic ? undefined : decl,
                ),
                fullCName, implemenationParentName, idl.maybeOptional(field.type, f.isNullableOriginalTypeField), false,
                new Method(`get${capitalize(field.name)}`, getSignature, [MethodModifier.PRIVATE, ...(isStatic ? [MethodModifier.STATIC]:[])]))
            mMethods.push(getAccessor)
            const isReadOnly = field.modifiers.includes(FieldModifier.READONLY)
            if (!isReadOnly) {
                const setSignature = new NamedMethodSignature(idl.IDLVoidType, [idl.maybeOptional(idlType, f.isNullableOriginalTypeField)], [field.name])
                const setAccessor = new MaterializedMethod(
                    new PeerMethodSignature(
                        `set${capitalize(field.name)}${overloadPostfix}`,
                        idl.getFQName(decl).split('.').concat(`set${capitalize(field.name)}${overloadPostfix}`).join('_'),
                        [new PeerMethodArg(f.field.name, idl.maybeOptional(idlType, f.isNullableOriginalTypeField))],
                        idl.IDLVoidType,
                        isStatic ? undefined : decl,
                    ),
                    fullCName, implemenationParentName, idl.IDLVoidType, false,
                    new Method(`set${capitalize(field.name)}`, setSignature, [MethodModifier.PRIVATE, ...(isStatic ? [MethodModifier.STATIC]:[])]))
                mMethods.push(setAccessor)
            }
        })
        this.library.materializedClasses.set(fullCName,
            new MaterializedClass(decl, decl.name, isDeclInterface, isStaticMaterialized, superType, interfaces, decl.typeParameters,
                mFields, mConstructors, mFinalizer, mMethods, true, taggedMethods))
    }

    private makeMaterializedField(prop: idl.IDLProperty): MaterializedField {
        const argConvertor = this.library.typeConvertor(prop.name, prop.type!, prop.isOptional)
        const modifiers: FieldModifier[] = []
        if (prop.isReadonly)
            modifiers.push(FieldModifier.READONLY)
        if (prop.isStatic)
            modifiers.push(FieldModifier.STATIC)
        return new MaterializedField(
            new Field(prop.name, prop.type, modifiers),
            argConvertor,
            createOutArgConvertor(this.library, prop.type, [prop.name]),
            prop.isOptional,
            idl.getExtAttribute(prop, idl.IDLExtendedAttributes.ExtraMethod))
    }

    private makeMaterializedMethod(
        decl: idl.IDLInterface,
        method: idl.IDLConstructor | idl.IDLMethod | undefined,
        originalParentName: string,
        implemenationParentName: string,
    ) {
        let methodName = PeerMethodSignature.CTOR
        let returnType: idl.IDLType = idl.createReferenceType(decl)
        if (method && !idl.isConstructor(method)) {
            methodName = method.name
            returnType = method.returnType
        }
        if (method === undefined) {
            // interface or class without constructors
            const ctor = new Method(PeerMethodSignature.CTOR, new NamedMethodSignature(idl.createReferenceType(decl), [], []), [MethodModifier.STATIC])
            return new MaterializedMethod(new PeerMethodSignature(
                PeerMethodSignature.CTOR,
                idl.getFQName(decl).split('.').concat(PeerMethodSignature.CTOR).join('_'),
                [],
                returnType,
            ), originalParentName, implemenationParentName, returnType, false, ctor)
        }

        const signature = generateSignature(method, returnType)
        const overloadPostfix = PeerMethodSignature.generateOverloadPostfix(method)
        return new MaterializedMethod(
            new PeerMethodSignature(
                methodName + overloadPostfix,
                idl.getFQName(decl).split('.').concat(methodName + overloadPostfix).join('_'),
                signature.args.map((it, index) => new PeerMethodArg(signature.argName(index), it)),
                signature.returnType,
                idl.isMethod(method) && !method.isStatic ? decl : undefined,
            ),
            originalParentName, implemenationParentName, returnType, false,
            new Method(methodName,
                signature,
                getMethodModifiers(method),
                method.typeParameters)
        )
    }

    private ignoreDeclaration(decl: idl.IDLEntry, language: Language): boolean {
        return isInIdlize(decl) ||
            peerGeneratorConfiguration().ignoreEntry(decl.name!, language)
    }

    process(): void {
        // initCustomBuilderClasses()
        const allDeclarations = this.library.files.flatMap(file => idl.linearizeNamespaceMembers(file.entries))
        const curConfig = generatorConfiguration()
        const curPeerConfig = peerGeneratorConfiguration()
        console.log(curConfig.LibraryPrefix, curPeerConfig.LibraryPrefix)

        for (const dep of allDeclarations) {
            if (peerGeneratorConfiguration().ignoreEntry(dep.name, this.library.language) || this.ignoreDeclaration(dep, this.library.language) || idl.isHandwritten(dep) || isInIdlizeInternal(dep))
                continue
            const isPeerDecl = idl.isInterface(dep) && isComponentDeclaration(this.library, dep)
            if (!isPeerDecl && idl.isInterface(dep) && [idl.IDLInterfaceSubkind.Class, idl.IDLInterfaceSubkind.Interface].includes(dep.subkind)) {
                if (isStaticMaterialized(dep, this.library)) {
                    this.processMaterialized(dep, true)
                    continue
                } else if (isMaterialized(dep, this.library)) {
                    this.processMaterialized(dep)
                    continue
                }
            }
        }
    }
}

function generateSignature(
    method: idl.IDLCallable | idl.IDLMethod | idl.IDLConstructor,
    returnType?: idl.IDLType
): NamedMethodSignature {
    return new NamedMethodSignature(
        returnType ?? method.returnType!,
        method.parameters.map(it => idl.maybeOptional(it.type!, it.isOptional)),
        method.parameters.map(it => it.name),
        undefined,
        method.parameters.map(it => it.isOptional ? ArgumentModifier.OPTIONAL : undefined)
    )
}