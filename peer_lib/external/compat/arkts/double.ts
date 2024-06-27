import { float64 } from "./types"

export function asFloat64(value: string): float64 {
    return (new Number(value)).valueOf()
}

export function asString(value: float64 | undefined): string | undefined {
    if (value === undefined) return undefined
    return (new Number(value)).toString()
}
