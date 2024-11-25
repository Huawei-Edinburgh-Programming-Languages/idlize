/**
 * Defining Component ClassDecorator
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 7
 */
/**
 * Defining Component ClassDecorator
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @form
 * @since 9
 */
/**
 * Defining Component ClassDecorator
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @since 10
 */
/**
 * Defining Component ClassDecorator
 *
 * Component is a ClassDecorator and it supports ComponentOptions as parameters.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @atomicservice
 * @since 11
 */
declare const Component: ClassDecorator & ((options: ComponentOptions) => ClassDecorator);

/**
 * Defining ComponentV2 ClassDecorator
 *
 * ComponentV2 is a ClassDecorator and it supports ComponentOptions as parameters.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 12
 */
declare const ComponentV2: ClassDecorator & ((options: ComponentOptions) => ClassDecorator);

/**
 * Defines the options of Entry ClassDecorator.
 *
 * @interface EntryOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @form
 * @since 10
 */
/**
 * Defines the options of Entry ClassDecorator.
 *
 * @interface EntryOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @form
 * @atomicservice
 * @since 11
 */
declare interface EntryOptions {
  /**
   * Named route name.
   *
   * @type { ?string }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @form
   * @since 10
   */
  /**
   * Named route name.
   *
   * @type { ?string }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @form
   * @atomicservice
   * @since 11
   */
  routeName? : string,

  /**
   * LocalStorage to be passed.
   *
   * @type { ?LocalStorage }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @form
   * @since 10
   */
  /**
   * LocalStorage to be passed.
   *
   * @type { ?LocalStorage }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @form
   * @atomicservice
   * @since 11
   */
  storage? : LocalStorage,

  /**
   * Determines whether to use the LocalStorage instance object returned by the LocalStorage.getShared() interface.
   *
   * @type { ?boolean }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @crossplatform
   * @form
   * @atomicservice
   * @since 12
   */
  useSharedStorage? : boolean,
}

/**
 * Defines Entry ClassDecorator.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 7
 */
/**
 * Defines Entry ClassDecorator.
 *
 * Entry is a ClassDecorator and it supports LocalStorage as parameters.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @form
 * @since 9
 */
/**
 * Defines Entry ClassDecorator.
 *
 * Entry is a ClassDecorator and it supports LocalStorage or EntryOptions as parameters.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @since 10
 */
/**
 * Defines Entry ClassDecorator.
 *
 * Entry is a ClassDecorator and it supports LocalStorage or EntryOptions as parameters.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @atomicservice
 * @since 11
 */
declare const Entry: ClassDecorator & ((options?: LocalStorage | EntryOptions) => ClassDecorator);

/**
 * Defining Observed ClassDecorator.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 7
 */
/**
 * Defining Observed ClassDecorator.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @form
 * @since 9
 */
/**
 * Defining Observed ClassDecorator.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @since 10
 */
/**
 * Defining Observed ClassDecorator.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @atomicservice
 * @since 11
 */
declare const Observed: ClassDecorator;

/**
 * Defining ObservedV2 ClassDecorator.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @atomicservice
 * @since 12
 */
declare const ObservedV2: ClassDecorator;

/**
 * Defining Preview ClassDecorator.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 7
 */
/**
 * Defining Preview ClassDecorator.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @form
 * @since 9
 */
/**
 * Defining Preview ClassDecorator.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @since 10
 */
/**
 * Defining Preview ClassDecorator.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @atomicservice
 * @since 11
 */
declare const Preview: ClassDecorator & ((value: PreviewParams) => ClassDecorator);

/**
 * Defining Require PropertyDecorator.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @atomicservice
 * @since 11
 */
declare const Require: PropertyDecorator;

/**
 * Defining BuilderParam PropertyDecorator
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 7
 */
/**
 * Defining BuilderParam PropertyDecorator
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @form
 * @since 9
 */
/**
 * Defining BuilderParam PropertyDecorator
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @since 10
 */
/**
 * Defining BuilderParam PropertyDecorator
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @atomicservice
 * @since 11
 */
declare const BuilderParam: PropertyDecorator;

/**
 * Defining Local PropertyDecorator.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 12
 */
declare const Local: PropertyDecorator;

/**
 * Defining Param PropertyDecorator.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 12
 */
declare const Param: PropertyDecorator;

/**
 * Defining Once PropertyDecorator.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 12
 */
declare const Once: PropertyDecorator;

/**
 * Defining Event PropertyDecorator.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 12
 */
declare const Event: PropertyDecorator;

/**
 * Defining State PropertyDecorator.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 7
 */
/**
 * Defining State PropertyDecorator.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @form
 * @since 9
 */
/**
 * Defining State PropertyDecorator.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @since 10
 */
/**
 * Defining State PropertyDecorator.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @atomicservice
 * @since 11
 */
declare const State: PropertyDecorator;

/**
 * Defining Track PropertyDecorator.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @since 11
 */
/**
 * Defining Track PropertyDecorator.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @atomicservice
 * @since 12
 */
declare const Track: PropertyDecorator;

/**
 * Defining Trace PropertyDecorator.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @atomicservice
 * @since 12
 */
declare const Trace: PropertyDecorator;

/**
 * Defining Prop PropertyDecorator.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 7
 */
/**
 * Defining Prop PropertyDecorator.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @form
 * @since 9
 */
/**
 * Defining Prop PropertyDecorator.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @since 10
 */
/**
 * Defining Prop PropertyDecorator.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @atomicservice
 * @since 11
 */
declare const Prop: PropertyDecorator;

/**
 * Defining Link PropertyDecorator.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 7
 */
/**
 * Defining Link PropertyDecorator.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @form
 * @since 9
 */
/**
 * Defining Link PropertyDecorator.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @since 10
 */
/**
 * Defining Link PropertyDecorator.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @atomicservice
 * @since 11
 */
declare const Link: PropertyDecorator;

/**
 * Defining ObjectLink PropertyDecorator.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 7
 */
/**
 * Defining ObjectLink PropertyDecorator.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @form
 * @since 9
 */
/**
 * Defining ObjectLink PropertyDecorator.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @since 10
 */
/**
 * Defining ObjectLink PropertyDecorator.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @atomicservice
 * @since 11
 */
declare const ObjectLink: PropertyDecorator;

/**
 * Defines the options of Provide PropertyDecorator.
 *
 * @interface ProvideOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @atomicservice
 * @since 11
 */
declare interface ProvideOptions {
  /**
   * Override the @Provide of any parent or parent of parent @Component.@Provide({allowOverride: "name"}) is
   * also allowed to be used even when there is no ancestor @Component whose @Provide would be overridden.
   *
   * @type { ?string }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @crossplatform
   * @form
   * @atomicservice
   * @since 11
   */
  allowOverride?: string,
}

/**
 * Defining Provide PropertyDecorator.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 7
 */
/**
 * Defining Provide PropertyDecorator.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @form
 * @since 9
 */
/**
 * Defining Provide PropertyDecorator.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @since 10
 */
/**
 * Defining Provide PropertyDecorator.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @atomicservice
 * @since 11
 */
declare const Provide: PropertyDecorator & ((value: string | ProvideOptions) => PropertyDecorator);

/**
 * Defining Provider PropertyDecorator, aliasName is the only matching key and if aliasName is the default, the default attribute name is regarded as aliasName.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 12
 */
declare const Provider: (aliasName?: string) => PropertyDecorator;

/**
 * Defining Consume PropertyDecorator.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 7
 */
/**
 * Defining Consume PropertyDecorator.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @form
 * @since 9
 */
/**
 * Defining Consume PropertyDecorator.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @since 10
 */
/**
 * Defining Consume PropertyDecorator.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @atomicservice
 * @since 11
 */
declare const Consume: PropertyDecorator & ((value: string) => PropertyDecorator);

/**
* Defining Consumer PropertyDecorator, aliasName is the only matching key and if aliasName is the default, the default attribute name is regarded as aliasName.
* And @Consumer will find the nearest @Provider.
* @syscap SystemCapability.ArkUI.ArkUI.Full
* @crossplatform
* @atomicservice
* @since 12
*/
declare const Consumer: (aliasName?: string) => PropertyDecorator;

/**
* Defining Computed MethodDecorator.
*
* @syscap SystemCapability.ArkUI.ArkUI.Full
* @crossplatform
* @atomicservice
* @since 12
*/
declare const Computed: MethodDecorator;

/**
 * Defining StorageProp PropertyDecorator.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 7
 */
/**
 * Defining StorageProp PropertyDecorator.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @since 10
 */
/**
 * Defining StorageProp PropertyDecorator.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 11
 */
declare const StorageProp: (value: string) => PropertyDecorator;

/**
 * Defining StorageLink PropertyDecorator.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 7
 */
/**
 * Defining StorageLink PropertyDecorator.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @since 10
 */
/**
 * Defining StorageLink PropertyDecorator.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 11
 */
declare const StorageLink: (value: string) => PropertyDecorator;

/**
 * Defining Watch PropertyDecorator.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 7
 */
/**
 * Defining Watch PropertyDecorator.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @form
 * @since 9
 */
/**
 * Defining Watch PropertyDecorator.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @since 10
 */
/**
 * Defining Watch PropertyDecorator.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @atomicservice
 * @since 11
 */
declare const Watch: (value: string) => PropertyDecorator;

/**
 * Defining Builder MethodDecorator
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 7
 */
/**
 * Defining Builder MethodDecorator
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @form
 * @since 9
 */
/**
 * Defining Builder MethodDecorator
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @since 10
 */
/**
 * Defining Builder MethodDecorator
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @atomicservice
 * @since 11
 */
declare const Builder: MethodDecorator;

/**
 * Defining LocalBuilder MethodDecorator
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @atomicservice
 * @since 12
 */
declare const LocalBuilder: MethodDecorator;

/**
 * Defining Styles MethodDecorator
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 8
 */
/**
 * Defining Styles MethodDecorator
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @form
 * @since 9
 */
/**
 * Defining Styles MethodDecorator
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @since 10
 */
/**
 * Defining Styles MethodDecorator
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @atomicservice
 * @since 11
 */
declare const Styles: MethodDecorator;

/**
 * Defining Extend MethodDecorator
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 7
 */
/**
 * Defining Extend MethodDecorator
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @form
 * @since 9
 */
/**
 * Defining Extend MethodDecorator
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @since 10
 */
/**
 * Defining Extend MethodDecorator
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @atomicservice
 * @since 11
 */
declare const Extend: MethodDecorator & ((value: any) => MethodDecorator);

/**
 * Define AnimatableExtend MethodDecorator
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @since 10
 */
/**
 * Define AnimatableExtend MethodDecorator
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 11
 */
 declare const AnimatableExtend: MethodDecorator & ((value: Object) => MethodDecorator);

/**
 * Define Monitor MethodDecorator
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 12
 */
declare const Monitor: MonitorDecorator;

/**
 * Define Monitor Decorator type
 *
 * @typedef { function } MonitorDecorator
 * @param { string } value - Monitored path input by the user
 * @param { string[] } args - Monitored path(s) input by the user
 * @returns { MethodDecorator } Monitor decorator
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 12
 */
declare type MonitorDecorator = (value: string, ...args: string[]) => MethodDecorator;

/**
 * Defining Concurrent MethodDecorator
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 9
 */
/**
 * Defining Concurrent MethodDecorator
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @since 10
 */
/**
 * Defining Concurrent MethodDecorator
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 11
 */
declare const Concurrent: MethodDecorator;

/**
 * Defining Sendable ClassDecorator
 * The Sendable decorator can be used only for classes. A class with this decorator is marked as sendable, and the class object can be shared globally.
 * Since 12, the Sendable decorator can be used for function and typeAlias also.
 * A function with this decorator is marked as sendable, and the function can be an shareable property of sendable-class object.
 * A typeAlias with this decorator is marked as sendable, and the typeAlias can be used to declare properties, variables,
 * and arguments that need to be assigned with sendable-function.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 11
 */
declare const Sendable: ClassDecorator;

/**
 * Defining  CustomDialog ClassDecorator
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 7
 */
/**
 * Defining  CustomDialog ClassDecorator
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @since 10
 */
/**
 * Defining  CustomDialog ClassDecorator
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 11
 */
declare const CustomDialog: ClassDecorator;

/**
 * Defining LocalStorageLink PropertyDecorator.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 9
 */
/**
 * Defining LocalStorageLink PropertyDecorator.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @since 10
 */
/**
 * Defining LocalStorageLink PropertyDecorator.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 11
 */
declare const LocalStorageLink: (value: string) => PropertyDecorator;

/**
 * Defining LocalStorageProp PropertyDecorator
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @form
 * @since 9
 */
/**
 * Defining LocalStorageProp PropertyDecorator
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @since 10
 */
/**
 * Defining LocalStorageProp PropertyDecorator
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @atomicservice
 * @since 11
 */
declare const LocalStorageProp: (value: string) => PropertyDecorator;

/**
 * Defining Reusable ClassDecorator.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @since 10
 */
/**
 * Defining Reusable ClassDecorator.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 11
 */
declare const Reusable: ClassDecorator;

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
 * @kit ArkUI
 */

/**
 * declare ForEachAttribute
 *
 * @extends DynamicNode<ForEachAttribute>
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @atomicservice
 * @since 12
 */
declare class ForEachAttribute extends DynamicNode<ForEachAttribute> {
}

/**
 * looping function.
 *
 * @interface ForEachInterface
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 7
 */
/**
 * looping function.
 *
 * @interface ForEachInterface
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @form
 * @since 9
 */
/**
 * looping function.
 *
 * @interface ForEachInterface
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @since 10
 */
/**
 * looping function.
 *
 * @interface ForEachInterface
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @atomicservice
 * @since 11
 */
interface ForEachInterface {
  /**
   * Set the value, array, and key.
   *
   * @param { Array<any> } arr
   * @param { function } itemGenerator
   * @param { function } keyGenerator
   * @returns { ForEachInterface }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 7
   */
  /**
   * Set the value, array, and key.
   *
   * @param { Array<any> } arr
   * @param { function } itemGenerator
   * @param { function } keyGenerator
   * @returns { ForEachInterface }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @form
   * @since 9
   */
  /**
   * Set the value, array, and key.
   *
   * @param { Array<any> } arr
   * @param { function } itemGenerator
   * @param { function } keyGenerator
   * @returns { ForEachInterface }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @crossplatform
   * @form
   * @since 10
   */
  /**
   * Set the value, array, and key.
   *
   * @param { Array<any> } arr
   * @param { function } itemGenerator
   * @param { function } keyGenerator
   * @returns { ForEachInterface }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @crossplatform
   * @form
   * @atomicservice
   * @since 11
   */
  /**
   * Set the value, array, and key.
   *
   * @param { Array<any> } arr
   * @param { function } itemGenerator
   * @param { function } keyGenerator
   * @returns { ForEachAttribute }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @crossplatform
   * @form
   * @atomicservice
   * @since 12
   */
  (
    arr: Array<any>,
    itemGenerator: (item: any, index: number) => void,
    keyGenerator?: (item: any, index: number) => string,
  ): ForEachAttribute;
}

/**
 * Defines ForEach Component.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 7
 */
/**
 * Defines ForEach Component.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @form
 * @since 9
 */
/**
 * Defines ForEach Component.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @since 10
 */
/**
 * Defines ForEach Component.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @atomicservice
 * @since 11
 */
declare const ForEach: ForEachInterface;

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

  declare interface DataChangeListener {
    /**
     * Data ready.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 7
     */
    /**
     * Data ready.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @since 10
     */
    /**
     * Data ready.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 11
     */
    onDataReloaded(): void;

    /**
     * Data added.
     *
     * @param { number } index
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 7
     * @deprecated since 8
     * @useinstead onDataAdd
     */
    onDataAdded(index: number): void;

    /**
     * Data added.
     *
     * @param { number } index
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 8
     */
    /**
     * Data added.
     *
     * @param { number } index
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @since 10
     */
    /**
     * Data added.
     *
     * @param { number } index
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 11
     */
    onDataAdd(index: number): void;

    /**
     * Data moved.
     *
     * @param { number } from
     * @param { number } to
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 7
     * @deprecated since 8
     * @useinstead onDataMove
     */
    onDataMoved(from: number, to: number): void;

    /**
     * Data moved.
     *
     * @param { number } from
     * @param { number } to
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 8
     */
    /**
     * Data moved.
     *
     * @param { number } from
     * @param { number } to
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @since 10
     */
    /**
     * Data moved.
     *
     * @param { number } from
     * @param { number } to
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 11
     */
    onDataMove(from: number, to: number): void;

    /**
     * Data deleted.
     *
     * @param { number } index
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 7
     * @deprecated since 8
     * @useinstead onDataDelete
     */
    onDataDeleted(index: number): void;

    /**
     * Data deleted.
     *
     * @param { number } index
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 8
     */
    /**
     * Data deleted.
     *
     * @param { number } index
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @since 10
     */
    /**
     * Data deleted.
     *
     * @param { number } index
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 11
     */
    onDataDelete(index: number): void;

    /**
     * Call when has data change.
     *
     * @param { number } index
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 7
     * @deprecated since 8
     * @useinstead onDataChange
     */
    onDataChanged(index: number): void;

    /**
     * Call when has data change.
     *
     * @param { number } index
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 8
     */
    /**
     * Call when has data change.
     *
     * @param { number } index
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @since 10
     */
    /**
     * Call when has data change.
     *
     * @param { number } index
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 11
     */
    onDataChange(index: number): void;

    /**
     * Call when multiple data change.
     *
     * @param { DataOperation[] } dataOperations
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 12
     */
    onDatasetChange(dataOperations: DataOperation[]): void;
  }

  /**
   * Developers need to implement this interface to provide data to LazyForEach component.
   *
   * @interface IDataSource
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 7
   */
  /**
   * Developers need to implement this interface to provide data to LazyForEach component.
   *
   * @interface IDataSource
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @crossplatform
   * @since 10
   */
  /**
   * Developers need to implement this interface to provide data to LazyForEach component.
   *
   * @interface IDataSource
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @crossplatform
   * @atomicservice
   * @since 11
   */
  declare interface IDataSource {
    /**
     * Total data count.
     *
     * @returns { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 7
     */
    /**
     * Total data count.
     *
     * @returns { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @since 10
     */
    /**
     * Total data count.
     *
     * @returns { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 11
     */
    totalCount(): number;

    /**
     * Return the data of index.
     *
     * @param { number } index
     * @returns { any }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 7
     */
    /**
     * Return the data of index.
     *
     * @param { number } index
     * @returns { any }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @since 10
     */
    /**
     * Return the data of index.
     *
     * @param { number } index
     * @returns { any }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 11
     */
    getData(index: number): any;

    /**
     * Register data change listener.
     *
     * @param { DataChangeListener } listener
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 7
     */
    /**
     * Register data change listener.
     *
     * @param { DataChangeListener } listener
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @since 10
     */
    /**
     * Register data change listener.
     *
     * @param { DataChangeListener } listener
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 11
     */
    registerDataChangeListener(listener: DataChangeListener): void;

    /**
     * Unregister data change listener.
     *
     * @param { DataChangeListener } listener
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 7
     */
    /**
     * Unregister data change listener.
     *
     * @param { DataChangeListener } listener
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @since 10
     */
    /**
     * Unregister data change listener.
     *
     * @param { DataChangeListener } listener
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 11
     */
    unregisterDataChangeListener(listener: DataChangeListener): void;
  }

  /**
   * declare ForEachAttribute
   *
   * @extends DynamicNode<LazyForEachAttribute>
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @crossplatform
   * @atomicservice
   * @since 12
   */
  declare class LazyForEachAttribute extends DynamicNode<LazyForEachAttribute> {
  }
  /**
   * Lazy loading.
   *
   * @interface LazyForEachInterface
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 7
   */
  /**
   * Lazy loading.
   *
   * @interface LazyForEachInterface
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @crossplatform
   * @since 10
   */
  /**
   * Lazy loading.
   *
   * @interface LazyForEachInterface
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @crossplatform
   * @atomicservice
   * @since 11
   */
  interface LazyForEachInterface {
    /**
     * Enter the value to obtain the LazyForEach.
     *
     * @param { IDataSource } dataSource
     * @param { function } itemGenerator
     * @param { function } keyGenerator
     * @returns { LazyForEachInterface }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 7
     */
    /**
     * Enter the value to obtain the LazyForEach.
     *
     * @param { IDataSource } dataSource
     * @param { function } itemGenerator
     * @param { function } keyGenerator
     * @returns { LazyForEachInterface }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @since 10
     */
    /**
     * Enter the value to obtain the LazyForEach.
     *
     * @param { IDataSource } dataSource
     * @param { function } itemGenerator
     * @param { function } keyGenerator
     * @returns { LazyForEachInterface }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 11
     */
    /**
     * Enter the value to obtain the LazyForEach.
     *
     * @param { IDataSource } dataSource
     * @param { function } itemGenerator
     * @param { function } keyGenerator
     * @returns { LazyForEachAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 12
     */
    (
      dataSource: IDataSource,
      itemGenerator: (item: any, index: number) => void,
      keyGenerator?: (item: any, index: number) => string,
    ): LazyForEachAttribute;
  }

  /**
   * Defines LazyForEach Component.
   *
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 7
   */
  /**
   * Defines LazyForEach Component.
   *
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @crossplatform
   * @since 10
   */
  /**
   * Defines LazyForEach Component.
   *
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @crossplatform
   * @atomicservice
   * @since 11
   */
  declare const LazyForEach: LazyForEachInterface;

