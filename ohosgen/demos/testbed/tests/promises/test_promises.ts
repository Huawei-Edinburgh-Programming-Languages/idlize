import { test_promises } from "#compat"

const result = await test_promises.returnPromise()
const expected = 42
if (result !== expected) throw new Error(`Assertion failed: expected ${expected}, got ${result}`)