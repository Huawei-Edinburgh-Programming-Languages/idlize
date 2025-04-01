import { EOL } from "node:os";
import * as idl from "../idl"
import { convertNode, NodeConvertor } from "../LanguageWriters";
import { ReferenceResolver } from "../peer-generation/ReferenceResolver";
import { IDLTokenInfoMap } from "./deserialize";

export interface IDLLinterOptions {
    validEntryAttributes: Map<idl.IDLKind, string[]>,
    checkEnumsConsistency: boolean,
    checkReferencesResolved: boolean,
}

export class IDLLinter {
    constructor(
        protected file: idl.IDLFile,
        protected resolver: ReferenceResolver,
        protected options: IDLLinterOptions,
        protected info?: IDLTokenInfoMap
    ) {}

    public errors: IDLLinterErrorSummary[] = []

    public visit(): IDLLinterErrorSummary[] {
        this.check(this.file)
        idl.forEachChild(this.file, node => {
            this.check(node)
        })
        return this.errors
    }

    protected check(node: idl.IDLNode) {
        if (idl.isEntry(node)) {
            this.checkValidAttributes(node, this.options.validEntryAttributes.get(node.kind) ?? [])
        }
        if (this.options.checkEnumsConsistency && idl.isEnum(node)) {
            this.checkEnumConsistency(node)
        }
        if (this.options.checkReferencesResolved && idl.isReferenceType(node)) {
            this.checkReferenceResolved(node)
        }
    }

    protected checkValidAttributes(entry: idl.IDLEntry, validAttributes: string[]): void {
        if (!entry.extendedAttributes)
            return
        for (const attr of entry.extendedAttributes) {
            if (!validAttributes.includes(attr.name)) {
                const tokens = this.info?.get(attr)
                const ident = tokens?.name
                const file = idl.getFileFor(entry)
                this.errors.push({
                    file: file?.fileName ?? '',
                    message: `Invalid attribute '${attr.name}'`,
                    position: [ident?.position ?? 0, attr.name.length]
                })
            }
        }
    }

    protected checkEnumConsistency(entry: idl.IDLEnum): void {
        const fileName = idl.getFileFor(entry)?.fileName
        let hasNumber = false
        let hasString = false
        for (const element of entry.elements) {
            if (typeof element.initializer === 'string')
                hasString = true
            if (typeof element.initializer === 'number')
                hasNumber = true
        }
        if (hasNumber && hasString) {
            const tokens = this.info?.get(entry)
            const ident = tokens?.name
            this.errors.push({
                file: fileName ?? '',
                message: "Enum includes both string and number values",
                position: [
                    ident?.position ?? 0,
                    ident?.value.length ?? 0
                ]
            })
        }
    }

    private static builtinReferences = [
        idl.IDLTopType.name,
        idl.IDLObjectType.name,
    ]
    protected checkReferenceResolved(reference: idl.IDLReferenceType): void {
        if (IDLLinter.builtinReferences.includes(reference.name))
            return
        const resolved = this.resolver.resolveTypeReference(reference)
        if (resolved === undefined) {
            const parentFile = idl.getFileFor(reference)!
            const parentNamespace = idl.fetchNamespaceFrom(reference)
            const scopeName = parentNamespace ? idl.getFQName(parentNamespace) : idl.getPackageName(parentFile)
            let current: idl.IDLNode | undefined = reference
            let tokens = this.info?.get(current)
            let location = tokens?.base
            while (current !== undefined && tokens === undefined) {
                current = current.parent
                tokens = this.info?.get(current)
                location = tokens?.name
            }
            this.errors.push({
                file: parentFile.fileName ?? '',
                message: `Can not resolve reference '${reference.name}' defined in scope '${scopeName}'`,
                position: [location?.position ?? 0, location?.value?.length ?? 0]
            })
        }
    }
}

interface IDLLinterErrorSummary {
    message: string
    file: string
    position: [number, number]
}

export class IDLLinterError extends Error {
    constructor(
        message:string,
        public size: number
    ) {
        super(message)
    }
}

function printErrors(errors:IDLLinterErrorSummary[], text:string) {
    errors.sort((a, b) => a.position[0] - b.position[0])
    let ptr = 0
    let lines = 1
    let cols = 1
    return EOL +
        errors.map(error => {
            while (ptr < error.position[0] && ptr < text.length) {
                if (text[ptr] === '\n') {
                    ++lines
                    cols = 0
                }
                ++cols
                ++ptr
            }
            let errorText = `${error.file}:${lines}:${cols} ${error.message}`
            return errorText
        }).join(EOL)
}

function prettyPrintErrors(errors:IDLLinterErrorSummary[], text:string) {
    errors.sort((a, b) => a.position[0] - b.position[0])

    const windowSize = 2
    let window: string[] = []

    let ptr = 0
    let lines = 1
    let cols = 1

    let lineBuffer = ''
    return EOL +
        errors.map(error => {
            while (ptr < error.position[0] && ptr < text.length) {
                if (text[ptr] === '\n') {
                    ++lines
                    cols = 0
                    while (window.length > windowSize) {
                        window.shift()
                    }
                    window.push(lineBuffer)
                    lineBuffer = ''
                } else {
                    if (text[ptr] !== '\r') {
                        lineBuffer += text[ptr]
                    }
                }

                ++cols
                ++ptr
            }

            let currentLine = lineBuffer
            let ii = ptr
            while (ii < text.length && text[ii] !== '\n') {
                currentLine += text[ii]
                ++ii
            }

            let errorLine = '       '
            ii = 0
            while (ii < cols) {
                errorLine += ' '
                ++ii
            }
            ii = 0
            errorLine += '\x1b[31m'
            while (ii < error.position[1]) {
                errorLine += '~'
                ++ii
            }
            errorLine += '\x1b[0m'

            const windowLines = [...window, currentLine].map((line, i) => {
                const idx = (lines - (window.length - i))
                const idxText = idx.toString().padStart(5, ' ')
                const idxColored = idx === lines
                    ? '\x1b[1m' + idxText + '\x1b[0m'
                    : idxText
                return idxColored + ' | ' + line
            })

            let errorText = ''
                + windowLines.join(EOL)
                + EOL + errorLine + EOL
                + `\x1b[31mERROR\x1b[0m: ${error.file}:${lines}:${cols} ${error.message}`
                + EOL
            return errorText
        }).join(EOL)
}

export function verifyIDLLinter(file: idl.IDLFile, resolver: ReferenceResolver, options: IDLLinterOptions, info?:IDLTokenInfoMap): true {
    const result = new IDLLinter(file, resolver, options, info).visit()
    if (result.length)
        throw new IDLLinterError(prettyPrintErrors(result, file.text ?? ''), result.length)
    return true
}