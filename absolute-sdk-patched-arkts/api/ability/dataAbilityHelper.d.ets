/*
 * Copyright (c) 2021-2023 Huawei Device Co., Ltd.
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
/**
 * Indicates the parameter of the PacMap type.
 * If a custom Sequenceable object is put in the PacMap object and will be transferred across processes,
 * you must call BasePacMap.setClassLoader(ClassLoader) to set a class loader for the custom object.
 * If the PacMap object is to be transferred to a non-OHOS process,
 * values of primitive types are supported, but not custom Sequenceable objects.
 *
 * @typedef { Record<string, number | string | boolean | Array<string | number | boolean> | null> }
 * @syscap SystemCapability.Ability.AbilityRuntime.FAModel
 * @since 20
 */
export type PacMap = Record<string, number | string | boolean | Array<string | number | boolean> | null>;
