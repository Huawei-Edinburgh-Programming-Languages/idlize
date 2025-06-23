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

import { Node } from "./parser"

export enum NodeKind {
    Interface = 100,
    Method    = 101,
    Parameter = 103,
}

export interface InterfaceNode {
    kind: NodeKind.Interface
    isDefinition: boolean
    name: string
    sort: 'class' | 'struct'
    extends: string[]
    members: AstNode[]
}
export interface MethodNode {
    kind: NodeKind.Method
    name: string
    parameters: ParameterNode[]
    returnType: string
}
export interface ParameterNode {
    kind: NodeKind.Parameter
    name: string
    type: string
}

export type AstNode =
      InterfaceNode
    | MethodNode
    | ParameterNode

//////////////////////////////////////////////////////////////////////


class ContentCrawler {
    private position: number = 0
    constructor(
        private content: string[]
    ) {}

    get current() {
        return this.content[this.position]
    }

    hasNext(): boolean {
       return this.position < this.content.length
    }
    skip() {
        this.position++
    }
    skipIf(token:string, length = 1) {
        if (this.current === token) {
            for (let i = 0; i < length; ++i) {
                this.skip()
            }
        }
    }
    skipUntil(tokens:string[] | string) {
        const expected = new Set(Array.isArray(tokens) ? tokens : [tokens])
        while (this.position < this.content.length && !expected.has(this.content[this.position])) {
            ++this.position
        }
    }
    skipWhile(tokens:string[] | string) {
        const expected = new Set(Array.isArray(tokens) ? tokens : [tokens])
        while (this.position < this.content.length && expected.has(this.content[this.position])) {
            ++this.position
        }
    }
    take() {
        return this.content[this.position++]
    }
    consume(token:string): boolean {
        if (this.current === token) {
            this.take()
            return true
        }
        return false
    }
}

function crawler(content:string[]): ContentCrawler {
    return new ContentCrawler(content)
}

function parseReturnType(signature:string): string {
    let stack: string[] = []
    let i = signature.length - 1
    for (; i >= 0; --i) {
        const letter = signature[i]
        if (letter === ')') {
            stack.push(')')
        }
        if (letter === '(') {
            stack.pop()
            if (stack.length === 0) {
                break
            }
        }
    }
    return signature.slice(0, i).trim() + "'"
}

export function toAST(root:Node): AstNode[] {
    switch (root.kind) {
        case 'TranslationUnitDecl': {
            return root.children.flatMap(toAST)
        }
        case 'CXXRecordDecl': {
            const content = crawler(root.content)
            content.skipUntil(['class'])
            const sort = content.take() as 'class'
            const name = content.take()
            const isDefinition = content.consume('definition')
            return [{
                kind: NodeKind.Interface,
                sort,
                name,
                isDefinition,
                extends: root.children
                    .filter(x => x.kind === 'public')
                    .map(x => x.content[0]),
                members: root.children.flatMap(toAST),
            }]
        }
        case 'CXXMethodDecl': {
            const content = crawler(root.content)
            content.take() // id
            content.take() // location 1
            content.take() // location 2
            content.skipWhile([
                'implicit',
                'constexpr'
            ])
            const name = content.take()
            const signature = content.take()
            const parameters = root.children.flatMap(toAST) as ParameterNode[]
            parameters.forEach((param, i) => {
                if (param.name === '') {
                    param.name = '_arg' + i
                }
            })
            const returnType = parseReturnType(signature)
            return [{
                kind: NodeKind.Method,
                name,
                parameters,
                returnType
            }]
        }
        case 'ParmVarDecl': {
            const content = crawler(root.content)
            content.take() // id
            content.take() // location 1
            content.take() // location 2

            let name = ''
            let type = ''
            const first = content.take()
            if (first.startsWith("'")) {
                type = first
            } else {
                name = first
                type = content.take()
            }

            return [{
                kind: NodeKind.Parameter,
                name,
                type
            }]
        }
    }
    return []
}
