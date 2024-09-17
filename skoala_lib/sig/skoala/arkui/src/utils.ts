export function unsafeCast<T>(value: unknown): T {
    return value as unknown as T
}