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
import * as fs from "fs"
import * as path from "path"
import { IndentedPrinter } from "../IndentedPrinter"
import { DeclarationTable, PrimitiveType } from "./DeclarationTable"
import { Language } from "../util"
import { PeerGeneratorConfig } from "./PeerGeneratorConfig";

const importTsInteropTypes = `
import {
    int32,
    float32
} from "@koalaui/common"
import {
    KInt,
    KBoolean,
    KStringPtr,
    KPointer,
    KNativePointer,
    KInt32ArrayPtr,
    KUint8ArrayPtr,
    pointer
} from "@koalaui/interop"
`.trim()

export function nativeModuleDeclaration(methods: string[], nativeBridgePath: string, useEmpty: boolean, language: Language): string {
    if (language == Language.JAVA) {
        // NativeModule will be taken from peer_lib.
        return ``
    }

    // TODO: better NativeBridge loader
    return `
${importTsInteropTypes}
import { NativeModuleEmpty } from "./NativeModuleEmpty"
import { NativeModuleBase } from "./NativeModuleBase"
import {
  NativeStringBase,
  providePlatformDefinedData,
  nullptr,
  Access,
  withByteArray,
  CallbackRegistry,
  ArrayDecoder
} from "@koalaui/interop"

export type NodePointer = pointer

let theModule: NativeModule | undefined = undefined

export function nativeModule(): NativeModule {
    if (theModule) return theModule
    if (${useEmpty})
        theModule = new NativeModuleEmpty()
    else
        theModule = require("${nativeBridgePath}") as NativeModule
    return theModule
}

class NativeString extends NativeStringBase {
    constructor(ptr: KPointer) {
        super(ptr)
    }
    protected bytesLength(): int32 {
        return nativeModule()._StringLength(this.ptr)
    }
    protected getData(data: Uint8Array): void {
        withByteArray(data, Access.WRITE, (dataPtr: KUint8ArrayPtr) => {
            nativeModule()._StringData(this.ptr, dataPtr, data.length)
        })
    }
    close(): void {
        nativeModule()._InvokeFinalizer(this.ptr, nativeModule()._GetStringFinalizer())
        this.ptr = nullptr
    }
}

providePlatformDefinedData({
    nativeString(ptr: KPointer): NativeStringBase { return new NativeString(ptr) },
    nativeStringArrayDecoder(): ArrayDecoder<NativeStringBase> { throw new Error("Not implemented") },
    callbackRegistry(): CallbackRegistry | undefined { return undefined }
})

export interface NativeModule extends NativeModuleBase {
${methods.map(it => `  ${it}`).join("\n")}
}
`
}

export function nativeModuleEmptyDeclaration(methods: string[]): string {
    return `
${importTsInteropTypes}
import { NativeModuleBase } from "./NativeModuleBase"
import { NativeModule, NodePointer } from "./NativeModule"

export class NativeModuleEmpty extends NativeModuleBase implements NativeModule {
${methods.join("\n")}
}
`.trim()
}

export function bridgeCcDeclaration(bridgeCc: string[]): string {
    const prefix = PeerGeneratorConfig.cppPrefix()

    return `#include "Interop.h"
#include "arkoala_api.h"
#include "Deserializer.h"

static ${prefix}ArkUIAnyAPI* impls[Ark_APIVariantKind::COUNT] = { 0 };

const ${prefix}ArkUIAnyAPI* GetAnyImpl(Ark_APIVariantKind kind, int version, std::string* result) {
    return impls[kind];
}

const ${prefix}ArkUIFullNodeAPI* GetFullImpl(std::string* result = nullptr) {
    return reinterpret_cast<const ${prefix}ArkUIFullNodeAPI*>(GetAnyImpl(Ark_APIVariantKind::FULL, ARKUI_FULL_API_VERSION, result));
}

const ${prefix}ArkUINodeModifiers* GetNodeModifiers() {
    // TODO: restore the proper call
    // return GetFullImpl()->getNodeModifiers();
    extern const ${prefix}ArkUINodeModifiers* GetArkUINodeModifiers();
    return GetArkUINodeModifiers();
}

${bridgeCc.join("\n")}
`
}

export function completeImplementations(lines: string[]): string {
    return `
#include "Interop.h"
#include "Deserializer.h"
#include "common-interop.h"

${lines.join("\n")}
`
}

export function dummyImplementations(lines: string[]): string {
    return `
#include "Interop.h"
#include "Deserializer.h"
#include "common-interop.h"

${lines.join("\n")}
`
}

export function modifierStructs(lines: string[]): string {
    return lines.join("\n")
}

export function modifierStructList(lines: string[]): string {
    const prefix = PeerGeneratorConfig.cppPrefix()
    return `
const ${prefix}ArkUINodeModifiers impl = {
    1, // version
${lines.join("\n")}
};

extern const ${prefix}ArkUINodeModifiers* GetArkUINodeModifiers()
{
    return &impl;
}

`
}

export function makeTSSerializer(table: DeclarationTable): string {
    let printer = new IndentedPrinter()
    table.generateSerializers(printer)
    return `
import { SerializerBase, runtimeType, Tags, RuntimeType, Function } from "./SerializerBase"
import { int32 } from "@koalaui/common"

${printer.getOutput().join("\n")}
`
}

export function makeCDeserializer(table: DeclarationTable, structs: IndentedPrinter, typedefs: IndentedPrinter): string {

    const deserializer = new IndentedPrinter()
    const writeToString = new IndentedPrinter()
    table.generateDeserializers(deserializer, structs, typedefs, writeToString)

    return `
#include "Interop.h"
#include "ArgDeserializerBase.h"
#include "arkoala_api.h"
#include <string>

${writeToString.getOutput().join("\n")}

${deserializer.getOutput().join("\n")}
`
}

export function makeApiModifiers(lines: string[], prefix: string): string {
    return `
/**
 * An API to control an implementation. When making changes modifying binary
 * layout, i.e. adding new events - increase ARKUI_API_VERSION above for binary
 * layout checks.
 */
typedef struct ${prefix}ArkUINodeModifiers {
    ${PrimitiveType.Int32.getText()} version;
${lines.join("\n")}
} ${prefix}ArkUINodeModifiers;

typedef struct ${prefix}ArkUIBasicAPI {
    ${PrimitiveType.Int32.getText()} version;
} ${prefix}ArkUIBasicAPI;

typedef struct ${prefix}ArkUIAnimation {
    ${PrimitiveType.Int32.getText()} version;
} ${prefix}ArkUIAnimation;

typedef struct ${prefix}ArkUINavigation {
    ${PrimitiveType.Int32.getText()} version;
} ${prefix}ArkUINavigation;

typedef struct ${prefix}ArkUIGraphicsAPI {
    ${PrimitiveType.Int32.getText()} version;
} ${prefix}ArkUIGraphicsAPI;

/**
 * An API to control an implementation. When making changes modifying binary
 * layout, i.e. adding new events - increase ARKUI_NODE_API_VERSION above for binary
 * layout checks.
 */
typedef struct ${prefix}ArkUIFullNodeAPI {
    ${PrimitiveType.Int32.getText()} version;
    const ${prefix}ArkUIBasicAPI* (*getBasicAPI)();
    const ${prefix}ArkUINodeModifiers* (*getNodeModifiers)();
    const ${prefix}ArkUIAnimation* (*getAnimation)();
    const ${prefix}ArkUINavigation* (*getNavigation)();
    const ${prefix}ArkUIGraphicsAPI* (*getGraphicsAPI)();
} ${prefix}ArkUIFullNodeAPI;

typedef struct ${prefix}ArkUIAnyAPI {
    ${PrimitiveType.Int32.getText()} version;
} ${prefix}ArkUIAnyAPI;
`
}

export function makeApiHeaders(lines: string[]): string {
    return `

${lines.join("\n")}
`
}

function readTemplate(name: string): string {
    return fs.readFileSync(path.join(__dirname, `../templates/${name}`), 'utf8')
}

export function makeAPI(
    apiVersion: string,
    apiPrefix: string,
    headers: string[], modifiers: string[],
    structs: IndentedPrinter, typedefs: IndentedPrinter
): string {

    let prologue = readTemplate('arkoala_api_prologue.h')
    let epilogue = readTemplate('arkoala_api_epilogue.h')

    prologue = prologue.replaceAll(`%ARKUI_FULL_API_VERSION_VALUE%`, apiVersion)

    return `
${prologue}

${structs.getOutput().join("\n")}

${typedefs.getOutput().join("\n")}

${makeApiHeaders(headers)}

${makeApiModifiers(modifiers, apiPrefix)}

${epilogue}
`
}

export function copyPeerLib(from: string, to: string) {
    const tsBase = path.join(from, 'ts')
    copyDir(tsBase, to)
    const cppBase = path.join(from, 'cpp')
    copyDir(cppBase, to)
    copyDir(cppBase, to)
    let subdirs = ['node', 'arkts', 'jni']
    subdirs.forEach(subdir => {
        const cppBase = path.join(from, 'cpp', subdir)
        copyDir(cppBase, to)
    })
    copyDir(path.join(from, 'arkts'), to)
    copyDir(path.join(from, 'java'), to)

}

function copyDir(from: string, to: string) {
    fs.readdirSync(from).forEach(it => {
        let file = path.join(from, it)
        if (fs.statSync(file).isFile()) {
            fs.copyFileSync(file, path.join(to, it))
        }
        // TODO: copy dir
    })
}
export function makeNodeTypes(types: string[]): string {
    const enumValues = types.map(it => `  ${it},`).join("\n")
    return `
export enum ArkUINodeType {
${enumValues}
}
`.trim()
}

export function makeArkuiModule(componentsFiles: string[]): string {
    return componentsFiles.map(file => {
        const basename = path.basename(file)
        const basenameNoExt = basename.replaceAll(path.extname(basename), "")
        return `export * from "./${basenameNoExt}"`
    }).join("\n")
}

export function makeStructCommon(commonMethods: string[], customComponentMethods: string[]): string {
    return `
import { NativePeerNode } from "@koalaui/arkoala"

export class ArkCommon implements CommonMethod<CommonAttribute> {
  protected peer?: NativePeerNode
  setPeer(peer: NativePeerNode) {
  }
  /** @memo:intrinsic */
  protected checkPriority(
      name: string
  ): boolean { throw new Error("not implemented") }
  protected applyAttributesFinish(): void { throw new Error("not implemented") }

  ${commonMethods.join('\n  ')}
}

export class ArkStructCommon extends ArkCommon implements CustomComponent {
  ${customComponentMethods.join('\n  ')}
}
`
}