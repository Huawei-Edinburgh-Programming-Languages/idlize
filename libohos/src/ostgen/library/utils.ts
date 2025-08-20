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

import { readdirSync, statSync } from "node:fs"
import { join } from "node:path"
import { generatorConfiguration } from "@idlizer/core"

export function throwError(msg:string): never {
    throw new Error(msg)
}

export function scan(root: string): string[] {
  return statSync(root).isDirectory()
    ? readdirSync(root).flatMap(p => scan(join(root, p)))
    : [root]
}

export function mkName(...chunks:string[]): string {
  return chunks.join('.')
}

export function mapName(name: string): string {
  return name
      .replace(/^managed\./, '')
      .replace(/^native\./, '')
      .replace(/^engine/, generatorConfiguration().moduleName + ".INTERNAL")
}
