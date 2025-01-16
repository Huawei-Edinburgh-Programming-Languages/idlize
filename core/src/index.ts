import { fromIDL } from "./from-idl/common"

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
export * from "./config"
export * from "./idl"
export * from "./idlize"
export * from "./inheritance"
export * from "./Language"
export * from "./languageSpecificKeywords"
export * from "./options"
export * from "./util"
export * from "./IndentedPrinter"
export * from "./peer-generation/LanguageWriters/LanguageWriter"
export * from "./peer-generation/LanguageWriters/ArgConvertors"
export * from "./peer-generation/LanguageWriters/common"
export * from "./peer-generation/LanguageWriters/nameConvertor"
export * from "./peer-generation/LanguageWriters/writers/CJLanguageWriter"
export * from "./peer-generation/LanguageWriters/writers/CLikeLanguageWriter"
export * from "./peer-generation/LanguageWriters/writers/CppLanguageWriter"
export * from "./peer-generation/LanguageWriters/writers/JavaLanguageWriter"
export * from "./peer-generation/LanguageWriters/writers/TsLanguageWriter"
export * from "./peer-generation/PrimitiveType"

export * from "./peer-generation/LanguageWriters"
export * from "./peer-generation/ReferenceResolver"
export * from "./peer-generation/idl/common"
export { fromIDL }  from "./from-idl/common"
export { idlToDtsString, CustomPrintVisitor }  from "./from-idl/DtsPrinter"
export { toIDL, addSyntheticType, resolveSyntheticType } from "./from-idl/deserialize"

