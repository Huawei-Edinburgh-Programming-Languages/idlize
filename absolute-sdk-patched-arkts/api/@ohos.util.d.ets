/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
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

'use static';
/**
 * @file
 * @kit ArkTS
 */

declare namespace util {
  /**
   * %s: String will be used to convert all values except BigInt, Object and -0. BigInt values will be represented
   * with an n and Objects that have no user defined toString function are inspected using util.inspect() with
   * options { depth: 0, colors: false, compact: 3 }.
   * %d: Number will be used to convert all values except BigInt and Symbol.
   * %i: parseInt(value, 10) is used for all values except BigInt and Symbol.
   * %f: parseFloat(value) is used for all values except Bigint and Symbol.
   * %j: JSON. Replaced with the string '[Circular]' if the argument contains circular references.
   * %o: Object. A string representation of an object with generic JavaScript object formatting.Similar to
   * util.inspect() with options { showHidden: true, showProxy: true}. This will show the full object including
   * non-enumerable properties and proxies.
   * %O: Object. A string representation of an object with generic JavaScript object formatting.
   * %O: Object. A string representation of an object with generic JavaScript object formatting.Similar to
   * util.inspect() without options. This will show the full object not including non-enumerable properties and
   * proxies.
   * %c: CSS. This specifier is ignored and will skip any CSS passed in.
   * %%: single percent sign ('%'). This does not consume an argument.Returns: <string> The formatted string.
   *
   * @param { string } format - Styled string
   * @param { Object[] } args - Data to be formatted
   * @returns { string } a string formatted in a specific format.
   * @throws { BusinessError } 401 - Parameter error. Possible causes:
   * 1.Mandatory parameters are left unspecified;
   * 2.Incorrect parameter types.
   * @syscap SystemCapability.Utils.Lang
   * @since 20
   */
  function format(format: string, ...args: Object[]): string;

  /**
   * Generate a random RFC 4122 version 4 UUID using a cryptographically secure random number generator.
   *
   * @param { boolean } [entropyCache] - Whether to generate the UUID with using the cache. Default: true.
   * @returns { string } Return a string representing this UUID.
   * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Incorrect parameter types.
   * @syscap SystemCapability.Utils.Lang
   * @since 20
   */
  function generateRandomUUID(entropyCache?: boolean): string;
  
  /**
   * The Type represents four different encoding formats for base64
   *
   * @enum { number } Type
   * @syscap SystemCapability.Utils.Lang
   * @since 20
   */
  enum Type {
    /**
     * The value indicates that the encoding format of base64 is BASIC
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    BASIC,
    /**
     * The value indicates that the encoding format of base64 is MIME
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    MIME,
    /**
     * The value indicates that the encoding format of base64 is BASIC_URL_SAFE
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    BASIC_URL_SAFE,
    /**
     * The value indicates that the encoding format of base64 is MIME_URL_SAFE
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    MIME_URL_SAFE,
  }

  /**
   * Decodes a Base64 encoded String or input u8 array into a newly-allocated
   * u8 array using the Base64 encoding scheme.
   *
   * @syscap SystemCapability.Utils.Lang
   * @since 20
   */
  class Base64Helper {
    /**
     * Constructor for creating base64 encoding and decoding
     *
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    constructor();

    /**
     * Encodes all bytes from the specified u8 array into a newly-allocated u8 array using the Base64 encoding scheme.
     *
     * @param { Uint8Array } src - A Uint8Array value
     * @param { Type } [options] - Enumerating input parameters includes two encoding formats: BASIC and BASIC_URL_SAFE
     * @returns { Uint8Array } Return the encoded new Uint8Array.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     * 1.Mandatory parameters are left unspecified;
     * 2.Incorrect parameter types.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    encodeSync(src: Uint8Array, options?: Type): Uint8Array;

    /**
     * Encodes the specified byte array into a String using the Base64 encoding scheme.
     *
     * @param { Uint8Array } src - A Uint8Array value
     * @param { Type } options - one of the Type enumeration
     * @returns { string } Return the encoded string.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     * 1.Mandatory parameters are left unspecified;
     * 2.Incorrect parameter types.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    encodeToStringSync(src: Uint8Array, options?: Type): string;

    /**
     * Decodes a Base64 encoded String or input u8 array into a newly-allocated u8 array using the Base64 encoding scheme.
     *
     * @param { Uint8Array | string } src - A Uint8Array value or a string value
     * @param { Type } [options] - one of the Type enumeration
     * @returns { Uint8Array } Return the decoded Uint8Array.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     * 1.Mandatory parameters are left unspecified;
     * 2.Incorrect parameter types.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    decodeSync(src: Uint8Array | string, options?: Type): Uint8Array;

    /**
     * Asynchronously encodes all bytes in the specified u8 array into the newly allocated u8 array using the Base64 encoding scheme.
     *
     * @param { Uint8Array } src - A Uint8Array value
     * @param { Type } [options] - Enumerating input parameters includes two encoding formats: BASIC and BASIC_URL_SAFE
     * @returns { Promise<Uint8Array> } Return the encodes asynchronous new Uint8Array.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     * 1.Mandatory parameters are left unspecified;
     * 2.Incorrect parameter types.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    encode(src: Uint8Array, options?: Type): Promise<Uint8Array>;

    /**
     * Asynchronously encodes the specified byte array into a String using the Base64 encoding scheme.
     *
     * @param { Uint8Array } src - A Uint8Array value
     * @param { Type } [options] - one of the Type enumeration
     * @returns { Promise<string> } Returns the encoded asynchronous string.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     * 1.Mandatory parameters are left unspecified;
     * 2.Incorrect parameter types.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    encodeToString(src: Uint8Array, options?: Type): Promise<string>;

    /**
     * Use the Base64 encoding scheme to asynchronously decode a Base64-encoded string or
     * input u8 array into a newly allocated u8 array.
     *
     * @param { Uint8Array | string } src - A Uint8Array value or a string value
     * @param { Type } [options] - one of the Type enumeration
     * @returns { Promise<Uint8Array> } Return the decoded asynchronous Uint8Array.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     * 1.Mandatory parameters are left unspecified;
     * 2.Incorrect parameter types.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    decode(src: Uint8Array | string, options?: Type): Promise<Uint8Array>;
  }

  /**
   * The ScopeComparable contains comparison methods.
   *
   * @interface ScopeComparable
   * @syscap SystemCapability.Utils.Lang
   * @since 20
   */
  interface ScopeComparable<T> {
    /**
     * The comparison function is used by the scope.
     *
     * @param { ScopeComparable } other - Other
     * @returns { boolean } Returns whether the current object is greater than or equal to the input object.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    compareTo(other: T): boolean;
  }

  /**
    * A type used to denote ScopeComparable or number.
    *
    * @typedef { ScopeComparable }
    * @syscap SystemCapability.Utils.Lang
    * @since 20
    */
  type ScopeType<T> = ScopeComparable<T>;

  class ScopeHelper<T extends ScopeComparable<T>> {
    /**
     * A constructor used to create a Scope instance with the lower and upper bounds specified.
     *
     * @param { ScopeType } lowerObj - A ScopeType value
     * @param { ScopeType } upperObj - A ScopeType value
     * @since 20
     */
    constructor(lowerObj: T, upperObj: T);

    /**
     * Obtains a string representation of the current range.
     *
     * @returns { string } Returns a string representation of the current range object.
     * @since 20
     */
    toString(): string;

    /**
     * Returns the intersection of a given range and the current range.
     *
     * @param { ScopeHelper } range - A Scope range object
     * @returns { ScopeHelper } Returns the intersection of a given range and the current range.
     * @since 20
     */
    intersect(range: ScopeHelper<T>): ScopeHelper<T>;

    /**
     * Returns the intersection of the current range and the range specified by the given lower and upper bounds.
     *
     * @param { ScopeType } lowerObj - A ScopeType value
     * @param { ScopeType } upperObj - A ScopeType value
     * @returns { ScopeHelper } Returns the intersection of the current range and the range specified by the given lower and upper bounds.
     * @since 20
     */
    intersect(lowerObj: T, upperObj: T): ScopeHelper<T>;

    /**
     * Obtains the upper bound of the current range.
     *
     * @returns { ScopeType } Returns the upper bound of the current range.
     * @since 20
     */
    getUpper(): T;

    /**
     * Obtains the lower bound of the current range.
     *
     * @returns { ScopeType } Returns the lower bound of the current range.
     * @since 20
     */
    getLower(): T;

    /**
     * Creates the smallest range that includes the current range and the given lower and upper bounds.
     *
     * @param { ScopeType } lowerObj - A ScopeType value
     * @param { ScopeType } upperObj - A ScopeType value
     * @returns { ScopeHelper } Returns the smallest range that includes the current range and the given lower and upper bounds.
     * @since 20
     */
    expand(lowerObj: T, upperObj: T): ScopeHelper<T>;

    /**
     * Creates the smallest range that includes the current range and a given range.
     *
     * @param { ScopeHelper } range - A Scope range object
     * @returns { ScopeHelper } Returns the smallest range that includes the current range and a given range.
     * @since 20
     */
    expand(range: ScopeHelper<T>): ScopeHelper<T>;

    /**
     * Creates the smallest range that includes the current range and a given value.
     *
     * @param { ScopeType } value - A ScopeType value
     * @returns { ScopeHelper } Returns the smallest range that includes the current range and a given value.
     * @since 20
     */
    expand(value: T): ScopeHelper<T>;

    /**
     * Checks whether a given value is within the current range.
     *
     * @param { ScopeType } value - A ScopeType value
     * @returns { boolean } If the value is within the current range return true,otherwise return false.
     * @since 20
     */
    contains(value: T): boolean;

    /**
     * Checks whether a given range is within the current range.
     *
     * @param { ScopeHelper } range - A Scope range
     * @returns { boolean } If the current range is within the given range return true,otherwise return false.
     * @since 20
     */
    contains(range: ScopeHelper<T>): boolean;

    /**
     * Clamps a given value to the current range.
     *
     * @param { ScopeType } value - A ScopeType value
     * @returns { ScopeType } Returns a ScopeType object that a given value is clamped to the current range.
     * @since 20
     */
    clamp(value: T): T;
  }

  class LRUCache<K, V> {
    /**
     * Default constructor used to create a new LruBuffer instance with the default capacity of 64.
     *
     * @param { number } [capacity] - Indicates the capacity to customize for the buffer.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Incorrect parameter types.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    constructor(capacity?: number);

    /**
     * Updates the buffer capacity to a specified capacity.
     *
     * @param { number } newCapacity - Indicates the new capacity to set.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    updateCapacity(newCapacity: number): void;

    /**
     * Returns a string representation of the object.
     *
     * @returns { string } Returns the string representation of the object and outputs the string representation of the object.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    toString(): string;

    /**
     * Obtains a list of all values in the current buffer.
     *
     * @type { number }
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    get length(): number;

    /**
     * Obtains the capacity of the current buffer.
     *
     * @returns { number } Returns the capacity of the current buffer.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    getCapacity(): number;

    /**
     * Clears key-value pairs from the current buffer.
     *
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    clear(): void;

    /**
     * Obtains the number of times createDefault(Object) returned a value.
     *
     * @returns { number } Returns the number of times createDefault(java.lang.Object) returned a value.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    getCreateCount(): number;

    /**
     * Obtains the number of times that the queried values are not matched.
     *
     * @returns { number } Returns the number of times that the queried values are not matched.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    getMissCount(): number;

    /**
     * Obtains the number of times that values are evicted from the buffer.
     *
     * @returns { number } Returns the number of times that values are evicted from the buffer.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    getRemovalCount(): number;

    /**
     * Obtains the number of times that the queried values are successfully matched.
     *
     * @returns { number } Returns the number of times that the queried values are successfully matched.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    getMatchCount(): number;

    /**
     * Obtains the number of times that values are added to the buffer.
     *
     * @returns { number } Returns the number of times that values are added to the buffer.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    getPutCount(): number;

    /**
     * Checks whether the current buffer is empty.
     *
     * @returns { boolean } Returns true if the current buffer contains no value.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    isEmpty(): boolean;

    /**
     * Obtains the value associated with a specified key.
     *
     * @param { K } key - Indicates the key to query.
     * @returns { V | undefined } Returns the value associated with the key if the specified key is present in the buffer; returns null otherwise.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     * 1.Mandatory parameters are left unspecified;
     * 2.Incorrect parameter types.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    get(key: K): V | undefined;

    /**
     * Adds a key-value pair to the buffer.
     *
     * @param { K } key - Indicates the key to add.
     * @param { V } value - Indicates the value associated with the key to add.
     * @returns { V | undefined } Returns the value associated with the added key; returns the original value if the key to add already exists, returns null otherwise.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     * 1.Mandatory parameters are left unspecified;
     * 2.Incorrect parameter types.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    put(key: K, value: V): V | undefined;

    /**
     * Obtains a list of all values in the current buffer.
     *
     * @returns { Array<V> } Returns the list of all values in the current buffer, ordered from the most recently accessed to the least recently accessed.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    values(): Array<V>;

    /**
     * Obtains a list of keys for the values in the current buffer.
     * since 9
     *
     * @returns { Array<K> } Returns a list of keys ordered by access time, from the most recently accessed to the least recently accessed.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    keys(): Array<K>;

    /**
     * Deletes a specified key and its associated value from the current buffer.
     *
     * @param { K } key - Indicates the key to delete.
     * @returns { V | undefined } Returns an Optional object containing the deleted key-value pair; returns an empty Optional object if the key does not exist.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     * 1.Mandatory parameters are left unspecified;
     * 2.Incorrect parameter types.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    remove(key: K): V | undefined;

    /**
     * Executes subsequent operations after a value is deleted.
     *
     * @param { boolean } isEvict - The parameter value is true if this method is called due to insufficient capacity,
     * and the parameter value is false in other cases.
     * @param { K } key - Indicates the deleted key.
     * @param { V } value - Indicates the deleted value.
     * @param { V } newValue - The parameter value is the new value associated if the put(java.lang.Object,java.lang.Object)
     * method is called and the key to add already exists. The parameter value is null in other cases.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     * 1.Mandatory parameters are left unspecified;
     * 2.Incorrect parameter types.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    afterRemoval(isEvict: boolean, key: K, value: V, newValue: V): void;

    /**
     * Checks whether the current buffer contains a specified key.
     *
     * @param { K } key - Indicates the key to check.
     * @returns { boolean } Returns true if the buffer contains the specified key.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     * 1.Mandatory parameters are left unspecified;
     * 2.Incorrect parameter types.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    contains(key: K): boolean;

    /**
     * Executes subsequent operations if miss to compute a value for the specific key.
     *
     * @param { K } key - Indicates the missed key.
     * @returns { V | undefined } Returns the value associated with the key.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     * 1.Mandatory parameters are left unspecified;
     * 2.Incorrect parameter types.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    createDefault(key: K): V | undefined;

    /**
     * Returns an array of key-value pairs of enumeratable properties of a given object.
     *
     * @returns { IterableIterator<[K, V]> } Returns an array of key-value pairs for the enumeratable properties of the given object itself.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    entries(): IterableIterator<[K, V]>;

    /**
     * Specifies the default iterator for an object.
     *
     * @returns { IterableIterator<[K, V]> } Returns a two - dimensional array in the form of key - value pairs.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    $_iterator(): IterableIterator<[K, V]>;
  }

  /**
   * Defines the TextDecoder related options parameters.
   *
   * @interface TextDecoderOptions
   * @syscap SystemCapability.Utils.Lang
   * @since 20
   */
  interface TextDecoderOptions {
    /**
     * Is a fatal error displayed? The default value is false.
     * @type { ?boolean }
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */

    fatal?: boolean;
    /**
    * Do you want to ignore BOM tags? The default value is false.
    * @type { ?boolean }
    * @syscap SystemCapability.Utils.Lang
    * @since 20
    */
    ignoreBOM?: boolean;
  }

  /**
   * Defines the decode with stream related options parameters.
   *
   * @interface DecodeToStringOptions
   * @syscap SystemCapability.Utils.Lang
   * @since 20
   */
  interface DecodeToStringOptions {
    /**
    * Stream option controls stream processing in decoding. The default value is false.
    * @type { ?boolean }
    * @syscap SystemCapability.Utils.Lang
    * @since 20
    */
    stream?: boolean;
  }

  /**
   * Provide the ability to decode binary streams into strings. The supported encoding types include: utf-8, iso-8859-2,
   * koi8-r, macintosh, windows-1250, windows-1251, gbk, gb18030, big5, utf-16be, utf-16 le, etc.
   *
   * @syscap SystemCapability.Utils.Lang
   * @since 20
   */
  class StringDecoder {
    /**
     * The StringDecoder constructor.
     *
     * @param { string } [encoding] - Encoding type of the input data.Default: utf8.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     * 1.Mandatory parameters are left unspecified;
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    constructor(encoding?: string);

    /**
     * Returns a decoded string, ensuring that any incomplete multiple byte characters at the end of the Uint8Array are
     * omitted from the returned string and stored in an internal buffer.
     *
     * @param { string | Uint8Array } chunk - The bytes to decode.
     * @returns { string } Returns a decoded string.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     * 1.Mandatory parameters are left unspecified;
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    write(chunk: string | Uint8Array): string;

    /**
     * Returns any remaining input stored in the internal buffer as a string. After end() is called,
     * this object can be reused for new input.
     *
     * @param { string | Uint8Array } [chunk] - The bytes to decode.
     * @returns { string } Returns any remaining input stored in the internal buffer as a string.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     * 1.Mandatory parameters are left unspecified;
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    end(chunk?: string | Uint8Array): string;
  }

  /**
   * The TextDecoder represents a text decoder that accepts a string as input,
   * decodes it in UTF-8 format, and outputs UTF-8 byte stream.
   *
   * @syscap SystemCapability.Utils.Lang
   * @since 20
   */
  class TextDecoder {
    /**
     * The textDecoder constructor.
     *
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    constructor();

    /**
     * The source encoding's name, lowercased.
     *
     * @return { string } The string of the TextDecoder encoding.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    get encoding(): string;

    /**
     * Returns `true` if error mode is "fatal", and `false` otherwise.
     *
     * @return { boolean } Whether to display fatal errors.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    get fatal(): boolean;

    /**
     * Returns `true` if ignore BOM flag is set, and `false` otherwise.
     *
     * @return { boolean } Returns `true` if ignore BOM flag is set, and `false` otherwise.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    get ignoreBOM(): boolean;

    /**
     * Replaces the original constructor to process arguments and return a textDecoder object.
     *
     * @param { string } [encoding] - Decoding format
     * @param { TextDecoderOptions } [options] - Options
     * @returns { TextDecoder }
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    static create(encoding?: string, options?: TextDecoderOptions): TextDecoder;

    /**
     * The input is decoded and a string is returned.
     * If options.stream is set to true, any incomplete byte sequences found at the end of the input are internally
     * buffered and will be emitted after the next call to textDecoder.decodeToString().
     * If textDecoder.fatal is set to true, any decoding errors that occur will result in a TypeError being thrown.
     *
     * @param { Uint8Array } input - Decoded numbers in accordance with the format.
     * @param { DecodeToStringOptions } [options] - The default option is set to false.
     * @returns { string } Return decoded text
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Parameter verification failed;
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    decodeToString(input: Uint8Array, options?: DecodeToStringOptions): string;
  }

  /**
   * Return encoded text.
   *
   * @interface EncodeIntoUint8ArrayInfo
   * @syscap SystemCapability.Utils.Lang
   * @since 20
   */
  interface EncodeIntoUint8ArrayInfo {
    /**
    * The read represents the number of characters that have been encoded.
    * @type { int }
    * @syscap SystemCapability.Utils.Lang
    * @since 20
    */

    read: int;
    /**
    * The written represents the number of bytes occupied by the encoded characters.
    * @type { int }
    * @syscap SystemCapability.Utils.Lang
    * @since 20
    */
    written: int;
  }

  /**
   * The rational number is mainly to compare rational numbers and obtain the numerator and denominator.
   *
   * @syscap SystemCapability.Utils.Lang
   * @since 20
   */
  class RationalNumber {
    /**
     * A constructor used to create a RationalNumber instance with a given numerator and denominator.
     *
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    constructor();

    /**
     * Used to create a RationalNumber instance with a given numerator and denominator.
     *
     * @param { number } numerator - An integer number
     * @param { number } denominator - An integer number
     * @returns { RationalNumber }
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     * 1.Mandatory parameters are left unspecified;
     * 2.Incorrect parameter types.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    static parseRationalNumber(numerator: number, denominator: number): RationalNumber;

    /**
     * Creates a RationalNumber object based on a given string.
     *
     * @param { string } rationalString - String Expression of Rational Numbers
     * @returns { RationalNumber } Returns a RationalNumber object generated based on the given string.
     * @throws { BusinessError } 401 - The type of rationalString must be string.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    static createRationalFromString(rationalString: string): RationalNumber;

    /**
     * Compares the current RationalNumber object to the given object.
     *
     * @param { RationalNumber } another - An object of other rational numbers
     * @returns { number } Returns 0 or 1, or -1, depending on the comparison.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     * 1.Mandatory parameters are left unspecified;
     * 2.Incorrect parameter types.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    compare(another: RationalNumber): number;

    /**
     * Compares two objects for equality.
     *
     * @param { Object } obj - An object
     * @returns { boolean } Returns true if the given object is the same as the current object;
     * Otherwise, false is returned.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    equals(obj: Object): boolean;

    /**
     * Gets integer and floating-point values of a rational number object.
     *
     * @returns { number } Returns the integer and floating-point values of a rational number object.
     * @syscap SystemCapability.Utils.Lang
     * @since 12
     */
    valueOf(): number;

    /**
     * Get the greatest common factor of two integers.
     *
     * @param { number } number1 - Is an integer.
     * @param { number } number2 - Is an integer.
     * @returns { number } Returns the greatest common factor of two integers, integer type.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     * 1.Mandatory parameters are left unspecified;
     * 2.Incorrect parameter types.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    static getCommonFactor(number1: number, number2: number): number;

    /**
     * Gets the denominator of the current object.
     *
     * @returns { number } Returns the denominator of the current object.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    getDenominator(): number;

    /**
     * Gets the numerator of the current object.
     *
     * @returns { number } Returns the numerator of the current object.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    getNumerator(): number;

    /**
     * Checks whether the current RationalNumber object represents an infinite value.
     *
     * @returns { boolean } If the denominator is not 0, true is returned. Otherwise, false is returned.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    isFinite(): boolean;

    /**
     * Checks whether the current RationalNumber object represents a Not-a-Number (NaN) value.
     *
     * @returns { boolean } If both the denominator and numerator are 0, true is returned. Otherwise, false is returned.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    isNaN(): boolean;

    /**
     * Checks whether the current RationalNumber object represents the value 0.
     *
     * @returns { boolean } If the value represented by the current object is 0, true is returned.
     * Otherwise, false is returned.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    isZero(): boolean;

    /**
     * Obtains a string representation of the current RationalNumber object.
     *
     * @returns { string } Returns a string representation of the current RationalNumber object.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    toString(): string;
  }

  /**
   * The TextEncoder interface represents a text encoder.
   * The encoder takes the byte stream as the input and outputs the String string.
   *
   * @syscap SystemCapability.Utils.Lang
   * @since 20
   */
  class TextEncoder {
    /**
     * Encoding format.
     *
     * @return { string } The string of the TextEncoder encoding.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    get encoding(): string;

    /**
     * The textEncoder constructor.
     *
     * @param { string } [encoding] - The string for encoding format.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Parameter verification failed.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    constructor(encoding?: string);

    /**
     * Create a TextEncoder object.
     *
     * @param { string } [encoding] - The string for encoding format.
     * @returns { TextEncoder }
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Parameter verification failed.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    static create(encoding?: string): TextEncoder;

    /**
     * UTF-8 encodes the input string and returns a Uint8Array containing the encoded bytes.
     *
     * @param { string } [input] - The string to be encoded.
     * @returns { Uint8Array } Returns the encoded text.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    encodeInto(input?: string): Uint8Array;

    /**
     * Encode string, write the result to dest array.
     *
     * @param { string } input - The string to be encoded.
     * @param { Uint8Array } dest - Encoded numbers in accordance with the format
     * @returns { EncodeIntoUint8ArrayInfo } Return the object, where read represents
     * the number of characters that have been encoded, and written
     * represents the number of bytes occupied by the encoded characters.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    encodeIntoUint8Array(input: string, dest: Uint8Array): EncodeIntoUint8ArrayInfo;
  }

  /**
   * Check the type of parameter.
   *
   * @syscap SystemCapability.Utils.Lang
   * @since 20
   */
  class types {

    /**
     * Check whether the entered value is of arraybuffer or sharedarraybuffer type.
     *
     * @param { Object } value - A ArrayBuffer or SharedArrayBuffer value
     * @returns { boolean } Returns true if the value is a built-in ArrayBuffer or SharedArrayBuffer instance.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    isAnyArrayBuffer(value: Object): boolean;
    /**
     * Check whether the type is included in the isAnyArrayBuffer.
     *
     * @param { Object } value - A included in the isAnyArrayBuffer value
     * @returns { boolean } Returns true if the value is an instance of one of the ArrayBuffer views,
     * such as typed array objects or DataView.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    isArrayBufferView(value: Object): boolean;
    /**
     * Check whether the entered value is of arraybuffer type.
     *
     * @param { Object } value - A arraybuffer value
     * @returns { boolean } Returns true if the value is a built-in ArrayBuffer instance.
     * This does not include SharedArrayBuffer instances.
     * Usually, it is desirable to test for both; See isAnyArrayBuffer() for that.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    isArrayBuffer(value: Object): boolean;
    /**
     * Check whether the entered value is of bigint64array array type.
     *
     * @param { Object } value - A BigInt64Array value
     * @returns { boolean } Returns true if the value is a BigInt64Array instance.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    isBigInt64Array(value: Object): boolean;
    /**
     * Check whether the entered value is of biguint64array array array type.
     *
     * @param { Object } value - A BigUint64Array value
     * @returns { boolean } Returns true if the value is a BigUint64Array instance.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    isBigUint64Array(value: Object): boolean;
    /**
     * Check whether the entered value is of DataView type.
     *
     * @param { Object } value - A DataView value
     * @returns { boolean } Returns true if the value is a built-in DataView instance.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    isDataView(value: Object): boolean;
    /**
     * Check whether the entered value is of type date.
     *
     * @param { Object } value - A Date value
     * @returns { boolean } Returns true if the value is a built-in Date instance.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    isDate(value: Object): boolean;
    /**
     * Check whether the entered value is of float32array array type.
     *
     * @param { Object } value - A Float32Array value
     * @returns { boolean } Returns true if the value is a built-in Float32Array instance.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    isFloat32Array(value: Object): boolean;
    /**
     * Check whether the entered value is of float64array array type.
     *
     * @param { Object } value - A Float64Array value
     * @returns { boolean } Returns true if the value is a built-in Float64Array instance.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    isFloat64Array(value: Object): boolean;
    /**
     * Check whether the entered value is of int8array array type.
     *
     * @param { Object } value - A Int8Array value
     * @returns { boolean } Returns true if the value is a built-in Int8Array instance.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    isInt8Array(value: Object): boolean;
    /**
     * Check whether the entered value is the int16array type.
     *
     * @param { Object } value - A Int16Array value
     * @returns { boolean } Returns true if the value is a built-in Int16Array instance.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    isInt16Array(value: Object): boolean;
    /**
     * Check whether the entered value is the int32array array type.
     *
     * @param { Object } value - A Int32Array value
     * @returns { boolean } Returns true if the value is a built-in Int32Array instance.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    isInt32Array(value: Object): boolean;
    /**
     * Check whether the entered value is of map type.
     *
     * @param { Object } value - A Map value
     * @returns { boolean } Returns true if the value is a built-in Map instance.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    isMap(value: Object): boolean;
    /**
     * Check whether the entered value is the iterator type of map.
     *
     * @param { Object } value - A Map iterator value
     * @returns { boolean } Returns true if the value is an iterator returned for a built-in Map instance.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    isMapIterator(value: Object): boolean;
    /**
     * Check whether the value entered is of type error.
     *
     * @param { Object } value - A Error value
     * @returns { boolean } Returns true if the value is an instance of a built-in Error type.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    isNativeError(value: Object): boolean;
    /**
     * Check whether the entered value is of promise type.
     *
     * @param { Object } value - A Promise value
     * @returns { boolean } Returns true if the value is a built-in Promise.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    isPromise(value: Object): boolean;
    /**
     * Check whether the entered value is of type regexp.
     *
     * @param { Object } value - A regular expression object value
     * @returns { boolean } Returns true if the value is a regular expression object.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    isRegExp(value: Object): boolean;
    /**
     * Check whether the entered value is of type set.
     *
     * @param { Object } value - A Set instance value
     * @returns { boolean } Returns true if the value is a built-in Set instance.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    isSet(value: Object): boolean;
    /**
     * Check whether the entered value is the iterator type of set.
     *
     * @param { Object } value - A Set iterator value
     * @returns { boolean } Returns true if the value is an iterator returned for a built-in Set instance.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    isSetIterator(value: Object): boolean;
    /**
     * Check whether the entered value is a type contained in typedarray.
     *
     * @param { Object } value - A TypedArray instance value
     * @returns { boolean } Returns true if the value is a built-in TypedArray instance.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    isTypedArray(value: Object): boolean;
    /**
     * Check whether the entered value is the uint8array array type.
     *
     * @param { Object } value - A Uint8Array value
     * @returns { boolean } Returns true if the value is a built-in Uint8Array instance.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    isUint8Array(value: Object): boolean;
    /**
     * Check whether the entered value is the uint8clapedarray array type.
     *
     * @param { Object } value - A Uint8ClampedArray value
     * @returns { boolean } Returns true if the value is a built-in Uint8ClampedArray instance.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    isUint8ClampedArray(value: Object): boolean;
    /**
     * Check whether the entered value is the uint16array array array type.
     *
     * @param { Object } value - A Uint16Array value
     * @returns { boolean } Returns true if the value is a built-in Uint16Array instance.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    isUint16Array(value: Object): boolean;
    /**
     * Check whether the entered value is the uint32array array type.
     *
     * @param { Object } value - A Uint32Array value
     * @returns { boolean } Returns true if the value is a built-in Uint32Array instance.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    isUint32Array(value: Object): boolean;
    /**
     * Check whether the entered value is of type weakmap.
     *
     * @param { Object } value - A WeakMap value
     * @returns { boolean } Returns true if the value is a built-in WeakMap instance.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    isWeakMap(value: Object): boolean;
    /**
     * Check whether the entered value is of type weakset.
     *
     * @param { Object } value - A WeakSet value
     * @returns { boolean } Returns true if the value is a built-in WeakSet instance.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    isWeakSet(value: Object): boolean;
  }

  /**
   * Takes a function following the common error-first callback style, i.e taking an (err, value) =>
   * callback as the last argument, and return a function that returns promises.
   *
   * @param { Function } original - Asynchronous Function
   * @returns { Function } Return a function that returns promises
   * @syscap SystemCapability.Utils.Lang
   * @since 20
   */
  function promisify(original: Function): (...args: FixedArray<Any>) => Promise<Any>;

  /**
   * Get the hash code of an object.
   *
   * @param { object } [obj] - The object that need to get hash code.
   * @returns { number } Return a hash code of an object.
   * @syscap SystemCapability.Utils.Lang
   * @since 20
   */
  function getHash(obj: object): number;

  /**
   * Generate a random RFC 4122 version 4 binary UUID using a cryptographically secure random number generator.
   *
   * @param { boolean } [entropyCache] - Whether to generate the UUID with using the cache. Default: true.
   * @returns { Uint8Array | undefined } Return a Uint8Array representing this UUID, or undefined on failure.
   * @syscap SystemCapability.Utils.Lang
   * @since 20
   */
  function generateRandomBinaryUUID(entropyCache?: boolean): Uint8Array | undefined;

  /**
   * Parse a UUID from the string standard representation as described in the RFC 4122 version 4.
   *
   * @param { string } uuid - String that specifies a UUID
   * @returns { Uint8Array } Return a Uint8Array representing this UUID. Throw SyntaxError if parsing fails.
   * @throws { BusinessError } 10200002 - Invalid uuid string.
   * @syscap SystemCapability.Utils.Lang
   * @since 20
   */
  function parseUUID(uuid: string): Uint8Array;
}
export default util;
