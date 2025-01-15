import { Language } from "@idlize/core"
import { IDLInterface } from '@idlize/core/idl'
import { createLanguageWriter } from '../src/peer-generation/LanguageWriters'
import { withDataFrom } from "./test-util"

test("Test union discrimination", () => {
    withDataFrom("unions.idl", data => {
        const writer = createLanguageWriter(Language.TS, data.peerLibrary)
        const testCases: IDLInterface = data.lookup("TestCases")
        testCases.properties.forEach(f =>
            data.peerLibrary.typeConvertor("", f.type).convertorSerialize("", "", writer))
    })
})

