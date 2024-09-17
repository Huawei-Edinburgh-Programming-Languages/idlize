import { Paint } from "./Paint"
import { Canvas } from "./Canvas"
import { Bitmap } from "./Bitmap"
import { SurfaceProps } from "./SurfaceProps"
import { uint8 } from "@koalaui/common"

export function testFun() {
    let clearColor = rgbColor(0xAA, 0xBB, 0xCC)
    let fgColor = rgbColor(0xCC, 0xAA, 0xBB)

    let bitmap = Bitmap.make()
    const props = SurfaceProps.Default
    let canvas = Canvas.makeFromBitmap(bitmap, props)
    let paint = Paint.make()
    paint.color = fgColor

    canvas.clear(clearColor)
    canvas.drawRect(8, 8, 24, 24, paint)
}

export function rgbColor(r: uint8, g: uint8, b: uint8, a: uint8 = 255) {
    return (a & 0xFF) << 24
        | (r & 0xFF) << 16
        | (g & 0xFF) << 8
        | (b & 0xFF) << 0
}
