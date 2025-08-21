/*
 * Copyright (c) 2021-2024 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License"),
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
 * @kit BasicServicesKit
 */
import { AsyncCallback } from './@ohos.base';


/**
 * @namespace zlib
 * @syscap SystemCapability.BundleManager.Zlib
 * @since 20
 */
declare namespace zlib {
    
    /**
     * CompressLevel
     *
     * @enum { int }
     * @syscap SystemCapability.BundleManager.Zlib
     * @since 20
     */
    export enum CompressLevel {
        
        /**
         * Indicates the no compression mode.
         *
         * @syscap SystemCapability.BundleManager.Zlib
         * @since 20
         */
        COMPRESS_LEVEL_NO_COMPRESSION = 0,
        
        /**
         * Indicates the best speed mode.
         *
         * @syscap SystemCapability.BundleManager.Zlib
         * @since 20
         */
        COMPRESS_LEVEL_BEST_SPEED = 1,
        
        /**
         * Indicates the best compression mode.
         *
         * @syscap SystemCapability.BundleManager.Zlib
         * @since 20
         */
        COMPRESS_LEVEL_BEST_COMPRESSION = 9,
        
        /**
         * Indicates the default compression mode.
         *
         * @syscap SystemCapability.BundleManager.Zlib
         * @since 20
         */
        COMPRESS_LEVEL_DEFAULT_COMPRESSION = -1
    }
    
    /**
     * CompressStrategy
     *
     * @enum { int }
     * @syscap SystemCapability.BundleManager.Zlib
     * @since 20
     */
    export enum CompressStrategy {
        
        /**
         * Indicates the default strategy.
         *
         * @syscap SystemCapability.BundleManager.Zlib
         * @since 20
         */
        COMPRESS_STRATEGY_DEFAULT_STRATEGY = 0,
        
        /**
         * Indicates the filtered strategy.
         *
         * @syscap SystemCapability.BundleManager.Zlib
         * @since 20
         */
        COMPRESS_STRATEGY_FILTERED = 1,
        
        /**
         * Indicates the huffman-only strategy.
         *
         * @syscap SystemCapability.BundleManager.Zlib
         * @since 20
         */
        COMPRESS_STRATEGY_HUFFMAN_ONLY = 2,
        
        /**
         * Indicates the RLE strategy.
         *
         * @syscap SystemCapability.BundleManager.Zlib
         * @since 20
         */
        COMPRESS_STRATEGY_RLE = 3,
        
        /**
         * Indicates the fixed strategy.
         *
         * @syscap SystemCapability.BundleManager.Zlib
         * @since 20
         */
        COMPRESS_STRATEGY_FIXED = 4
    }
    /**
     * ParallelStrategy
     *
     * @enum { int }
     * @syscap SystemCapability.BundleManager.Zlib
     * @since 20
     */
    export enum ParallelStrategy {
        /**
         * Indicates the sequential strategy, compress and decompress sequentially.
         *
         * @syscap SystemCapability.BundleManager.Zlib
         * @since 20
         */
        PARALLEL_STRATEGY_SEQUENTIAL = 0,
        /**
         * Indicates the parallel decompression strategy.
         *
         * @syscap SystemCapability.BundleManager.Zlib
         * @since 20
         */
        PARALLEL_STRATEGY_PARALLEL_DECOMPRESSION = 1
    }
    
    /**
     * MemLevel
     *
     * @enum { int }
     * @syscap SystemCapability.BundleManager.Zlib
     * @since 20
     */
    export enum MemLevel {
        
        /**
         * Uses the least amount of memory.
         *
         * @syscap SystemCapability.BundleManager.Zlib
         * @since 20
         */
        MEM_LEVEL_MIN = 1,
        
        /**
         * Uses the maximum amount of memory.
         *
         * @syscap SystemCapability.BundleManager.Zlib
         * @since 20
         */
        MEM_LEVEL_MAX = 9,
        
        /**
         * Uses the default amount of memory.
         *
         * @syscap SystemCapability.BundleManager.Zlib
         * @since 20
         */
        MEM_LEVEL_DEFAULT = 8
    }
    /**
     * CompressFlushMode
     *
     * @enum { int }
     * @syscap SystemCapability.BundleManager.Zlib
     * @since 20
     */
    export enum CompressFlushMode {
        /**
         * Default value, indicating normal operation.
         *
         * @syscap SystemCapability.BundleManager.Zlib
         * @since 20
         */
        NO_FLUSH = 0,
        /**
         * Generate partial refresh points in compressed streams.
         *
         * @syscap SystemCapability.BundleManager.Zlib
         * @since 20
         */
        PARTIAL_FLUSH = 1,
        /**
         * Force output of all compressed data while maintaining the compressed stream state.
         *
         * @syscap SystemCapability.BundleManager.Zlib
         * @since 20
         */
        SYNC_FLUSH = 2,
        /**
         * the compression state is reset.
         *
         * @syscap SystemCapability.BundleManager.Zlib
         * @since 20
         */
        FULL_FLUSH = 3,
        /**
         * The compression or decompression process ends.
         *
         * @syscap SystemCapability.BundleManager.Zlib
         * @since 20
         */
        FINISH = 4,
        /**
         * Allow for finer grained control.
         *
         * @syscap SystemCapability.BundleManager.Zlib
         * @since 20
         */
        BLOCK = 5,
        /**
         * There are special purposes in implementation.
         *
         * @syscap SystemCapability.BundleManager.Zlib
         * @since 20
         */
        TREES = 6
    }
    /**
     * Return codes for the compression/decompression functions.
     *
     * @enum { int }
     * @syscap SystemCapability.BundleManager.Zlib
     * @since 20
     */
    export enum ReturnStatus {
        /**
         * Indicates success.
         *
         * @syscap SystemCapability.BundleManager.Zlib
         * @since 20
         */
        OK = 0,
        /**
         * Indicates that the entire data has been processed.
         *
         * @syscap SystemCapability.BundleManager.Zlib
         * @since 20
         */
        STREAM_END = 1,
        /**
         * Indicates preset dictionary is required to continue decompression.
         *
         * @syscap SystemCapability.BundleManager.Zlib
         * @since 20
         */
        NEED_DICT = 2
    }
    /**
     * Define the reference point for offset.
     *
     * @enum { int }
     * @syscap SystemCapability.BundleManager.Zlib
     * @since 20
     */
    export enum OffsetReferencePoint {
        /**
         * Seek from beginning of file.
         *
         * @syscap SystemCapability.BundleManager.Zlib
         * @since 20
         */
        SEEK_SET = 0,
        /**
         * Seek from current position.
         *
         * @syscap SystemCapability.BundleManager.Zlib
         * @since 20
         */
        SEEK_CUR = 1
    }
    
    /**
     * Defines compress or decompress options.
     *
     * @typedef Options
     * @syscap SystemCapability.BundleManager.Zlib
     * @since 20
     */
    interface Options {
        
        /**
         * Indicates the compress level.
         *
         * @type { ?CompressLevel }
         * @syscap SystemCapability.BundleManager.Zlib
         * @since 20
         */
        level?: CompressLevel;
        
        /**
         * Indicates the memory level.
         *
         * @type { ?MemLevel }
         * @syscap SystemCapability.BundleManager.Zlib
         * @since 20
         */
        memLevel?: MemLevel;
        
        /**
         * Indicates the compress strategy.
         *
         * @type { ?CompressStrategy }
         * @syscap SystemCapability.BundleManager.Zlib
         * @since 20
         */
        strategy?: CompressStrategy;
        /**
         * Indicates the parallel strategy.
         *
         * @type { ?ParallelStrategy }
         * @syscap SystemCapability.BundleManager.Zlib
         * @since 20
         */
        parallel?: ParallelStrategy;
    }
    /**
     * GzError return value information.
     *
     * @typedef GzErrorOutputInfo
     * @syscap SystemCapability.BundleManager.Zlib
     * @since 20
     */
    interface GzErrorOutputInfo {
        /**
         * Return Zlib status ReturnStatus the specific meaning is defined as enum.
         *
         * @type { ReturnStatus }
         * @syscap SystemCapability.BundleManager.Zlib
         * @since 20
         */
        status: ReturnStatus;
        /**
         * The status message for the last status which occurred on file.
         *
         * @type { string }
         * @syscap SystemCapability.BundleManager.Zlib
         * @since 20
         */
        statusMsg: string;
    }
    
    /**
     * Compress the specified file.
     *
     * @param { string } inFile - Indicates the path of the file to be compressed.
     * @param { string } outFile - Indicates the path of the output compressed file.
     * @param { Options } options - Indicates the options of compressing file.
     * @param { AsyncCallback<void> } callback - The callback of compressing file result.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified; 2. Incorrect parameter types.
     * @throws { BusinessError } 900001 - The input source file is invalid.
     * @throws { BusinessError } 900002 - The input destination file is invalid.
     * @syscap SystemCapability.BundleManager.Zlib
     * @since 20
     */
    function compressFile(inFile: string, outFile: string, options: Options, callback: AsyncCallback<void>): void;
    
    /**
     * Compress the specified file.
     *
     * @param { string } inFile - Indicates the path of the file to be compressed.
     * @param { string } outFile - Indicates the path of the output compressed file.
     * @param { Options } options - Indicates the options of compressing file.
     * @returns { Promise<void> } Returns the result of compressFile file.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified; 2. Incorrect parameter types.
     * @throws { BusinessError } 900001 - The input source file is invalid.
     * @throws { BusinessError } 900002 - The input destination file is invalid.
     * @syscap SystemCapability.BundleManager.Zlib
     * @since 20
     */
    function compressFile(inFile: string, outFile: string, options: Options): Promise<void>;
    /**
     * Compress the specified multiple files.
     *
     * @param { Array<string> } inFiles - Indicates the files to be compressed.
     * @param { string } outFile - Indicates the path of the output compressed file.
     * @param { Options } options - Indicates the options of compressing file.
     * @returns { Promise<void> } Returns the result of compressFile file.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified; 2. Incorrect parameter types.
     * @throws { BusinessError } 900001 - The input source file is invalid.
     * @throws { BusinessError } 900002 - The input destination file is invalid.
     * @syscap SystemCapability.BundleManager.Zlib
     * @since 20
     */
    function compressFiles(inFiles: Array<string>, outFile: string, options: Options): Promise<void>;
    
    
    /**
     * Decompress the specified file.
     *
     * @param { string } inFile - Indicates the path of the file to be decompressed.
     * @param { string } outFile - Indicates the path of the output decompressed file.
     * @param { Options } options - Indicates the options of decompressing file.
     * @param { AsyncCallback<void> } callback - The callback of decompressing file result.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified; 2. Incorrect parameter types.
     * @throws { BusinessError } 900001 - The input source file is invalid.
     * @throws { BusinessError } 900002 - The input destination file is invalid.
     * @throws { BusinessError } 900003 - The input source file is not in ZIP format or is damaged.
     * @syscap SystemCapability.BundleManager.Zlib
     * @since 20
     */
    function decompressFile(inFile: string, outFile: string, options: Options, callback: AsyncCallback<void>): void;
    
    /**
     * Decompress the specified file.
     *
     * @param { string } inFile - Indicates the path of the file to be decompressed.
     * @param { string } outFile - Indicates the path of the output decompressed file.
     * @param { AsyncCallback<void> } callback - The callback of decompressing file result.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified; 2. Incorrect parameter types.
     * @throws { BusinessError } 900001 - The input source file is invalid.
     * @throws { BusinessError } 900002 - The input destination file is invalid.
     * @throws { BusinessError } 900003 - The input source file is not in ZIP format or is damaged.
     * @syscap SystemCapability.BundleManager.Zlib
     * @since 20
     */
    function decompressFile(inFile: string, outFile: string, callback: AsyncCallback<void>): void;
    
    
    /**
     * Decompress the specified file.
     *
     * @param { string } inFile - Indicates the path of the file to be decompressed.
     * @param { string } outFile - Indicates the path of the output decompressing file.
     * @param { Options } options - Indicates the options of decompressing file.
     * @returns { Promise<void> } Returns the result of decompressing file.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified; 2. Incorrect parameter types.
     * @throws { BusinessError } 900001 - The input source file is invalid.
     * @throws { BusinessError } 900002 - The input destination file is invalid.
     * @throws { BusinessError } 900003 - The input source file is not in ZIP format or is damaged.
     * @syscap SystemCapability.BundleManager.Zlib
     * @since 20
     */
    function decompressFile(inFile: string, outFile: string, options?: Options): Promise<void>;
    /**
     * Get the original size of the compressed zip file, the size is the meta data stored in zip file.
     *
     * @param { string } compressedFile - Indicates the path of the compressed file.
     * @returns { Promise<long> } Returns the original size of the compressed file.
     * @throws { BusinessError } 401 - The parameter check failed. Possible causes: 1. Mandatory parameters are left unspecified; 2. Incorrect parameter types.
     * @throws { BusinessError } 900001 - The input source file is invalid.
     * @throws { BusinessError } 900003 - The input source file is not in ZIP format or is damaged.
     * @syscap SystemCapability.BundleManager.Zlib
     * @since 20
     */
    function getOriginalSize(compressedFile: string): Promise<long>;
    /**
     * Asynchronous creation of verification objects.
     *
     * @returns { Promise<Checksum> } Returns verification objects.
     * @syscap SystemCapability.BundleManager.Zlib
     * @since 20
     */
    function createChecksum(): Promise<Checksum>;
    /**
     * Synchronize creation of verification objects.
     *
     * @returns { Checksum } Returns verification objects.
     * @syscap SystemCapability.BundleManager.Zlib
     * @since 20
     */
    function createChecksumSync(): Checksum;
    /**
     * Synchronize creation of gzip objects.
     *
     * @returns { Promise<GZip> } Returns zip objects.
     * @syscap SystemCapability.BundleManager.Zlib
     * @since 20
     */
    function createGZip(): Promise<GZip>;
    /**
     * Synchronize creation of gzip objects.
     *
     * @returns { GZip } Returns zip objects.
     * @syscap SystemCapability.BundleManager.Zlib
     * @since 20
     */
    function createGZipSync(): GZip;
    /**
     * Calculate Adler-32 and CRC-32 checksum.
     *
     * @typedef Checksum
     * @syscap SystemCapability.BundleManager.Zlib
     * @since 20
     */
    interface Checksum {
        /**
         * Update a running Adler-32 checksum with the bytes buf.
         *
         * @param { long } adler - Initial value of Adler32 checksum.
         * @param { ArrayBuffer } buf - Calculate checksum data buffer.
         * @returns { Promise<long> } Return the updated checksum.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types; 3. Parameter verification failed.
         * @syscap SystemCapability.BundleManager.Zlib
         * @since 20
         */
        adler32(adler: long, buf: ArrayBuffer): Promise<long>;
        /**
         * Combine two Adler-32 checksum into one.
         *
         * @param { long } adler1 - The first Adler32 checksum.
         * @param { long } adler2 - The second Adler32 checksum.
         * @param { long } len2 - The length of the data block associated with the second Adler32 checksum.
         * @returns { Promise<long> } Returns the Adler-32 checksum.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types; 3. Parameter verification failed.
         * @syscap SystemCapability.BundleManager.Zlib
         * @since 20
         */
        adler32Combine(adler1: long, adler2: long, len2: long): Promise<long>;
        /**
         * Update a running CRC-32 with the bytes buf.
         *
         * @param { long } crc - Initial value of CRC-32 checksum.
         * @param { ArrayBuffer } buf - Calculate checksum data buffer.
         * @returns { Promise<long> } Return the updated CRC-32.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types; 3. Parameter verification failed.
         * @syscap SystemCapability.BundleManager.Zlib
         * @since 20
         */
        crc32(crc: long, buf: ArrayBuffer): Promise<long>;
        /**
         * Combine two CRC-32 check values into one.
         *
         * @param { long } crc1 - The first CRC-32 checksum.
         * @param { long } crc2 - The second CRC-32 checksum.
         * @param { long } len2 - The length of the data block associated with the second CRC-32 checksum.
         * @returns { Promise<long> } Returns the CRC-32 check value.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types; 3. Parameter verification failed.
         * @syscap SystemCapability.BundleManager.Zlib
         * @since 20
         */
        crc32Combine(crc1: long, crc2: long, len2: long): Promise<long>;
        /**
         * Update a running CRC-64 with the bytes buf.
         *
         * @param { long } crc - Initial value of CRC-64 checksum.
         * @param { ArrayBuffer } buf - Calculate checksum data buffer.
         * @returns { Promise<long> } Return the updated CRC-64.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types; 3. Parameter verification failed.
         * @syscap SystemCapability.BundleManager.Zlib
         * @since 20
         */
        crc64(crc: long, buf: ArrayBuffer): Promise<long>;
        /**
         * Get CRC-32 table.
         *
         * @returns { Promise<Array<long>> } Return a array to the CRC-32 table.
         * @syscap SystemCapability.BundleManager.Zlib
         * @since 20
         */
        getCrcTable(): Promise<Array<long>>;
        /**
         * Get CRC-64 table.
         *
         * @returns { Promise<Array<long>> } Return a array to the CRC-64 table.
         * @syscap SystemCapability.BundleManager.Zlib
         * @since 20
         */
        getCrc64Table(): Promise<Array<long>>;
    }
    /**
     * Gzip related interfaces.
     *
     * @typedef GZip
     * @syscap SystemCapability.BundleManager.Zlib
     * @since 20
     */
    interface GZip {
        /**
         * Associate a gzFile with the file descriptor fd.
         *
         * @param { int } fd - The file descriptor. Usually this is obtained through system calls to 'open' or other methods.
         * @param { string } mode - Used to specify access mode.
         * @returns { Promise<void> }
         * @throws { BusinessError } 401 - The parameter check failed. Possible causes: 1. Mandatory parameters are left unspecified;
         * 2. Incorrect parameter types; 3. Parameter verification failed.
         * @throws { BusinessError } 17800002 - No such file or access mode error.
         * @syscap SystemCapability.BundleManager.Zlib
         * @since 20
         */
        gzdopen(fd: int, mode: string): Promise<void>;
        /**
         * Set the internal buffer size used by this library's functions for file to size.
         *
         * @param { long } size - The internal buffer size to be set.
         * @returns { Promise<int> } Returns 0 on success.
         * @throws { BusinessError } 401 - The parameter check failed. Possible causes: 1. Mandatory parameters are left unspecified;
         * 2. Incorrect parameter types; 3. Parameter verification failed.
         * @throws { BusinessError } 17800009 - Internal structure error.
         * @syscap SystemCapability.BundleManager.Zlib
         * @since 20
         */
        gzbuffer(size: long): Promise<int>;
        /**
         * Open the gzip (.gz) file at path for reading and decompressing, or compressing and writing.
         *
         * @param { string } path - The file path to be opened.
         * @param { string } mode - Specify the file opening method.
         * @returns { Promise<void> }
         * @throws { BusinessError } 401 - The parameter check failed. Possible causes: 1. Mandatory parameters are left unspecified;
         * 2. Incorrect parameter types; 3. Parameter verification failed.
         * @throws { BusinessError } 17800002 - No such file or access mode error.
         * @syscap SystemCapability.BundleManager.Zlib
         * @since 20
         */
        gzopen(path: string, mode: string): Promise<void>;
        /**
         * Check if the reading position of the gzip compressed file has reached the end of the file.
         *
         * @returns { Promise<int> } Return 1 (true) if the end-of-file indicator for file has been set while reading.
         * @syscap SystemCapability.BundleManager.Zlib
         * @since 20
         */
        gzeof(): Promise<int>;
        /**
         * Check if the specified gzip file handle file directly accesses the original uncompressed data.
         *
         * @returns { Promise<int> } returns 1 (true) if transparent writing was requested.
         * @syscap SystemCapability.BundleManager.Zlib
         * @since 20
         */
        gzdirect(): Promise<int>;
        /**
         * Flush all pending output for file, if necessary, close file and deallocate the (de)compression state.
         *
         * @returns { Promise<ReturnStatus> } Return ReturnStatus the specific meaning is defined as enum.
         * @throws { BusinessError } 17800004 - Compression or decompression stream error, which may be caused by an initialization error in the zlib stream structure or a modified structure.
         * @throws { BusinessError } 17800006 - Memory allocation failed.
         * @syscap SystemCapability.BundleManager.Zlib
         * @since 20
         */
        gzclose(): Promise<ReturnStatus>;
        /**
         * Clear the error and end-of-file flags for file.
         *
         * @returns { Promise<void> }
         * @syscap SystemCapability.BundleManager.Zlib
         * @since 20
         */
        gzclearerr(): Promise<void>;
        /**
         * The error message for the last error which occurred on file.
         *
         * @returns { Promise<GzErrorOutputInfo> } Return the status message for the last status which occurred on file and ReturnStatus.
         * @throws { BusinessError } 17800004 - Compression or decompression stream error, which may be caused by an initialization error in the zlib stream structure or a modified structure.
         * @syscap SystemCapability.BundleManager.Zlib
         * @since 20
         */
        gzerror(): Promise<GzErrorOutputInfo>;
        /**
         * Read and decompress one byte from file.
         *
         * @returns { Promise<int> } Return the ASCII code of a character.
         * @throws { BusinessError } 17800009 - Internal structure error.
         * @syscap SystemCapability.BundleManager.Zlib
         * @since 20
         */
        gzgetc(): Promise<int>;
        /**
         * Flush all pending output to file.
         *
         * @param { CompressFlushMode } flush - Control the behavior of refresh operations.
         * @returns { Promise<ReturnStatus> } Return ReturnStatus the specific meaning is defined as enum.
         * @throws { BusinessError } 401 - The parameter check failed. Possible causes: 1. Mandatory parameters are left unspecified;
         * 2. Incorrect parameter types; 3. Parameter verification failed.
         * @throws { BusinessError } 17800004 - Compression or decompression stream error, which may be caused by an initialization error in the zlib stream structure or a modified structure.
         * @syscap SystemCapability.BundleManager.Zlib
         * @since 20
         */
        gzflush(flush: CompressFlushMode): Promise<ReturnStatus>;
        /**
         * Compress and write nitems items of size size from buf to file.
         *
         * @param { ArrayBuffer } buf - The buffer to write data to.
         * @param { long } size - The number of bytes in a single data block.
         * @param { long } nitems - Number of data blocks to be written.
         * @returns { Promise<long> } Return the number of full items written of size size.
         * @throws { BusinessError } 401 - The parameter check failed. Possible causes: 1. Mandatory parameters are left unspecified;
         * 2. Incorrect parameter types; 3. Parameter verification failed.
         * @throws { BusinessError } 17800009 - Internal structure error.
         * @syscap SystemCapability.BundleManager.Zlib
         * @since 20
         */
        gzfwrite(buf: ArrayBuffer, size: long, nitems: long): Promise<long>;
        /**
         * Read and decompress data from gzip compressed files.
         *
         * @param { ArrayBuffer } buf - Target buffer for storing read results.
         * @param { long } size - The number of bytes in a single data block.
         * @param { long } nitems - Number of data blocks to be read.
         * @returns { Promise<long> } Return the number of full items read of size size.
         * @throws { BusinessError } 401 - The parameter check failed. Possible causes: 1. Mandatory parameters are left unspecified;
         * 2. Incorrect parameter types; 3. Parameter verification failed.
         * @throws { BusinessError } 17800009 - Internal structure error.
         * @syscap SystemCapability.BundleManager.Zlib
         * @since 20
         */
        gzfread(buf: ArrayBuffer, size: long, nitems: long): Promise<long>;
        /**
         * Same as gzclose(), gzclosew() only for use when writing or appending.
         *
         * @returns { Promise<ReturnStatus> } Return ReturnStatus the specific meaning is defined as enum.
         * @throws { BusinessError } 17800004 - Compression or decompression stream error, which may be caused by an initialization error in the zlib stream structure or a modified structure.
         * @throws { BusinessError } 17800006 - Memory allocation failed.
         * @syscap SystemCapability.BundleManager.Zlib
         * @since 20
         */
        gzclosew(): Promise<ReturnStatus>;
        /**
         * Same as gzclose(), gzcloser() is only for use when reading.
         *
         * @returns { Promise<ReturnStatus> } Return ReturnStatus the specific meaning is defined as enum.
         * @throws { BusinessError } 17800004 - Compression or decompression stream error, which may be caused by an initialization error in the zlib stream structure or a modified structure.
         * @syscap SystemCapability.BundleManager.Zlib
         * @since 20
         */
        gzcloser(): Promise<ReturnStatus>;
        /**
         * Compress and write the len uncompressed bytes at buf to file.
         *
         * @param { ArrayBuffer } buf - Object to the data buffer to be written.
         * @param { long } len - The len uncompressed bytes.
         * @returns { Promise<long> } Return the number of uncompressed bytes written.
         * @throws { BusinessError } 401 - The parameter check failed. Possible causes: 1. Mandatory parameters are left unspecified;
         * 2. Incorrect parameter types; 3. Parameter verification failed.
         * @throws { BusinessError } 17800009 - Internal structure error.
         * @syscap SystemCapability.BundleManager.Zlib
         * @since 20
         */
        gzwrite(buf: ArrayBuffer, len: long): Promise<long>;
        /**
         * Push c back onto the stream for file to be read as the first character on the next read.
         *
         * @param { int } c - To fall back to the character before the input stream.
         * @returns { Promise<int> } Return the character pushed.
         * @throws { BusinessError } 401 - The parameter check failed. Possible causes: 1. Mandatory parameters are left unspecified;
         * 2. Incorrect parameter types; 3. Parameter verification failed.
         * @throws { BusinessError } 17800009 - Internal structure error.
         * @syscap SystemCapability.BundleManager.Zlib
         * @since 20
         */
        gzungetc(c: int): Promise<int>;
        /**
         * Return the starting position for the next gzread or gzwrite on file.
         *
         * @returns { Promise<long> } Return the starting position for the next gzread or gzwrite on file.
         * @throws { BusinessError } 17800009 - Internal structure error.
         * @syscap SystemCapability.BundleManager.Zlib
         * @since 20
         */
        gztell(): Promise<long>;
        /**
         * Dynamically update the compression level and strategy for file.
         *
         * @param { CompressLevel } level - Compression level.
         * @param { CompressStrategy } strategy - Compression strategy.
         * @returns { Promise<ReturnStatus> } Return ReturnStatus the specific meaning is defined as enum.
         * @throws { BusinessError } 401 - The parameter check failed. Possible causes: 1. Mandatory parameters are left unspecified;
         * 2. Incorrect parameter types; 3. Parameter verification failed.
         * @throws { BusinessError } 17800004 - Compression or decompression stream error, which may be caused by an initialization error in the zlib stream structure or a modified structure.
         * @syscap SystemCapability.BundleManager.Zlib
         * @since 20
         */
        gzsetparams(level: CompressLevel, strategy: CompressStrategy): Promise<ReturnStatus>;
        /**
         * Set the starting position to offset relative to whence for the next gzread or gzwrite on file.
         *
         * @param { long } offset - Specify the new offset to move to.
         * @param { OffsetReferencePoint } whence - Define the reference point for offset.
         * @returns { Promise<long> } Return the resulting offset location as measured in bytes from the beginning of the uncompressed stream.
         * @throws { BusinessError } 401 - The parameter check failed. Possible causes: 1. Mandatory parameters are left unspecified;
         * 2. Incorrect parameter types; 3. Parameter verification failed.
         * @throws { BusinessError } 17800009 - Internal structure error.
         * @syscap SystemCapability.BundleManager.Zlib
         * @since 20
         */
        gzseek(offset: long, whence: OffsetReferencePoint): Promise<long>;
        /**
         * Rewind file. This function is supported only for reading.
         *
         * @returns { Promise<ReturnStatus> } Return ReturnStatus the specific meaning is defined as enum.
         * @throws { BusinessError } 17800009 - Internal structure error.
         * @syscap SystemCapability.BundleManager.Zlib
         * @since 20
         */
        gzrewind(): Promise<ReturnStatus>;
        /**
         * Read and decompress up to len uncompressed bytes from file into buf.
         *
         * @param { ArrayBuffer } buf - User provided buffer address.
         * @returns { Promise<long> } Return the number of uncompressed bytes actually read, less than len for end of file.
         * @throws { BusinessError } 401 - The parameter check failed. Possible causes: 1. Mandatory parameters are left unspecified;
         * 2. Incorrect parameter types; 3. Parameter verification failed.
         * @throws { BusinessError } 17800009 - Internal structure error.
         * @syscap SystemCapability.BundleManager.Zlib
         * @since 20
         */
        gzread(buf: ArrayBuffer): Promise<long>;
        /**
         * Compress and write the given null-terminated string s to file, excluding the terminating null character.
         *
         * @param { string } str - Format descriptors and plain text.
         * @returns { Promise<int> } Return the number of characters written.
         * @throws { BusinessError } 401 - The parameter check failed. Possible causes: 1. Mandatory parameters are left unspecified;
         * 2. Incorrect parameter types; 3. Parameter verification failed.
         * @throws { BusinessError } 17800009 - Internal structure error.
         * @syscap SystemCapability.BundleManager.Zlib
         * @since 20
         */
        gzputs(str: string): Promise<int>;
        /**
         * Compress and write c, converted to an unsigned char, into file.
         *
         * @param { int } ch - Write ASCII values for characters.
         * @returns { Promise<int> } Return the value that was written.
         * @throws { BusinessError } 401 - The parameter check failed. Possible causes: 1. Mandatory parameters are left unspecified;
         * 2. Incorrect parameter types; 3. Parameter verification failed.
         * @throws { BusinessError } 17800009 - Internal structure error.
         * @syscap SystemCapability.BundleManager.Zlib
         * @since 20
         */
        gzputc(ch: int): Promise<int>;
        /**
         * Convert, format, compress, and write the arguments to file under control of the string format, as in fprintf.
         *
         * @param { string } format - Format descriptors and plain text.
         * @param { Array<string | number> } args - Variable argument lists.
         * @returns { Promise<int> } Return the number of uncompressed bytes actually written.
         * @throws { BusinessError } 401 - The parameter check failed. Possible causes: 1. Mandatory parameters are left unspecified;
         * 2. Incorrect parameter types; 3. Parameter verification failed.
         * @throws { BusinessError } 17800004 - Compression or decompression stream error, which may be caused by an initialization error in the zlib stream structure or a modified structure.
         * @throws { BusinessError } 17800009 - Internal structure error.
         * @syscap SystemCapability.BundleManager.Zlib
         * @since 20
         */
        gzprintf(format: string, ...args: Array<string | number>): Promise<int>;
        /**
         * Return the current compressed (actual) read or write offset of file.
         *
         * @returns { Promise<long> } Return the current compressed (actual) read or write offset of file.
         * @throws { BusinessError } 17800009 - Internal structure error.
         * @syscap SystemCapability.BundleManager.Zlib
         * @since 20
         */
        gzoffset(): Promise<long>;
        /**
         * Read and decompress bytes from file into buf, until len-1 characters are read, or until a newline character is read and transferred to buf,
         * or an end-of-file condition is encountered.
         *
         * @param { ArrayBuffer } buf - Store the read row data.
         * @returns { Promise<string> } Return buf which is a null-terminated string.
         * @throws { BusinessError } 401 - The parameter check failed. Possible causes: 1. Mandatory parameters are left unspecified;
         * 2. Incorrect parameter types; 3. Parameter verification failed.
         * @throws { BusinessError } 17800009 - Internal structure error.
         * @syscap SystemCapability.BundleManager.Zlib
         * @since 20
         */
        gzgets(buf: ArrayBuffer): Promise<string>;
    }
}
export default zlib;
