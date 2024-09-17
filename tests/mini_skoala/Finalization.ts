
export interface Thunk {
    clean(): void
}

// const registry = new FinalizationRegistry<Thunk>(
//     (thunk: Thunk) => { thunk.clean() }
// );

// export function finalizerRegister(target: object, thunk: Thunk) {
//     registry.register(target, thunk)
// }

// export function finalizerUnregister(target: object) {
//     registry.unregister(target)
// }