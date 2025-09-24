/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
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

import fs from 'node:fs';
import path from 'node:path'
import { program } from 'commander';

// is not used, some operators cannot be splitted by line break
function splitLongLines(inputLines) {
    let outputLines = []
    let inSingleLineComment = false
    let inMultiLineComment = false
    let inBackQuotes = false
    let inSingleQuotes = false
    let inDoubleQuotes = false
    let prevSlash = false
    let prevBackSlash = false
    let prevStar = false
    for (const line of inputLines) {
        const indentation = Math.max(line.search(/\S/), 0)
        const longIndentation = indentation + 4
        let currIndentation = indentation
        let outputLine = line.substring(0, indentation)
        let curr_word = ''
        for (let i = indentation; i < line.length; i++) {
            const isSpace = /\s/.test(line[i])
            if (inSingleQuotes || inDoubleQuotes || !isSpace) {
                curr_word += line[i]
            } else {
                let expectedLen = outputLine.length + curr_word.length
                const isFirstWord = outputLine.length <= currIndentation
                if (!isFirstWord) {
                    expectedLen += 1
                }
                let line_splitted = false
                if (expectedLen > 120) {
                    let expectedNewLineLen = longIndentation + curr_word.length
                    if (inSingleLineComment) {
                        expectedNewLineLen += 3
                    }
                    if (expectedNewLineLen < expectedLen) {
                        outputLines.push(outputLine)
                        currIndentation = longIndentation
                        outputLine  = ' '.repeat(currIndentation)
                        if (inSingleLineComment) {
                            outputLine += '// '
                        }
                        line_splitted = true
                    }
                }
                if (!line_splitted && !isFirstWord) {
                    outputLine += ' '
                }
                outputLine += curr_word
                curr_word = ''
            }
            if (line[i] === '/') {
                if (prevSlash) {
                    if (!inMultiLineComment && !inBackQuotes && !inSingleQuotes && !inDoubleQuotes) {
                        inSingleLineComment = true
                    }
                } else if (prevStar) {
                    inMultiLineComment = false
                }
                prevSlash = true
                prevBackSlash = false
                prevStar = false
            } else if (line[i] === '*') {
                if (prevSlash) {
                    if (!inSingleLineComment && ! inBackQuotes && !inSingleQuotes && !inDoubleQuotes) {
                        inMultiLineComment = true
                    }
                } else {
                    prevStar = true
                }
                prevSlash = false
                prevBackSlash = false
            } else if (line[i] === '\\') {
                if (inBackQuotes || inSingleQuotes || inDoubleQuotes) {
                    prevBackSlash = !prevBackSlash
                }
                prevSlash = false
                prevStar = false
            } else if (line[i] === '`') {
                if (!prevBackSlash && !inSingleLineComment && !inMultiLineComment && !inSingleQuotes && !inDoubleQuotes) {
                    inBackQuotes = !inBackQuotes
                }
                prevSlash = false
                prevBackSlash = false
                prevStar = false
            } else if (line[i] === "'") {
                if (!prevBackSlash && !inSingleLineComment && !inMultiLineComment && !inBackQuotes && !inDoubleQuotes) {
                    inSingleQuotes = !inSingleQuotes
                }
                prevSlash = false
                prevBackSlash = false
                prevStar = false
            } else if (line[i] === '"') {
                if (!prevBackSlash && !inSingleLineComment && !inMultiLineComment && !inBackQuotes && !inSingleQuotes) {
                    inDoubleQuotes = !inDoubleQuotes
                }
                prevSlash = false
                prevBackSlash = false
                prevStar = false
            } else {
                prevSlash = false
                prevBackSlash = false
                prevStar = false
            }
        }
        if (curr_word) {
            let expectedLen = outputLine.length + curr_word.length
            const isFirstWord = outputLine.length <= currIndentation
            if (!isFirstWord) {
                expectedLen += 1
            }
            let line_splitted = false
            if (expectedLen > 120) {
                let expectedNewLineLen = longIndentation + curr_word.length
                if (inSingleLineComment) {
                    expectedNewLineLen += 3
                }
                if (expectedNewLineLen < expectedLen) {
                    outputLines.push(outputLine)
                    outputLine  = ' '.repeat(longIndentation)
                    if (inSingleLineComment) {
                        outputLine += '// ' + curr_word
                    }
                    line_splitted = true
                }
            }
            if (!line_splitted && !isFirstWord) {
                outputLine += ' '
            }
            outputLine += curr_word
        }
        outputLines.push(outputLine)
        inSingleLineComment = false
        inSingleQuotes = false
        inDoubleQuotes = false
        prevSlash = false
        prevBackSlash = false
        prevStar = false
    }
    return outputLines
}

function upCurly(inputLines) {
    let prevLineNeedsCurly = false
    let prevCurlyNeeder = ''
    let outputLines = []
    const patterns = [
        /^\s*if\s*\(/,
        /^\s*else\s*$/,
        /^\s*}\s*else\s*$/
    ]
    for (const line of inputLines) {
        const needsCurly = patterns.some(p => p.test(line))
        let isOpeningCurlyLine = (/^\s*{\s*$/).test(line)
        if (prevLineNeedsCurly) {
            if (isOpeningCurlyLine) {
                outputLines.push(prevCurlyNeeder + ' {')
                prevLineNeedsCurly = false
                continue
            }
            outputLines.push(prevCurlyNeeder)
        }
        prevLineNeedsCurly = needsCurly
        if (needsCurly) {
            prevCurlyNeeder = line
        } else {
            outputLines.push(line)
        }
    }
    if (prevLineNeedsCurly) {
        outputLines.push(prevCurlyNeeder)
    }
    return outputLines
}

function processFile(inputFile, outputFile) {
    const contents = fs.readFileSync(inputFile).toString()
    const lines = contents.split('\n')
    const outputLines = upCurly(lines)
    
    fs.writeFileSync(outputFile, outputLines.join('\n'))
}

function main() {
    const options = program
        .option(`--input-dir <path>`, 'directory with input files')
        .option(`--output-dir <path>`, 'directory for processed output files', "")
        .option(`--inplace`, 'whether to replace input files by formatted', false)
        .parse()
        .opts()
    const inputDir = path.resolve(process.cwd(), options.inputDir)
    let outputDir = inputDir
    if (options.outputDir) {
        outputDir = path.resolve(process.cwd(), options.outputDir)
    } else if (!options.inplace) {
        errorAndExit(`Output directory is not specified and --inplace parameter is not provided`)
    }

    if (!inputDir || !fs.existsSync(inputDir))
        errorAndExit(`input-dir ${inputDir} does not exists`)

    if (!outputDir || !fs.existsSync(outputDir))
        errorAndExit(`output-dir ${outputDir} does not exists`)

    const files = fs.readdirSync(inputDir, {
        recursive: true
    })
    for (const file of files) {
        const inputFilePath = path.resolve(inputDir, file)
        const outputFilePath = path.resolve(outputDir, file)
        if (fs.lstatSync(inputFilePath).isFile()) {
            const dirName = path.dirname(outputFilePath)
            fs.mkdirSync(dirName, { recursive: true })
            processFile(inputFilePath, outputFilePath)
        }
    }
}

main()
