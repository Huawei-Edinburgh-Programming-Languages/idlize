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
 * @kit TestKit
 */
/**
 * Prepare the unit testing environment for running test cases.
 *
 * @typedef { Function }
 * @syscap SystemCapability.Ability.AbilityRuntime.Core
 * @since 20
 */
type OnPrepareFn = () => void;
/**
 * Run all test cases.
 *
 * @typedef { Function }
 * @syscap SystemCapability.Ability.AbilityRuntime.Core
 * @since 20
 */
type OnRunFn = () => void;

/**
 * Base class for the test framework.
 * If you want to implement your own unit test framework, you must inherit this class and overrides all its methods.
 *
 * @interface TestRunner
 * @syscap SystemCapability.Ability.AbilityRuntime.Core
 * @since 20
 */
interface TestRunner {
    
    /**
     * Prepare the unit testing environment for running test cases.
     *
     * @type { OnPrepareFn }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @since 20
     */
    onPrepare: OnPrepareFn;
    
    /**
     * Run all test cases.
     *
     * @typedef { OnRunFn }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @since 20
     */
    onRun: OnRunFn;
}
export default TestRunner;
