import { assert } from "chai"
import { getFilesRecursive, licence } from "../../src/from-idl/common"
import { idlToDtsString } from "../../src/from-idl/DtsPrinter"
import * as path from "path"
import * as fs from "fs"
import { toIDLString } from "../../src/idl"


suite("Test idlize", () => {
    const inputDir = path.resolve("./test/resources/golden/")
    const idlFiles: string[] = getFilesRecursive(inputDir, ".idl")

    test("check d.ts", () => {
        // checkReverseTransform(idlFiles, idlToDtsString, toIDLString)
        compareIdlVsDtsFiles(inputDir)
    })
})

function checkReverseTransform(
    idlFiles: string[],
    transform: (name: string, content: string) => string,
    reverseTransform: (content: string) => string
): void {
    const idlResults = idlFiles.map((file: string) => fs.readFileSync(file).toString())
    const dtsResults = idlFiles.map((file: string) => licence.concat(
        transform(file, fs.readFileSync(file).toString())
    ))

    idlResults.forEach((value: string, index: number) => {
        assert.equal(value, dtsResults[index])
    })
}

function compareIdlVsDtsFiles(inputDir: string, inputFile?: string) {
    const idlResults: string[] = [path.join(inputDir, inputFile + ".idl")]
        .map((file: string) => licence.concat(idlToDtsString(file, fs.readFileSync(file).toString())))

    const dtsResults: string[] = [path.join(inputDir, inputFile + ".d.ts")]
        .map((file: string) => fs.readFileSync(file).toString())

    idlResults.forEach((value: string, index: number) => {
        assert.equal(value, dtsResults[index])
    })
}