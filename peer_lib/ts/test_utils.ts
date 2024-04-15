import {nativeModule} from "./NativeModule"
import {withStringResult} from "@arkoala/arkui/Interop";

const TEST_GROUP_LOG = 1

export let reportTestFailures: boolean = true

let failedTestsCount = 0

export function setReportTestFailures(report: boolean) {
    reportTestFailures = report
}

export function checkTestFailures() {
    if (reportTestFailures && failedTestsCount > 0) process.exit(1)
}

export function clearNativeLog() {
    nativeModule()._ClearGroupedLog(TEST_GROUP_LOG)
}

export function getNativeLog(): string {
    return withStringResult(nativeModule()._GetGroupedLog(TEST_GROUP_LOG))!
}

export function checkResult(name: string, test: () => void, expected: string) {
    clearNativeLog()
    test()
    let out = getNativeLog()
    if (reportTestFailures) {
        if (out != expected) {
            failedTestsCount++
            console.log(`TEST ${name} FAIL:\n  EXPECTED "${expected}"\n  ACTUAL   "${out}"`)
        } else {
            console.log(`TEST ${name} PASS`)
        }
    }
}
