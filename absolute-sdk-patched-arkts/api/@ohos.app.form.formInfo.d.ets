/*
 * Copyright (c) 2022-2023 Huawei Device Co., Ltd.
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
 * @kit FormKit
 */
import Want from './@ohos.app.ability.Want';

/**
 * interface of formInfo.
 *
 * @namespace formInfo
 * @syscap SystemCapability.Ability.Form
 * @since 20
 */
declare namespace formInfo {
    
    /**
     * Provides information about a form.
     *
     * @typedef FormInfo
     * @syscap SystemCapability.Ability.Form
     * @since 20
     */
    interface FormInfo {
        
        /**
         * Obtains the bundle name of the application to which this form belongs.
         *
         * @type { string }
         * @syscap SystemCapability.Ability.Form
         * @since 20
         */
        bundleName: string;
        
        /**
         * Obtains the name of the application module to which this form belongs.
         *
         * @type { string }
         * @syscap SystemCapability.Ability.Form
         * @since 20
         */
        moduleName: string;
        
        /**
         * Obtains the class name of the ability to which this form belongs.
         *
         * @type { string }
         * @syscap SystemCapability.Ability.Form
         * @since 20
         */
        abilityName: string;
        
        /**
         * Obtains the name of this form.
         *
         * @type { string }
         * @syscap SystemCapability.Ability.Form
         * @since 20
         */
        name: string;
        /**
         * Obtains the display name of this form.
         *
         * @type { string }
         * @syscap SystemCapability.Ability.Form
         * @since 20
         */
        displayName: string;
        /**
         * Obtains the displayName resource id of this form.
         *
         * @type { int }
         * @syscap SystemCapability.Ability.Form
         * @since 20
         */
        displayNameId: int;
        
        /**
         * Obtains the description of this form.
         *
         * @type { string }
         * @syscap SystemCapability.Ability.Form
         * @since 20
         */
        description: string;
        
        /**
         * Obtains the description id of this form.
         *
         * @type { int }
         * @syscap SystemCapability.Ability.Form
         * @since 20
         */
        descriptionId: int;
        
        /**
         * Obtains the type of this form. Currently, JS forms are supported.
         *
         * @type { FormType }
         * @syscap SystemCapability.Ability.Form
         * @since 20
         */
        type: FormType;
        
        /**
         * Obtains the JS component name of this JS form.
         *
         * @type { string }
         * @syscap SystemCapability.Ability.Form
         * @since 20
         */
        jsComponentName: string;
        
        /**
         * Checks whether this form is a default form.
         *
         * @type { boolean }
         * @syscap SystemCapability.Ability.Form
         * @since 20
         */
        isDefault: boolean;
        
        /**
         * Obtains the updateEnabled.
         *
         * @type { boolean }
         * @syscap SystemCapability.Ability.Form
         * @since 20
         */
        updateEnabled: boolean;
        
        /**
         * Obtains whether notify visible of this form.
         *
         * @type { boolean }
         * @syscap SystemCapability.Ability.Form
         * @since 20
         */
        formVisibleNotify: boolean;
        
        /**
         * Obtains the scheduledUpdateTime.
         *
         * @type { string }
         * @syscap SystemCapability.Ability.Form
         * @since 20
         */
        scheduledUpdateTime: string;
        
        /**
         * Obtains the form config ability about this form.
         *
         * @type { string }
         * @syscap SystemCapability.Ability.Form
         * @since 20
         */
        formConfigAbility: string;
        
        /**
         * Obtains the updateDuration.
         *
         * @type { int }
         * @syscap SystemCapability.Ability.Form
         * @since 20
         */
        updateDuration: int;
        
        /**
         * Obtains the default grid style of this form.
         *
         * @type { int }
         * @syscap SystemCapability.Ability.Form
         * @since 20
         */
        defaultDimension: int;
        
        /**
         * Obtains the grid styles supported by this form.
         *
         * @type { Array<int> }
         * @syscap SystemCapability.Ability.Form
         * @since 20
         */
        supportDimensions: Array<int>;
        
        /**
         * Obtains the custom data defined in this form.
         *
         * @type { Record<string, string> }
         * @syscap SystemCapability.Ability.Form
         * @since 20
         */
        customizeData: Record<string, string>;
        
        /**
         * Obtains whether this form is a dynamic form.
         *
         * @type { boolean }
         * @syscap SystemCapability.Ability.Form
         * @since 20
         */
        isDynamic: boolean;
        /**
         * Indicates whether the form can be set as a transparent background
         *
         * @type { boolean }
         * @default false
         * @syscap SystemCapability.Ability.Form
         * @since 20
         */
        transparencyEnabled: boolean;
        /**
         * Obtains the shape supported by this form.
         *
         * @type { Array<int> }
         * @syscap SystemCapability.Ability.Form
         * @since 20
         */
        supportedShapes: Array<int>;
        /**
         * Indicates the form previewImage IDs map corresponds to the \"supportDimensions\".
         *
         * @type { ?Array<int> }
         * @readonly
         * @syscap SystemCapability.Ability.Form
         * @systemapi
         * @since 20
         */
        readonly previewImages?: Array<int>;
        /**
         * Indicates whether the form uses a blur background provided by the form host.
         *
         * @type { ?boolean }
         * @readonly
         * @syscap SystemCapability.Ability.Form
         * @systemapi
         * @since 20
         */
        readonly enableBlurBackground?: boolean;
        /**
         * Obtains the rendering mode of the form.
         *
         * @type { ?RenderingMode }
         * @readonly
         * @syscap SystemCapability.Ability.Form
         * @systemapi
         * @since 20
         */
        readonly renderingMode?: RenderingMode;
    }
    /**
     * Rendering mode.
     *
     * @enum { int }
     * @syscap SystemCapability.Ability.Form
     * @systemapi
     * @since 20
     */
    enum RenderingMode {
        /**
         * Auto color mode.
         *
         * @syscap SystemCapability.Ability.Form
         * @systemapi
         * @since 20
         */
        AUTO_COLOR = 0,
        /**
         * Full color mode.
         *
         * @syscap SystemCapability.Ability.Form
         * @systemapi
         * @since 20
         */
        FULL_COLOR = 1,
        /**
         * Single color mode.
         *
         * @syscap SystemCapability.Ability.Form
         * @systemapi
         * @since 20
         */
        SINGLE_COLOR = 2
    }
    
    /**
     * Type of form.
     *
     * @enum { int }
     * @syscap SystemCapability.Ability.Form
     * @since 20
     */
    enum FormType {
        
        /**
         * JS form.
         *
         * @syscap SystemCapability.Ability.Form
         * @since 20
         */
        JS = 1,
        
        /**
         * eTS form.
         *
         * @syscap SystemCapability.Ability.Form
         * @since 20
         */
        eTS = 2
    }
    
    /**
     * Provides state information about a form.
     *
     * @typedef FormStateInfo
     * @syscap SystemCapability.Ability.Form
     * @since 20
     */
    interface FormStateInfo {
        
        /**
         * Obtains the form state.
         *
         * @type { FormState }
         * @syscap SystemCapability.Ability.Form
         * @since 20
         */
        formState: FormState;
        
        /**
         * Obtains the want form .
         *
         * @type { Want }
         * @syscap SystemCapability.Ability.Form
         * @since 20
         */
        want: Want;
    }
    
    /**
     * Provides state about a form.
     *
     * @enum { int }
     * @syscap SystemCapability.Ability.Form
     * @since 20
     */
    enum FormState {
        
        /**
         * Indicates that the form status is unknown due to an internal error.
         *
         * @syscap SystemCapability.Ability.Form
         * @since 20
         */
        UNKNOWN = -1,
        
        /**
         * Indicates that the form is in the default state.
         *
         * @syscap SystemCapability.Ability.Form
         * @since 20
         */
        DEFAULT = 0,
        
        /**
         * Indicates that the form is ready.
         *
         * @syscap SystemCapability.Ability.Form
         * @since 20
         */
        READY = 1
    }
    
    /**
     * Parameter of form.
     *
     * @enum { string }
     * @syscap SystemCapability.Ability.Form
     * @since 20
     */
    enum FormParam {
        
        /**
         * Indicates the key specifying the ID of the form to be obtained, which is represented as
         * want: {
         *   "parameters": {
         *       IDENTITY_KEY: "119476135"
         *    }
         * }.
         *
         * @syscap SystemCapability.Ability.Form
         * @since 20
         */
        IDENTITY_KEY = "ohos.extra.param.key.form_identity",
        
        /**
         * Indicates the key specifying the grid style of the form to be obtained, which is represented as
         * want: {
         *   "parameters": {
         *       DIMENSION_KEY: FormDimension.Dimension_1_2
         *    }
         * }.
         *
         * @syscap SystemCapability.Ability.Form
         * @since 20
         */
        DIMENSION_KEY = "ohos.extra.param.key.form_dimension",
        
        /**
         * Indicates the key specifying the name of the form to be obtained, which is represented as
         * want: {
         *   "parameters": {
         *       NAME_KEY: "formName"
         *    }
         * }.
         *
         * @syscap SystemCapability.Ability.Form
         * @since 20
         */
        NAME_KEY = "ohos.extra.param.key.form_name",
        
        /**
         * Indicates the key specifying the name of the module to which the form to be obtained belongs, which is
         * represented as
         * want: {
         *   "parameters": {
         *       MODULE_NAME_KEY: "formEntry"
         *    }
         * }
         * This constant is mandatory.
         *
         * @syscap SystemCapability.Ability.Form
         * @since 20
         */
        MODULE_NAME_KEY = "ohos.extra.param.key.module_name",
        
        /**
         * Indicates the key specifying the width of the form to be obtained, which is represented as
         * want: {
         *   "parameters": {
         *       WIDTH_KEY: 800
         *    }
         * }
         *
         * @syscap SystemCapability.Ability.Form
         * @since 20
         */
        WIDTH_KEY = "ohos.extra.param.key.form_width",
        
        /**
         * Indicates the key specifying the height of the form to be obtained, which is represented as
         * want: {
         *   "parameters": {
         *       HEIGHT_KEY: 400
         *    }
         * }
         *
         * @syscap SystemCapability.Ability.Form
         * @since 20
         */
        HEIGHT_KEY = "ohos.extra.param.key.form_height",
        
        /**
         * Indicates the key specifying whether a form is temporary, which is represented as
         * want: {
         *   "parameters": {
         *       TEMPORARY_KEY: true
         *    }
         * }
         *
         * @syscap SystemCapability.Ability.Form
         * @since 20
         */
        TEMPORARY_KEY = "ohos.extra.param.key.form_temporary",
        
        /**
         * Indicates the key specifying the name of the bundle to be obtained, which is represented as
         * want: {
         *   "parameters": {
         *       BUNDLE_NAME_KEY: "bundleName"
         *    }
         * }
         *
         * @syscap SystemCapability.Ability.Form
         * @since 20
         */
        BUNDLE_NAME_KEY = "ohos.extra.param.key.bundle_name",
        
        /**
         * Indicates the key specifying the name of the ability to be obtained, which is represented as
         * want: {
         *   "parameters": {
         *       ABILITY_NAME_KEY: "abilityName"
         *    }
         * }
         *
         * @syscap SystemCapability.Ability.Form
         * @since 20
         */
        ABILITY_NAME_KEY = "ohos.extra.param.key.ability_name",
        /**
         * Indicates the key specifying whether a form type is theme, which is represented as
         * want: {
         *   "parameters": {
         *       THEME_KEY: true
         *    }
         * }
         *
         * @syscap SystemCapability.Ability.Form
         * @systemapi
         * @since 20
         */
        THEME_KEY = 'ohos.extra.param.key.form_is_theme',
        /**
         * Indicates the key specifying the the device ID, which is represented as
         * want: {
         *   "parameters": {
         *       DEVICE_ID_KEY : "EFC11C0C53628D8CC2F8CB5052477E130D075917034613B9884C55CD22B3DEF2"
         *    }
         * }
         *
         * @syscap SystemCapability.Ability.Form
         * @systemapi
         * @since 20
         */
        DEVICE_ID_KEY = "ohos.extra.param.key.device_id",
        
        /**
         * Indicates the key specifying the launch reason of the form to be obtained, which is represented as
         * want: {
         *   "parameters": {
         *       LAUNCH_REASON_KEY: LaunchReason.FORM_DEFAULT
         *    }
         * }
         *
         * @syscap SystemCapability.Ability.Form
         * @since 20
         */
        LAUNCH_REASON_KEY = "ohos.extra.param.key.form_launch_reason",
        
        /**
         * Indicates the key specifying the custom data of the form to be obtained, which is represented as
         * want: {
         *   "parameters": {
         *       PARAM_FORM_CUSTOMIZE_KEY: {
         *          "key": "userData"
         *       }
         *    }
         * }
         *
         * @syscap SystemCapability.Ability.Form
         * @since 20
         */
        PARAM_FORM_CUSTOMIZE_KEY = "ohos.extra.param.key.form_customize",
        /**
         * Indicates the key specifying the form location, which is represented as
         * want: {
         *   "parameters": {
         *       FORM_LOCATION_KEY: FormLocation.DESKTOP
         *    }
         * }.
         *
         * @syscap SystemCapability.Ability.Form
         * @since 20
         */
        FORM_LOCATION_KEY = 'ohos.extra.param.key.form_location',
        
        /**
         * Indicates the key specifying the form rendering mode, which is represented as
         * want: {
         *   "parameters": {
         *       FORM_RENDERING_MODE_KEY: FormRenderingMode.SINGLE_COLOR
         *    }
         * }.
         *
         * @syscap SystemCapability.Ability.Form
         * @since 20
         */
        FORM_RENDERING_MODE_KEY = 'ohos.extra.param.key.form_rendering_mode',
        /**
         * Indicates the key specifying the inverse of the host background color, which is represented as
         * want: {
         *   "parameters": {
         *       HOST_BG_INVERSE_COLOR_KEY: "#FF000000"
         *    }
         * }.
         *
         * @syscap SystemCapability.Ability.Form
         * @since 20
         */
        HOST_BG_INVERSE_COLOR_KEY = 'ohos.extra.param.key.host_bg_inverse_color',
        /**
         * Indicates the key specifying the user granted permission name, which is represented as
         * want: {
         *   "parameters": {
         *       FORM_PERMISSION_NAME_KEY: "permissionName"
         *    }
         * }.
         *
         * @syscap SystemCapability.Ability.Form
         * @since 20
         */
        FORM_PERMISSION_NAME_KEY = 'ohos.extra.param.key.permission_name',
        /**
         * Indicates the key specifying whether the user granted, which is represented as
         * want: {
         *   "parameters": {
         *       FORM_PERMISSION_GRANTED_KEY: true
         *    }
         * }.
         *
         * @syscap SystemCapability.Ability.Form
         * @since 20
         */
        FORM_PERMISSION_GRANTED_KEY = 'ohos.extra.param.key.permission_granted'
    }
    
    /**
     * The optional options used as filters to ask
     * getFormsInfo to return formInfos from only forms that match the options.
     *
     * @typedef FormInfoFilter
     * @syscap SystemCapability.Ability.Form
     * @since 20
     */
    interface FormInfoFilter {
        /**
         * optional bundleName that used to ask getFormsInfo to return
         * form infos with the same bundleName.
         *
         * @type { ?string }
         * @syscap SystemCapability.Ability.Form
         * @systemapi
         * @since 20
         */
        bundleName?: string;
        
        /**
         * optional moduleName that used to ask getFormsInfo to return
         * form infos with the same moduleName.
         *
         * @type { ?string }
         * @syscap SystemCapability.Ability.Form
         * @since 20
         */
        moduleName?: string;
        /**
         * optional supportedDimensions that used to ask getFormsInfo to return
         * form infos with the same supportedDimensions.
         *
         * @type { ?Array<int> }
         * @syscap SystemCapability.Ability.Form
         * @systemapi
         * @since 20
         */
        supportedDimensions?: Array<int>;
        /**
         * optional supportedShapes that used to ask getFormsInfo to return
         * form infos with the same supportedShapes.
         *
         * @type { ?Array<int> }
         * @syscap SystemCapability.Ability.Form
         * @systemapi
         * @since 20
         */
        supportedShapes?: Array<int>;
    }
    
    /**
     * Defines the FormDimension enum.
     *
     * @enum { int }
     * @syscap SystemCapability.Ability.Form
     * @since 20
     */
    enum FormDimension {
        
        /**
         * 1 x 2 form
         *
         * @syscap SystemCapability.Ability.Form
         * @since 20
         */
        Dimension_1_2 = 1,
        
        /**
         * 2 x 2 form
         *
         * @syscap SystemCapability.Ability.Form
         * @since 20
         */
        Dimension_2_2 = 2,
        
        /**
         * 2 x 4 form
         *
         * @syscap SystemCapability.Ability.Form
         * @since 20
         */
        Dimension_2_4 = 3,
        
        /**
         * 4 x 4 form
         *
         * @syscap SystemCapability.Ability.Form
         * @since 20
         */
        Dimension_4_4 = 4,
        /**
         * 1 x 1 form
         *
         * @syscap SystemCapability.Ability.Form
         * @since 20
         */
        DIMENSION_1_1 = 6,
        /**
         * 6 x 4 form
         *
         * @syscap SystemCapability.Ability.Form
         * @since 20
         */
        DIMENSION_6_4 = 7,
        /**
         * 2 x 3 form used for wearable devices
         *
         * @syscap SystemCapability.Ability.Form
         * @since 20
         */
        DIMENSION_2_3 = 8,
        /**
         * 3 x 3 form used for wearable devices
         *
         * @syscap SystemCapability.Ability.Form
         * @since 20
         */
        DIMENSION_3_3 = 9
    }
    /**
     * Defines the FormShape enum.
     *
     * @enum { int }
     * @syscap SystemCapability.Ability.Form
     * @since 20
     */
    enum FormShape {
        /**
         * The rect shape.
         *
         * @syscap SystemCapability.Ability.Form
         * @since 20
         */
        RECT = 1,
        /**
         * The circle shape.
         *
         * @syscap SystemCapability.Ability.Form
         * @since 20
         */
        CIRCLE = 2
    }
    
    /**
     * The visibility of a form.
     *
     * @enum { int }
     * @syscap SystemCapability.Ability.Form
     * @since 20
     */
    enum VisibilityType {
        
        /**
         * Indicates the type of the form type is unknown.
         * Often used as a condition variable in function OnVisibilityChange to specify actions only on forms that are
         * changing to unknown.
         *
         * @syscap SystemCapability.Ability.Form
         * @since 20
         */
        UNKNOWN = 0,
        
        /**
         * Indicates the type of the form is visible.
         * Often used as a condition variable in function OnVisibilityChange to specify actions only on forms that are
         * changing to visible.
         *
         * @syscap SystemCapability.Ability.Form
         * @since 20
         */
        FORM_VISIBLE = 1,
        
        /**
         * Indicates the type of the form is invisible.
         * Often used as a condition variable in function OnVisibilityChange to specify actions only on forms that are
         * changing to invisible.
         *
         * @syscap SystemCapability.Ability.Form
         * @since 20
         */
        FORM_INVISIBLE = 2
    }
    
    /**
     * Indicates the launch reason of a form.
     *
     * @enum { int }
     * @syscap SystemCapability.Ability.Form
     * @since 20
     */
    enum LaunchReason {
        
        /**
         * Indicates the launch reason of a form is default.
         *
         * @syscap SystemCapability.Ability.Form
         * @since 20
         */
        FORM_DEFAULT = 1,
        
        /**
         * Indicates the launch reason of a form is share.
         *
         * @syscap SystemCapability.Ability.Form
         * @since 20
         */
        FORM_SHARE = 2
    }
    /**
     * The result of publish form.
     *
     * @typedef PublishFormResult
     * @syscap SystemCapability.Ability.Form
     * @systemapi
     * @stagemodelonly
     * @since 20
     */
    interface PublishFormResult {
        /**
         * The error code.
         *
         * @type { PublishFormErrorCode }
         * @syscap SystemCapability.Ability.Form
         * @systemapi
         * @stagemodelonly
         * @since 20
         */
        code: PublishFormErrorCode;
        /**
         * The message.
         *
         * @type { string }
         * @syscap SystemCapability.Ability.Form
         * @systemapi
         * @stagemodelonly
         * @since 20
         */
        message: string;
    }
    /**
     * The error code of publish form.
     *
     * @enum { int }
     * @syscap SystemCapability.Ability.Form
     * @systemapi
     * @stagemodelonly
     * @since 20
     */
    enum PublishFormErrorCode {
        /**
         * Publish form success.
         *
         * @syscap SystemCapability.Ability.Form
         * @systemapi
         * @stagemodelonly
         * @since 20
         */
        SUCCESS = 0,
        /**
         * Host has no space to publish form.
         *
         * @syscap SystemCapability.Ability.Form
         * @systemapi
         * @stagemodelonly
         * @since 20
         */
        NO_SPACE = 1,
        /**
         * Check param failed.
         *
         * @syscap SystemCapability.Ability.Form
         * @systemapi
         * @stagemodelonly
         * @since 20
         */
        PARAM_ERROR = 2,
        /**
         * Internal error occurs during form processing.
         *
         * @syscap SystemCapability.Ability.Form
         * @systemapi
         * @stagemodelonly
         * @since 20
         */
        INTERNAL_ERROR = 3
    }
    /**
     * Information about a running form.
     *
     * @typedef FormProviderFilter
     * @syscap SystemCapability.Ability.Form
     * @systemapi
     * @stagemodelonly
     * @since 20
     */
    interface FormProviderFilter {
        /**
         * Obtains the bundle name of the provider application.
         *
         * @type { string }
         * @syscap SystemCapability.Ability.Form
         * @systemapi
         * @stagemodelonly
         * @since 20
         */
        bundleName: string;
        /**
         * Obtains the form name of the provider application form.
         *
         * @type { ?string }
         * @syscap SystemCapability.Ability.Form
         * @systemapi
         * @stagemodelonly
         * @since 20
         */
        formName?: string;
        /**
         * Obtains the module name of the provider application module.
         *
         * @type { ?string }
         * @syscap SystemCapability.Ability.Form
         * @systemapi
         * @stagemodelonly
         * @since 20
         */
        moduleName?: string;
        /**
         * Obtains the ability name of the provider application module.
         *
         * @type { ?string }
         * @syscap SystemCapability.Ability.Form
         * @systemapi
         * @stagemodelonly
         * @since 20
         */
        abilityName?: string;
        /**
         * Indicates whether to include unused form.
         *
         * @type { ?boolean }
         * @default false
         * @syscap SystemCapability.Ability.Form
         * @systemapi
         * @stagemodelonly
         * @since 20
         */
        isUnusedIncluded?: boolean;
    }
    /**
     * The class of a running form information.
     *
     * @typedef RunningFormInfo
     * @syscap SystemCapability.Ability.Form
     * @systemapi hide this for inner system use
     * @since 20
     */
    interface RunningFormInfo {
        /**
         * Obtains the id of the this form.
         *
         * @type { string }
         * @readonly
         * @default -
         * @syscap SystemCapability.Ability.Form
         * @systemapi
         * @since 20
         */
        readonly formId: string;
        /**
         * Obtains the bundle name of the application to which this form belongs.
         *
         * @type { string }
         * @readonly
         * @default -
         * @syscap SystemCapability.Ability.Form
         * @systemapi
         * @since 20
         */
        readonly bundleName: string;
        /**
         * Obtains the bundle name of the form host application.
         *
         * @type { string }
         * @readonly
         * @default -
         * @syscap SystemCapability.Ability.Form
         * @systemapi
         * @since 20
         */
        readonly hostBundleName: string;
        /**
         * The location of this form.
         *
         * @type { FormLocation }
         * @readonly
         * @default -
         * @syscap SystemCapability.Ability.Form
         * @systemapi
         * @since 20
         */
        readonly formLocation: FormLocation;
        /**
         * Obtains the visibility of this form.
         *
         * @type { VisibilityType }
         * @readonly
         * @default -
         * @syscap SystemCapability.Ability.Form
         * @systemapi
         * @since 20
         */
        readonly visibilityType: VisibilityType;
        /**
         * Obtains the name of the application module to which this form belongs.
         *
         * @type { string }
         * @readonly
         * @default -
         * @syscap SystemCapability.Ability.Form
         * @systemapi
         * @since 20
         */
        readonly moduleName: string;
        /**
         * Obtains the class name of the ability to which this form belongs.
         *
         * @type { string }
         * @readonly
         * @default -
         * @syscap SystemCapability.Ability.Form
         * @systemapi
         * @since 20
         */
        readonly abilityName: string;
        /**
         * Obtains the name of this form.
         *
         * @type { string }
         * @readonly
         * @default -
         * @syscap SystemCapability.Ability.Form
         * @systemapi
         * @since 20
         */
        readonly formName: string;
        /**
         * Obtains the grid style of this form.
         *
         * @type { int }
         * @default -
         * @readonly
         * @syscap SystemCapability.Ability.Form
         * @systemapi
         * @since 20
         */
        readonly dimension: int;
        /**
         * Obtains the stage of form use.
         *
         * @type { FormUsageState }
         * @default FormUsageState.USED
         * @readonly
         * @syscap SystemCapability.Ability.Form
         * @systemapi
         * @since 20
         */
        readonly formUsageState: FormUsageState;
        /**
         * Obtains the description of this form.
         *
         * @type { string }
         * @readonly
         * @syscap SystemCapability.Ability.Form
         * @systemapi
         * @since 20
         */
        readonly formDescription: string;
        /**
         * Obtains the extra data of the this form.
         *
         * @type { ?Record<string, Object> }
         * @default -
         * @readonly
         * @syscap SystemCapability.Ability.Form
         * @systemapi
         * @since 20
         */
        readonly extraData?: Record<string, Object>;
    }
    /**
     * The stage of form use.
     *
     * @enum { int }
     * @syscap SystemCapability.Ability.Form
     * @systemapi
     * @since 20
     */
    enum FormUsageState {
        /**
         * Indicates the stage of the form is used.
         *
         * @syscap SystemCapability.Ability.Form
         * @systemapi
         * @since 20
         */
        USED = 0,
        /**
         * Indicates the stage of the form is unused.
         *
         * @syscap SystemCapability.Ability.Form
         * @systemapi
         * @since 20
         */
        UNUSED = 1
    }
    
    /**
     * Defines the FormLocation enum.
     *
     * @enum { int }
     * @syscap SystemCapability.Ability.Form
     * @since 20
     */
    enum FormLocation {
        /**
         * Form is on the other location.
         *
         * @syscap SystemCapability.Ability.Form
         * @systemapi
         * @since 20
         */
        OTHER = -1,
        
        /**
         * Form is on the desktop
         *
         * @syscap SystemCapability.Ability.Form
         * @since 20
         */
        DESKTOP = 0,
        
        /**
         * Form is on the form center.
         *
         * @syscap SystemCapability.Ability.Form
         * @since 20
         */
        FORM_CENTER = 1,
        
        /**
         * Form is on the form manager.
         *
         * @syscap SystemCapability.Ability.Form
         * @since 20
         */
        FORM_MANAGER = 2,
        
        /**
         * Form is on the negative screen.
         *
         * @syscap SystemCapability.Ability.Form
         * @since 20
         */
        NEGATIVE_SCREEN = 3,
        /**
         * Form is on the form center of negative screen.
         *
         * @syscap SystemCapability.Ability.Form
         * @systemapi
         * @since 20
         */
        FORM_CENTER_NEGATIVE_SCREEN = 4,
        /**
         * Form is on the form manager of negative screen.
         *
         * @syscap SystemCapability.Ability.Form
         * @systemapi
         * @since 20
         */
        FORM_MANAGER_NEGATIVE_SCREEN = 5,
        
        /**
         * Form is on the screen lock.
         *
         * @syscap SystemCapability.Ability.Form
         * @since 20
         */
        SCREEN_LOCK = 6,
        
        /**
         * Form is on the ai suggestion.
         *
         * @syscap SystemCapability.Ability.Form
         * @since 20
         */
        AI_SUGGESTION = 7
    }
}
export default formInfo;
