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

export function createInterfaceDeclName(name: string): string {
    return `INTERFACE_${name}`
}
// function createTemplateLiteralDeclName(name: string): string {
//     return `TEMPLATE_LITERAL_${name}`
// }
export function createLiteralDeclName(name: string): string {
    return `LITERAL_${name}`
}
// function createUnionDeclName(name: string): string {
//     return `UNION_${name}`
// }
// function createTupleDeclName(name: string): string {
//     return `TUPLE_${name}`
// }
