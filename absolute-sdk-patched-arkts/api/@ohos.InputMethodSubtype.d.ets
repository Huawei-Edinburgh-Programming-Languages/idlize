/*
 * Copyright (c) 2022-2025 Huawei Device Co., Ltd.
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
 * @kit IMEKit
 */
/**
 * Input method subtype
 *
 * @interface InputMethodSubtype
 * @syscap SystemCapability.MiscServices.InputMethodFramework
 * @since 20
 */
export default interface InputMethodSubtype {
    /**
     * The label of input method subtype.
     *
     * @type { ?string }
     * @readonly
     * @syscap SystemCapability.MiscServices.InputMethodFramework
     * @since 20
     */
    readonly label?: string;
    /**
     * The label id of input method subtype.
     *
     * @type { ?double }
     * @readonly
     * @syscap SystemCapability.MiscServices.InputMethodFramework
     * @since 20
     */
    readonly labelId?: double;
    /**
     * The name of input method.
     *
     * @type { string }
     * @readonly
     * @syscap SystemCapability.MiscServices.InputMethodFramework
     * @since 20
     */
    readonly name: string;
    /**
     * The id of input method subtype.
     *
     * @type { string }
     * @readonly
     * @syscap SystemCapability.MiscServices.InputMethodFramework
     * @since 20
     */
    readonly id: string;
    /**
     * The mode of input method subtype.
     *
     * @type { ?('upper' | 'lower') }
     * @readonly
     * @syscap SystemCapability.MiscServices.InputMethodFramework
     * @since 20
     */
    readonly mode?: 'upper' | 'lower';
    /**
     * The locale of input method subtype.
     *
     * @type { string }
     * @readonly
     * @syscap SystemCapability.MiscServices.InputMethodFramework
     * @since 20
     */
    readonly locale: string;
    /**
     * The language of input method subtype.
     *
     * @type { string }
     * @readonly
     * @syscap SystemCapability.MiscServices.InputMethodFramework
     * @since 20
     */
    readonly language: string;
    /**
     * The icon of input method subtype.
     *
     * @type { ?string }
     * @readonly
     * @syscap SystemCapability.MiscServices.InputMethodFramework
     * @since 20
     */
    readonly icon?: string;
    /**
     * The icon id of input method subtype.
     *
     * @type { ?double }
     * @readonly
     * @syscap SystemCapability.MiscServices.InputMethodFramework
     * @since 20
     */
    readonly iconId?: double;
    
    /**
     * The extra info of input method subtype.
     *
     * @type { ?object }
     * @syscap SystemCapability.MiscServices.InputMethodFramework
     * @since 20
     */
    extra?: object;
}
