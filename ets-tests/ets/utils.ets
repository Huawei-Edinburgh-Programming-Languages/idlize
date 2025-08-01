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
import { int32 } from '@koalaui/common'
import { assert, suite } from '@koalaui/harness'
import { TestController } from "./TestHarness"

export function testPageOnLoad(
    control: TestController,
    page: string,
    expected: string | Array<string>,
    message?: string,
    skipFrames: int32 = 3
): void {
    control.start()
    // make sure child components of all nested levels are loaded
    control.loadPage(page)
    await control.skipFrames(skipFrames)
    control.stop()
    const result = control.getLog()
    const expectedStr: string = expected instanceof Array ? expected.join("\n") + "\n" : expected
    if (result != expectedStr) {
        console.log(`\nTest ${page} returned:\n|${result}|\ninstead of:\n|${expectedStr}|`)
    }
    assert.equal(result, expectedStr, message || page + " is not properly updated")
}

export function testPageOnChange(
    control: TestController,
    page: string,
    targetId: int32 | Array<int32>,
    expected: string | Array<string>,
    message?: string,
    skipFrames: int32 = 3
): Promise<void> {
    const ids: Array<int32> = targetId instanceof Array ? targetId : [targetId]
    control.loadPage(page)
    control.start()
    await control.skipFrames(skipFrames)
    for (let i = 0; i < ids.length; i++) {
        control.notifyChange("" + ids[i])
        await control.skipFrames(skipFrames)
    }
    control.stop()
    const result = control.getLog()
    const expectedStr: string = expected instanceof Array ? expected.join("\n") + "\n" : expected
    if (result != expectedStr) {
        console.log(`\nTest ${page} returned:\n|${result}|\ninstead of:\n|${expectedStr}|`)
    }
    assert.equal(result, expectedStr, (message ?? `${page} is not properly updated`))
    return Promise.resolve()
}

export function testPageOnChangeStrict(
    control: TestController,
    page: string,
    targetId: int32 | Array<int32>,
    expected: string | Array<string>,
    message: string | undefined = undefined
  ) {
    return testPageOnChange(control, page, targetId, expected, message)
}

@memo
function pageByName(name: string): void {
    console.log(`Default pageByName() called`)
}

export let pageByNameFunction: @memo(name: string) => void = pageByName
export function registerPageByNameFunction(@memo pageByName: (name: string) => void) {
    pageByNameFunction = pageByName
}

