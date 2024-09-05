import { Language } from "../../util"
import { tsCopyrightAndWarning } from "../FileGenerators"
import { IdlPeerLibrary } from "../idl/IdlPeerLibrary"
import { createLanguageWriter } from "../LanguageWriters"
import { ARKOALA_PACKAGE, ARKOALA_PACKAGE_PATH } from "./lang/Java"
import { TargetFile } from "./TargetFile"

interface SyntheticTypesVisitor {
    getTypes(): Map<TargetFile, string[]>
    visit(): void
}

class JavaSyntheticTypesVisitor implements SyntheticTypesVisitor {
    constructor(private readonly peerLibrary: IdlPeerLibrary) {}
    private types = new Map<TargetFile, string[]>()
    getTypes(): Map<TargetFile, string[]> {
        return this.types
    }
    visit(): void {
        this.peerLibrary.syntheticTypes.forEach((type, name) => {
            const writer = createLanguageWriter(Language.JAVA)
            writer.print(`package ${ARKOALA_PACKAGE};\n`)
            type.print(writer)
            this.types.set(new TargetFile(name, ARKOALA_PACKAGE_PATH), writer.getOutput())
        })
    }
}

function createVisitor(peerLibrary: IdlPeerLibrary) {
    return new JavaSyntheticTypesVisitor(peerLibrary)
}

export function printSyntheticTypes(peerLibrary: IdlPeerLibrary): Map<TargetFile, string> {
    const result = new Map<TargetFile, string>()
    if (peerLibrary.language != Language.JAVA) {
        return result
    }

    const visitor = createVisitor(peerLibrary)
    visitor.visit()
    for (const [key, content] of visitor.getTypes()) {
        if (content.length === 0) continue
        const text = tsCopyrightAndWarning(content.join('\n'))
        result.set(key, text)
    }
    return result
}
