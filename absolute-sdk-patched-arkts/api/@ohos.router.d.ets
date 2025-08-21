'use static'
/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
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

/**
 * @namespace router
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
declare namespace router {
  /**
   * Router Mode
   *
   * @enum { number }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  export enum RouterMode {
    /**
     * Default route mode.
     * The page will be added to the top of the page stack.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Standard,

    /**
     * Single route mode.
     * If the target page already has the same url page in the page stack,
     * the same url page closest to the top of the stack will be moved to the top of the stack.
     * If the target page url does not exist in the page stack, route will use default route mode.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Single
  }

  /**
   * @typedef RouterOptions
   * @syscap SystemCapability.ArkUI.ArkUI.Lite
   * @since 20
   */
  interface RouterOptions {
    /**
     * URI of the destination page, which supports the following formats:
     * 1. Absolute path of the page, which is provided by the pages list in the config.json file.
     *    Example:
     *      pages/index/index
     *      pages/detail/detail
     * 2. Particular path. If the URI is a slash (/), the home page is displayed.
     *
     * @type { string }
     * @syscap SystemCapability.ArkUI.ArkUI.Lite
     * @since 20
     */
    url: string;

    /**
     * Data that needs to be passed to the destination page during navigation.
     * After the destination page is displayed, the parameter can be directly used for the page.
     * For example, this.data1 (data1 is the key value of the params used for page navigation.)
     *
     * @type { ?Object }
     * @syscap SystemCapability.ArkUI.ArkUI.Lite
     * @since 20
     */
    params?: Object;

    /**
     * Set router page stack can be recovered after application is destroyed. When router page stack is recovered,
     * top page will be recovered, other page recovered when it backs. the default value is 'true'.
     *
     * @type { ?boolean }
     * @syscap SystemCapability.ArkUI.ArkUI.Lite
     * @since 20
     */
    recoverable?: boolean;
  }

  /**
   * @typedef RouterState
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  interface RouterState {
    /**
     * Index of the current page in the stack.
     * NOTE: The index starts from 1 from the bottom to the top of the stack.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    index: number;

    /**
     * Name of the current page, that is, the file name.
     *
     * @type { string }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    name: string;

    /**
     * Path of the current page.
     *
     * @type { string }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    path: string;

    /**
     * Data that passed to the destination page during navigation.
     *
     * @type { Object }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    params: Object;
  }


  /**
   * @typedef EnableAlertOptions
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  interface EnableAlertOptions {
    /**
     * dialog context.
     *
     * @type { string }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    message: string;
  }

  /**
   * @typedef NamedRouterOptions
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  interface NamedRouterOptions {
    /**
     * Name of the destination named route.
     *
     * @type { string }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    name: string;

    /**
     * Data that needs to be passed to the destination page during navigation.
     *
     * @type { ?Object }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    params?: Object;

    /**
     * Set router page stack can be recovered after application is destroyed. When router page stack is recovered,
     * top page will be recovered, other page recovered when it backs. the default value is 'true'.
     *
     * @type { ?boolean }
     * @syscap SystemCapability.ArkUI.ArkUI.Lite
     * @since 20
     */
    recoverable?: boolean;
  }
}

export default router;
