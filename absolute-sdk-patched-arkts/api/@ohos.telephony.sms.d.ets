/*
 * Copyright (C) 2021-2023 Huawei Device Co., Ltd.
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
 * @kit TelephonyKit
 */
import type { AsyncCallback } from './@ohos.base';
import type Context from './application/BaseContext';
/**
 * Provides the capabilities and methods for obtaining Short Message Service (SMS) management objects.
 *
 * @namespace sms
 * @syscap SystemCapability.Telephony.SmsMms
 * @since 20
 */
declare namespace sms {
    /**
     * Returns whether a device is capable of sending and receiving SMS messages.
     *
     * @returns { boolean } Returns {@code true} if the device is capable of sending and receiving SMS messages;
     * Returns {@code false} otherwise.
     * @syscap SystemCapability.Telephony.SmsMms
     * @since 20
     */
    function hasSmsCapability(): boolean;
}
export default sms;
