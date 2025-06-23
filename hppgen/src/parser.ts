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

export interface Node {
    kind: string
    content: string[]
    line: number
    children: Node[]
}

//////////////////////////////////////////////////////////////////////

function split(line:string): string[] {
    const result: string[] = []
    const modes: ('string' | 'global' | 'brackets' | 'nested_brackets')[] = ['global']
    let buffer: string = ''
    for (let letter of line) {
        const mode = modes.at(-1)!
        switch (mode) {
            case 'nested_brackets': {
                buffer += letter
                if (letter === '<') {
                    modes.push('nested_brackets')
                }
                if (letter === '>') {
                    modes.pop()
                }
                break
            }
            case 'brackets': {
                buffer += letter
                if (letter === '<') {
                    modes.push('nested_brackets')
                    continue
                }
                if (letter === '>') {
                    result.push(buffer)
                    buffer = ''
                    modes.pop()
                    continue
                }
                break
            }
            case 'string': {
                buffer += letter
                if (letter === "'") {
                    result.push(buffer)
                    buffer = ''
                    modes.pop()
                    continue
                }
                break
            }
            case 'global': {
                if (letter === "'") {
                    result.push(buffer)
                    buffer = "'"
                    modes.push('string')
                    continue
                }
                if (letter === '<') {
                    result.push(buffer)
                    buffer = letter
                    modes.push('brackets')
                    continue
                }
                if (letter === " ") {
                    result.push(buffer)
                    buffer = ''
                    continue
                }
                buffer += letter
                break
            }
        }
    }

    result.push(buffer)
    return result.filter(x => x.length)
}

function parseNode(text:string, line:number, begin:number): [Node, number] {
    let kind = ''
    while (/[a-zA-Z_]/.test(text[begin]) && begin < text.length) {
        kind += text[begin]
        ++begin
    }

    let content = ''
    while (text[begin] !== '\n' && begin < text.length) {
        content += text[begin]
        ++begin
    }
    return [
        {
            kind,
            content: split(content),
            line,
            children: []
        },
        begin
    ]
}

export function parseAstDump(content:string): Node {

    // collect
    const parsed: [Node, number][] = []

    let line = 0
    let ptr = 0
    while (ptr < content.length) {
        ++line
        if (parsed.length === 0) {
            const [node, next] = parseNode(content, line, ptr)
            parsed.push([node, 0])
            ptr = next + 1
            continue
        }

        let indent = 0
        while (ptr < content.length && content[ptr++] !== '-') {
            ++indent
        }
        if (ptr === content.length) {
            throw new Error("Unexpected end")
        }

        let [ node, next ] = parseNode(content, line, ptr)
        ptr = next + 1

        while (parsed.length && parsed.at(-1)![1] >= indent) {
            parsed.at(-2)![0].children.push(parsed.at(-1)![0])
            parsed.pop()
        }
        parsed.push([node, indent])
    }

    const root = parsed[0][0]
    let current = root
    for (let i = 1; i < parsed.length; ++i) {
        current.children.push(parsed[i][0])
        current = parsed[i][0]
    }

    return root
}
