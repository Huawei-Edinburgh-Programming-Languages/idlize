/*
 * Copyright (c) 2023-2025 Huawei Device Co., Ltd.
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
 * @kit ArkUI
 */
import { ResourceStr } from './arkui/component/units';
import { PropRef } from './arkui/stateManagement/decorator';
import { Component } from './arkui/component/customComponent';
import { Builder } from './arkui/component/builder';


/**
 * Declare component SwipeRefresher
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 * @noninterop
 */
@Component
export declare struct SwipeRefresher {
    /**
     * Sets the content when loading.
     * @type { ?ResourceStr }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    @PropRef
    content?: ResourceStr;
    /**
     * Whether the component is loading.
     * type { boolean }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    @PropRef
    isLoading: boolean;
    /**
     * The method to build component.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    @Builder
    build(): void;
}
