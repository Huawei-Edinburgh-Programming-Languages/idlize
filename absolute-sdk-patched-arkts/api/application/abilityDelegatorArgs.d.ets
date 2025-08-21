/*
 * Copyright (c) 2021-2023 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
/**
 * @file
 * @kit AbilityKit
 */


/**
 * Store unit testing-related parameters, including test case names, and test runner name.
 *
 * @typedef AbilityDelegatorArgs
 * @syscap SystemCapability.Ability.AbilityRuntime.Core
 * @since 20
 */
export interface AbilityDelegatorArgs {
    
    
    /**
     * the bundle name of the application being tested.
     *
     * @type { string }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @since 20
     */
    bundleName: string;
    
    
    /**
     * the parameters used for unit testing.
     *
     * @type { Record<string, string> }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @since 20
     */
    parameters: Record<string, string>;
    
    
    /**
     * the class names of all test cases.
     *
     * @type { string }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @since 20
     */
    testCaseNames: string;
    
    
    /**
     * the class name of the test runner used to execute test cases.
     *
     * @type { string }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @since 20
     */
    testRunnerClassName: string;
}
