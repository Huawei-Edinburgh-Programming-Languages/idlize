/*
 * Copyright (C) 2021-2023 Huawei Device Co., Ltd.
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
 * @kit IPCKit
 */
import type { AsyncCallback } from './@ohos.base';
/**
 * This module provides inter process communication capability.
 *
 * @namespace rpc
 * @syscap SystemCapability.Communication.IPC.Core
 * @since 20
 */
declare namespace rpc {
    /**
     * A data object used for remote procedure call (RPC).
     * <p>
     * During RPC, the sender can use the write methods provided by {@link MessageSequence} to
     * write the to-be-sent data into a {@link MessageSequence} object in a specific format, and the receiver can use the
     * read methods provided by {@link MessageSequence} to read data of the specific format from
     * the {@link MessageSequence} object.
     * <p>
     * <p>
     * The default capacity of a {@link MessageSequence} instance is 200KB. If you want more or less,
     * use {@link #setCapacity(int)} to change it.
     * </p>
     * <b>Note</b>: Only data of the following data types can be written into or read from a {@link MessageSequence}:
     * byte, byteArray, short, shortArray, int, intArray, long, longArray, float, floatArray, double, doubleArray,
     * boolean, booleanArray, char, charArray, String, StringArray, {@link IRemoteObject}, IRemoteObjectArray,
     * {@link Parcelable}, and ParcelableArray.
     *
     * @syscap SystemCapability.Communication.IPC.Core
     * @since 20
     */
    class MessageSequence {
        /**
         * Creates an empty {@link MessageSequence} object.
         *
         * @returns { MessageSequence } Return the object created.
         * @syscap SystemCapability.Communication.IPC.Core
         * @since 20
         */
        static create(): MessageSequence;
        /**
         * Reclaim the {@link MessageSequence} object.
         *
         * @syscap SystemCapability.Communication.IPC.Core
         * @since 20
         */
        reclaim(): void;
        /**
         * Serialize a remote object and writes it to the {@link MessageSequence} object.
         *
         * @param { IRemoteObject } obj - Remote object to serialize.
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         *     1.The number of parameters is incorrect;
         *     2.The parameter type does not match.
         * @throws { BusinessError } 1900008 - The proxy or remote object is invalid.
         * @throws { BusinessError } 1900009 - Failed to write data to the message sequence.
         * @syscap SystemCapability.Communication.IPC.Core
         * @since 20
         */
        writeRemoteObject(obj: IRemoteObject): void;
        /**
         * Reads a remote object from {@link MessageSequence} object.
         *
         * @returns { IRemoteObject } Return the remote object.
         * @throws { BusinessError } 1900008 - The proxy or remote object is invalid.
         * @throws { BusinessError } 1900010 - Failed to read data from the message sequence.
         * @syscap SystemCapability.Communication.IPC.Core
         * @since 20
         */
        readRemoteObject(): IRemoteObject;
        /**
         * Writes an interface token into the {@link MessageSequence} object.
         *
         * @param { string } token - Interface descriptor to write.
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         *     1.The number of parameters is incorrect;
         *     2.The parameter type does not match;
         *     3.The string length exceeds 40960 bytes;
         *     4.The number of bytes copied to the buffer is different from the length of the obtained string.
         * @throws { BusinessError } 1900009 - Failed to write data to the message sequence.
         * @syscap SystemCapability.Communication.IPC.Core
         * @since 20
         */
        writeInterfaceToken(token: string): void;
        /**
         * Reads an interface token from the {@link MessageSequence} object.
         *
         * @returns { string } Return a string value.
         * @throws { BusinessError } 1900010 - Failed to read data from the message sequence.
         * @syscap SystemCapability.Communication.IPC.Core
         * @since 20
         */
        readInterfaceToken(): string;
        /**
         * Obtains the storage capacity (in bytes) of the {@link MessageSequence} object.
         *
         * @returns { int } Return the storage capacity of the {@link MessageSequence} object.
         * @syscap SystemCapability.Communication.IPC.Core
         * @since 20
         */
        getCapacity(): int;
        /**
         * Sets the storage capacity (in bytes) of the {@link MessageSequence} object.
         * <p>{@code false} is returned if the capacity set in this method is less than
         * the size of data contained in the {@link MessageSequence}.
         *
         * @param { int } size - Indicates the storage capacity of the {@link MessageSequence} object.
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         *     1.The number of parameters is incorrect;
         *     2.The parameter type does not match.
         * @throws { BusinessError } 1900009 - Failed to write data to the message sequence.
         * @throws { BusinessError } 1900011 - Memory allocation failed.
         * @syscap SystemCapability.Communication.IPC.Core
         * @since 20
         */
        setCapacity(size: int): void;
        /**
         * Writes information to this MessageSequence object indicating that no exception occurred.
         * <p>After handling requests, you should call this method before writing any data to reply
         * {@link MessageSequence}.
         *
         * @throws { BusinessError } 1900009 - Failed to write data to the message sequence.
         * @syscap SystemCapability.Communication.IPC.Core
         * @since 20
         */
        writeNoException(): void;
        /**
         * Reads the exception information from this MessageSequence object.
         * <p>If exception was thrown in server side, it will be thrown here.
         * This method should be called before reading any data from reply {@link MessageSequence}
         * if {@link writeNoException} was invoked in server side.
         *
         * @throws { BusinessError } 1900010 - Failed to read data from the message sequence.
         * @syscap SystemCapability.Communication.IPC.Core
         * @since 20
         */
        readException(): void;
        /**
         * Writes an integer value into the {@link MessageSequence} object.
         *
         * @param { int } val - Indicates the integer value to write.
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         *     1.The number of parameters is incorrect;
         *     2.The parameter type does not match.
         * @throws { BusinessError } 1900009 - Failed to write data to the message sequence.
         * @syscap SystemCapability.Communication.IPC.Core
         * @since 20
         */
        writeInt(val: int): void;
        /**
         * Writes a long integer value into the {@link MessageSequence} object.
         *
         * @param { long } val - Indicates the long integer value to write.
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         *     1.The number of parameters is incorrect;
         *     2.The parameter type does not match.
         * @throws { BusinessError } 1900009 - Failed to write data to the message sequence.
         * @syscap SystemCapability.Communication.IPC.Core
         * @since 20
         */
        writeLong(val: long): void;
        /**
         * Writes a boolean value into the {@link MessageSequence} object.
         *
         * @param { boolean } val - Indicates the boolean value to write.
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         *     1.The number of parameters is incorrect;
         *     2.The parameter type does not match.
         * @throws { BusinessError } 1900009 - Failed to write data to the message sequence.
         * @syscap SystemCapability.Communication.IPC.Core
         * @since 20
         */
        writeBoolean(val: boolean): void;
        /**
         * Writes a string value into the {@link MessageSequence} object.
         *
         * @param { string } val - Indicates the string value to write.
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         *     1.The number of parameters is incorrect;
         *     2.The parameter type does not match;
         *     3.The string length exceeds 40960 bytes;
         *     4.The number of bytes copied to the buffer is different from the length of the obtained string.
         * @throws { BusinessError } 1900009 - Failed to write data to the message sequence.
         * @syscap SystemCapability.Communication.IPC.Core
         * @since 20
         */
        writeString(val: string): void;
        /**
         * Writes a {@link Parcelable} object into the {@link MessageSequence} object.
         *
         * @param { Parcelable } val - Indicates the {@link Parcelable} object to write.
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         *     1.The number of parameters is incorrect;
         *     2.The parameter type does not match.
         * @throws { BusinessError } 1900009 - Failed to write data to the message sequence.
         * @syscap SystemCapability.Communication.IPC.Core
         * @since 20
         */
        writeParcelable(val: Parcelable): void;
        /**
         * Writes a byte array into the {@link MessageSequence} object.
         *
         * @param { int[] } byteArray - Indicates the byte array to write.
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         *     1.The parameter is an empty array;
         *     2.The number of parameters is incorrect;
         *     3.The parameter type does not match;
         *     4.The element does not exist in the array.
         *     5.The type of the element in the array is incorrect.
         * @throws { BusinessError } 1900009 - Failed to write data to the message sequence.
         * @syscap SystemCapability.Communication.IPC.Core
         * @since 20
         */
        writeByteArray(byteArray: int[]): void;
        /**
         * Writes an integer array into the {@link MessageSequence} object.
         * Ensure that the data type and size comply with the interface definition.
         * Otherwise,data may be truncated.
         *
         * @param { int[] } intArray - Indicates the integer array to write.
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         *     1.The parameter is an empty array;
         *     2.The number of parameters is incorrect;
         *     3.The parameter type does not match;
         *     4.The element does not exist in the array;
         *     5.The type of the element in the array is incorrect.
         * @throws { BusinessError } 1900009 - Failed to write data to the message sequence.
         * @syscap SystemCapability.Communication.IPC.Core
         * @since 20
         */
        writeIntArray(intArray: int[]): void;
        /**
         * Writes a double-precision floating point array into the {@link MessageSequence} object.
         * Ensure that the data type and size comply with the interface definition.
         * Otherwise,data may be truncated.
         *
         * @param { double[] } doubleArray - Indicates the double-precision floating point array to write.
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         *     1.The parameter is an empty array;
         *     2.The number of parameters is incorrect;
         *     3.The parameter type does not match;
         *     4.The element does not exist in the array;
         *     5.The type of the element in the array is incorrect.
         * @throws { BusinessError } 1900009 - Failed to write data to the message sequence.
         * @syscap SystemCapability.Communication.IPC.Core
         * @since 20
         */
        writeDoubleArray(doubleArray: double[]): void;
        /**
         * Writes a boolean array into the {@link MessageSequence} object.
         * Ensure that the data type and size comply with the interface definition.
         * Otherwise,data may be truncated.
         *
         * @param { boolean[] } booleanArray - Indicates the boolean array to write.
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         *     1.The parameter is an empty array;
         *     2.The number of parameters is incorrect;
         *     3.The parameter type does not match;
         *     4.The element does not exist in the array.
         * @throws { BusinessError } 1900009 - Failed to write data to the message sequence.
         * @syscap SystemCapability.Communication.IPC.Core
         * @since 20
         */
        writeBooleanArray(booleanArray: boolean[]): void;
        /**
         * Writes a string array into the {@link MessageSequence} object.
         * Ensure that the data type and size comply with the interface definition.
         * Otherwise,data may be truncated.
         *
         * @param { string[] } stringArray - Indicates the string array to write.
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         *     1.The parameter is an empty array;
         *     2.The number of parameters is incorrect;
         *     3.The parameter type does not match;
         *     4.The string length exceeds 40960 bytes;
         *     5.The number of bytes copied to the buffer is different from the length of the obtained string.
         * @throws { BusinessError } 1900009 - Failed to write data to the message sequence.
         * @syscap SystemCapability.Communication.IPC.Core
         * @since 20
         */
        writeStringArray(stringArray: string[]): void;
        /**
         * Writes a {@link Parcelable} object array into the {@link MessageSequence} object.
         *
         * @param { Parcelable[] } parcelableArray - Indicates the {@link Parcelable} object array to write.
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         *     1.The parameter is an empty array;
         *     2.The number of parameters is incorrect;
         *     3.The parameter type does not match;
         *     4.The element does not exist in the array.
         * @throws { BusinessError } 1900009 - Failed to write data to the message sequence.
         * @syscap SystemCapability.Communication.IPC.Core
         * @since 20
         */
        writeParcelableArray(parcelableArray: Parcelable[]): void;
        /**
         * Reads an integer value from the {@link MessageSequence} object.
         *
         * @returns { int } Return an integer value.
         * @throws { BusinessError } 1900010 - Failed to read data from the message sequence.
         * @syscap SystemCapability.Communication.IPC.Core
         * @since 20
         */
        readInt(): int;
        /**
         * Reads a long integer value from the {@link MessageSequence} object.
         *
         * @returns { long } Return a long integer value.
         * @throws { BusinessError } 1900010 - Failed to read data from the message sequence.
         * @syscap SystemCapability.Communication.IPC.Core
         * @since 20
         */
        readLong(): long;
        /**
         * Reads a boolean value from the {@link MessageSequence} object.
         *
         * @returns { boolean } Return a boolean value.
         * @throws { BusinessError } 1900010 - Failed to read data from the message sequence.
         * @syscap SystemCapability.Communication.IPC.Core
         * @since 20
         */
        readBoolean(): boolean;
        /**
         * Reads a string value from the {@link MessageSequence} object.
         *
         * @returns { string } Return a string value.
         * @throws { BusinessError } 1900010 - Failed to read data from the message sequence.
         * @syscap SystemCapability.Communication.IPC.Core
         * @since 20
         */
        readString(): string;
        /**
         * Reads a {@link Parcelable} object from the {@link MessageSequence} instance.
         *
         * @param { Parcelable } dataIn - Indicates the {@link Parcelable} object that needs to perform
         *                       the {@code unmarshalling} operation using the {@link MessageSequence}.
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         *     1.The number of parameters is incorrect.
         * @throws { BusinessError } 1900010 - Failed to read data from the message sequence.
         * @throws { BusinessError } 1900012 - Failed to call the JS callback function.
         * @syscap SystemCapability.Communication.IPC.Core
         * @since 20
         */
        readParcelable(dataIn: Parcelable): void;
        /**
         * Reads an integer array from the {@link MessageSequence} object.
         *
         * @param { int[] } dataIn - Indicates the integer array to read.
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         *     1.The parameter is an empty array;
         *     2.The number of parameters is incorrect;
         *     3.The parameter type does not match.
         * @throws { BusinessError } 1900010 - Failed to read data from the message sequence.
         * @syscap SystemCapability.Communication.IPC.Core
         * @since 20
         */
        readIntArray(dataIn: int[]): void;
        /**
         * Reads an integer array from the {@link MessageSequence} object.
         *
         * @returns { int[] } Return an integer array.
         * @throws { BusinessError } 1900010 - Failed to read data from the message sequence.
         * @syscap SystemCapability.Communication.IPC.Core
         * @since 20
         */
        readIntArray(): int[];
        /**
         * Reads a double-precision floating point array from the {@link MessageSequence} object.
         *
         * @param { double[] } dataIn - Indicates the double-precision floating point array to read.
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         *     1.The parameter is an empty array;
         *     2.The number of parameters is incorrect;
         *     3.The parameter type does not match.
         * @throws { BusinessError } 1900010 - Failed to read data from the message sequence.
         * @syscap SystemCapability.Communication.IPC.Core
         * @since 20
         */
        readDoubleArray(dataIn: double[]): void;
        /**
         * Reads a double-precision floating point array from the {@link MessageSequence} object.
         *
         * @returns { double[] } Return a double-precision floating point array.
         * @throws { BusinessError } 1900010 - Failed to read data from the message sequence.
         * @syscap SystemCapability.Communication.IPC.Core
         * @since 20
         */
        readDoubleArray(): double[];
        /**
         * Reads a boolean array from the {@link MessageSequence} object.
         *
         * @param { boolean[] } dataIn - Indicates the boolean array to read.
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         *     1.The parameter is an empty array;
         *     2.The number of parameters is incorrect;
         *     3.The parameter type does not match.
         * @throws { BusinessError } 1900010 - Failed to read data from the message sequence.
         * @syscap SystemCapability.Communication.IPC.Core
         * @since 20
         */
        readBooleanArray(dataIn: boolean[]): void;
        /**
         * Reads a boolean array from the {@link MessageSequence} object.
         *
         * @returns { boolean[] } Return a boolean array.
         * @throws { BusinessError } 1900010 - Failed to read data from the message sequence.
         * @syscap SystemCapability.Communication.IPC.Core
         * @since 20
         */
        readBooleanArray(): boolean[];
        /**
         * Reads a string array from the {@link MessageSequence} object.
         *
         * @param { string[] } dataIn - Indicates the string array to read.
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         *     1.The parameter is an empty array;
         *     2.The number of parameters is incorrect;
         *     3.The parameter type does not match.
         * @throws { BusinessError } 1900010 - Failed to read data from the message sequence.
         * @syscap SystemCapability.Communication.IPC.Core
         * @since 20
         */
        readStringArray(dataIn: string[]): void;
        /**
         * Reads a string array from the {@link MessageSequence} object.
         *
         * @returns { string[] } Return a string array.
         * @throws { BusinessError } 1900010 - Failed to read data from the message sequence.
         * @syscap SystemCapability.Communication.IPC.Core
         * @since 20
         */
        readStringArray(): string[];
        /**
         * Reads the specified {@link Parcelable} array from this {@link MessageSequence} object.
         *
         * @param { Parcelable[] } parcelableArray - Parcelable array to read.
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         *     1.The parameter is an empty array;
         *     2.The number of parameters is incorrect;
         *     3.The parameter type does not match;
         *     4.The length of the array passed when reading is not equal to the length passed when writing to the array;
         *     5.The element does not exist in the array.
         * @throws { BusinessError } 1900010 - Failed to read data from the message sequence.
         * @throws { BusinessError } 1900012 - Failed to call the JS callback function.
         * @syscap SystemCapability.Communication.IPC.Core
         * @since 20
         */
        readParcelableArray(parcelableArray: Parcelable[]): void;
        /**
         * Closes the specified file descriptor.
         *
         * @param { int } fd - File descriptor to be closed.
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         *     1.The number of parameters is incorrect;
         *     2.The parameter type does not match.
         * @static
         * @syscap SystemCapability.Communication.IPC.Core
         * @since 20
         */
        static closeFileDescriptor(fd: int): void;
        /**
         * Writes a file descriptor to this {@link MessageSequence} object.
         *
         * @param { int } fd - File descriptor to wrote.
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         *     1.The number of parameters is incorrect;
         *     2.The parameter type does not match.
         * @throws { BusinessError } 1900009 - Failed to write data to the message sequence.
         * @syscap SystemCapability.Communication.IPC.Core
         * @since 20
         */
        writeFileDescriptor(fd: int): void;
        /**
         * Reads a file descriptor from this {@link MessageSequence} object.
         *
         * @returns { int } Return a file descriptor obtained.
         * @throws { BusinessError } 1900010 - Failed to read data from the message sequence.
         * @syscap SystemCapability.Communication.IPC.Core
         * @since 20
         */
        readFileDescriptor(): int;
        /**
         * Writes an anonymous shared memory object to this {@link MessageSequence} object.
         *
         * @param { Ashmem } ashmem - Anonymous shared memory object to wrote.
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         *     1.The number of parameters is incorrect;
         *     2.The parameter is not an instance of the Ashmem object.
         * @throws { BusinessError } 1900009 - Failed to write data to the message sequence.
         * @syscap SystemCapability.Communication.IPC.Core
         * @since 20
         */
        writeAshmem(ashmem: Ashmem): void;
        /**
         * Reads the anonymous shared memory object from this {@link MessageSequence} object.
         *
         * @returns { Ashmem } Return the anonymous share object obtained.
         * @throws { BusinessError } 1900010 - Failed to read data from the message sequence.
         * @syscap SystemCapability.Communication.IPC.Core
         * @since 20
         */
        readAshmem(): Ashmem;
        /**
         * Writes raw data to this {@link MessageSequence} object.
         *
         * @param { ArrayBuffer } rawData - Raw data to wrote.
         * @param { int } size - Size of the raw data, in bytes.
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         *     1.The number of parameters is incorrect;
         *     2.The parameter type does not match;
         *     3.Failed to obtain arrayBuffer information;
         *     4.The transferred size cannot be obtained;
         *     5.The transferred size is less than or equal to 0;
         *     6.The transferred size is greater than the byte length of ArrayBuffer.
         * @throws { BusinessError } 1900009 - Failed to write data to the message sequence.
         * @syscap SystemCapability.Communication.IPC.Core
         * @since 20
         */
        writeRawDataBuffer(rawData: ArrayBuffer, size: int): void;
        /**
         * Reads raw data from this {@link MessageSequence} object.
         *
         * @param { int } size - Size of the raw data to read.
         * @returns { ArrayBuffer } Return the raw data obtained, in bytes.
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         *     1.The number of parameters is incorrect;
         *     2.The parameter type does not match.
         * @throws { BusinessError } 1900010 - Failed to read data from the message sequence.
         * @syscap SystemCapability.Communication.IPC.Core
         * @since 20
         */
        readRawDataBuffer(size: int): ArrayBuffer;
    }
    
    /**
     * During inter-process communication, objects of the class are written to the {@link MessageSequence} and
     * they are recovered from the {@link MessageSequence}.
     *
     * @typedef Parcelable
     * @syscap SystemCapability.Communication.IPC.Core
     * @since 20
     */
    interface Parcelable {
        /**
         * Marshal this {@code Parcelable} object into a {@link MessageSequence}.
         *
         * @param { MessageSequence } dataOut - Indicates the {@link MessageSequence} object to which the {@code Parcelable}
         *                            object will be marshalled.
         * @returns { boolean } Return {@code true} if the marshalling is successful; return {@code false} otherwise.
         * @syscap SystemCapability.Communication.IPC.Core
         * @since 20
         */
        marshalling(dataOut: MessageSequence): boolean;
        /**
         * Unmarshal this {@code Parcelable} object from a {@link MessageSequence}.
         *
         * @param { MessageSequence } dataIn - Indicates the {@link MessageSequence} object into
         *                            which the {@code Parcelable} object has been marshalled.
         * @returns { boolean } Return {@code true} if the unmarshalling is successful; return {@code false} otherwise.
         * @syscap SystemCapability.Communication.IPC.Core
         * @since 20
         */
        unmarshalling(dataIn: MessageSequence): boolean;
    }
    /**
     * Defines the response to the request.
     * <p> SendRequestResult object contains four members, namely error code of this operation, request code, data parcel
     * and reply parcel.
     *
     * @typedef RequestResult
     * @syscap SystemCapability.Communication.IPC.Core
     * @since 20
     */
    interface RequestResult {
        /**
         * Error code. 0 indicates successful, otherwise it is failed.
         *
         * @type { int }
         * @syscap SystemCapability.Communication.IPC.Core
         * @since 20
         */
        errCode: int;
        /**
         * Message code. It is same as the code in {@link SendRequest} method.
         *
         * @type { int }
         * @syscap SystemCapability.Communication.IPC.Core
         * @since 20
         */
        code: int;
        /**
         * MessageSequence object sent to the peer process.
         * It is the same object in {@link SendRequest} method.
         *
         * @type { MessageSequence }
         * @syscap SystemCapability.Communication.IPC.Core
         * @since 20
         */
        data: MessageSequence;
        /**
         * MessageSequence object returned by the peer process.
         * It is the same object in {@link SendRequest} method.
         *
         * @type { MessageSequence }
         * @syscap SystemCapability.Communication.IPC.Core
         * @since 20
         */
        reply: MessageSequence;
    }
    
    /**
     * Used to query or get interface descriptors, add or remove death notifications, dump object status to
     * a specific file, and send messages.
     *
     * @syscap SystemCapability.Communication.IPC.Core
     * @since 20
     */
    abstract class IRemoteObject {
        /**
         * Sends a {@link MessageSequence} message to the peer process asynchronously.
         * <p>If options indicates the asynchronous mode, a promise will be fulfilled immediately
         * and the reply message does not contain any content. If options indicates the synchronous mode,
         * a promise will be fulfilled when the response to sendMessageRequest is returned,
         * and the reply message contains the returned information.
         *
         * @param { int } code - Message code called by the request, which is determined by the client and server.
         * If the method is generated by an IDL tool, the message code is automatically generated by the IDL tool.
         * @param {MessageSequence } data - {@link MessageSequence} object holding the data to send.
         * @param {MessageSequence } reply - {@link MessageSequence} object that receives the response.
         * @param { MessageOption } options - Indicates the synchronous or asynchronous mode to send messages.
         * @returns { Promise<RequestResult> } Promise used to return the {@link RequestResult} instance.
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         *     1.The number of parameters is incorrect;
         *     2.The parameter type does not match;
         *     3.Failed to obtain the passed object instance.
         * @syscap SystemCapability.Communication.IPC.Core
         * @since 20
         */
        sendMessageRequest(code: int, data: MessageSequence, reply: MessageSequence, options: MessageOption): Promise<RequestResult>;
        /**
         * Sends a {@link MessageSequence} message to the peer process in synchronous or asynchronous mode.
         * <p>If options indicates the asynchronous mode, a callback will be invoked immediately
         * and the reply message does not contain any content. If options indicates the synchronous mode,
         * a callback will be invoked when the response to sendMessageRequest is returned,
         * and the reply message contains the returned information.
         *
         * @param {int } code - Message code called by the request, which is determined by the client and server.
         * If the method is generated by an IDL tool, the message code is automatically generated by the IDL tool.
         * @param { MessageSequence } data - {@link MessageSequence} object holding the data to send.
         * @param { MessageSequence } reply - {@link MessageSequence} object that receives the response.
         * @param { MessageOption } options - Indicates the synchronous or asynchronous mode to send messages.
         * @param { AsyncCallback<RequestResult> } callback - Callback for receiving the sending result.
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         *     1.The number of parameters is incorrect;
         *     2.The parameter type does not match;
         *     3.Failed to obtain the passed object instance.
         * @syscap SystemCapability.Communication.IPC.Core
         * @since 20
         */
        sendMessageRequest(code: int, data: MessageSequence, reply: MessageSequence, options: MessageOption, callback: AsyncCallback<RequestResult>): void;
        /**
         * Register a callback used to receive notifications of the death of a remote object.
         *
         * @param { DeathRecipient } recipient - Indicates the callback to be registered.
         * @param { int } flags - Indicates the flag of the death notification.
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         *     1.The number of parameters is incorrect;
         *     2.The parameter type does not match;
         *     3.The callback used to receive remote object death notifications is empty.
         * @throws { BusinessError } 1900005 - Operation allowed only for the proxy object.
         * @throws { BusinessError } 1900008 - The proxy or remote object is invalid.
         * @syscap SystemCapability.Communication.IPC.Core
         * @since 20
         */
        registerDeathRecipient(recipient: DeathRecipient, flags: int): void;
        /**
         * Unregister a callback used to receive notifications of the death of a remote object.
         *
         * @param { DeathRecipient } recipient - Indicates the callback to be unregister.
         * @param { int } flags - Indicates the flag of the death notification.
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         *     1.The number of parameters is incorrect;
         *     2.The parameter type does not match;
         *     3.The callback used to receive remote object death notifications is empty.
         * @throws { BusinessError } 1900005 - Operation allowed only for the proxy object.
         * @throws { BusinessError } 1900008 - The proxy or remote object is invalid.
         * @syscap SystemCapability.Communication.IPC.Core
         * @since 20
         */
        unregisterDeathRecipient(recipient: DeathRecipient, flags: int): void;
        /**
         * Obtains the interface descriptor of an object.
         * <p>The interface descriptor is a character string.
         *
         * @returns { string } Return the interface descriptor.
         * @throws { BusinessError } 1900008 - The proxy or remote object is invalid.
         * @syscap SystemCapability.Communication.IPC.Core
         * @since 20
         */
        getDescriptor(): string;
        /**
         * Checks whether an object is dead.
         *
         * @returns { boolean } Return {@code true} if the object is dead; return {@code false} otherwise.
         * @syscap SystemCapability.Communication.IPC.Core
         * @since 20
         */
        isObjectDead(): boolean;
    }
    
    /**
     * Used to define the communication interface of the IPC communication objects.
     *
     * @typedef IRemoteBroker
     * @syscap SystemCapability.Communication.IPC.Core
     * @since 20
     */
    interface IRemoteBroker {
        /**
         * Obtains a proxy or remote object. This method must be implemented by its derived classes.
         *
         * @returns { IRemoteObject } Return the RemoteObject if the caller is a RemoteObject; return the IRemoteObject,
         * that is, the holder of this RemoteProxy object, if the caller is a RemoteProxy object.
         * @syscap SystemCapability.Communication.IPC.Core
         * @since 20
         */
        asObject(): IRemoteObject;
    }
    
    /**
     * Used to subscribe to death notifications for remote objects.
     * <p>
     * When a remote object subscribed to the notification dies, the local end can receive a message and call
     * the onRemoteDied operation. The death of a remote object can be caused by the death of the process to which the
     * remote object belongs, the shutdown or restart of the device to which the remote object belongs,
     * or the death of the remote object when the remote object and the local object belong to different devices,
     * and when the remote object leaves the network.
     * </p>
     *
     * @typedef DeathRecipient
     * @syscap SystemCapability.Communication.IPC.Core
     * @since 20
     */
    interface DeathRecipient {
        /**
         * Called to perform subsequent operations when a death notification of the remote object is received.
         *
         * @syscap SystemCapability.Communication.IPC.Core
         * @since 20
         */
        onRemoteDied(): void;
    }
    
    /**
     * Public Message Option, using the specified flag type, constructs the specified MessageOption object.
     *
     * @syscap SystemCapability.Communication.IPC.Core
     * @since 20
     */
    class MessageOption {
        /**
         * Indicates synchronous call.
         *
         * @type { int }
         * @default 0
         * @static
         * @syscap SystemCapability.Communication.IPC.Core
         * @since 20
         */
        static TF_SYNC: int;
        /**
         * Indicates asynchronous call.
         *
         * @type { int }
         * @default 1
         * @static
         * @syscap SystemCapability.Communication.IPC.Core
         * @since 20
         */
        static TF_ASYNC: int;
        
        /**
         * Indicates the wait time for RPC, in seconds. It is NOT used in IPC case.
         *
         * @type { int }
         * @default 8
         * @static
         * @syscap SystemCapability.Communication.IPC.Core
         * @since 20
         */
        static TF_WAIT_TIME: int;
        /**
         * A constructor used to create a MessageOption instance.
         *
         * @param { int } syncFlags - Specifies whether the SendRequest is called synchronously (default) or asynchronously.
         * @param { int } waitTime - Maximum wait time for a RPC call. The default value is TF_WAIT_TIME.
         * @syscap SystemCapability.Communication.IPC.Core
         * @since 20
         */
        constructor(syncFlags?: int, waitTime?: int);
        /**
         * A constructor used to create a MessageOption instance.
         *
         * @param { boolean } isAsync - Specifies whether the SendRequest is called synchronously (default) or asynchronously.
         * @syscap SystemCapability.Communication.IPC.Core
         * @since 20
         */
        constructor(isAsync: boolean);
        /**
         * Obtains the SendRequest call flag, which can be synchronous or asynchronous.
         *
         * @returns { boolean } Return {@code true} if the asynchronous call succeeds;
         *                      return {@code false} if the synchronous call succeeds.
         * @syscap SystemCapability.Communication.IPC.Core
         * @since 20
         */
        isAsync(): boolean;
        /**
         * Sets the SendRequest call flag, which can be synchronous or asynchronous.
         *
         * @param { boolean } isAsync - Indicates the call flag, which can be synchronous or asynchronous.
         * @syscap SystemCapability.Communication.IPC.Core
         * @since 20
         */
        setAsync(isAsync: boolean): void;
    }
    
    /**
     * Implement remote objects. The service provider must inherit this class.
     *
     * @extends IRemoteObject
     * @syscap SystemCapability.Communication.IPC.Core
     * @since 20
     */
    class RemoteObject extends IRemoteObject {
        /**
         * A constructor to create a RemoteObject instance.
         *
         * @param { string } descriptor - Specifies interface descriptor.
         * @syscap SystemCapability.Communication.IPC.Core
         * @since 20
         */
        constructor(descriptor: string);
        /**
         * Queries an interface descriptor.
         *
         * @returns { string } Return the interface descriptor.
         * @throws { BusinessError } 1900008 - The proxy or remote object is invalid.
         * @syscap SystemCapability.Communication.IPC.Core
         * @since 20
         */
        getDescriptor(): string;
        /**
         * Sets an entry for receiving requests.
         * <p>This method is implemented by the remote service provider. You need to override this method with
         * your own service logic when you are using IPC.
         *
         * @param { int } code - Indicates the service request code sent from the peer end.
         * @param { MessageSequence } data - Indicates the {@link MessageSequence} object sent from the peer end.
         * @param { MessageSequence } reply - Indicates the response message object sent from the remote service.
         * The local service writes the response data to the {@link MessageSequence} object.
         * @param { MessageOption } options - Indicates whether the operation is synchronous or asynchronous.
         * @returns { boolean | Promise<boolean> }
         * Return a simple boolean which is {@code true} if the operation succeeds;
         * {{@code false} otherwise} when the function call is synchronous.
         * Return a promise object with a boolean when the function call is asynchronous.
         * @syscap SystemCapability.Communication.IPC.Core
         * @since 20
         */
        onRemoteMessageRequest(code: int, data: MessageSequence, reply: MessageSequence, options: MessageOption): boolean | Promise<boolean>;
        /**
         * Sends a {@link MessageSequence} message to the peer process in synchronous or asynchronous mode.
         * <p>If options indicates the asynchronous mode, a promise will be fulfilled immediately
         * and the reply message does not contain any content. If options indicates the synchronous mode,
         * a promise will be fulfilled when the response to sendMessageRequest is returned,
         * and the reply message contains the returned information.
         *
         * @param { int } code - Message code called by the request, which is determined by the client and server.
         * If the method is generated by an IDL tool, the message code is automatically generated by the IDL tool.
         * @param { MessageSequence } data - {@link MessageSequence} object holding the data to send.
         * @param { MessageSequence } reply - {@link MessageSequence} object that receives the response.
         * @param { MessageOption } options - Indicates the synchronous or asynchronous mode to send messages.
         * @returns { Promise<RequestResult> } Promise used to return the {@link RequestResult} instance.
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         *     1.The number of parameters is incorrect;
         *     2.The parameter type does not match;
         *     3.Failed to obtain the passed object instance.
         * @syscap SystemCapability.Communication.IPC.Core
         * @since 20
         */
        sendMessageRequest(code: int, data: MessageSequence, reply: MessageSequence, options: MessageOption): Promise<RequestResult>;
        /**
         * Sends a {@link MessageSequence} message to the peer process in synchronous or asynchronous mode.
         * <p>If options indicates the asynchronous mode, a callback will be invoked immediately
         * and the reply message does not contain any content. If options indicates the synchronous mode,
         * a callback will be invoked when the response to sendMessageRequest is returned,
         * and the reply message contains the returned information.
         *
         * @param { int } code - Message code called by the request, which is determined by the client and server.
         * If the method is generated by an IDL tool, the message code is automatically generated by the IDL tool.
         * @param { MessageSequence } data - {@link MessageSequence} object holding the data to send.
         * @param { MessageSequence } reply - {@link MessageSequence} object that receives the response.
         * @param { MessageOption } options - Indicates the synchronous or asynchronous mode to send messages.
         * @param { AsyncCallback<RequestResult> } callback - Callback for receiving the sending result.
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         *     1.The number of parameters is incorrect;
         *     2.The parameter type does not match;
         *     3.Failed to obtain the passed object instance.
         * @syscap SystemCapability.Communication.IPC.Core
         * @since 20
         */
        sendMessageRequest(code: int, data: MessageSequence, reply: MessageSequence, options: MessageOption, callback: AsyncCallback<RequestResult>): void;
        /**
         * Obtains the PID of the {@link RemoteProxy} object.
         *
         * @returns { int } Return the PID of the {@link RemoteProxy} object.
         * @syscap SystemCapability.Communication.IPC.Core
         * @since 20
         */
        getCallingPid(): int;
        /**
         * Obtains the UID of the {@link RemoteProxy} object.
         *
         * @returns { int } Return the UID of the {@link RemoteProxy} object.
         * @syscap SystemCapability.Communication.IPC.Core
         * @since 20
         */
        getCallingUid(): int;
    }
    
    /**
     * Implement the IRemoteObject proxy object.
     *
     * @extends IRemoteObject
     * @syscap SystemCapability.Communication.IPC.Core
     * @since 20
     */
    class RemoteProxy extends IRemoteObject {
        /**
         * Register a callback used to receive death notifications of a remote object.
         *
         * @param { DeathRecipient } recipient - Indicates the callback to be registered.
         * @param { int } flags - Indicates the flag of the death notification. This is a reserved parameter.
         *                   Set it to {@code 0}.
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         *     1.The number of parameters is incorrect;
         *     2.The parameter type does not match;
         *     3.The callback used to receive remote object death notifications is empty.
         * @throws { BusinessError } 1900008 - The proxy or remote object is invalid.
         * @syscap SystemCapability.Communication.IPC.Core
         * @since 20
         */
        registerDeathRecipient(recipient: DeathRecipient, flags: int): void;
        /**
         * Unregister a callback used to receive death notifications of a remote object.
         *
         * @param { DeathRecipient } recipient - Indicates the callback to be unregister.
         * @param { int } flags - Indicates the flag of the death notification. This is a reserved parameter.
         *                   Set it to {@code 0}.
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         *     1.The number of parameters is incorrect;
         *     2.The parameter type does not match;
         *     3.The callback used to receive remote object death notifications is empty.
         * @throws { BusinessError } 1900008 - The proxy or remote object is invalid.
         * @syscap SystemCapability.Communication.IPC.Core
         * @since 20
         */
        unregisterDeathRecipient(recipient: DeathRecipient, flags: int): void;
        /**
         * Queries the interface descriptor of remote object.
         *
         * @returns { string } Return the interface descriptor.
         * @throws { BusinessError } 1900007 - communication failed.
         * @throws { BusinessError } 1900008 - The proxy or remote object is invalid.
         * @syscap SystemCapability.Communication.IPC.Core
         * @since 20
         */
        getDescriptor(): string;
        /**
         * Sends a {@link MessageSequence} message to the peer process in synchronous or asynchronous mode.
         * <p>If options indicates the asynchronous mode, a promise will be fulfilled immediately
         * and the reply message does not contain any content. If options indicates the synchronous mode,
         * a promise will be fulfilled when the response to sendMessageRequest is returned,
         * and the reply message contains the returned information.
         *
         * @param { int } code - Message code called by the request, which is determined by the client and server.
         * If the method is generated by an IDL tool, the message code is automatically generated by the IDL tool.
         * @param { MessageSequence } data - {@link MessageSequence} object holding the data to send.
         * @param { MessageSequence } reply - {@link MessageSequence} object that receives the response.
         * @param { MessageOption } options - Indicates the synchronous or asynchronous mode to send messages.
         * @returns { Promise<RequestResult> } Promise used to return the {@link RequestResult} instance.
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         *     1.The number of parameters is incorrect;
         *     2.The parameter type does not match;
         *     3.Failed to obtain the passed object instance.
         * @syscap SystemCapability.Communication.IPC.Core
         * @since 20
         */
        sendMessageRequest(code: int, data: MessageSequence, reply: MessageSequence, options: MessageOption): Promise<RequestResult>;
        /**
         * Sends a {@link MessageSequence} message to the peer process in synchronous or asynchronous mode.
         * <p>If options indicates the asynchronous mode, a callback will be invoked immediately
         * and the reply message does not contain any content. If options indicates the synchronous mode,
         * a callback will be invoked when the response to sendRequest is returned,
         * and the reply message contains the returned information.
         *
         * @param { int } code - Message code called by the request, which is determined by the client and server.
         * If the method is generated by an IDL tool, the message code is automatically generated by the IDL tool.
         * @param { MessageSequence } data - {@link MessageSequence} object holding the data to send.
         * @param { MessageSequence } reply - {@link MessageSequence} object that receives the response.
         * @param { MessageOption } options - Indicates the synchronous or asynchronous mode to send messages.
         * @param { AsyncCallback<RequestResult> } callback - Callback for receiving the sending result.
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         *     1.The number of parameters is incorrect;
         *     2.The parameter type does not match;
         *     3.Failed to obtain the passed object instance.
         * @syscap SystemCapability.Communication.IPC.Core
         * @since 20
         */
        sendMessageRequest(code: int, data: MessageSequence, reply: MessageSequence, options: MessageOption, callback: AsyncCallback<RequestResult>): void;
        /**
         * Checks whether the {@code RemoteObject} corresponding to a {@code RemoteProxy} is dead.
         *
         * @returns { boolean } Return {@code true} if the {@code RemoteObject} is dead; return {@code false} otherwise.
         * @syscap SystemCapability.Communication.IPC.Core
         * @since 20
         */
        isObjectDead(): boolean;
    }
    
    /**
     * Used to obtain IPC context information, including obtaining the UID and PID, obtaining the local and
     * peer device IDs, and checking whether the API call is on the same device.
     *
     * @syscap SystemCapability.Communication.IPC.Core
     * @since 20
     */
    class IPCSkeleton {
        /**
         * Obtains a local {@link IRemoteObject} reference of a registered service.
         * <p>This method is static.
         *
         * @returns { IRemoteObject } Return an {@link IRemoteObject} reference of the registered service.
         * @syscap SystemCapability.Communication.IPC.Core
         * @since 20
         */
        static getContextObject(): IRemoteObject;
        /**
         * Obtains the PID of a proxy.
         * <p>This method is static. The PID is a positive integer during the communication between
         * the {@link RemoteProxy} object and {@link RemoteObject} object, and resumes to {@code 0}
         * when the communication ends. If this method is called from the {@link RemoteProxy} object,
         * {@code 0} is returned; if this method is called from the {@link RemoteObject} object,
         * the PID of the corresponding {@link RemoteProxy} object is returned.
         *
         * @returns { int } Return the PID of the proxy.
         * @static
         * @syscap SystemCapability.Communication.IPC.Core
         * @since 20
         */
        static getCallingPid(): int;
        /**
         * Obtains the UID of a proxy.
         * <p>This method is static. The UID is a positive integer during the communication between
         * the {@link RemoteProxy} object and {@link RemoteObject} object, and resumes to {@code 0}
         * when the communication ends. If this method is called from the {@link RemoteProxy} object,
         * {@code 0} is returned; if this method is called from the {@link RemoteObject} object,
         * the UID of the corresponding {@link RemoteProxy} object is returned.
         *
         * @returns { int } Return the UID of the proxy.
         * @static
         * @syscap SystemCapability.Communication.IPC.Core
         * @since 20
         */
        static getCallingUid(): int;
        /**
         * Obtains the TOKENID.
         * <p>This method is static.
         *
         * @returns { long } Return the TOKENID.
         * @static
         * @syscap SystemCapability.Communication.IPC.Core
         * @since 20
         */
        static getCallingTokenId(): long;
    }
    /**
     * Provides methods related to anonymous shared memory objects,
     * including creating, closing, mapping, and unmapping an Ashmem object,
     * reading data from and writing data to an Ashmem object,
     * obtaining the Ashmem size, and setting Ashmem protection.
     *
     * @syscap SystemCapability.Communication.IPC.Core
     * @since 20
     */
    class Ashmem {
        /**
         * Creates an Ashmem object with the specified name and size.
         *
         * @param { string } name - Name of the Ashmem object to create.
         * @param { int } size - Size (in bytes) of the Ashmem object to create.
         * @returns { Ashmem } Return the Ashmem object if it is created successfully; return null otherwise.
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         *     1.The number of parameters is incorrect;
         *     2.The parameter type does not match;
         *     3.The Ashmem name passed is empty;
         *     4.The Ashmem size passed is less than or equal to 0.
         * @static
         * @syscap SystemCapability.Communication.IPC.Core
         * @since 20
         */
        static create(name: string, size: int): Ashmem;
        /**
         * Creates an Ashmem object by copying the file descriptor (FD) of an existing Ashmem object.
         * The two Ashmem objects point to the same shared memory region.
         *
         * @param { Ashmem } ashmem - Existing Ashmem object.
         * @returns { Ashmem } Ashmem object created.
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         *     1.The number of parameters is incorrect;
         *     2.The passed parameter is not an Ahmem object;
         *     3.The ashmem instance for obtaining packaging is empty.
         * @syscap SystemCapability.Communication.IPC.Core
         * @since 20
         */
        static create(ashmem: Ashmem): Ashmem;
        /**
         * Obtains the mapped memory size of this Ashmem object.
         *
         * @returns { int } Memory size mapped.
         * @syscap SystemCapability.Communication.IPC.Core
         * @since 20
         */
        getAshmemSize(): int;
        /**
         * Maps the shared file to the readable and writable virtual address space of the process.
         *
         * @throws { BusinessError } 1900001 - Failed to call mmap.
         * @syscap SystemCapability.Communication.IPC.Core
         * @since 20
         */
        mapReadWriteAshmem(): void;
    }
}
export default rpc;
