/*
 * Copyright (c) 2022 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (The type of "License");
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
 * The Buffer class is a global type for dealing with binary data directly. It can be constructed in a variety of ways.
 *
 * @namespace buffer
 * @syscap SystemCapability.Utils.Lang
 * @since 20
 */
declare namespace buffer {
    
    
    /**
     * Enumerates the supported encoding formats.
     *
     * @typedef { 'ascii' | 'utf8' | 'utf-8' | 'utf16le' | 'ucs2' | 'ucs-2' | 'base64' | 'base64url' | 'latin1' | 'binary' | 'hex' }
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    type BufferEncoding = 'ascii' | 'utf8' | 'utf-8' | 'utf16le' | 'ucs2' | 'ucs-2' | 'base64' | 'base64url' | 'latin1' | 'binary' | 'hex';
    /**
     * TypedArray  features and methods
     *
     * @typedef { Int8Array | Uint8Array | Uint8ClampedArray | Int16Array | Uint16Array | Int32Array | Uint32Array | Float32Array | Float64Array | BigInt64Array | BigUint64Array }
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    type TypedArray = Int8Array | Uint8Array | Uint8ClampedArray | Int16Array | Uint16Array | Int32Array | Uint32Array | Float32Array | Float64Array | BigInt64Array | BigUint64Array;
    /**
     * ArrayUnionType features and methods
     *
     * @typedef { Array<Int8Array> | Array<Uint8Array> | Array<Uint8ClampedArray> | Array<Int16Array> | Array<Uint16Array> | Array<Int32Array> |
     * Array<Uint32Array> | Array<Float32Array> | Array<Float64Array> | Array<BigInt64Array> | Array<BigUint64Array> | Array<string> |
     * Array<ArrayBuffer> | Array<DataView> | Array<Blob>}
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    type ArrayUnionType = Array<Int8Array> | Array<Uint8Array> | Array<Uint8ClampedArray> | Array<Int16Array> | Array<Uint16Array> | Array<Int32Array> | Array<Uint32Array> | Array<Float32Array> | Array<Float64Array> | Array<BigInt64Array> | Array<BigUint64Array> | Array<string> | Array<ArrayBuffer> | Array<DataView> | Array<Blob>;
    
    
    /**
     * Creates and initializes a Buffer instance of the specified length.
     *
     * @param { int } size - Size of the Buffer instance to create, in bytes.
     * @param { string | Buffer | int | double | long } [fill] - Value to be filled in the buffer. The default value is 0.
     * @param { BufferEncoding } [encoding] - Encoding format (valid only when fill is a string). The default value is 'utf8'.
     * @returns { Buffer } Return a new allocated Buffer
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     * 1.Mandatory parameters are left unspecified;
     * 2.Incorrect parameter types;
     * 3.Parameter verification failed.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    function alloc(size: int, fill?: string | Buffer | int | double | long, encoding?: BufferEncoding): Buffer;
    
    
    /**
     * Creates a Buffer instance of the specified size from the buffer pool, without initializing it.
     * You need to use fill() to initialize the Buffer instance created.
     *
     * @param { int } size - Size of the Buffer instance to create, in bytes.
     * @returns { Buffer } Return a new allocated Buffer
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     * 1.Mandatory parameters are left unspecified;
     * 2.Incorrect parameter types;
     * 3.Parameter verification failed.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    function allocUninitializedFromPool(size: int): Buffer;
    
    
    /**
     * Creates a Buffer instance of the specified size, without initializing it.
     *
     * @param { int } size - Size of the Buffer instance to create, in bytes.
     * @returns { Buffer } Return a new allocated Buffer
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     * 1.Mandatory parameters are left unspecified;
     * 2.Incorrect parameter types;
     * 3.Parameter verification failed.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    function allocUninitialized(size: int): Buffer;
    /**
     * Obtains the number of bytes of a string based on the encoding format.
     *
     * @param { string | Buffer | TypedArray | DataView | ArrayBuffer } doc - Target string.
     * @param { BufferEncoding } [encoding] - Encoding format of the string. The default value is 'utf8'.
     * @returns { int } The number of bytes contained within `string`
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    function byteLength(doc: string | Buffer | TypedArray | DataView | ArrayBuffer, encoding?: BufferEncoding): int;
    
    
    /**
     * Concatenates an array of Buffer instances of the specified length into a new instance.
     *
     * @param { Buffer[] | Uint8Array[] } list - Array of instances to concatenate.
     * @param { int } [totalLength] - Total length of bytes to be copied. The default value is 0.
     * @returns { Buffer } Return a new allocated Buffer
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     * 1.Mandatory parameters are left unspecified;
     * 2.Incorrect parameter types;
     * 3.Parameter verification failed.
     * @throws { BusinessError } 10200001 - The value of "length" is out of range. It must be >= 0 and <= uint32 max. Received value is: [length]
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    function concat(list: Buffer[] | Uint8Array[], totalLength?: int): Buffer;
    /**
     * Creates a Buffer instance with the specified array.
     *
     * @param { double[] } array - Array to create a Buffer instance.
     * @returns { Buffer } Return a new allocated Buffer
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    function fromWithArray(array: double[]): Buffer;
    /**
     * This creates a view of the ArrayBuffer without copying the underlying memory.
     *
     * @param { ArrayBuffer } arrayBuffer - arrayBuffer arrayBuffer An ArrayBuffer,
     * @param { int } [byteOffset] - byteOffset [byteOffset = 0] Index of first byte to expose
     * @param { int } [length] - length [length = arrayBuffer.byteLength - byteOffset] Number of bytes to expose
     * @returns { Buffer } Return a view of the ArrayBuffer
     * @throws { BusinessError } 10200001 - The value of "[byteOffset/length]" is out of range.
     * It must be >= [left range] and <= [right range]. Received value is: [byteOffset/length]
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    function fromWithArrayBufferByteOffsetLength(arrayBuffer: ArrayBuffer, byteOffset?: int, length?: int): Buffer;
    /**
     * Copies the data of a passed Buffer instance to create a new Buffer instance and returns the new one.
     *
     * @param { Buffer | Uint8Array } buffer - Buffer or Uint8Array instance.
     * @returns { Buffer } Return a new allocated Buffer
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    function fromWithBuffer(buffer: Buffer | Uint8Array): Buffer;
    /**
     * Creates a Buffer instance based on the specified object.
     *
     * @param { Object } input - Object that supports Symbol.toPrimitive or valueOf().
     * @param { int | string } offsetOrEncoding - Byte offset or encoding format.
     * @param { int } length - Length of the Buffer instance to create, in bytes.
     * @returns { Buffer } Return a new allocated Buffer
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    function fromWithObjectTypedInputOffsetOrEncodingLength(input: Object, offsetOrEncoding: int | string, length: int): Buffer;
    /**
     * Creates a Buffer instance based on various types.
     *
     * @param { string } input - string.
     * @param { BufferEncoding } [encoding] - Encoding format of the string. The default value is 'utf8'.
     * @returns { Buffer } Return a new Buffer containing string
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    function fromWithStringTypedInputEncoding(input: string, encoding?: BufferEncoding): Buffer;
    /**
     * @since 20
     */
    export overload from {
        fromWithArray,
        fromWithArrayBufferByteOffsetLength,
        fromWithBuffer,
        fromWithObjectTypedInputOffsetOrEncodingLength,
        fromWithStringTypedInputEncoding
    };
    
    
    /**
     * Checks whether the specified object is a Buffer instance.
     *
     * @param { Object } obj - Object to check.
     * @returns { boolean } true or false
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    function isBuffer(obj: Object): boolean;
    
    
    /**
     * Checks whether the encoding format is supported.
     *
     * @param { string } encoding - Encoding format.
     * @returns { boolean } true or false
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    function isEncoding(encoding: string): boolean;
    /**
     * Compares buf1 to buf2
     *
     * @param { Buffer | Uint8Array } buf1 - buf1 buf1 A Buffer or Uint8Array instance.
     * @param { Buffer | Uint8Array } buf2 - buf2 buf2 A Buffer or Uint8Array instance.
     * @returns { int } 0 is returned if target is the same as buf
     *         1 is returned if target should come before buf when sorted.
     *        -1 is returned if target should come after buf when sorted.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    function compare(buf1: Buffer | Uint8Array, buf2: Buffer | Uint8Array): int;
    
    
    /**
     * Transcodes the given Buffer or Uint8Array object from one encoding format to another.
     *
     * @param { Buffer | Uint8Array } source - Instance to encode.
     * @param { string } fromEnc - Current encoding format
     * @param { string } toEnc - Target encoding format.
     * @returns { Buffer } Returns a new Buffer instance
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     * 1.Mandatory parameters are left unspecified;
     * 2.Incorrect parameter types.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    function transcode(source: Buffer | Uint8Array, fromEnc: string, toEnc: string): Buffer;
    
    
    /**
     * The Buffer object is a method of handling buffers dedicated to binary data.
     *
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    class Buffer {
        /**
         * Gets the element number of the buffer.
         *
         * @type { int }
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        get length(): int;
        /**
         * The underlying ArrayBuffer object based on which this Buffer object is created.
         *
         * @type { ArrayBuffer }
         * @throws { BusinessError } 10200013 - Buffer cannot be set for the buffer that has only a getter.
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        get buffer(): ArrayBuffer;
        /**
         * The byteOffset of the Buffers underlying ArrayBuffer object
         *
         * @type { int }
         * @throws { BusinessError } 10200013 - ByteOffset  cannot be set for the buffer that has only a getter.
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        get byteOffset(): int;
        
        
        /**
         * Fills this Buffer instance at the specified position. By default, data is filled cyclically.
         *
         * @param { string | Buffer | Uint8Array | int | double | long } value - Value to fill.
         * @param { int } [offset] - Offset to the start position in this Buffer instance where data is filled. The default value is 0.
         * @param { int } [end] - Offset to the end position in this Buffer instance (not inclusive). The default value is the length of this Buffer instance.
         * @param { BufferEncoding } [encoding] - Encoding format (valid only when value is a string). The default value is 'utf8'.
         * @returns { Buffer } A reference to buf
         * @throws { BusinessError } 10200001 - The value of "[offset/end]" is out of range. It must be >= 0 and <= [right range]. Received value is: [offset/end]
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         * 1.Incorrect parameter types;
         * 2.Parameter verification failed.
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        fill(value: string | Buffer | Uint8Array | int | double | long, offset?: int, end?: int, encoding?: BufferEncoding): Buffer;
        /**
         * Compares buf with target and returns a number indicating whether buf comes before, after,
         * or is the same as target in sort order. Comparison is based on the actual sequence of bytes in each Buffer.
         *
         * @param { Buffer | Uint8Array } target - target target A Buffer or Uint8Array with which to compare buf
         * @param { int } [targetStart] - targetStart [targetStart = 0] The offset within target at which to begin comparison
         * @param { int } [targetEnd] - targetEnd [targetEnd = target.length] The offset within target at which to end comparison (not inclusive)
         * @param { int } [sourceStart] - sourceStart [sourceStart = 0] The offset within buf at which to begin comparison
         * @param { int } [sourceEnd] - sourceEnd [sourceEnd = buf.length] The offset within buf at which to end comparison (not inclusive)
         * @returns { int } number is returned if target is the same as buf
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         * 1.Mandatory parameters are left unspecified;
         * 2.Incorrect parameter types.
         * @throws { BusinessError } 10200001 - The value of "[targetStart/targetEnd/sourceStart/sourceEnd]" is out of range.
         *         It must be >= 0 and <= [right range]. Received value is: [targetStart/targetEnd/sourceStart/sourceEnd]
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        compare(target: Buffer | Uint8Array, targetStart?: int, targetEnd?: int, sourceStart?: int, sourceEnd?: int): int;
        
        
        /**
         * Copies data at the specified position in this Buffer instance to the specified position in another Buffer instance.
         *
         * @param { Buffer | Uint8Array } target - Instance to which data is copied.
         * @param { int } [targetStart] - Offset to the start position in the target instance where data is copied. The default value is 0.
         * @param { int } [sourceStart] - Offset to the start position in this Buffer instance where data is copied. The default value is 0.
         * @param { int } [sourceEnd] - Offset to the end position in this Buffer instance (not inclusive).
         * The default value is the length of this Buffer instance.
         * @returns { int } The number of bytes copied
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         * 1.Mandatory parameters are left unspecified;
         * 2.Incorrect parameter types.
         * @throws { BusinessError } 10200001 - The value of "[targetStart/sourceStart/sourceEnd]" is out of range. It must be >= 0.
         *                                    Received value is: [targetStart/sourceStart/sourceEnd]
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        copy(target: Buffer | Uint8Array, targetStart?: int, sourceStart?: int, sourceEnd?: int): int;
        
        
        /**
         * Checks whether this Buffer instance is the same as another Buffer instance.
         *
         * @param { Uint8Array | Buffer } otherBuffer - Buffer instance to compare.
         * @returns { boolean } true or false
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2.Incorrect parameter types.
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        equals(otherBuffer: Uint8Array | Buffer): boolean;
        
        
        /**
         * Checks whether this Buffer instance contains the specified value.
         *
         * @param { string | int | double | long | Buffer | Uint8Array } value - Value to match.
         * @param { int } [byteOffset] - Number of bytes to skip before starting to check data.
         * Number of bytes to skip before starting to check data. If the offset is a negative number,
         * data is checked from the end of the Buffer instance. The default value is 0.
         * @param { BufferEncoding } [encoding] - Encoding format (valid only when value is a string). The default value is 'utf8'.
         * @returns { boolean } true or false
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         * 1.Mandatory parameters are left unspecified;
         * 2.Incorrect parameter types.
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        includes(value: string | int | double | long | Buffer | Uint8Array, byteOffset?: int, encoding?: BufferEncoding): boolean;
        
        
        /**
         * Obtains the index of the first occurrence of the specified value in this Buffer instance.
         *
         * @param { string | int | double | long | Buffer | Uint8Array } value - Value to match.
         * @param { int } [byteOffset] - Number of bytes to skip before starting to check data.
         * If the offset is a negative number, data is checked from the end of the Buffer instance. The default value is 0.
         * @param { BufferEncoding } [encoding] - Encoding format (valid only when value is a string). The default value is 'utf8'.
         * @returns { int } The index of the first occurrence of value in buf, or -1 if buf does not contain value
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         * 1.Mandatory parameters are left unspecified;
         * 2.Incorrect parameter types.
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        indexOf(value: string | int | double | long | Buffer | Uint8Array, byteOffset?: int, encoding?: BufferEncoding): int;
        
        
        /**
         * Creates and returns an iterator that contains the keys of this Buffer instance.
         *
         * @returns { IterableIterator<int> }
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        keys(): IterableIterator<int>;
        
        
        /**
         * Creates and returns an iterator that contains the values of this Buffer instance.
         *
         * @returns { IterableIterator<long> }
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        values(): IterableIterator<long>;
        
        
        /**
         * Creates and returns an iterator that contains key-value pairs of this Buffer instance.
         *
         * @returns { IterableIterator<[int, long]> }
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        entries(): IterableIterator<[
            int,
            long
        ]>;
        
        
        /**
         * Obtains the index of the last occurrence of the specified value in this Buffer instance.
         *
         * @param { string | int | double | long | Buffer | Uint8Array } value - Value to match.
         * @param { int } [byteOffset] - Number of bytes to skip before starting to check data.
         * If the offset is a negative number, data is checked from the end of the Buffer instance.
         * The default value is the length of this Buffer instance.
         * @param { BufferEncoding } [encoding] - Encoding format (valid only when value is a string). The default value is 'utf8'.
         * @returns { int } The index of the last occurrence of value in buf, or -1 if buf does not contain value
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         * 1.Mandatory parameters are left unspecified;
         * 2.Incorrect parameter types.
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        lastIndexOf(value: string | int | double | long | Buffer | Uint8Array, byteOffset?: int, encoding?: BufferEncoding): int;
        
        
        /**
         * Reads a 64-bit, big-endian, signed big integer from this Buffer instance at the specified offset.
         *
         * @param { int } [offset] - Number of bytes to skip before starting to read data. The default value is 0. The value range is [0, Buffer.length - 8].
         * @returns { bigint } Return a signed, big-endian 64-bit integer
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Incorrect parameter types.
         * @throws { BusinessError } 10200001 - The value of "offset" is out of range. It must be >= 0 and <= buf.length - 8. Received value is: [offset]
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        readBigInt64BE(offset?: int): bigint;
        
        
        /**
         * Reads a 64-bit, little-endian, signed big integer from this Buffer instance at the specified offset.
         *
         * @param { int } [offset] - Number of bytes to skip before starting to read data. The default value is 0. The value range is [0, Buffer.length - 8].
         * @returns { bigint } Return a signed, little-endian 64-bit integer
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Incorrect parameter types.
         * @throws { BusinessError } 10200001 - The value of "offset" is out of range. It must be >= 0 and <= buf.length - 8. Received value is: [offset]
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        readBigInt64LE(offset?: int): bigint;
        
        
        /**
         * Reads a 64-bit, big-endian, unsigned big integer from this Buffer instance at the specified offset.
         *
         * @param { int } [offset] - Number of bytes to skip before starting to read data. The default value is 0. The value range is [0, Buffer.length - 8].
         * @returns { bigint } Return a unsigned, big-endian 64-bit integer
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Incorrect parameter types.
         * @throws { BusinessError } 10200001 - The value of "offset" is out of range. It must be >= 0 and <= buf.length - 8. Received value is: [offset]
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        readBigUInt64BE(offset?: int): bigint;
        
        
        /**
         * Reads a 64-bit, little-endian, unsigned big integer from this Buffer instance at the specified offset.
         *
         * @param { int } [offset] - Number of bytes to skip before starting to read data. The default value is 0. The value range is [0, Buffer.length - 8].
         * @returns { bigint } Return a unsigned, little-endian 64-bit integer
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Incorrect parameter types.
         * @throws { BusinessError } 10200001 - The value of "offset" is out of range. It must be >= 0 and <= buf.length - 8. Received value is: [offset]
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        readBigUInt64LE(offset?: int): bigint;
        
        
        /**
         * Reads a 64-bit, big-endian, double-precision floating-point number from this Buffer instance at the specified offset.
         *
         * @param { int } [offset] - Number of bytes to skip before starting to read data. The default value is 0. The value range is [0, Buffer.length - 8].
         * @returns { double } Return a 64-bit, big-endian double
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Incorrect parameter types.
         * @throws { BusinessError } 10200001 - The value of "offset" is out of range. It must be >= 0 and <= buf.length - 8. Received value is: [offset]
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        readDoubleBE(offset?: int): double;
        
        
        /**
         * Reads a 64-bit, little-endian, double-precision floating-point number from this Buffer instance at the specified offset.
         *
         * @param { int } [offset] - Number of bytes to skip before starting to read data. The default value is 0. The value range is [0, Buffer.length - 8].
         * @returns { double } Return a 64-bit, little-endian double
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Incorrect parameter types.
         * @throws { BusinessError } 10200001 - The value of "offset" is out of range. It must be >= 0 and <= buf.length - 8. Received value is: [offset]
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        readDoubleLE(offset?: int): double;
        
        
        /**
         * Reads a 32-bit, big-endian, single-precision floating-point number from this Buffer instance at the specified offset.
         *
         * @param { int } [offset] - Number of bytes to skip before starting to read data. The default value is 0. The value range is [0, Buffer.length - 4].
         * @returns { double } Return a 32-bit, big-endian float
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Incorrect parameter types.
         * @throws { BusinessError } 10200001 - The value of "offset" is out of range. It must be >= 0 and <= buf.length - 4. Received value is: [offset]
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        readFloatBE(offset?: int): double;
        
        
        /**
         * Reads a 32-bit, little-endian, single-precision floating-point number from this Buffer instance at the specified offset.
         *
         * @param { int } [offset] - Number of bytes to skip before starting to read data. The default value is 0. The value range is [0, Buffer.length - 4].
         * @returns { double } Return a 32-bit, little-endian float
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Incorrect parameter types.
         * @throws { BusinessError } 10200001 - The value of "offset" is out of range. It must be >= 0 and <= buf.length - 4. Received value is: [offset]
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        readFloatLE(offset?: int): double;
        
        
        /**
         * Reads an 8-bit signed integer from this Buffer instance at the specified offset.
         *
         * @param { int } [offset] - Number of bytes to skip before starting to read data. The default value is 0. The value range is [0, Buffer.length - 1].
         * @returns { long } Return a signed 8-bit integer
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Incorrect parameter types.
         * @throws { BusinessError } 10200001 - The value of "offset" is out of range. It must be >= 0 and <= buf.length - 1. Received value is: [offset]
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        readInt8(offset?: int): long;
        
        
        /**
         * Reads a 16-bit, big-endian, signed integer from this Buffer instance at the specified offset.
         *
         * @param { int } [offset] - Number of bytes to skip before starting to read data. The default value is 0. The value range is [0, Buffer.length - 2].
         * @returns { long } Return a signed, big-endian 16-bit integer
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Incorrect parameter types.
         * @throws { BusinessError } 10200001 - The value of "offset" is out of range. It must be >= 0 and <= buf.length - 2. Received value is: [offset]
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        readInt16BE(offset?: int): long;
        
        
        /**
         * Reads a 16-bit, little-endian, signed integer from this Buffer instance at the specified offset.
         *
         * @param { int } [offset] - Number of bytes to skip before starting to read data. The default value is 0. The value range is [0, Buffer.length - 2].
         * @returns { long } Return a signed, little-endian 16-bit integer
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Incorrect parameter types.
         * @throws { BusinessError } 10200001 - The value of "offset" is out of range. It must be >= 0 and <= buf.length - 2. Received value is: [offset]
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        readInt16LE(offset?: int): long;
        
        
        /**
         * Reads a 32-bit, big-endian, signed integer from this Buffer instance at the specified offset.
         *
         * @param { int } [offset] - Number of bytes to skip before starting to read data. The default value is 0. The value range is [0, Buffer.length - 4].
         * @returns { long } Return a signed, big-endian 32-bit integer
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Incorrect parameter types.
         * @throws { BusinessError } 10200001 - The value of "offset" is out of range. It must be >= 0 and <= buf.length - 4. Received value is: [offset]
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        readInt32BE(offset?: int): long;
        
        
        /**
         * Reads a 32-bit, little-endian, signed integer from this Buffer instance at the specified offset.
         *
         * @param { int } [offset] - Number of bytes to skip before starting to read data. The default value is 0. The value range is [0, Buffer.length - 4].
         * @returns { long } Return a signed, little-endian 32-bit integer
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Incorrect parameter types.
         * @throws { BusinessError } 10200001 - The value of "offset" is out of range. It must be >= 0 and <= buf.length - 4. Received value is: [offset]
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        readInt32LE(offset?: int): long;
        
        
        /**
         * Reads the specified number of bytes from this Buffer instance at the specified offset, and interprets the result as a big-endian,
         * two's complement signed value that supports up to 48 bits of precision.
         *
         * @param { int } offset - Number of bytes to skip before starting to read data. The default value is 0. The value range is [0, Buffer.length - byteLength].
         * @param { int } byteLength - Number of bytes to read. The value range is [1, 6].
         * @returns { long }
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         * 1.Mandatory parameters are left unspecified;
         * 2.Incorrect parameter types.
         * @throws { BusinessError } 10200001 - The value of "[param]" is out of range. It must be >= [left range] and <= [right range]. Received value is: [param]
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        readIntBE(offset: int, byteLength: int): long;
        
        
        /**
         * Reads the specified number of bytes from this Buffer instance at the specified offset and interprets the result as a little-endian,
         * two's complement signed value that supports up to 48 bits of precision.
         *
         * @param { int } offset - Number of bytes to skip before starting to read data. The default value is 0. The value range is [0, Buffer.length - byteLength].
         * @param { int } byteLength - Number of bytes to read. The value range is [1, 6].
         * @returns { long }
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         * 1.Mandatory parameters are left unspecified;
         * 2.Incorrect parameter types.
         * @throws { BusinessError } 10200001 - The value of "[param]" is out of range. It must be >= [left range] and <= [right range]. Received value is: [param]
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        readIntLE(offset: int, byteLength: int): long;
        
        
        /**
         * Reads an 8-bit unsigned integer from this Buffer instance at the specified offset.
         *
         * @param { int } [offset] - Number of bytes to skip before starting to read data. The default value is 0. The value range is [0, Buffer.length - 1].
         * @returns { long } Reads an unsigned 8-bit integer
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Incorrect parameter types.
         * @throws { BusinessError } 10200001 - The value of "offset" is out of range. It must be >= 0 and <= buf.length - 1. Received value is: [offset]
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        readUInt8(offset?: int): long;
        
        
        /**
         * Reads a 16-bit, big-endian, unsigned integer from this Buffer instance at the specified offset.
         *
         * @param { int } [offset] - Number of bytes to skip before starting to read data. The default value is 0. The value range is [0, Buffer.length - 2].
         * @returns { long } Reads an unsigned, big-endian 16-bit integer
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Incorrect parameter types.
         * @throws { BusinessError } 10200001 - The value of "offset" is out of range. It must be >= 0 and <= buf.length - 2. Received value is: [offset]
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        readUInt16BE(offset?: int): long;
        
        
        /**
         * Reads a 16-bit, little-endian, unsigned integer from this Buffer instance at the specified offset.
         *
         * @param { int } [offset] - Number of bytes to skip before starting to read data. The default value is 0. The value range is [0, Buffer.length - 2].
         * @returns { long } Reads an unsigned, little-endian 16-bit integer
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Incorrect parameter types.
         * @throws { BusinessError } 10200001 - The value of "offset" is out of range. It must be >= 0 and <= buf.length - 2. Received value is: [offset]
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        readUInt16LE(offset?: int): long;
        
        
        /**
         * Reads a 32-bit, big-endian, unsigned integer from this Buffer instance at the specified offset.
         *
         * @param { int } [offset] - Number of bytes to skip before starting to read data. The default value is 0. The value range is [0, Buffer.length - 4].
         * @returns { long } Reads an unsigned, big-endian 32-bit integer
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Incorrect parameter types.
         * @throws { BusinessError } 10200001 - The value of "offset" is out of range. It must be >= 0 and <= buf.length - 4. Received value is: [offset]
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        readUInt32BE(offset?: int): long;
        
        
        /**
         * Reads a 32-bit, little-endian, unsigned integer from this Buffer instance at the specified offset.
         *
         * @param { int } [offset] - Number of bytes to skip before starting to read data. The default value is 0. The value range is [0, Buffer.length - 4].
         * @returns { long } Reads an unsigned, little-endian 32-bit integer
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Incorrect parameter types.
         * @throws { BusinessError } 10200001 - The value of "offset" is out of range. It must be >= 0 and <= buf.length - 4. Received value is: [offset]
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        readUInt32LE(offset?: int): long;
        
        
        /**
         * Reads the specified number of bytes from this Buffer instance at the specified offset, and interprets the result as an unsigned,
         * big-endian integer that supports up to 48 bits of precision.
         *
         * @param { int } offset - Number of bytes to skip before starting to read data. The default value is 0. The value range is [0, Buffer.length - byteLength].
         * @param { int } byteLength - Number of bytes to read. The value range is [1, 6].
         * @returns { long }
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         * 1.Mandatory parameters are left unspecified;
         * 2.Incorrect parameter types.
         * @throws { BusinessError } 10200001 - The value of "[param]" is out of range. It must be >= [left range] and <= [right range]. Received value is: [param]
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        readUIntBE(offset: int, byteLength: int): long;
        
        
        /**
         * Reads the specified number of bytes from this Buffer instance at the specified offset, and interprets the result as an unsigned,
         * little-endian integer that supports up to 48 bits of precision.
         *
         * @param { int } offset - Number of bytes to skip before starting to read data. The default value is 0. The value range is [0, Buffer.length - byteLength].
         * @param { int } byteLength - Number of bytes to read. The value range is [1, 6].
         * @returns { long }
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         * 1.Mandatory parameters are left unspecified;
         * 2.Incorrect parameter types.
         * @throws { BusinessError } 10200001 - The value of "[param]" is out of range. It must be >= [left range] and <= [right range]. Received value is: [param]
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        readUIntLE(offset: int, byteLength: int): long;
        
        
        /**
         * Truncates this Buffer instance from the specified position to create a new Buffer instance.
         *
         * @param { int } [start] - Offset to the start position in this Buffer instance where data is truncated. The default value is 0.
         * @param { int } [end] - Offset to the end position in this Buffer instance (not inclusive). The default value is the length of this Buffer instance.
         * @returns { Buffer } Returns a new Buffer that references the same memory as the original
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        subarray(start?: int, end?: int): Buffer;
        
        
        /**
         * Interprets this Buffer instance as an array of unsigned 16-bit integers and swaps the byte order in place.
         *
         * @returns { Buffer } A reference to buf
         * @throws { BusinessError } 10200009 - The buffer size must be a multiple of 16-bits
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        swap16(): Buffer;
        
        
        /**
         * Interprets this Buffer instance as an array of unsigned 32-bit integers and swaps the byte order in place.
         *
         * @returns { Buffer } A reference to buf
         * @throws { BusinessError } 10200009 - The buffer size must be a multiple of 32-bits
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        swap32(): Buffer;
        
        
        /**
         * Interprets this Buffer instance as an array of unsigned 64-bit integers and swaps the byte order in place.
         *
         * @returns { Buffer } A reference to buf
         * @throws { BusinessError } 10200009 - The buffer size must be a multiple of 64-bits
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        swap64(): Buffer;
        /**
         * Converts this Buffer instance into a JsonElement.
         *
         * @returns { jsonx.JsonElement } A new JsonElement containing the Buffer
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        toJSON(): jsonx.JsonElement;
        /**
         * Decodes buf to a string according to the specified character encoding in encoding
         *
         * @param { BufferEncoding } [encoding] - encoding [encoding='utf8'] The character encoding to use
         * @param { int } [start] - start [start = 0] The byte offset to start decoding at
         * @param { int } [end] - end [end = buf.length] The byte offset to stop decoding at (not inclusive)
         * @returns { string }
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        toString(encoding?: BufferEncoding, start?: int, end?: int): string;
        
        
        /**
         * Writes a string of the specified length to this Buffer instance at the specified position in the given encoding format.
         *
         * @param { string } str - String to write.
         * @param { int } [offset] - Number of bytes to skip before starting to write data. The default value is 0.
         * @param { int } [length] - Maximum number of bytes to write. The default value is Buffer.length minus offset.
         * @param { string } [encoding] - Encoding format of the string. The default value is 'utf8'.
         * @returns { int } Number of bytes written.
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         * 1.Mandatory parameters are left unspecified;
         * 2.Incorrect parameter types.
         * @throws { BusinessError } 10200001 - The value of "[offset/length]" is out of range. It must be >= 0 and <= buf.length. Received value is: [offset/length]
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        write(str: string, offset?: int, length?: int, encoding?: string): int;
        
        
        /**
         * Writes a 64-bit, big-endian, signed big integer to this Buffer instance at the specified offset.
         *
         * @param { bigint } value - Data to write.
         * @param { int } [offset] - Number of bytes to skip before starting to write data. The default value is 0. The value range is [0, Buffer.length - 8].
         * @returns { int } offset plus the number of bytes written
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         * 1.Mandatory parameters are left unspecified;
         * 2.Incorrect parameter types;
         * 3.Parameter verification failed.
         * @throws { BusinessError } 10200001 - The value of "[param]" is out of range. It must be >= [left range] and <= [right range]. Received value is: [param]
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        writeBigInt64BE(value: bigint, offset?: int): int;
        
        
        /**
         * Writes a 64-bit, little-endian, signed big integer to this Buffer instance at the specified offset.
         *
         * @param { bigint } value - Data to write.
         * @param { int } [offset] - Number of bytes to skip before starting to write data. The default value is 0. The value range is [0, Buffer.length - 8].
         * @returns { int } offset plus the number of bytes written
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         * 1.Mandatory parameters are left unspecified;
         * 2.Incorrect parameter types;
         * 3.Parameter verification failed.
         * @throws { BusinessError } 10200001 - The value of "[param]" is out of range. It must be >= [left range] and <= [right range]. Received value is: [param]
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        writeBigInt64LE(value: bigint, offset?: int): int;
        
        
        /**
         * Writes a 64-bit, big-endian, unsigned big integer to this Buffer instance at the specified offset.
         *
         * @param { bigint } value - Data to write.
         * @param { int } [offset] - Number of bytes to skip before starting to write data. The default value is 0. The value range is [0, Buffer.length - 8].
         * @returns { int } offset plus the number of bytes written
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         * 1.Mandatory parameters are left unspecified;
         * 2.Incorrect parameter types;
         * 3.Parameter verification failed.
         * @throws { BusinessError } 10200001 - The value of "[param]" is out of range. It must be >= [left range] and <= [right range]. Received value is: [param]
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        writeBigUInt64BE(value: bigint, offset?: int): int;
        
        
        /**
         * Writes a 64-bit, little-endian, unsigned big integer to this Buffer instance at the specified offset.
         *
         * @param { bigint } value - Data to write.
         * @param { int } [offset] - Number of bytes to skip before starting to write data. The default value is 0. The value range is [0, Buffer.length - 8].
         * @returns { int } offset plus the number of bytes written
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         * 1.Mandatory parameters are left unspecified;
         * 2.Incorrect parameter types;
         * 3.Parameter verification failed.
         * @throws { BusinessError } 10200001 - The value of "[param]" is out of range. It must be >= [left range] and <= [right range]. Received value is: [param]
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        writeBigUInt64LE(value: bigint, offset?: int): int;
        
        
        /**
         * Writes a 64-bit, big-endian, double-precision floating-point number to this Buffer instance at the specified offset.
         *
         * @param { double } value - Data to write.
         * @param { int } [offset] - Number of bytes to skip before starting to write data. The default value is 0. The value range is [0, Buffer.length - 8].
         * @returns { int } offset plus the number of bytes written
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         * 1.Mandatory parameters are left unspecified;
         * 2.Incorrect parameter types.
         * @throws { BusinessError } 10200001 - The value of "offset" is out of range. It must be >= 0 and <= buf.length - 8. Received value is: [offset]
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        writeDoubleBE(value: double, offset?: int): int;
        
        
        /**
         * Writes a 64-bit, little-endian, double-precision floating-point number to this Buffer instance at the specified offset.
         *
         * @param { double } value - Data to write.
         * @param { int } [offset] - Number of bytes to skip before starting to write data. The default value is 0. The value range is [0, Buffer.length - 8].
         * @returns { int } offset plus the number of bytes written
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         * 1.Mandatory parameters are left unspecified;
         * 2.Incorrect parameter types.
         * @throws { BusinessError } 10200001 - The value of "offset" is out of range. It must be >= 0 and <= buf.length - 8. Received value is: [offset]
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        writeDoubleLE(value: double, offset?: int): int;
        
        
        /**
         * Writes a 32-bit, big-endian, single-precision floating-point number to this Buffer instance at the specified offset.
         *
         * @param { double } value - Data to write.
         * @param { int } [offset] - Number of bytes to skip before starting to write data. The default value is 0. The value range is [0, Buffer.length - 4].
         * @returns { int } offset plus the number of bytes written
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         * 1.Mandatory parameters are left unspecified;
         * 2.Incorrect parameter types.
         * @throws { BusinessError } 10200001 - The value of "offset" is out of range. It must be >= 0 and <= buf.length - 4. Received value is: [offset]
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        writeFloatBE(value: double, offset?: int): int;
        
        
        /**
         * Writes a 32-bit, little-endian, single-precision floating-point number to this Buffer instance at the specified offset.
         *
         * @param { double } value - Data to write.
         * @param { int } [offset] - Number of bytes to skip before starting to write data. The default value is 0. The value range is [0, Buffer.length - 4].
         * @returns { int } offset plus the number of bytes written
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         * 1.Mandatory parameters are left unspecified;
         * 2.Incorrect parameter types.
         * @throws { BusinessError } 10200001 - The value of "offset" is out of range. It must be >= 0 and <= buf.length - 4. Received value is: [offset]
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        writeFloatLE(value: double, offset?: int): int;
        
        
        /**
         * Writes an 8-bit signed integer to this Buffer instance at the specified offset.
         *
         * @param { long } value - Data to write.
         * @param { int } [offset] - Number of bytes to skip before starting to write data. The default value is 0. The value range is [0, Buffer.length - 1].
         * @returns { int } offset plus the number of bytes written
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         * 1.Mandatory parameters are left unspecified;
         * 2.Incorrect parameter types;
         * 3.Parameter verification failed.
         * @throws { BusinessError } 10200001 - The value of "[param]" is out of range. It must be >= [left range] and <= [right range]. Received value is: [param]
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        writeInt8(value: long, offset?: int): int;
        
        
        /**
         * Writes a 16-bit, big-endian, signed integer to this Buffer instance at the specified offset.
         *
         * @param { long } value - Data to write.
         * @param { int } [offset] - Number of bytes to skip before starting to write data. The default value is 0. The value range is [0, Buffer.length - 2].
         * @returns { int } offset plus the number of bytes written
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         * 1.Mandatory parameters are left unspecified;
         * 2.Incorrect parameter types;
         * 3.Parameter verification failed.
         * @throws { BusinessError } 10200001 - The value of "[param]" is out of range. It must be >= [left range] and <= [right range]. Received value is: [param]
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        writeInt16BE(value: long, offset?: int): int;
        
        
        /**
         * Writes a 16-bit, little-endian, signed integer to this Buffer instance at the specified offset.
         *
         * @param { long } value - Data to write.
         * @param { int } [offset] - Number of bytes to skip before starting to write data. The default value is 0. The value range is [0, Buffer.length - 2].
         * @returns { int } offset plus the number of bytes written
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         * 1.Mandatory parameters are left unspecified;
         * 2.Incorrect parameter types;
         * 3.Parameter verification failed.
         * @throws { BusinessError } 10200001 - The value of "[param]" is out of range. It must be >= [left range] and <= [right range]. Received value is: [param]
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        writeInt16LE(value: long, offset?: int): int;
        
        
        /**
         * Writes a 32-bit, big-endian, signed integer to this Buffer instance at the specified offset.
         *
         * @param { long } value - Data to write.
         * @param { int } [offset] - Number of bytes to skip before starting to write data. The default value is 0. The value range is [0, Buffer.length - 4].
         * @returns { int } offset plus the number of bytes written
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         * 1.Mandatory parameters are left unspecified;
         * 2.Incorrect parameter types;
         * 3.Parameter verification failed.
         * @throws { BusinessError } 10200001 - The value of "[param]" is out of range. It must be >= [left range] and <= [right range]. Received value is: [param]
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        writeInt32BE(value: long, offset?: int): int;
        
        
        /**
         * Writes a 32-bit, little-endian, signed integer to this Buffer instance at the specified offset.
         *
         * @param { long } value - Data to write.
         * @param { int } [offset] - Number of bytes to skip before starting to write data. The default value is 0. The value range is [0, Buffer.length - 4].
         * @returns { int } offset plus the number of bytes written
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         * 1.Mandatory parameters are left unspecified;
         * 2.Incorrect parameter types;
         * 3.Parameter verification failed.
         * @throws { BusinessError } 10200001 - The value of "[param]" is out of range. It must be >= [left range] and <= [right range]. Received value is: [param]
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        writeInt32LE(value: long, offset?: int): int;
        
        
        /**
         * Writes a big-endian signed value of the specified length to this Buffer instance at the specified offset.
         *
         * @param { long } value - Data to write.
         * @param { int } offset - Number of bytes to skip before starting to write data. The default value is 0.
         *     The value range is [0, Buffer.length - byteLength].
         * @param { int } byteLength - Number of bytes to write.
         * @returns { int } offset plus the number of bytes written
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         * 1.Mandatory parameters are left unspecified;
         * 2.Incorrect parameter types.
         * @throws { BusinessError } 10200001 - The value of "[param]" is out of range. It must be >= [left range] and <= [right range]. Received value is: [param]
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        writeIntBE(value: long, offset: int, byteLength: int): int;
        
        
        /**
         * Writes a little-endian signed value of the specified length to this Buffer instance at the specified offset.
         *
         * @param { long } value - Data to write.
         * @param { int } offset - Number of bytes to skip before starting to write data. The default value is 0.
         *     The value range is [0, Buffer.length - byteLength].
         * @param { int } byteLength - Number of bytes to write.
         * @returns { int } offset plus the number of bytes written
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         * 1.Mandatory parameters are left unspecified;
         * 2.Incorrect parameter types.
         * @throws { BusinessError } 10200001 - The value of "[param]" is out of range. It must be >= [left range] and <= [right range]. Received value is: [param]
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        writeIntLE(value: long, offset: int, byteLength: int): int;
        
        
        /**
         * Writes an 8-bit unsigned integer to this Buffer instance at the specified offset.
         *
         * @param { long } value - Data to write.
         * @param { int } [offset] - Number of bytes to skip before starting to write data. The default value is 0. The value range is [0, Buffer.length - 1].
         * @returns { int } offset plus the number of bytes written
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         * 1.Mandatory parameters are left unspecified;
         * 2.Incorrect parameter types;
         * 3.Parameter verification failed.
         * @throws { BusinessError } 10200001 - The value of "[param]" is out of range. It must be >= [left range] and <= [right range]. Received value is: [param]
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        writeUInt8(value: long, offset?: int): int;
        
        
        /**
         * Writes a 16-bit, big-endian, unsigned integer to this Buffer instance at the specified offset.
         *
         * @param { long } value - 	Data to write.
         * @param { int } [offset] - Number of bytes to skip before starting to write data. The default value is 0. The value range is [0, Buffer.length - 2].
         * @returns { int } offset plus the number of bytes written
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         * 1.Mandatory parameters are left unspecified;
         * 2.Incorrect parameter types;
         * 3.Parameter verification failed.
         * @throws { BusinessError } 10200001 - The value of "[param]" is out of range. It must be >= [left range] and <= [right range]. Received value is: [param]
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        writeUInt16BE(value: long, offset?: int): int;
        
        
        /**
         * Writes a 16-bit, little-endian, unsigned integer to this Buffer instance at the specified offset.
         *
         * @param { long } value - Data to write.
         * @param { int } [offset] - Number of bytes to skip before starting to write data. The default value is 0. The value range is [0, Buffer.length - 2].
         * @returns { int } offset plus the number of bytes written
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         * 1.Mandatory parameters are left unspecified;
         * 2.Incorrect parameter types;
         * 3.Parameter verification failed.
         * @throws { BusinessError } 10200001 - The value of "[param]" is out of range. It must be >= [left range] and <= [right range]. Received value is: [param]
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        writeUInt16LE(value: long, offset?: int): int;
        
        
        /**
         * Writes a 32-bit, big-endian, unsigned integer to this Buffer instance at the specified offset.
         *
         * @param { long } value - Data to write.
         * @param { int } [offset] - Number of bytes to skip before starting to write data. The default value is 0. The value range is [0, Buffer.length - 4].
         * @returns { int } offset plus the number of bytes written
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         * 1.Mandatory parameters are left unspecified;
         * 2.Incorrect parameter types;
         * 3.Parameter verification failed.
         * @throws { BusinessError } 10200001 - The value of "[param]" is out of range. It must be >= [left range] and <= [right range]. Received value is: [param]
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        writeUInt32BE(value: long, offset?: int): int;
        
        
        /**
         * Writes a 32-bit, little-endian, unsigned integer to this Buffer instance at the specified offset.
         *
         * @param { long } value - Data to write.
         * @param { int } [offset] - Number of bytes to skip before starting to write data. The default value is 0. The value range is [0, Buffer.length - 4].
         * @returns { int } offset plus the number of bytes written
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         * 1.Mandatory parameters are left unspecified;
         * 2.Incorrect parameter types;
         * 3.Parameter verification failed.
         * @throws { BusinessError } 10200001 - The value of "[param]" is out of range. It must be >= [left range] and <= [right range]. Received value is: [param]
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        writeUInt32LE(value: long, offset?: int): int;
        
        
        /**
         * Writes an unsigned big-endian value of the specified length to this Buffer instance at the specified offset.
         *
         * @param { long } value - Data to write.
         * @param { int } offset - Number of bytes to skip before starting to write data. The default value is 0.
         *     The value range is [0, Buffer.length - byteLength].
         * @param { int } byteLength - Number of bytes to write.
         * @returns { int } offset plus the number of bytes written
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         * 1.Mandatory parameters are left unspecified;
         * 2.Incorrect parameter types.
         * @throws { BusinessError } 10200001 - The value of "[param]" is out of range. It must be >= [left range] and <= [right range]. Received value is: [param]
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        writeUIntBE(value: long, offset: int, byteLength: int): int;
        
        
        /**
         * Writes an unsigned little-endian value of the specified length to this Buffer instance at the specified offset.
         *
         * @param { long } value - Data to write.
         * @param { int } offset - Number of bytes to skip before starting to write data. The default value is 0.
         *     The value range is [0, Buffer.length - byteLength].
         * @param { int } byteLength - Number of bytes to write.
         * @returns { int } offset plus the number of bytes written
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         * 1.Mandatory parameters are left unspecified;
         * 2.Incorrect parameter types.
         * @throws { BusinessError } 10200001 - The value of "[param]" is out of range. It must be >= [left range] and <= [right range]. Received value is: [param]
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        writeUIntLE(value: long, offset: int, byteLength: int): int;
        /**
         * Returns the item at that index.
         *
         * @param { int } index - The zero-based index of the desired code unit.
         *     Throws error if index < 0 or index >= buffer.length.
         * @returns { long } The element in the buffer matching the given index.
         * @throws { BusinessError } 10200001 - The value of index is out of range.
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        [index: int]: long;
    }
    /**
     * Defines the Blob related options parameters.
     *
     * @interface BlobOptions
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    interface BlobOptions {
        /**
         * Blob content type. The default parameter is' '.
         * @type { ?string }
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        type?: string;
        /**
         * How to output a string ending with '\ n' as' transparent or native . The default value is transparent.
         * @type { ?string }
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        endings?: string;
    }
    
    
    /**
     * Process data as blob type
     *
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    class Blob {
        /**
         * Creates a new Blob object containing a concatenation of the given sources.
         *
         * @param { ArrayUnionType } sources - sources sources ArrayUnionType
         * @param { BlobOptions } [options] - options options {endings: string, type: string}
         *                 endings:  One of either 'transparent' or 'native'.
         *                 type: The Blob content-type
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        constructor(sources: ArrayUnionType, options?: BlobOptions);
        
        
        /**
         * Total size of the Blob instance, in bytes.
         *
         * @type { int }
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        get size(): int;
        
        
        /**
         * Type of the data in the Blob instance.
         *
         * @type { string }
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        get type(): string;
        
        
        /**
         * Puts the Blob data into an ArrayBuffer instance. This API uses a promise to return the result.
         *
         * @returns { Promise<ArrayBuffer> }
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        arrayBuffer(): Promise<ArrayBuffer>;
        
        
        /**
         * Creates a Blob instance by copying specified data from this Blob instance.
         *
         * @param { int } [start] - Offset to the start position of the data to copy. The default value is 0.
         * @param { int } [end] - Offset to the end position of the data to copy. The default value is the data length in the original Blob instance.
         * @param { string } [type] - Type of the data in the new Blob instance. The default value is ''.
         * @returns { Blob }
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        slice(start?: int, end?: int, type?: string): Blob;
        
        
        /**
         * Returns text in UTF-8 format. This API uses a promise to return the result.
         *
         * @returns { Promise<string> }
         * @syscap SystemCapability.Utils.Lang
         * @since 20
         */
        text(): Promise<string>;
    }
}
export default buffer;
