'use static'
/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License"),
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

/**
 * EnvProps object
 *
 * @interface EnvPropsOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface EnvPropsOptions {

  /**
   * Property name of Environment variable
   *
   * @type { string }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  key: string;

  /**
   * DefaultValue is the default value if cannot get the environment property value
   *
   * @type { number | string | boolean }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  defaultValue: number | string | boolean;
}

/**
 * Defines the Environment interface.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare class Environment {
  /**
   * Creates a new property in AppStorage. The UI framework implementation takes care of updating
   * its value whenever the named device environment property changes. Recommended use is at app startup.
   * The function call fails and returns false if a property with given name exists in AppStorage already.
   * It is wrong API use to access a property with given name in AppStorage before calling Environment.envProp.
   *
   * @param { string } key - environment property
   * @param { T } value - is the default value if cannot get the environment property value
   * @returns { boolean } false if method failed
   * @static
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  static envProp<T>(key: string, value: T): boolean;

  /**
   * Called when multiple property values are added to Environment.
   *
   * @param { EnvPropsOptions[] } props environment parameter
   * @static
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  static envProps(props: EnvPropsOptions[]): void;

  /**
   * returns an Array<string> of all environment property keys
   *
   * @returns { Array<string> } all environment property keys
   * @static
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  static keys(): Array<string>;
}