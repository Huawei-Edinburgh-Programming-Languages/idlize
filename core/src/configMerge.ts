function isObject(i: any): i is object {
    if (typeof i !== 'object')
        return false
    if (Array.isArray(i))
        return false
    return true
}

export function deepMergeConfig<T extends object>(defaults: T, custom: Partial<T>): T {
    if (custom === undefined)
        return defaults
    const result = Object.assign({}, defaults)
    for (const key in custom) {
        if (Object.prototype.hasOwnProperty.call(custom, key)) {
            const defaultValue = result[key]
            const customValue = custom[key]
            if (isObject(defaultValue) && isObject(customValue)) {
                Object.assign(result, { [key]: deepMergeConfig(defaultValue, customValue) })
            } else {
                if (isObject(defaultValue))
                    throw new Error("Replacing default object value with custom non-object")
                Object.assign(result, { [key]: customValue })
            }
        }
    }
    return result
}