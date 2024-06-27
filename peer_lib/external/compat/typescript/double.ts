import { float64 } from "./types"

export function asFloat64(value: string): float64 {
    return Number(value)
}

export function asString(value: float64 | undefined): string | undefined {
    return value?.toString()
}

