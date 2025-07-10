import { readFileSync, writeFileSync } from "node:fs"
import { Point, PointEncoder, Star  } from "./lib"
import { ByteWriter } from "./stdlib"

function main() {
    const bw = new ByteWriter()
    PointEncoder.encode(bw, { x: 42, y: 42 })

    writeFileSync('point.bin', bw.asBuffer())
}
