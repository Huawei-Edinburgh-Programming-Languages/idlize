import { assert } from "chai"
import { licence } from "../../src/from-idl/common"
import { idlToDtsString } from "../../src/from-idl/DtsPrinter"
import * as path from "path"
import * as fs from "fs"


suite("Test idlize", () => {
    const inputDir = "./test/resources/golden/"
    // const outputDir = "./test/idl_test/generated/dts/"

    test("generate interfaces", () => {
        compareIdlVsDtsFiles(inputDir, "testInterfaces")
    })

    test("generate classes", () => {
        compareIdlVsDtsFiles(inputDir, "testClasses")
    })
})

function compareIdlVsDtsFiles(inputDir: string, inputFile: string) {
    const idlResults: string[] = [path.join(inputDir, inputFile + ".idl")]
        .map((file: string) => licence.concat(idlToDtsString(file, fs.readFileSync(file).toString())))

    const dtsResults: string[] = [path.join(inputDir, inputFile + ".d.ts")]
        .map((file: string) => fs.readFileSync(file).toString())

    idlResults.forEach((value: string, index: number) => {
        assert.equal(value, dtsResults[index])
    })
}