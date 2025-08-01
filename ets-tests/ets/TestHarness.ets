/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
import { ScreenshotService, UserView, UserViewBuilder } from '@ohos.arkui'
import { memoBind } from '@koalaui/runtime'
import { errorAsString, int32 } from "@koalaui/common"
import { pageByNameFunction } from './utils'
import { TestFilter, setTestFilter, suite } from '@koalaui/harness'
import { Suites } from "@test/pages"

/**
 * Tests and test harness architecture.
 *
 * Harness is implemented as a regular Arkoala application, which is capable to load and execute tests
 * similar to real applications with controlled event loop behavior, allowing to ensure proper functionin
 * of state management and other aspects of the system.
 *
 * For tests, it exposes TestController interface which allows to capture tests's log, wait for event loop's
 * iterations, switch currently running test and notify TestComponent to execute callbacks.
 *
 * Typical test consists of two parts, page in 'pages' folder and matching suite in 'suites' folder.
 * Suite selects which page to load with 'loadPage()' API, and captures the log, typically with 'testPageOnChange()'
 * and 'testPageOnLoad()' service functions. Also test can explicitly control event loop and logs, if needed.
 *
 * Harness executes in separate coroutine, to allow control of event loop even in case we're waiting
 * for vsync or user input.
 */

const exclusiveTestsToRun = new Set<string>()
const exclusiveSuiteToRun = new Set<string>()

function registerExclusiveTests(names: string[]) {
    if (names.length > 0) {
        names.forEach(it => { if (it != "") exclusiveTestsToRun.add(it) })
    }
}

function registerExclusiveSuite(names: string[]) {
    if (names.length > 0) {
        names.forEach(it => { if (it != "") exclusiveSuiteToRun.add(it) })
    }
}

function testFilter(id: string, suite: boolean = false): boolean {
    if (suite) return (exclusiveSuiteToRun.size > 1 && !exclusiveSuiteToRun.has(id))
    return (exclusiveTestsToRun.size > 0 && !exclusiveTestsToRun.has(id))
}

function startTests(harness: TestHarness): void {
    harness.startTests()
}

export interface TestController {
    getLog(): string
    emitTask(type: int32, target: string, arg1?: int32, arg2?: int32): TestController
    start(): TestController
    stop(): TestController
    nextFrame(): Promise<TestController>
    skipFrames(count: int32): Promise<TestController>
    loadPage(page: string): TestController
    notifyChange(id: string): TestController
    notifyClick(id: string): TestController
    snapshot(target: string, name: string): boolean
}

export class TestHarness extends UserView implements TestController {
    private currentTest: string
    constructor() {
        super()
        this.currentTest = ""
        launch<void, (harness: TestHarness) => void>(startTests, this)
    }
    getLog(): string {
        return this.control!.getLog()
    }
    emitTask(type: int32, target: string, arg1?: int32, arg2?: int32): TestController {
        this.control!.emitTask(type, "" + target, arg1, arg2)
        return this
    }
    start(): TestController {
        this.control!.startLog()
        return this
    }
    stop(): TestController {
        this.control!.stopLog()
        return this
    }
    async nextFrame(): Promise<TestController> {
        await this.control!.nextFrame()
        return this
    }
    async skipFrames(count: int32): Promise<TestController> {
        for (let i = 0; i < count; i++) {
            await this.nextFrame()
        }
        return this
    }
    loadPage(page: string): TestController {
        this.currentTest = page
        this.control!.reloadView()
        return this
    }

    notifyChange(id: string): TestController {
        this.control!.emitTask(1 /* TaskType.OnChange */, "" + id)
        return this
    }

    notifyClick(id: string): TestController {
        this.control!.emitTask(0 /* TaskType.OnChange */, id)
        return this
    }

    snapshot(target: string, name: string): boolean {
        // Improve: native call to capture snapshot + compare + diff
        return ScreenshotService.requestScreenshot(target, name)
    }

    startTests() {
        console.log(`Tests started`)

        const suites: string[] = ["ETS HARNESS"]
        const tests: string[] = []
        const params = this.control!.params.split("|")
        registerExclusiveSuite(suites.concat(params.slice(0, 1)))
        registerExclusiveTests(tests.concat(params.slice(1)))
        setTestFilter(testFilter)

        let crash: string | undefined = undefined
        try {
            Suites(this)
        } catch (error) {
            crash = errorAsString(error)
        } finally {
            this.control!.requestStopApp(crash)
        }
    }

    getBuilder(): UserViewBuilder {
        return memoBind(pageByNameFunction, this.currentTest)
    }
}
