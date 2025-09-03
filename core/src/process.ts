
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

import { IDLNode } from "./idl"
import { ProcessingFatal } from "./diagnosticmessages"
import { DiagnosticMessage } from "./diagnostictypes"

export class FatalGenerationException extends Error {
    diagnosticMessages?: DiagnosticMessage[]
    constructor(diagnosticMessages?: DiagnosticMessage[]) {
        super()
        this.diagnosticMessages = diagnosticMessages
    }
}

export function terminateWithPanic(msg:DiagnosticMessage|DiagnosticMessage[]): never {
    throw new FatalGenerationException(Array.isArray(msg) ? msg : [msg])
}

function optionToArray<T>(x:T | undefined): T[] {
    if (x === undefined) {
        return []
    }
    return [x]
}

export const reportError = {
    fromNode: (node:IDLNode, msg?:string): DiagnosticMessage => ProcessingFatal.reportDiagnosticMessage(optionToArray(node.nodeLocation), msg)
}
