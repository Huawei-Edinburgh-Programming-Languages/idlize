/*
 * Copyright (C) 2025 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
/**
 * @file
 * @kit ArkUI
 */

import { Resource as __Resource__ } from "../../global/resource";

export type Resource = __Resource__;

declare function _r(bundleName: string, moduleName: string, name: string, ...params: string[]): Resource;

declare function _rawfile(bundleName: string, moduleName: string, name: string): Resource;

export { _r, _rawfile }
