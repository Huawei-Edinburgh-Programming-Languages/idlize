"use strict";
/*
 * Copyright (c) 2024 Huawei Device Co., Ltd.
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
var __extends = (this && this.__extends) || (function () {
    var extendStatics = function (d, b) {
        extendStatics = Object.setPrototypeOf ||
            ({ __proto__: [] } instanceof Array && function (d, b) { d.__proto__ = b; }) ||
            function (d, b) { for (var p in b) if (Object.prototype.hasOwnProperty.call(b, p)) d[p] = b[p]; };
        return extendStatics(d, b);
    };
    return function (d, b) {
        if (typeof b !== "function" && b !== null)
            throw new TypeError("Class extends value " + String(b) + " is not a constructor or null");
        extendStatics(d, b);
        function __() { this.constructor = d; }
        d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
    };
})();
var __read = (this && this.__read) || function (o, n) {
    var m = typeof Symbol === "function" && o[Symbol.iterator];
    if (!m) return o;
    var i = m.call(o), r, ar = [], e;
    try {
        while ((n === void 0 || n-- > 0) && !(r = i.next()).done) ar.push(r.value);
    }
    catch (error) { e = { error: error }; }
    finally {
        try {
            if (r && !r.done && (m = i["return"])) m.call(i);
        }
        finally { if (e) throw e.error; }
    }
    return ar;
};
var __spreadArray = (this && this.__spreadArray) || function (to, from, pack) {
    if (pack || arguments.length === 2) for (var i = 0, l = from.length, ar; i < l; i++) {
        if (ar || !(i in from)) {
            if (!ar) ar = Array.prototype.slice.call(from, 0, i);
            ar[i] = from[i];
        }
    }
    return to.concat(ar || Array.prototype.slice.call(from));
};
exports.__esModule = true;
exports.ArrayDecoder = exports.withByteArray = exports.withUint8Array = exports.Access = exports.withStringResult = exports.providePlatformDefinedData = exports.nullptr = exports.NativeStringBase = exports.Wrapper = exports.CustomTextDecoder = exports.ptrToString = exports.className = exports.isNullPtr = exports.decodeToString = void 0;
function decodeToString(array) {
    return decoder.decode(array);
}
exports.decodeToString = decodeToString;
function isNullPtr(value) {
    return value === exports.nullptr;
}
exports.isNullPtr = isNullPtr;
function className(object) {
    var _a;
    return (_a = object === null || object === void 0 ? void 0 : object.constructor.name) !== null && _a !== void 0 ? _a : "<null>";
}
exports.className = className;
function ptrToString(ptr) {
    return "0x".concat(ptr.toString(16).padStart(8, "0"));
}
exports.ptrToString = ptrToString;
var CustomTextDecoder = /** @class */ (function () {
    function CustomTextDecoder(decoder) {
        this.decoder = decoder !== null && decoder !== void 0 ? decoder : new TextDecoder();
    }
    CustomTextDecoder.prototype.decode = function (input) {
        if (this.decoder !== undefined) {
            return this.decoder.decode(input);
        }
        var cpSize = Math.min(CustomTextDecoder.cpArrayMaxSize, input.length);
        var codePoints = new Int32Array(cpSize);
        var cpIndex = 0;
        var index = 0;
        var result = "";
        while (index < input.length) {
            var elem = input[index];
            var lead = elem & 0xff;
            var count = 0;
            var value = 0;
            if (lead < 0x80) {
                count = 1;
                value = elem;
            }
            else if ((lead >> 5) == 0x6) {
                value = ((elem << 6) & 0x7ff) + (input[index + 1] & 0x3f);
                count = 2;
            }
            else if ((lead >> 4) == 0xe) {
                value = ((elem << 12) & 0xffff) + ((input[index + 1] << 6) & 0xfff) +
                    (input[index + 2] & 0x3f);
                count = 3;
            }
            else if ((lead >> 3) == 0x1e) {
                value = ((elem << 18) & 0x1fffff) + ((input[index + 1] << 12) & 0x3ffff) +
                    ((input[index + 2] << 6) & 0xfff) + (input[index + 3] & 0x3f);
                count = 4;
            }
            codePoints[cpIndex++] = value;
            if (cpIndex == cpSize) {
                cpIndex = 0;
                result += String.fromCodePoint.apply(String, __spreadArray([], __read(codePoints), false));
            }
            index += count;
        }
        if (cpIndex > 0) {
            result += String.fromCodePoint.apply(String, __spreadArray([], __read(codePoints.slice(0, cpIndex)), false));
        }
        return result;
    };
    CustomTextDecoder.cpArrayMaxSize = 128;
    return CustomTextDecoder;
}());
exports.CustomTextDecoder = CustomTextDecoder;
var decoder = new CustomTextDecoder();
var Wrapper = /** @class */ (function () {
    function Wrapper(ptr) {
        if (ptr == null)
            throw new Error("Init <".concat(className(this), "> with null native peer"));
        this.ptr = ptr;
    }
    Wrapper.prototype.toString = function () {
        return "[native object <".concat(className(this), "> at ").concat(ptrToString(this.ptr), "]");
    };
    return Wrapper;
}());
exports.Wrapper = Wrapper;
var NativeStringBase = /** @class */ (function (_super) {
    __extends(NativeStringBase, _super);
    function NativeStringBase(ptr) {
        return _super.call(this, ptr) || this;
    }
    NativeStringBase.prototype.toString = function () {
        var length = this.bytesLength();
        var data = new Uint8Array(length);
        this.getData(data);
        return decodeToString(data);
    };
    return NativeStringBase;
}(Wrapper));
exports.NativeStringBase = NativeStringBase;
exports.nullptr = BigInt(0);
var platformData = undefined;
function providePlatformDefinedData(platformDataParam) {
    platformData = platformDataParam;
}
exports.providePlatformDefinedData = providePlatformDefinedData;
function withStringResult(ptr) {
    if (isNullPtr(ptr))
        return undefined;
    var managedString = platformData.nativeString(ptr);
    var result = managedString === null || managedString === void 0 ? void 0 : managedString.toString();
    managedString === null || managedString === void 0 ? void 0 : managedString.close();
    return result;
}
exports.withStringResult = withStringResult;
var Access;
(function (Access) {
    Access[Access["READ"] = 1] = "READ";
    Access[Access["WRITE"] = 2] = "WRITE";
    Access[Access["READWRITE"] = 3] = "READWRITE";
})(Access = exports.Access || (exports.Access = {}));
function withArray(data, exec) {
    var _a;
    return exec(data !== null && data !== void 0 ? data : null, (_a = data === null || data === void 0 ? void 0 : data.length) !== null && _a !== void 0 ? _a : 0);
}
function withUint8Array(data, access, exec) {
    return withArray(data, exec);
}
exports.withUint8Array = withUint8Array;
exports.withByteArray = withUint8Array;
var ArrayDecoder = /** @class */ (function () {
    function ArrayDecoder() {
    }
    ArrayDecoder.prototype.decode = function (blob) {
        throw new Error("TODO");
    };
    return ArrayDecoder;
}());
exports.ArrayDecoder = ArrayDecoder;
