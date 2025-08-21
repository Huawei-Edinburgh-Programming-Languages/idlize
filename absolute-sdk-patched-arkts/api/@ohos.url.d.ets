/*
 * Copyright (c) 2021-2022 Huawei Device Co., Ltd.
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
 * The url module provides APIs for parsing URL strings and constructing URL instances to process URL strings.
 *
 * @namespace url
 * @syscap SystemCapability.Utils.Lang
 * @since 20
 */
declare namespace url {
    
    
    /**
     * The URLParams interface defines some practical methods to process URL query strings.
     *
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     * @name URLParams
     */
    class URLParams {
        /**
         * A parameterized constructor used to create an URLParams instance.
         * As the input parameter of the constructor function, init supports four types.
         * The input parameter is a character string two-dimensional array.
         * The input parameter is the object list.
         * The input parameter is a character string.
         * The input parameter is the URLParams object.
         *
         * @param { [string, string][] | Record<string, string> | string | URLParams } [init] - init init
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        constructor(init?: [
            string,
            string
        ][] | Record<string, string> | string | URLParams);
        
        
        /**
         * Appends a key-value pair into the query string.
         *
         * @param { string } name - Key of the key-value pair to append.
         * @param { string } value - Value of the key-value pair to append.
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         * 1.Mandatory parameters are left unspecified;
         * 2.Incorrect parameter types;
         * 3.Parameter verification failed.
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        append(name: string, value: string): void;
        
        
        /**
         * Deletes key-value pairs of the specified key.
         *
         * @param { string } name - Key of the key-value pairs to delete.
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         * 1.Mandatory parameters are left unspecified;
         * 2.Incorrect parameter types;
         * 3.Parameter verification failed.
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        delete(name: string): void;
        
        
        /**
         * Obtains all the values based on the specified key.
         *
         * @param { string } name - Target key.
         * @returns { string[] } string[] Returns all key-value pairs with the specified name.
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         * 1.Mandatory parameters are left unspecified;
         * 2.Incorrect parameter types;
         * 3.Parameter verification failed.
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        getAll(name: string): string[];
        
        
        /**
         * Obtains an ES6 iterator. Each item of the iterator is a JavaScript array, and the first and second fields of
         * each array are the key and value respectively.
         *
         * @returns { IterableIterator<[string, string]> } Returns an iterator for ES6.
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        entries(): IterableIterator<[
            string,
            string
        ]>;
        /**
         * Iterates over a collection (e.g., URLs) and executes a callback function for each element.
         *
         * @param { UrlCbFn } callbackFn - A callback function to execute for each element.
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        forEach(callbackFn: UrlCbFn): void;
        /**
         * Obtains the value of the first key-value pair based on the specified key.
         *
         * @param { string } name - Key specified to obtain the value.
         * @returns { string | undefined } Returns the first value found by name.
         * If no value is found, undefined is returned.
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        get(name: string): string | undefined;
        
        
        /**
         * Checks whether a key has a value.
         *
         * @param { string } name - Key specified to search for its value.
         * @returns { boolean } Returns a Boolean value that indicates whether a found
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         * 1.Mandatory parameters are left unspecified;
         * 2.Incorrect parameter types.
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        has(name: string): boolean;
        
        
        /**
         * Sets the value for a key. If key-value pairs matching the specified key exist, the value of the first key-value
         * pair will be set to the specified value and other key-value pairs will be deleted. Otherwise, the key-value pair
         * will be appended to the query string.
         *
         * @param { string } name - Key of the value to set.
         * @param { string } value - Value to set.
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         * 1.Mandatory parameters are left unspecified;
         * 2.Incorrect parameter types;
         * 3.Parameter verification failed.
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        set(name: string, value: string): void;
        
        
        /**
         * Sorts all key-value pairs contained in this object based on the Unicode code points of the keys and returns
         * undefined. This method uses a stable sorting algorithm, that is, the relative order between key-value pairs
         * with equal keys is retained.
         *
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        sort(): void;
        
        
        /**
         * Obtains an ES6 iterator that contains the keys of all the key-value pairs.
         *
         * @returns { IterableIterator<string> } Returns an ES6 Iterator over the names of each name-value pair.
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        keys(): IterableIterator<string>;
        
        
        /**
         * Obtains an ES6 iterator that contains the values of all the key-value pairs.
         *
         * @returns { IterableIterator<string> } Returns an ES6 Iterator over the values of each name-value pair.
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        values(): IterableIterator<string>;
        /**
         * Obtains an ES6 iterator. Each item of the iterator is a JavaScript array, and the first and second fields ofeach array are
         * the key and value respectively.
         *
         * @returns { IterableIterator<[string, string]> } Returns an ES6 iterator.
         * Each item of the iterator is a JavaScript Array.
         * The first item of Array is name, and the second item of Array is value.
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        $_iterator(): IterableIterator<[
            string,
            string
        ]>;
        
        
        /**
         * Obtains search parameters that are serialized as a string and, if necessary, percent-encodes the characters in the string.
         *
         * @returns { string } Returns a search parameter serialized as a string, percent-encoded if necessary.
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        toString(): string;
    }
    
    
    /**
     * The interface of URL is used to parse, construct, normalize, and encode URLs.
     *
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     * @name URL
     */
    class URL {
        
        
        /**
         * A no-argument constructor used to create a URL. It returns a URL object after parseURL is called.
         * It is not used independently.
         *
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        constructor();
        
        
        /**
         * Parses a URL.
         *
         * @param { string } url - A string representing an absolute or a relative URL.
         * In the case of a relative URL, you must specify base to parse the final URL.
         * In the case of an absolute URL, the passed base will be ignored.
         * @param { string | URL } [base] - Either a string or an object. The default value is undefined.
         * - string: string.
         * - URL: URL object.
         * This parameter is used when url is a relative URL.
         * @returns { URL }
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         * 1.Mandatory parameters are left unspecified;
         * 2.Incorrect parameter types;
         * 3.Parameter verification failed.
         * @throws { BusinessError } 10200002 - Invalid url string.
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        static parseURL(url: string, base?: string | URL): URL;
        
        
        /**
         * Converts the parsed URL into a string.
         *
         * @returns { string } Returns the serialized URL as a string.
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        toString(): string;
        
        
        /**
         * Converts the parsed URL into a JSON string.
         *
         * @returns { string } Returns the serialized URL as a string.
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        toJSON(): string;
        /**
         * Gets and sets the fragment portion of the URL.
         *
         * @type { string }
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        get hash(): string;
        /**
         * Gets and sets the fragment portion of the URL.
         *
         * @type { string }
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        set hash(hash: string);
        /**
         * Gets and sets the host portion of the URL.
         *
         * @type { string }
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        get host(): string;
        /**
        * Gets and sets the host portion of the URL.
        *
        * @type { string }
        * @syscap SystemCapability.Utils.Lang
        * @since 20
        */
        set host(host: string);
        /**
         * Gets and sets the host name portion of the URL，not include the port.
         *
         * @type { string }
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        get hostname(): string;
        /**
        * Gets and sets the host name portion of the URL，not include the port.
        *
        * @type { string }
        * @syscap SystemCapability.Utils.Lang
        * @since 20
        */
        set hostname(hostname: string);
        /**
         * Gets and sets the serialized URL.
         *
         * @type { string }
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        get href(): string;
        /**
         * Gets and sets the serialized URL.
         *
         * @type { string }
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        set href(href: string);
        /**
         * Gets the read-only serialization of the URL's origin.
         *
         * @type { string }
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        get origin(): string;
        /**
         * Gets and sets the password portion of the URL.
         *
         * @type { string }
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        get password(): string;
        /**
         * Gets and sets the password portion of the URL.
         *
         * @type { string }
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        set password(password: string);
        /**
         * Gets and sets the path portion of the URL.
         *
         * @type { string }
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        get pathname(): string;
        /**
        * Gets and sets the path portion of the URL.
        *
        * @type { string }
        * @syscap SystemCapability.Utils.Lang
        * @since 20
        */
        set pathname(pathname: string);
        /**
         * Gets and sets the port portion of the URL.
         *
         * @type { string }
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        get port(): string;
        /**
        * Gets and sets the port portion of the URL.
        *
        * @type { string }
        * @syscap SystemCapability.Utils.Lang
        * @since 20
        */
        set port(port: string);
        /**
         * Gets and sets the protocol portion of the URL.
         *
         * @type { string }
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        get protocol(): string;
        /**
        * Gets and sets the protocol portion of the URL.
        *
        * @type { string }
        * @syscap SystemCapability.Utils.Lang
        * @since 20
        */
        set protocol(protocol: string);
        /**
         * Gets and sets the serialized query portion of the URL.
         *
         * @type { string }
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        get search(): string;
        /**
       * Gets and sets the serialized query portion of the URL.
       *
       * @type { string }
       * @syscap SystemCapability.Utils.Lang
       * @since 20
       */
        set search(search: string);
        /**
         * Gets the URLParams object that represents the URL query parameter.
         * This property is read-only, but URLParams provides an object that can be used to change
         * the URL instance. To replace the entire query parameter for a URL, use url.searchsetter.
         *
         * @type { URLParams }
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        get params(): URLParams;
        /**
         * Gets and sets the username portion of the URL.
         *
         * @type { string }
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        get username(): string;
        /**
        * Gets and sets the username portion of the URL.
        *
        * @type { string }
        * @syscap SystemCapability.Utils.Lang
        * @since 20
        */
        set username(username: string);
    }
    /**
     * The type of URL callback function.
     *
     * @typedef { function } UrlCbFn
     * @param { string } value - The value of the URL parameter.
     * @param { string } key - The key of the URL parameter.
     * @param { URLParams } searchParams - The URLParams object containing all parameters.
     * @returns { void } This callback does not return a value.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    type UrlCbFn = (value: string, key: string, searchParams: URLParams) => void;
}
export default url;
