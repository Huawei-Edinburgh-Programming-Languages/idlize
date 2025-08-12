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
import { generatorConfiguration } from '../config';
import * as idl from '../idl'
import { getModuleFor } from './modules';

var count = 0
export function isManaged(target: idl.IDLNamedNode) {
    if (generatorConfiguration().forceResource.includes(target.name)) return true
    if(target.name.includes("ManagedClass")) {
        console.log(`--- --- ---`)
        console.log(`Count: ${count}`)
        count++
        const module = getModuleFor(target)
        console.log(`Target: ${target.name}`)
        console.log(`Module: ${module.name}`)
        console.log(`ForceObject: ${module.forceObject}`)
        const res = getModuleFor(target).forceObject?.includes(target.name)
        console.log(`  res: ${res}`)
        console.log()
    }
    if (getModuleFor(target).forceObject?.includes(target.name)) return true
    return false
}