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

import { ExtendableComponent } from '../component/extendableComponent';
 
/**
 * Defining State annotation
 * State variable that holds the state property and is used to render the owning custom component.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
@Retention({policy: "SOURCE"})
export declare @interface State {};

/**
 * Defining Prop annotation
 * Prop is an annotation which is mutable, and its changes will not be synchronized to the parent component.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
@Retention({policy: "SOURCE"})
export declare @interface Prop {};

/**
 * Defining PropRef annotation
 * PropRef is an annotation which is mutable.
 * Any object property modifications made through PropRef are visible in the 
 * parent component, which is different from Prop.
 * In order to prevent this, need to take a deep copy of the parent data.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
@Retention({policy: "SOURCE"})
export declare @interface PropRef {};

/**
 * Defining Link annotation
 * Link decorated variable creates two-way synchronization with a variable of its parent component.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
@Retention({policy: "SOURCE"})
export declare @interface Link {};

/**
 * Defining Observed annotation
 * Observed is used to decorate a class.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
@Retention({policy: "SOURCE"})
export declare @interface Observed {};

/**
 * Defining Track annotation
 * Track is a decorator used to decorate properties of class objects. 
 * Any changes to the properties decorated by Track will trigger only updates to the UI associated with those properties.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
@Retention({policy: "SOURCE"})
export declare @interface Track {};

/**
 * Defining ObjectLink annotation
 * ObjectLink is used to observe property changes in nested class objects.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
@Retention({policy: "SOURCE"})
export declare @interface ObjectLink {};

/**
 * Defining StorageProp annotation
 * StorageProp a one-way data synchronization is established from the attribute with the given key in AppStorage to the variable. 
 * A local change can be made, but it will not be synchronized to AppStorage. 
 * An update to the attribute with the given key in AppStorage will overwrite local changes.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
@Retention({policy: "SOURCE"})
export declare @interface StorageProp {
    property: string;
};

/**
 * Defining StoragePropRef annotation
 * StoragePropRef is an annotation which is mutable.
 * Any object property modifications made through StoragePropRef are visible in the 
 * AppStorage, which is different from StorageProp.
 * In order to prevent this, need to take a deep copy of AppStorage instance data.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
@Retention({policy: "SOURCE"})
export declare @interface StoragePropRef {
    /**
     * The give property in AppStorage.
     *
     * @type { string }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    property: string;
};

/**
 * Defining StorageLink annotation
 * StorageLink is used to create a two-way data synchronization between the variable
 * it decorates and the attribute with the given key in AppStorage.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
@Retention({policy: "SOURCE"})
export declare @interface StorageLink {
    /**
     * The give property in AppStorage.
     *
     * @type { string }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    property: string;
};

/**
 * Defining LocalStorageProp annotation
 * LocalStorageProp is a one-way data synchronization is established from the attribute with the given key in 
 * LocalStorage to the variable. This means that, local changes 
 * (if any) will not be synchronized to LocalStorage, and an update to the attribute with the given key in LocalStorage.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
@Retention({policy: "SOURCE"})
export declare @interface LocalStorageProp {
    /**
     * The give property in LocalStorage.
     *
     * @type { string }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    property: string;
};

/**
 * Defining LocalStoragePropRef annotation
 * LocalStoragePropRef is an annotation which is mutable.
 * Any object property modifications made through LocalStoragePropRef are visible in the 
 * LocalStorage, which is different from LocalStorageProp.
 * In order to prevent this, need to take a deep copy of LocalStorage data.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
@Retention({policy: "SOURCE"})
export declare @interface LocalStoragePropRef {
    /**
     * The give property in LocalStorage.
     *
     * @type { string }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    property: string;
};

/**
 * Defining LocalStorageLink annotation
 * LocalStorageLink is used to create a two-way data synchronization with the attribute 
 * in LocalStorage.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
@Retention({policy: "SOURCE"})
export declare @interface LocalStorageLink {
    /**
     * The give property in LocalStorage.
     *
     * @type { string }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    property: string;
};

/**
 * Defining Provide annotation
 * Provide is used for two-way data synchronization with descendant components when 
 * state data needs to be transferred between multiple levels. An @Provide decorated state 
 * variable exists in the ancestor component and is said to be "provided" to descendent components.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
@Retention({policy: "SOURCE"})
export declare @interface Provide {
    /**
     * The alias name.
     *
     * @type { string }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    alias: string = "";
    /**
     * allowOverride is used to override an existing @Provide decorated variable.
     *
     * @type { boolean }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    allowOverride: boolean = false;
};

/**
 * Defining Consume annotation
 * Consume is used to access the provided state variable for a descendent component
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
@Retention({policy: "SOURCE"})
export declare @interface Consume {
    /**
     * The alias name.
     *
     * @type { string }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    alias: string = "";
};

/**
 * Defining Watch annotation
 * Watch is used to listen for state variables.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
@Retention({policy: "SOURCE"})
export declare @interface Watch {
    /**
     * The callback function name.
     *
     * @type { string }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    callback: string;
};

/**
 * Defining Require annotation
 * Require is a decorator for declaring that parameters – regular variables.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
@Retention({policy: "SOURCE"})
export declare @interface Require {};

/**
 * Defining Local annotation
 * Local is the internal state of a component, which enables the variables in the 
 * custom component to observe changes.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
@Retention({policy: "SOURCE"})
export declare @interface Local {};

/**
 * Defining Param annotation
 * Param indicates the state passed in from the external, ensuring that 
 * data can be synchronized between the parent and child components.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
@Retention({policy: "SOURCE"})
export declare @interface Param {};

/**
 * Defining Once annotation
 * Once annotation accepts values passed in only during variable initialization
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
@Retention({policy: "SOURCE"})
export declare @interface Once {};

/** 
 * Defining Event annotation
 * Event is used to decorate the callback method is a standard, indicating that the 
 * child component needs to pass in the callback for updating the data source.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
@Retention({policy: "SOURCE"})
export declare @interface Event {};

/**
 * Defining Provider annotation
 * Provider is used for two-way data synchronization with descendant components when 
 * state data needs to be transferred between multiple levels. An @Provider decorated state 
 * variable exists in the ancestor component and is said to be "provider" to descendent components.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
@Retention({policy: "SOURCE"})
export declare @interface Provider {
    /**
     * The alias name.
     *
     * @type { string }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    alias: string = "";
};

/**
 * Defining Consumer annotation
 * Consumer is used to access the provided state variable for a descendent component
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
@Retention({policy: "SOURCE"})
export declare @interface Consumer {
    /**
     * The alias name.
     *
     * @type { string }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    alias: string = "";
};

/**
 * Defining ObservedV2 annotation
 * ObservedV2 is used to decorate with class.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
@Retention({policy: "SOURCE"})
export declare @interface ObservedV2 {};

/**
 * Defining Trace annotation
 * Trace is used to directly observe the property changes of nested objects
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
@Retention({policy: "SOURCE"})
export declare @interface Trace {};

/**
 * Defining Computed annotation
 * Computed is a method decorator that decorates the getter method.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
@Retention({policy: "SOURCE"})
export declare @interface Computed {};

/**
 * Defining Monitor annotation
 * Monitor provides the capability of listening for state variables of V2.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
@Retention({policy: "SOURCE"})
export declare @interface Monitor {
    /**
     * Listened property name.
     *
     * @type { string[] }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    path: string[];
};

/**
 * Define IMonitor interface
 *
 * @interface IMonitor
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface IMonitor {
  /**
   * Array of changed paths(keys)
   *
   * @type { Array<string> }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
   dirty: Array<string>;
  /**
   * Return the pair of the value before the most recent change and current value for given path.
   * If path does not exist, return undefined; If path is not specified, return the value pair corresponding to the first path in dirty.
   *
   * @param { string } [path] Listened property name
   * @returns { IMonitorValue<T> | undefined }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
   value<T>(path?: string): IMonitorValue<T> | undefined;
}

/**
 * Define IMonitorValue interface
 *
 * @interface IMonitorValue<T>
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface IMonitorValue<T> {
  /**
   * Get the previous value.
   *
   * @type { T }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
   before: T;
  /**
   * Get current value.
   *
   * @type { T }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
   now: T;
  /**
   * Monitored path input by the user.
   *
   * @type { string }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
   path: string;
}

/**
 * Define decorated variable interface.
 *
 * @interface IDecoratedVariable
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface IDecoratedVariable {
  /**
   * Decorated variable name.
   *
   * @type { string }
   * @readonly
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  readonly varName: string;
}

/**
 * Define V1 decorated variable interface.
 *
 * @extends IDecoratedVariable
 * @interface IDecoratedVariable
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface IDecoratedV1Variable<T> extends IDecoratedVariable {
  /**
   * Registers the watch callback function with the data source.
   *
   * @param { IDecoratedV1Variable<T> } decoratedVar
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  registerWatchToSource(decoratedVar: IDecoratedV1Variable<T>): void;
}

/**
 * Define decorated immutable variable interface.
 *
 * @interface IDecoratedImmutableVariable<T>
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface IDecoratedImmutableVariable<T> {
  /**
   * Get the state variable.
   *
   * @returns { T }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  get(): T;
}

/**
 * Define decorated mutable variable interface.
 *
 * @interface IDecoratedMutableVariable<T>
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface IDecoratedMutableVariable<T> {
  /**
   * Get the state variable.
   *
   * @returns { T }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  get(): T;
  /**
   * Set the state variable with a new Value.
   *
   * @param { T } newValue
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  set(newValue: T): void;
}

/**
 * Define decorated updatable variable interface.
 *
 * @interface IDecoratedUpdatableVariable<T>
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface IDecoratedUpdatableVariable<T> {
  /**
   * Update the state variable with a new Value.
   *
   * @param { T } newValue
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  update(newValue: T): void;
}

/**
 * Define state decoration variable interface.
 *
 * @extends IDecoratedMutableVariable<T>, IDecoratedV1Variable<T>
 * @interface IStateDecoratedVariable<T>
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface IStateDecoratedVariable<T> extends IDecoratedMutableVariable<T>, IDecoratedV1Variable<T> {}

export declare interface IPropDecoratedVariable<T> extends IDecoratedMutableVariable<T>,
    IDecoratedUpdatableVariable<T>, IDecoratedV1Variable<T> {
}

/**
 * Define PropRef decoration variable interface.
 *
 * @extends IDecoratedMutableVariable<T>, IDecoratedUpdatableVariable<T>, IDecoratedV1Variable<T>
 * @interface IPropRefDecoratedVariable<T>
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface IPropRefDecoratedVariable<T> extends IDecoratedMutableVariable<T>,
    IDecoratedUpdatableVariable<T>, IDecoratedV1Variable<T> {}

/**
 * Define LocalStoragePropRef decoration variable interface.
 *
 * @extends IDecoratedMutableVariable<T>, IDecoratedV1Variable<T>
 * @interface ILocalStoragePropRefDecoratedVariable<T>
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface ILocalStoragePropRefDecoratedVariable<T> extends IDecoratedMutableVariable<T>, IDecoratedV1Variable<T> {}

/**
 * Define Link decoration variable interface.
 *
 * @extends IDecoratedMutableVariable<T>, IDecoratedV1Variable<T>
 * @interface ILinkDecoratedVariable<T>
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface ILinkDecoratedVariable<T> extends IDecoratedMutableVariable<T>, IDecoratedV1Variable<T> {}

/**
 * Define Provide decoration variable interface.
 *
 * @extends IDecoratedMutableVariable<T>, IDecoratedV1Variable<T>
 * @interface IProvideDecoratedVariable<T>
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface IProvideDecoratedVariable<T> extends IDecoratedMutableVariable<T>, IDecoratedV1Variable<T> {}

/**
 * Define Consume decoration variable interface.
 *
 * @extends IDecoratedMutableVariable<T>, IDecoratedV1Variable<T>
 * @interface IConsumeDecoratedVariable<T>
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface IConsumeDecoratedVariable<T> extends IDecoratedMutableVariable<T>, IDecoratedV1Variable<T> {}

/**
 * Define ObjectLink decoration variable interface.
 *
 * @extends IDecoratedImmutableVariable<T>, IDecoratedUpdatableVariable<T>, IDecoratedV1Variable<T>
 * @interface IObjectLinkDecoratedVariable<T>
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface IObjectLinkDecoratedVariable<T> extends IDecoratedImmutableVariable<T>,
    IDecoratedUpdatableVariable<T>, IDecoratedV1Variable<T> {}

/**
 * Define StorageLink decoration variable interface.
 *
 * @extends IDecoratedMutableVariable<T>, IDecoratedV1Variable<T>
 * @interface IStorageLinkDecoratedVariable<T>
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface IStorageLinkDecoratedVariable<T> extends IDecoratedMutableVariable<T>, IDecoratedV1Variable<T> {}

/**
 * Define StorageProp decoration variable interface.
 *
 * @extends IDecoratedMutableVariable<T>, IDecoratedV1Variable<T>
 * @interface IStoragePropDecoratedVariable<T>
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface IStoragePropDecoratedVariable<T> extends IDecoratedMutableVariable<T>, IDecoratedV1Variable<T> {
}

/**
 * Define StoragePropRef decoration variable interface.
 *
 * @extends IDecoratedMutableVariable<T>, IDecoratedV1Variable<T>
 * @interface IStoragePropRefDecoratedVariable<T>
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface IStoragePropRefDecoratedVariable<T> extends IDecoratedMutableVariable<T>, IDecoratedV1Variable<T> {}

/**
 * Define LocalStorageLink decoration variable interface.
 *
 * @extends IDecoratedMutableVariable<T>, IDecoratedV1Variable<T>
 * @interface ILocalStorageLinkDecoratedVariable<T>
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface ILocalStorageLinkDecoratedVariable<T> extends IDecoratedMutableVariable<T>, IDecoratedV1Variable<T> {}

/**
 * Define Local decoration variable interface.
 *
 * @extends IDecoratedMutableVariable<T>, IDecoratedV2Variable
 * @interface ILocalDecoratedVariable<T>
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface ILocalDecoratedVariable<T> extends IDecoratedMutableVariable<T>, IDecoratedV2Variable {} 

/**
 * Define Param decoration variable interface.
 *
 * @extends IDecoratedImmutableVariable<T>,  IDecoratedUpdatableVariable<T>, IDecoratedV2Variable
 * @interface IParamDecoratedVariable<T>
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface IParamDecoratedVariable<T> extends IDecoratedImmutableVariable<T>, IDecoratedUpdatableVariable<T>, IDecoratedV2Variable {}

/**
 * Define Param Once decoration variable interface.
 *
 * @extends IDecoratedMutableVariable<T>, IDecoratedV2Variable
 * @interface IParamOnceDecoratedVariable<T>
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface IParamOnceDecoratedVariable<T> extends IDecoratedMutableVariable<T>, IDecoratedV2Variable {}

/**
 * Define Link source type.
 *
 * @typedef { IDecoratedV1Variable<T> } LinkSourceType<T>
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type LinkSourceType<T> = IDecoratedV1Variable<T>;

/**
 * Define mutable state meta interface.
 *
 * @interface IMutableStateMeta
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface IMutableStateMeta {
  /**
   * Collect the dependancy for UI component with state variable
   *
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  addRef(): void;
  /**
   * Notify UI component to update when state variable is changed
   *
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  fireChange(): void;
}

/**
 * Define mutable state meta interface with key.
 *
 * @interface IMutableKeyedStateMeta
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface IMutableKeyedStateMeta {
  /**
   * Collect the dependancy for UI component with state variable based on given key
   *
   * @param { string } key
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  addRef(key: string): void;
  /**
   * Collect the dependancy for UI component with state variable based on given key
   *
   * @param { int } index
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  addRef(index: int): void;
  /**
   * Notify UI component with given key to update when state variable is changed
   *
   * @param { string } key
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  fireChange(key: string): void;
  /**
   * Notify UI component with given key to update when state variable is changed
   *
   * @param { int } index
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  fireChange(index: int): void;
}

/**
 * Define IObserve interface.
 *
 * @interface IObserve
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface IObserve {
  /**
   * Rendering component.
   *
   * @type { number }
   * @readonly
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  readonly renderingComponent: number;
  /**
   * Rendering component id.
   *
   * @type { RenderIdType }
   * @readonly
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  readonly renderingId: RenderIdType;
  /**
   * Collect the dependancy for UI component with state variable
   *
   * @param { RenderIdType } iObjectsRenderId
   * @returns { boolean }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  shouldAddRef(iObjectsRenderId: RenderIdType): boolean;
}

/**
 * Define OBSERVED.
 *
 * @type { IObserve }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare const OBSERVE: IObserve;

/**
 * Define int alias.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type RenderIdType = int;

/**
 * Define IObservedObject interface.
 *
 * @extends IWatchSubscriberRegister
 * @interface IObservedObject
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface IObservedObject extends IWatchSubscriberRegister {
  /**
   * Set V1 renderId
   *
   * @param { RenderIdType } renderId
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  setV1RenderId(renderId: RenderIdType): void;
}

/**
 * Define STATE_MGMT_FACTORY.
 *
 * @type { IStateMgmtFactory }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare const STATE_MGMT_FACTORY: IStateMgmtFactory;

/**
 * Define IStateMgmtFactory interface.
 *
 * @interface IStateMgmtFactory
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface IStateMgmtFactory {
  /**
   * get mutable state meta
   *
   * @returns { IMutableStateMeta }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  makeMutableStateMeta(): IMutableStateMeta;
  /**
   * get subscribed watches
   *
   * @returns { ISubscribedWatches }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  makeSubscribedWatches(): ISubscribedWatches;
  /**
   * Create a State variable instance.
   *
   * @param { ExtendableComponent } owningView - custom component.
   * @param { string } varName - state variable name.
   * @param { T } initValue - state variable initValue.
   * @param { WatchFuncType } [watchFunc] - watch type
   * @returns { IStateDecoratedVariable<T> } State instance
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  makeState<T>(owningView: ExtendableComponent, varName: string, initValue: T,
    watchFunc?: WatchFuncType): IStateDecoratedVariable<T>;

  /**
   * Create a PropRef variable instance.
   *
   * @param { ExtendableComponent } owningView - custom component.
   * @param { string } varName - state variable name.
   * @param { T } initValue - state variable initValue.
   * @param { WatchFuncType } [watchFunc] - watch type
   * @returns { IPropRefDecoratedVariable<T> } PropRef instance
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  makePropRef<T>(owningView: ExtendableComponent, varName: string, initValue: T,
    watchFunc?: WatchFuncType): IPropRefDecoratedVariable<T>;
  
  /**
   * Create a Link variable instance.
   *
   * @param { ExtendableComponent } owningView - custom component.
   * @param { string } varName - state variable name.
   * @param { LinkSourceType<T> } source - state variable sync source.
   * @param { WatchFuncType } [watchFunc] - watch type
   * @returns { ILinkDecoratedVariable<T> } PropRef instance
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  makeLink<T>(owningView: ExtendableComponent, varName: string, source: LinkSourceType<T>,
    watchFunc?: WatchFuncType): ILinkDecoratedVariable<T>;

  makeProp<T>(owningView: ExtendableComponent, varName: string, initValue: T,
        watchFunc?: WatchFuncType): IPropDecoratedVariable<T>;
  
  /**
   * Create a Provide variable instance.
   *
   * @param { ExtendableComponent } owningView - custom component.
   * @param { string } varName - state variable name.
   * @param { string } provideAlias - provide alias.
   * @param { T } initValue - init value.
   * @param { boolean } allowOverride - Override the @Provide of any parent
   * @param { WatchFuncType } [watchFunc] - watch type
   * @returns { IProvideDecoratedVariable<T> } Provide instance
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  makeProvide<T>(owningView: ExtendableComponent, varName: string, provideAlias: string, initValue: T, 
      allowOverride: boolean, watchFunc?: WatchFuncType): IProvideDecoratedVariable<T>;

  /**
   * Create a Consume variable instance.
   *
   * @param { ExtendableComponent } owningView - custom component.
   * @param { string } varName - state variable name.
   * @param { string } provideAlias - provide alias.
   * @param { WatchFuncType } [watchFunc] - watch type
   * @returns { IConsumeDecoratedVariable<T> } Consume instance
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  makeConsume<T>(owningView: ExtendableComponent, varName: string,
    provideAlias: string, watchFunc?: WatchFuncType): IConsumeDecoratedVariable<T>;

  /**
   * Create a ObjectLink variable instance.
   *
   * @param { ExtendableComponent } owningView - custom component.
   * @param { string } varName - state variable name.
   * @param { T } initValue - init value.
   * @param { WatchFuncType } [wathcFunc] - watch type
   * @returns { IObjectLinkDecoratedVariable<T> } ObjectLink instance
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  makeObjectLink<T>(owningView: ExtendableComponent, varName: string,
    initValue: T, wathcFunc?: WatchFuncType): IObjectLinkDecoratedVariable<T>;

  /**
   * Create a StorageLink variable instance.
   *
   * @param { ExtendableComponent } owningView - custom component.
   * @param { string } propName - property name.
   * @param { string } varName - state variable name.
   * @param { T } initValue - init value.
   * @param { WatchFuncType } [watchFunc] - watch type
   * @returns { IStorageLinkDecoratedVariable<T> } StorageLink instance
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  makeStorageLink<T>(owningView: ExtendableComponent, propName: string,
        varName: string, initValue: T, watchFunc?: WatchFuncType): IStorageLinkDecoratedVariable<T>;
   /**
    * Create a StoragePropRef variable instance.
    *
    * @param { ExtendableComponent } owningView - custom component.
    * @param { string } propName - property name.
    * @param { string } varName - state variable name.
    * @param { T } initValue - init value.
    * @param { WatchFuncType } [watchFunc] - watch type
    * @returns { IStoragePropRefDecoratedVariable<T> } StoragePropRef instance
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @since 20
    */
   makeStoragePropRef<T>(owningView: ExtendableComponent, propName: string,
        varName: string, initValue: T, watchFunc?: WatchFuncType): IStoragePropRefDecoratedVariable<T>;
  /**
   * Create a LocalStoragePropRef variable instance.
   *
   * @param { ExtendableComponent } owningView - custom component.
   * @param { string } propName - property name.
   * @param { string } varName - state variable name.
   * @param { T } initValue - init value.
   * @param { WatchFuncType } [watchFunc] - watch type
   * @returns { ILocalStoragePropRefDecoratedVariable<T> } LocalStoragePropRef instance
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
   makeLocalStoragePropRef<T>(owningView: ExtendableComponent, propName: string,
        varName: string, initValue: T, watchFunc?: WatchFuncType): ILocalStoragePropRefDecoratedVariable<T>;

  /**
   * Create a LocalStorageLink variable instance.
   *
   * @param { ExtendableComponent } owningView - custom component.
   * @param { string } propName - property name.
   * @param { string } varName - state variable name.
   * @param { T } initValue - init value.
   * @param { WatchFuncType } [watchFunc] - watch type
   * @returns { ILocalStorageLinkDecoratedVariable<T> } LocalStorageLink instance
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
   makeLocalStorageLink<T>(owningView: ExtendableComponent, propName: string,
        varName: string, initValue: T, watchFunc?: WatchFuncType): ILocalStorageLinkDecoratedVariable<T>;

  /**
   * Create a Local variable instance.
   *
   * @param { ExtendableComponent } owningView - custom component.
   * @param { string } varName - state variable name.
   * @param { T } localInitValue - state variable initValue.
   * @returns { ILocalDecoratedVariable<T> } Local instance
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
   makeLocal<T>(owningView: ExtendableComponent, varName: string, localInitValue: T): ILocalDecoratedVariable<T>;

  /**
   * Create a Param variable instance.
   *
   * @param { ExtendableComponent } owningView - custom component.
   * @param { string } varName - state variable name.
   * @param { T } initValue - param variable initValue.
   * @returns { IParamDecoratedVariable<T> } Param instance
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  makeParam<T>(owningView: ExtendableComponent, varName: string, initValue: T): IParamDecoratedVariable<T>;

  /**
   * Create a param once variable instance.
   *
   * @param { ExtendableComponent } owningView - custom component.
   * @param { string } varName - state variable name.
   * @param { T } initValue - param once variable initValue.
   * @returns { IParamOnceDecoratedVariable<T> } Param Once instance
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
   makeParamOnce<T>(owningView: ExtendableComponent, varName: string, initValue: T): IParamOnceDecoratedVariable<T>;

  /**
   * Create a provider variable instance.
   *
   * @param { ExtendableComponent } owningView - custom component.
   * @param { string } varName - provider variable name.
   * @param { string } providerAlias - provider alias.
   * @param { T } localInitValue - provider local variable value.
   * @returns { IProviderDecoratedVariable<T> } Provider instance
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  makeProvider<T>(owningView: ExtendableComponent, varName: string, providerAlias: string, localInitValue: T ): IProviderDecoratedVariable<T>;

  /**
   * Create a consumer variable instance.
   *
   * @param { ExtendableComponent } owningView - custom component.
   * @param { string } varName - consumer variable name.
   * @param { string } providerAlias - consumer alias.
   * @param { T } defaultValue - consumer default value.
   * @returns { IConsumerDecoratedVariable<T> } Consumer instance
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  makeConsumer<T>(owningView: ExtendableComponent, varName: string, providerAlias: string, defaultValue: T): IConsumerDecoratedVariable<T>;      

  /**
   * Create a computed variable instance.
   * 
   * @param { ComputedCallback<T> } computedCallback - computed callback function
   * @param { string } computeName - name of the computed function
   * @returns { IComputedDecoratedVariable<T> } Computed instance
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  makeComputed<T>(computedCallback: ComputedCallback<T>, computeName: string): IComputedDecoratedVariable<T>;

  /**
   * Create a monitored variable instance.
   * 
   * @param { Array<IMonitorPathInfo> } pathInfos - monitor path to its accessor
   * @param { MonitorCallback } monitorCallback - callback when monitor triggers
   * @returns { IMonitorDecoratedVariable } Monitor variable instance
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  makeMonitor(pathInfos: Array<IMonitorPathInfo>, monitorCallback: MonitorCallback): IMonitorDecoratedVariable;
}


/**
 * Define V2 decorated variable interface.
 *
 * @extends IDecoratedVariable
 * @interface IDecoratedV2Variable
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export interface IDecoratedV2Variable extends IDecoratedVariable {}

/**
 * Define Provider decoration variable interface.
 *
 * @extends IDecoratedMutableVariable<T>, IDecoratedV2Variable
 * @interface IProviderDecoratedVariable<T>
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface IProviderDecoratedVariable<T>  extends IDecoratedMutableVariable<T>, IDecoratedV2Variable {}

/**
 * Define Consumer decoration variable interface.
 *
 * @extends IDecoratedMutableVariable<T>, IDecoratedV2Variable
 * @interface IConsumerDecoratedVariable<T>
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface IConsumerDecoratedVariable<T> extends IDecoratedMutableVariable<T>, IDecoratedV2Variable {}

/**
 * Defines computed callback function
 * @typedef { function } ComputedCallback
 * @returns { T }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
type ComputedCallback<T> = () => T;

/**
 * Defines IMonitor callback function
 *
 * @typedef { function } MonitorCallback
 * @param { IMonitor } iMonitor MonitorValue
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
type MonitorCallback = (iMonitor: IMonitor) => void;

/**
 * Defines IMonitor value callback function
 *
 * @typedef { function } MonitorValueCallback
 * @returns { Any }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
type MonitorValueCallback = () => Any;

/**
 * Defines the callback that is called when state variable is change
 * @typedef { function } WatchFuncType
 * @param {string} propertyName - property name
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type WatchFuncType = (propertyName: string) => void;

/**
 * Define int alias.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type WatchIdType = int;

/**
 * Define IWatchSubscriberRegister interface.
 *
 * @interface IWatchSubscriberRegister
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface IWatchSubscriberRegister {
  /**
   * Registers the watch function callback.
   *
   * @param { WatchIdType } watchId - the watch function id
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  addWatchSubscriber(watchId: WatchIdType): void;
  /**
   * UnRegister the watch function callback.
   *
   * @param { WatchIdType } watchId - the watch function id
   * @returns { boolean }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  removeWatchSubscriber(watchId: WatchIdType): boolean;
}

/**
 * Define ISubscribedWatches interface.
 *
 * @extends IWatchSubscriberRegister
 * @interface ISubscribedWatches
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface ISubscribedWatches extends IWatchSubscriberRegister {
  /**
   * Execute the watch function callback.
   *
   * @param { string } propertyName - property name
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  executeOnSubscribingWatches(propertyName: string): void;
}

/**
 * Defines Computed decoration variable interface.
 *
 * @interface IComputedDecoratedVariable<T>
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface IComputedDecoratedVariable<T> {
    /**
     * Get the computed variable.
     *
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    get(): T;
}

/**
 * Defines @Monitor decorated variable interface.
 *
 * @interface IMonitorDecoratedVariable
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface IMonitorDecoratedVariable {}

/**
 * Defines Monitor path with its accessor interface.
 *
 * @interface IMonitorPathInfo
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface IMonitorPathInfo {
    /**
     * Changed paths(keys)
     *
     * @type { string }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    path: string;
    /**
     * Callback function to access monitored value.
     *
     * @type { MonitorValueCallback }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    valueCallback: MonitorValueCallback;
}
