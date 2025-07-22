export interface DTSCheckPromiseOptions {
    flag: boolean
    count: number
}

export class DTSCheckPromise {
    check(options: DTSCheckPromiseOptions)
    checkPromiseVoid(options: DTSCheckPromiseOptions): Promise<void>
}

