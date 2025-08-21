/*
 * Copyright (c) 2024 Huawei Device Co., Ltd.
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
 * @kit ArkTS
 */
/**
 * JSON is a syntax for serializing objects, arrays, numbers, strings, booleans, and null.
 *
 * @namespace json
 * @syscap SystemCapability.Utils.Lang
 * @since 20
 */
declare namespace json {
    /**
     * The type of conversion result function.
     *
     * @typedef { function } Transformer
     * @param { Object } this - The object to which the parsed key value pair belongs.
     * @param { string } key - Attribute name.
     * @param { Object } value - The value of the parsed key value pair.
     * @returns { Object | undefined | null } Return an Object, undefined or null value
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    type Transformer = (this: Object, key: string, value: Object) => Object | undefined | null;
    /**
     * Converts a JavaScript Object Notation (JSON) string into an Object or null.
     *
     * @param { string } text - A valid JSON string.
     * @param { Type } type - A constructor or class representing the expected type of the parsed result.
     * @param { Transformer } [reviver] - A function that transforms the results.
     * @param {ParseOptions} options - The config of parse.
     * @returns { T | null | undefined } Return an Object, array, string, number, boolean, undefined, or null value corresponding to JSON text.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    function parse<T>(text: string, type: Type, reviver?: Transformer, options?: ParseOptions): T | null | undefined;
    /**
     * Converts a JavaScript value to a JavaScript Object Notation (JSON) string.
     *
     * @param { NullishType } value - A JavaScript value, usually an NullishType or array.
     * @param { Transformer | ((double | string)[]) | null } [replacer] - An array of strings and numbers that acts as an approved list
     * for selecting the object properties that will be stringify.
     * @param { string | int } [space] - Adds indentation, white space, and line break characters to the return-value JSON text to make it easier to read.
     * @returns { string } Return a JSON text.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    function stringify(value: NullishType, replacer?: Transformer | ((double | string)[]) | null, space?: string | int): string;
    /**
     * Checks whether an ArkTS object contains a key.
     *
     * @param { object } obj - The object parsed from a JSON string.
     * @param { string } property - Determine whether the object contains the property.
     * @returns { boolean } Return true if the key is in the object, otherwise return false.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2.Incorrect parameter types.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    function has(obj: object, property: string): boolean;
    /**
     * Enum defining modes for handling bigint.
     *
     * @enum { number } BigIntMode
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    const enum BigIntMode {
        /**
         * BigInt is not supported.
         *
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        DEFAULT = 0,
        /**
         * Parse as BigInt when number less than -(2^53 – 1) or greater than (2^53 – 1).
         *
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        PARSE_AS_BIGINT = 1,
        /**
         * All numbers parse as BigInt.
         *
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        ALWAYS_PARSE_AS_BIGINT = 2
    }
    /**
     * Parse's options
     *
     * @typedef ParseOptions
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    interface ParseOptions {
        /**
        * Enum defining modes for handling bigint.
        * @type { BigIntMode }
        * @syscap SystemCapability.Utils.Lang
        * @since 20
        */
        bigIntMode: BigIntMode;
    }
}
export default json;
