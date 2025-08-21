/*
 * Copyright (c) 2021-2023 Huawei Device Co., Ltd.
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
 * @kit PerformanceAnalysisKit
 */


/**
 * Provides interfaces to generate system logs.
 *
 * @namespace hilog
 * @syscap SystemCapability.HiviewDFX.HiLog
 * @since 20
 */
declare namespace hilog {
    
    
    
    /**
     * Outputs debug-level logs.
     *
     * @param { int } domain Indicates the service domain, which is a hexadecimal integer ranging from 0x0 to 0xFFFF
     *                          if the value exceeds the range, logs cannot be printed.
     * @param { string } tag Identifies the log tag, length cannot exceed 32 bytes, the excess part will be truncated.
     * @param { string } format Indicates the log format string.
     * @param { (Object | undefined | null)[] }args Indicates the log parameters.
     * @syscap SystemCapability.HiviewDFX.HiLog
     * @since 20
     */
    function debug(domain: int, tag: string, format: string, ...args: (Object | undefined | null)[]): void;
    
    
    
    /**
     * Outputs info-level logs.
     *
     * @param { int } domain Indicates the service domain, which is a hexadecimal integer ranging from 0x0 to 0xFFFF
     *                          if the value exceeds the range, logs cannot be printed.
     * @param { string } tag Identifies the log tag, length cannot exceed 32 bytes, the excess part will be truncated.
     * @param { string } format Indicates the log format string.
     * @param { (Object | undefined | null)[] }args Indicates the log parameters.
     * @syscap SystemCapability.HiviewDFX.HiLog
     * @since 20
     */
    function info(domain: int, tag: string, format: string, ...args: (Object | undefined | null)[]): void;
    
    
    
    /**
     * Outputs warning-level logs.
     *
     * @param { int } domain Indicates the service domain, which is a hexadecimal integer ranging from 0x0 to 0xFFFF
     *                          if the value exceeds the range, logs cannot be printed.
     * @param { string } tag Identifies the log tag, length cannot exceed 32 bytes, the excess part will be truncated.
     * @param { string } format Indicates the log format string.
     * @param { (Object | undefined | null)[] }args Indicates the log parameters.
     * @syscap SystemCapability.HiviewDFX.HiLog
     * @since 20
     */
    function warn(domain: int, tag: string, format: string, ...args: (Object | undefined | null)[]): void;
    
    
    
    /**
     * Outputs error-level logs.
     *
     * @param { int } domain Indicates the service domain, which is a hexadecimal integer ranging from 0x0 to 0xFFFF
     *                          if the value exceeds the range, logs cannot be printed.
     * @param { string } tag Identifies the log tag, length cannot exceed 32 bytes, the excess part will be truncated.
     * @param { string } format Indicates the log format string.
     * @param { (Object | undefined | null)[] }args Indicates the log parameters.
     * @syscap SystemCapability.HiviewDFX.HiLog
     * @since 20
     */
    function error(domain: int, tag: string, format: string, ...args: (Object | undefined | null)[]): void;
    
    
    
    /**
     * Outputs fatal-level logs.
     *
     * @param { int } domain Indicates the service domain, which is a hexadecimal integer ranging from 0x0 to 0xFFFF
     *                          if the value exceeds the range, logs cannot be printed.
     * @param { string } tag Identifies the log tag, length cannot exceed 32 bytes, the excess part will be truncated.
     * @param { string } format Indicates the log format string.
     * @param { (Object | undefined | null)[] }args Indicates the log parameters.
     * @syscap SystemCapability.HiviewDFX.HiLog
     * @since 20
     */
    function fatal(domain: int, tag: string, format: string, ...args: (Object | undefined | null)[]): void;
    
    /**
     * Checks whether logs of the specified tag, and level can be printed.
     *
     * @param { int } domain Indicates the service domain, which is a hexadecimal integer ranging from 0x0 to 0xFFFF
     *                          if the value exceeds the range, logs cannot be printed.
     * @param { string } tag Identifies the log tag, length cannot exceed 32 bytes, the excess part will be truncated.
     * @param { LogLevel } level log level
     * @returns { boolean }
     * @syscap SystemCapability.HiviewDFX.HiLog
     * @since 20
     */
    function isLoggable(domain: int, tag: string, level: LogLevel): boolean;
    /**
     * Sets the lowest log level of the current application process.
     *
     * @param { LogLevel } level log level
     * @syscap SystemCapability.HiviewDFX.HiLog
     * @since 20
     */
    function setMinLogLevel(level: LogLevel): void;
    
    
    /**
     * Log level define
     *
     * @enum { int }
     * @syscap SystemCapability.HiviewDFX.HiLog
     * @since 20
     */
    enum LogLevel {
        
        
        /**
         * DEBUG Log level define
         *
         * @syscap SystemCapability.HiviewDFX.HiLog
         * @since 20
         */
        DEBUG = 3,
        
        
        /**
         * INFO Log level define
         *
         * @syscap SystemCapability.HiviewDFX.HiLog
         * @since 20
         */
        INFO = 4,
        
        
        /**
         * WARN Log level define
         *
         * @syscap SystemCapability.HiviewDFX.HiLog
         * @since 20
         */
        WARN = 5,
        
        
        /**
         * ERROR Log level define
         *
         * @syscap SystemCapability.HiviewDFX.HiLog
         * @since 20
         */
        ERROR = 6,
        
        
        /**
         * FATAL Log level define
         *
         * @syscap SystemCapability.HiviewDFX.HiLog
         * @since 20
         */
        FATAL = 7
    }
}
export default hilog;
