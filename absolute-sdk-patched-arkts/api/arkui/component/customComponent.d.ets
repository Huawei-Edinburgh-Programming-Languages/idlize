'use static'
/*
 * Copyright (C) 2025 Huawei Device Co., Ltd.
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
 * @arkts 1.2
 */

import { memo, ComponentBuilder, __memo_context_type, __memo_id_type } from "../stateManagement/runtime";
import { ExtendableComponent } from './extendableComponent';
import { GeometryInfo, Layoutable, Measurable, SizeResult } from './common'
import { ConstraintSizeOptions } from './units'
import { Builder } from './builder'
import { LocalStorage } from './../stateManagement/storage/localStorage';
import { CustomDialogController } from './customDialogController';

/**
 * Defines Entry Annotation.
 *
 * Entry is an Annotation and it supports parameters.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
@Retention({policy: "SOURCE"})
export @interface Entry {
    /**
     * Named route name.
     *
     * @type { string }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    routeName: string = "";

    /**
     * Name of the function which returns LocalStorage instance.
     *
     * @type { string }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    storage: string = "";

    /**
     * Determines whether to use the LocalStorage instance object returned by UIContext.getSharedLocalStorage() interface.
     *
     * @type { boolean }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    useSharedStorage: boolean = false;
}

/**
 * Defining Component Annotation
 *
 * Component is an Annotation to define a custom component using state management V1.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
@Retention({policy: "SOURCE"})
export @interface Component {}

/**
 * Defining ComponentV2 Annotation
 *
 * ComponentV2 is an Annotation to define a custom component using state management V2.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
@Retention({policy: "SOURCE"})
export @interface ComponentV2 {}

/**
 * Defining Reusable Annotation that is used to decorate @Component.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
@Retention({policy: "SOURCE"})
export @interface Reusable {}

/**
 * Defining ReusableV2 Annotation that is used to decorate @ComponentV2.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
@Retention({policy: "SOURCE"})
export @interface ReusableV2 {}

/**
 * Defining CustomLayout Annotation that is used to decorate @Component and @ComponentV2.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
@Retention({policy: "SOURCE"})
export @interface CustomLayout {}

/**
 * Defining CustomDialog Annotation
 *
 * CustomDialog is an Annotation to define a custom dialog.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
@Retention({policy: "SOURCE"})
export @interface CustomDialog {}

/**
 * Definition of base custom dialog class.
 *
 * @extends ExtendableComponent
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare abstract class BaseCustomDialog<T extends BaseCustomDialog<T, T_Options>, T_Options> extends ExtendableComponent {
   /**
    * Constructor to use to create a custom dialog instance.
    * @param {boolean} [useSharedStorage] - determine whether to use the LocalStorage instance object returned by UIContext.getSharedLocalStorage() interface.
    * @param {LocalStorage} [storage] - localStorage instance.
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @since 20
    */
   constructor(useSharedStorage?: boolean, storage?: LocalStorage);

    /**
     * Define the constructor of custom dialog
     *
     * @param { () => T } factory - factory to create instance of custom dialog
     * @param { T_Options } initializers - initial data for all the fields in custom dialog
     * @param { @Builder () => void } content - tail closure for custom dialog
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    @ComponentBuilder
    static $_instantiate(
        factory: () => T,
        initializers?: T_Options,
        @Builder content?: () => void
    ): T
}

/**
 * Definition of base custom component, which is base class of custom component.
 *
 * @extends ExtendableComponent
 * @implements CommonAttribute
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare abstract class BaseCustomComponent extends ExtendableComponent {
    /**
     * aboutToRecycle Method.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    aboutToRecycle(): void;
}

/**
 * Definition of custom component class.
 *
 * @extends BaseCustomComponent
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare abstract class CustomComponent<T extends CustomComponent<T, T_Options>, T_Options> extends BaseCustomComponent {
   /**
    * Constructor to use to create a customComponent instance.
    * @param {boolean} [useSharedStorage] - determine whether to use the LocalStorage instance object returned by UIContext.getSharedLocalStorage() interface.
    * @param {LocalStorage} [storage] - localStorage instance.
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @since 20
    */
   constructor(useSharedStorage?: boolean, storage?: LocalStorage);
    
    /**
     * Define the constructor of custom component
     *
     * @param { () => T } factory - factory to create instance of custom component
     * @param { T_Options } initializers - initial data for all the fields in custom component
     * @param { string } reuseId - reuse id for reusable. Only valid if custom component decorated with @Reusable
     * @param { @Builder () => void } content - tail closure for custom component
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    @ComponentBuilder
    static $_instantiate(
        factory: () => T,
        initializers?: T_Options,
        reuseId?: string,
        @Builder content?: () => void
    ): T

    /**
     * aboutToReuse Method
     *
     * @param { Record<string, Object> } params - Custom component init params.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    aboutToReuse(params: Record<string, Object>): void;
}

/**
 * Definition of V2 custom component class.
 *
 * @extends BaseCustomComponent
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare abstract class CustomComponentV2<T extends CustomComponentV2<T, T_Options>, T_Options> extends BaseCustomComponent {
    /**
     * Define the constructor of custom component
     *
     * @param { () => T } factory - factory to create instance of custom component
     * @param { T_Options } initializers - initial data for all the fields in custom component
     * @param { string } reuseId - reuse id for reusable. Only valid if custom component decorated with @Reusable
     * @param { @Builder () => void } content - tail closure for custom component
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    @ComponentBuilder
    static $_instantiate(
        factory: () => T,
        initializers?: T_Options,
        reuseId?: string,
        @Builder content?: () => void
    ): T

    /**
     * aboutToReuse Method
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    aboutToReuse(): void;
}

/**
 * Defining interface of PageLifeCycle for custom component, when decorate with @Entry.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export interface PageLifeCycle {
    /**
     * onPageShow Method.
     *
     * The page is triggered once each time it is displayed, including scenarios such as the routing process and the application entering the foreground
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    onPageShow(): void {}

    /**
     * onPageHide Method.
     *
     * It is triggered once each time the page is hidden, including scenarios such as the routing process and the application entering the background
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    onPageHide(): void {}

    /**
     * onBackPress Method.
     *
     * Triggered when the user clicks the back button
     *
     * @returns { boolean } true means that the page itself processes the return logic.
     * false means that the default return logic is used.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    onBackPress(): boolean { return false }

    /**
     * PageTransition Method.
     * Implement Animation when enter this page or move to other pages.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    pageTransition(): void {}

    /**
     * Triggered when the Entry custom component has been pushed with singleton mode.
     *
     * @param { object | undefined | null } param - New parameters pushed with singleton mode.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    onNewParam(param: object | undefined | null): void {}
}

/**
 * Defining interface of LayoutCallback for custom component, when decorate with @Layoutable.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export interface LayoutCallback {
    /**
     * Custom component override this method to layout each of its sub components.
     *
     * @param { GeometryInfo } selfLayoutInfo
     * @param { Array<Layoutable> } children
     * @param { ConstraintSizeOptions } constraint
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    onPlaceChildren(selfLayoutInfo: GeometryInfo, children: Array<Layoutable>, constraint: ConstraintSizeOptions): void {}

    /**
     * Custom component override this method to measure each of its sub components.
     * @param { GeometryInfo } selfLayoutInfo
     * @param { Array<Measurable> } children - indicate the measure child
     * @param { ConstraintSizeOptions } constraint - indicate child constraint size
     * @returns { SizeResult }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    onMeasureSize(selfLayoutInfo: GeometryInfo, children: Array<Measurable>, constraint: ConstraintSizeOptions): SizeResult {
        return {width: 0, height: 0} as SizeResult
    }
}
