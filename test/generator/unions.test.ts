import { Language } from "../../src/Language"
import { IDLInterface } from '../../src/idl'
import { createLanguageWriter } from '../../src/peer-generation/LanguageWriters'
import { IDLTest } from '../util';

test("Test union discrimination", () => {
    const suite = new IDLTest("generator/unions.idl")
    const writer = createLanguageWriter(Language.TS, suite.peerLibrary)

    const testCases: IDLInterface = suite.lookup("TestCases")
    testCases.properties.forEach(f =>
        suite.peerLibrary.typeConvertor("", f.type).convertorSerialize("", "", writer))
})

