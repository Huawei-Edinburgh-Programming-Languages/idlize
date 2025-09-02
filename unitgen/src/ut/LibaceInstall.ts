/*
 * Copyright (c) 2024-2025 Huawei Device Co., Ltd.
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
import * as fs from 'node:fs'
import * as path from 'node:path'

export class LibaceInstall {

    public libace: string
    public implementationDir: string
    public generatedInterface: string
    public generatedUtility: string
    public userConverterHeader: string
    public mesonBuild: string
    public unittestDir: string

    public arkoalaMacros: string
    public generatedArkoalaApi: string
    public gniComponents: string
    public allModifiers: string
    public unitTestGni: string

    constructor(private outDir: string, private test: boolean) {
        this.libace = this.mkdir(this.test ? path.join(this.outDir, "libace") : this.outDir)

        this.implementationDir = this.mkdir(path.join(this.libace, "implementation"))
        this.generatedInterface = this.mkdir(path.join(this.libace, "generated", "interface"))
        this.generatedUtility = this.mkdir(path.join(this.libace, "utility", "generated"))
        this.userConverterHeader = path.join(this.generatedUtility, "converter_generated.h")
        this.mesonBuild = path.join(this.libace, "meson.build")
        this.unittestDir = path.join(this.libace, "unittest", "capi", "modifiers", "generated")

        this.arkoalaMacros = this.interface("arkoala-macros.h")
        this.generatedArkoalaApi = this.interface("arkoala_api_generated.h")
        this.gniComponents = this.interface("node_interface.gni")
        this.allModifiers = this.implementation("all_modifiers.cpp")
        this.unitTestGni = this.unittest("modifiers.gni")
    }

    interface(name: string) {
        return path.join(this.generatedInterface, name)
    }
    implementation(name: string) {
        return path.join(this.implementationDir, name)
    }
    modifierHeader(component: string) {
        return this.interface(`${component}_modifier.h`)
    }
    modifierCpp(component: string) {
        return this.implementation(`${component}_modifier.cpp`)
    }
    accessorCpp(component: string) {
        return this.implementation(`${component}_accessor.cpp`)
    }
    delegateHeader(component: string) {
        return this.interface(`${component}_delegate.h`)
    }
    delegateCpp(component: string) {
        return this.implementation(`${component}_delegate.cpp`)
    }
    unittest(name: string) {
        this.mkdir(this.unittestDir)
        return path.join(this.unittestDir, name)
    }
    modifierUnittest(component: string, index?: number) {
        return this.unittest(`${component}_modifier_test${index ? `_${index}` : ''}.${index == 0 ? 'h' : 'cpp'}`)
    }

    mkdir(path: string): string {
        fs.mkdirSync(path, { recursive: true })
        return path
    }
}