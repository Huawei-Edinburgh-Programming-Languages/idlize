import * as fs from 'fs'

const libaceHeader = "generated/peers/libace/generated/interface/arkoala_api_generated.h"
const arkoalaHeader = "generated/peers/koalaui/arkoala/native/src/generated/arkoala_api_generated.h"

const libaceContent = fs.readFileSync(libaceHeader).toString()
const arkoalaContent = fs.readFileSync(arkoalaHeader).toString()

if (libaceContent != arkoalaContent) {
    console.log(libaceHeader)
    console.log(arkoalaHeader)
    throw new Error("Arkoala and libace headers differ!")
}

