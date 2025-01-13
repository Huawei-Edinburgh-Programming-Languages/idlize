import { assert } from 'chai'
import { Language } from "../../src/Language"
import { IDLTypedef } from '../../src/idl'
import { createLanguageWriter } from '../../src/peer-generation/LanguageWriters'
import { IDLTest } from '../util';

suite("Test union discrimination", () => {
    const suite = new IDLTest("generator/unions.idl")
    const writer = createLanguageWriter(Language.TS, suite.peerLibrary)

    test("baby steps", () => {
        const uTypedef = suite.lookup("U") as IDLTypedef
        suite.peerLibrary.typeConvertor("", uTypedef.type).convertorSerialize("", "", writer)

        const eTypedef = suite.lookup("E") as IDLTypedef
        // suite.peerLibrary.typeConvertor("", eTypedef.type).convertorSerialize("", "", writer)
    })
})

