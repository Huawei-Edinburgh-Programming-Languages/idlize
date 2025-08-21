/*
 * Copyright (c) 2022-2024 Huawei Device Co., Ltd.
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
import _UIAbilityContext from './application/UIAbilityContext';
import type _UIExtensionContext from './application/UIExtensionContext';
import _AbilityStageContext from './application/AbilityStageContext';
import _ApplicationContext from './application/ApplicationContext';
import _BaseContext from './application/BaseContext';
import _Context from './application/Context';
import _ExtensionContext from './application/ExtensionContext';
import _FormExtensionContext from './application/FormExtensionContext';
import _ServiceExtensionContext from './application/ServiceExtensionContext';
import _EventHub from './application/EventHub';
import { AbilityResult as _AbilityResult } from './ability/abilityResult';
import type _AbilityStartCallback from './application/AbilityStartCallback';
import { ConnectOptions as _ConnectOptions } from './ability/connectOptions';
import { PacMap as _PacMap } from './ability/dataAbilityHelper';


/**
 * This module provides application context classes and common data structures.
 *
 * @namespace common
 * @syscap SystemCapability.Ability.AbilityRuntime.Core
 * @since 20
 */
declare namespace common {
    /**
     * The context of an ability. It allows access to ability-specific resources.
     *
     * @typedef { _UIAbilityContext }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    export type UIAbilityContext = _UIAbilityContext;
    /**
     * The context of an abilityStage. It allows access to abilityStage-specific resources.
     *
     * @typedef { _AbilityStageContext }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    export type AbilityStageContext = _AbilityStageContext;
    /**
     * The context of an application. It allows access to application-specific resources.
     *
     * @typedef { _ApplicationContext }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    export type ApplicationContext = _ApplicationContext;
    /**
     * The base context of 'app.Context' for FA Mode or 'application.Context' for Stage Mode.
     *
     * @typedef { _BaseContext }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    export type BaseContext = _BaseContext;
    /**
     * The base context of an ability or an application. It allows access to
     * application-specific resources.
     *
     * @typedef { _Context }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    export type Context = _Context;
    /**
     * The context of an extension. It allows access to extension-specific resources.
     *
     * @typedef { _ExtensionContext }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    export type ExtensionContext = _ExtensionContext;
    /**
     * The context of form extension. It allows access to
     * formExtension-specific resources.
     *
     * @typedef { _FormExtensionContext }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    export type FormExtensionContext = _FormExtensionContext;
    /**
     * The context of service extension. It allows access to
     * serviceExtension-specific resources.
     *
     * @typedef { _ServiceExtensionContext }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @systemapi
     * @stagemodelonly
     * @since 20
     */
    export type ServiceExtensionContext = _ServiceExtensionContext;
    /**
     * The event center of a context, support the subscription and publication of events.
     *
     * @typedef { _EventHub }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    export type EventHub = _EventHub;
    
    /**
     * Defines a PacMap object for storing a series of values.
     *
     * @typedef { _PacMap }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @since 20
     */
    export type PacMap = _PacMap;
    
    /**
     * Indicates the result of startAbility.
     *
     * @typedef { _AbilityResult }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    export type AbilityResult = _AbilityResult;
    /**
     * Indicates the callback of connection
     *
     * @typedef { _ConnectOptions }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    export type ConnectOptions = _ConnectOptions;
    /**
     * The context of UI extension. It allows access to
     * UIExtension-specific resources.
     *
     * @typedef { _UIExtensionContext }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    export type UIExtensionContext = _UIExtensionContext;
    /**
     * The function Called when some error occurred except disconnected from UIAbility or UIExtensionAbility
     *
     * @typedef { _AbilityStartCallback }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    export type AbilityStartCallback = _AbilityStartCallback;
}
export default common;
