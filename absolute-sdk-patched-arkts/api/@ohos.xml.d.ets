/*
 * Copyright (c) 2021 Huawei Device Co., Ltd.
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
 * The xml module provides utilities for converting XML text to Javascript object, XML generation and parsing.
 *
 * @namespace xml
 * @syscap SystemCapability.Utils.Lang
 * @since 20
 */
declare namespace xml {
    /**
   * The XmlDynamicSerializer interface is used to dynamically generate an xml file.
   *
   * @syscap SystemCapability.Utils.Lang
   * @since 20
   * @name XmlDynamicSerializer
   */
    class XmlDynamicSerializer {
        /**
         * A parameterized constructor used to create a new XmlDynamicSerializer instance.
         * The input parameter is an encoding format of string type.
         *
         * @param { string } [encoding] - [encoding='utf8']  this is its encoding, only support utf-8.
         * @throws { BusinessError } 10200066 - Incorrect encoding format, only support utf-8.
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        constructor(encoding?: string);
        /**
         * Write an attribute to xml element.
         *
         * @param { string } name - Key name of the attribute. Cannot be an empty string.
         * @param { string } value - Values of attribute.
         * @throws { BusinessError } 10200062 - The cumulative length of xml has exceeded the upper limit 100000.
         * @throws { BusinessError } 10200063 - Illegal position for xml.
         * @throws { BusinessError } 10200064 - Cannot be an empty string.
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        setAttributes(name: string, value: string): void;
        /**
         * Add an empty element.
         *
         * @param { string } name - Name of the element.
         * @throws { BusinessError } 10200062 - The cumulative length of xml has exceeded the upper limit 100000.
         * @throws { BusinessError } 10200064 - Cannot be an empty string.
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        addEmptyElement(name: string): void;
        /**
         * Writes xml declaration with encoding. For example: <?xml version="1.0" encoding="utf-8"?>.
         * @throws { BusinessError } 10200062 - The cumulative length of xml has exceeded the upper limit 100000.
         * @throws { BusinessError } 10200063 - Illegal position for xml.
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        setDeclaration(): void;
        /**
         * Writes a element start tag with the given name.
         *
         * @param { string } name - Name of the element.
         * @throws { BusinessError } 10200062 - The cumulative length of xml has exceeded the upper limit 100000.
         * @throws { BusinessError } 10200064 - Cannot be an empty string.
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        startElement(name: string): void;
        /**
         * Writes end tag of the element.
         *
         * @throws { BusinessError } 10200062 - The cumulative length of xml has exceeded the upper limit 100000.
         * @throws { BusinessError } 10200065 - There is no match between the startElement and the endElement.
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        endElement(): void;
        /**
         * Writes the namespace of the current element tag.
         *
         * @param { string } prefix - Values name of the prefix. Cannot be an empty string.
         * @param { string } namespace - Values of namespace. Cannot be an empty string.
         * @throws { BusinessError } 10200062 - The cumulative length of xml has exceeded the upper limit 100000.
         * @throws { BusinessError } 10200064 - Cannot be an empty string.
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        setNamespace(prefix: string, namespace: string): void;
        /**
         * Writes the comment to xml.
         *
         * @param { string } text - Values of comment. Cannot be an empty string.
         * @throws { BusinessError } 10200062 - The cumulative length of xml has exceeded the upper limit 100000.
         * @throws { BusinessError } 10200064 - Cannot be an empty string.
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        setComment(text: string): void;
        /**
         * Writes the CDATA.
         *
         * @param { string } text - Values of CDATA. Cannot be an empty string.
         * @throws { BusinessError } 10200062 - The cumulative length of xml has exceeded the upper limit 100000.
         * @throws { BusinessError } 10200064 - Cannot be an empty string.
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        setCdata(text: string): void;
        /**
         * Writes the text to xml element.
         *
         * @param { string } text - Values of text. Cannot be an empty string.
         * @throws { BusinessError } 10200062 - The cumulative length of xml has exceeded the upper limit 100000.
         * @throws { BusinessError } 10200064 - Cannot be an empty string.
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        setText(text: string): void;
        /**
         * Writes the DOCTYPE.
         *
         * @param { string } text - Values of docType. Cannot be an empty string.
         * @throws { BusinessError } 10200062 - The cumulative length of xml has exceeded the upper limit 100000.
         * @throws { BusinessError } 10200064 - Cannot be an empty string.
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        setDocType(text: string): void;
        /**
         * Get an ArrayBuffer from a XmlDynamicSerializer instance.
         *
         * @returns { ArrayBuffer } - Returns ArrayBuffer result from a XmlDynamicSerializer instance.
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        getOutput(): ArrayBuffer;
    }
    
    
    /**
     * The XmlSerializer interface is used to generate an xml file.
     *
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     * @name XmlSerializer
     */
    class XmlSerializer {
        
        
        /**
         * A constructor used to create an XmlSerializer instance.
         *
         * @param { ArrayBuffer | DataView } buffer - ArrayBuffer or DataView for storing the XML information to set.
         * @param { string } [encoding] - Encoding format. The default value is 'utf-8' (the only format currently supported).
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         * 1.Mandatory parameters are left unspecified;
         * 2.Incorrect parameter types;
         * 3.Parameter verification failed.
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        constructor(buffer: ArrayBuffer | DataView, encoding?: string);
        
        
        /**
         * Sets an attribute.
         *
         * @param { string } name - Key of the attribute.
         * @param { string } value - Value of the attribute.
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         * 1.Mandatory parameters are left unspecified;
         * 2.Incorrect parameter types; 3.Parameter verification failed.
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        setAttributes(name: string, value: string): void;
        
        
        /**
         * Adds an empty element.
         *
         * @param { string } name - Name of the empty element to add.
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         * 1.Mandatory parameters are left unspecified;
         * 2.Incorrect parameter types;
         * 3.Parameter verification failed.
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        addEmptyElement(name: string): void;
        
        
        /**
         * Sets a file declaration with encoding.
         *
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        setDeclaration(): void;
        
        
        /**
         * Writes the start tag based on the given element name.
         *
         * @param { string } name - Name of the element.
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         * 1.Mandatory parameters are left unspecified;
         * 2.Incorrect parameter types;
         * 3.Parameter verification failed.
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        startElement(name: string): void;
        
        
        /**
         * Writes the end tag of the element.
         *
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        endElement(): void;
        
        
        /**
         * Sets the namespace for an element tag.
         *
         * @param { string } prefix - Prefix of the element and its child elements.
         * @param { string } namespace - Namespace to set.
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         * 1.Mandatory parameters are left unspecified;
         * 2.Incorrect parameter types;
         * 3.Parameter verification failed.
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        setNamespace(prefix: string, namespace: string): void;
        
        
        /**
         * Sets a comment.
         *
         * @param { string } text - Comment to set.
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         * 1.Mandatory parameters are left unspecified;
         * 2.Incorrect parameter types;
         * 3.Parameter verification failed.
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        setComment(text: string): void;
        
        
        /**
         * Adds data to the CDATA tag. The structure of the generated CDATA tag is "<! <![CDATA["+ Data added + "]]>".
         *
         * @param { string } text - CDATA data to set.
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         * 1.Mandatory parameters are left unspecified;
         * 2.Incorrect parameter types;
         * 3.Parameter verification failed.
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        setCDATA(text: string): void;
        
        
        /**
         * Sets a tag value.
         *
         * @param { string } text - Tag value to set, which is the content of the text attribute.
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         * 1.Mandatory parameters are left unspecified;
         * 2.Incorrect parameter types;
         * 3.Parameter verification failed.
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        setText(text: string): void;
        
        
        /**
         * Sets a document type.
         *
         * @param { string } text - Content of DocType to set.
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         * 1.Mandatory parameters are left unspecified;
         * 2.Incorrect parameter types;
         * 3.Parameter verification failed.
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        setDocType(text: string): void;
    }
    
    
    /**
     * The event types represented by XML elements.
     *
     * @enum { number }
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    enum EventType {
        
        
        /**
         * Start a document.
         *
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        START_DOCUMENT,
        
        
        /**
         * End a document.
         *
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        END_DOCUMENT,
        
        
        /**
         * Start a tag.
         *
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        START_TAG,
        
        
        /**
         * End a tag.
         *
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        END_TAG,
        
        
        /**
         * Character data.
         *
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        TEXT,
        
        
        /**
         * A CDATA sections.
         *
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        CDSECT,
        
        
        /**
         * An XML comment.
         *
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        COMMENT,
        
        
        /**
         * An XML document type declaration.
         *
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        DOCDECL,
        
        
        /**
         * An XML processing instruction declaration.
         *
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        INSTRUCTION,
        
        
        /**
         * An entity reference.
         *
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        ENTITY_REFERENCE,
        
        
        /**
         * A whitespace.
         *
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        WHITESPACE
    }
    
    
    /**
     * The current parse info.
     *
     * @typedef ParseInfo
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    interface ParseInfo {
        
        
        /**
         * Obtains the current column number, starting from 1.
         *
         * @returns { int }
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        getColumnNumber(): int;
        
        
        /**
         * Obtains the depth of this element.
         *
         * @returns { int }
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        getDepth(): int;
        
        
        /**
         * Obtains the current line number, starting from 1.
         *
         * @returns { int }
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        getLineNumber(): int;
        
        
        /**
         * Obtains the name of this element.
         *
         * @returns { string }
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        getName(): string;
        
        
        /**
         * Obtains the namespace of this element.
         *
         * @returns { string }
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        getNamespace(): string;
        
        
        /**
         * Obtains the prefix of this element.
         *
         * @returns { string }
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        getPrefix(): string;
        
        
        /**
         * Obtains the text of the current event.
         *
         * @returns { string }
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        getText(): string;
        
        
        /**
         * Checks whether the current element is empty.
         *
         * @returns { boolean }
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        isEmptyElementTag(): boolean;
        
        
        /**
         * Checks whether the current event contains only whitespace characters.
         *
         * @returns { boolean }
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        isWhitespace(): boolean;
        
        
        /**
         * Obtains the number of attributes for the current start tag.
         *
         * @returns { int }
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        getAttributeCount(): int;
    }
    
    
    /**
     * Parse options for XmlPullParser.
     *
     * @typedef ParseOptions
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    interface ParseOptions {
        
        
        /**
         * Whether to parsing Doctype of the elements.
         *
         * @type { ?boolean }
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        supportDoctype?: boolean;
        
        
        /**
         * Whether to ignore parsing texts of the elements.
         *
         * @type { ?boolean }
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        ignoreNameSpace?: boolean;
        
        
        /**
         * Tag value callback function.
         *
         * @type { ?function }
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        tagValueCallbackFunction?: (name: string, value: string) => boolean;
        
        
        /**
         * Attribute value callback function.
         *
         * @type { ?function }
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        attributeValueCallbackFunction?: (name: string, value: string) => boolean;
        
        
        /**
         * Token value callback function.
         *
         * @type { ?function }
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        tokenValueCallbackFunction?: (eventType: EventType, value: ParseInfo) => boolean;
    }
    
    
    /**
     * The XmlPullParser interface is used to parse the existing xml file.
     *
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     * @name XmlPullParser
     */
    class XmlPullParser {
        
        
        /**
         * Creates and returns an XmlPullParser object.
         *
         * @param { ArrayBuffer | DataView } buffer - A instance, the new XmlPullParser with.
         * @param { string } [encoding] - [encoding='utf8']  this is its encoding.
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         * 1.Mandatory parameters are left unspecified;
         * 2.Incorrect parameter types;
         * 3.Parameter verification failed.
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        constructor(buffer: ArrayBuffer | DataView, encoding?: string);
        /**
         * Parses XML information.
         *
         * @param { ParseOptions } option - XML parsing options.
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         * 1.Mandatory parameters are left unspecified;
         * 2.Incorrect parameter types.
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        parseXml(option: ParseOptions): void;
    }
}
export default xml;
