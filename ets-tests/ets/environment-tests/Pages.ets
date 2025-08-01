/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
import { assert, suite, test } from "@koalaui/harness"
import { TestController } from "../TestHarness"
import { suiteComponentLifeCycle } from './suites/ComponentLifeCycle'
import { suiteStateManagement } from './suites/StateManagement'
import { suiteLinkDecorator } from './suites/LinkDecorator'
import { suitePropDecorator } from './suites/PropDecorator'
import { suiteProvideConsumeDecorators } from './suites/ProvideConsume'
import { suiteWatchDecorator } from './suites/WatchDecoratorTest'
import { suiteAppLocalStorage } from './suites/StorageTests'
import { suiteAttributeModifier } from './suites/AttributeModifier'
import { suiteBuilderDecorator } from './suites/BuilderDecoratorTest'
import { suiteBuilderParamDecorator } from './suites/BuilderParamDecoratorTest'
import { suiteObservedTest } from './suites/ObservedTest'
import { suiteScreenshotService } from './suites/ScreenshotService'
import { suiteDrawModifier } from './suites/DrawModifier'
import { suiteTrackDecorator } from './suites/TrackDecoratorTests'
import { suiteRenderServiceNode } from './suites/RenderServiceNodeTest';
import { suiteTraceDecorator } from './suites/TraceDecoratorTests';
import { InitializationFromParent } from "./pages/states/InitializationFromParent"
import { StateIncrement } from "./pages/states/StateIncrement"
import { StateDecrement } from "./pages/states/StateDecrement"
import { UndefinedStateVariable } from "./pages/states/UndefinedStateVariable"
import { ObservableDate } from "./pages/states/ObservableDate"
import { ObservableArray } from "./pages/states/ObservableArray"
import { ObservableDateArray } from "./pages/states/ObservableDateArray"
import { ObservableMap } from "./pages/states/ObservableMap"
import { ObservableObject } from "./pages/states/ObservableObject"
import { ObservableSet } from "./pages/states/ObservableSet"
import { LinkSimpleNumberBinding } from "./pages/links/LinkSimpleNumberBinding"
import { DateSyncTest } from "./pages/links/DateSyncTest"
import { LinkUnionStringNullTest } from "./pages/links/LinkUnionStringNullTest"
import { ObjectPropertyMutationTest } from "./pages/links/ObjectPropertyMutationTest"
import { DeepLinkPropagationTest } from "./pages/links/DeepLinkPropagationTest"
import { LinkArrayBindingTest } from "./pages/links/LinkArrayBindingTest"
import { LinkBooleanTest } from "./pages/links/LinkBooleanTest"
import { LinkEnumTest } from "./pages/links/LinkEnumTest"
import { LinkMapTest } from "./pages/links/LinkMapTest"
import { LinkObjectTest } from "./pages/links/LinkObjectTest"
import { LinkSetTest } from "./pages/links/LinkSetTest"
import { PropTest } from "./pages/props/PropTest"
import { PropMutateTest } from "./pages/props/PropMutateTest"
import { PropStringTest } from "./pages/props/PropStringTest"
import { PropBoolTest } from "./pages/props/PropBoolTest"
import { PropLocalInitTest } from "./pages/props/PropLocalInitTest"
import { PropSetTest } from "./pages/props/PropSetTest"
import { PropMapTest } from "./pages/props/PropMapTest"
import { PropParentChildBasicTest } from "./pages/props/PropParentChildBasicTest"
import { PropDateParentChildTest } from "./pages/props/PropDateParentChildTest"
import { PropIndependentChildTest } from "./pages/props/PropIndependentChildTest"
import { PropArrayChildElement } from "./pages/props/PropArrayChildElement"
import { ProvideConsumeBaseTest } from "./pages/provide/ProvideConsumeBaseTest"
import { ProvideConsumeObject } from "./pages/provide/ProvideConsumeObject"
import { ProvideConsumeChildTest } from "./pages/provide/ProvideConsumeChildTest"
import { ProvideConsumeMapTest } from "./pages/provide/ProvideConsumeMapTest"
import { ProvideConsumeSetTest } from "./pages/provide/ProvideConsumeSetTest"
import { ProvideConsumeOverride } from "./pages/provide/ProvideConsumeOverride"
import { ProvideConsumeNoOverride } from "./pages/provide/ProvideConsumeNoOverride"
import { OnDidBuildSupport } from "./pages/lifecycle/OnDidBuildSupport"
import { WatchAppStorageLink, WatchAppStorageProp } from "./pages/watch/WatchAppStorage"
import { WatchLink } from "./pages/watch/WatchLink"
import { WatchLocalStorage } from "./pages/watch/WatchLocalStorage"
// import { WatchObjectLink } from "./pages/watch/WatchObjectLink"
import { WatchProp } from "./pages/watch/WatchProp"
import { WatchProvideConsume } from "./pages/watch/WatchProvideConsume"
import { WatchState } from "./pages/watch/WatchState"
import { AppStorageLinkTest } from "./pages/storage/AppStorageLinkTest"
import { AppStoragePropTest } from "./pages/storage/AppStoragePropTest"
import { LocalStorageLinkTest } from "./pages/storage/LocalStorageLinkTest"
import { LocalStoragePropTest } from "./pages/storage/LocalStoragePropTest"
import { StorageLinkUpdateTest } from "./pages/storage/StorageLinkUpdateTest"
import { AttributeUpdaterTest } from "./pages/AttributeUpdaterTest"
import { LinkDecorator } from "./pages/links/LinkDecorator"
import { DrawModifierTest } from "./pages/DrawModifierTest"
import { BuilderGlobalFunction } from "./pages/builder/BuilderGlobalFunction"
import { BuilderMultipleNesting } from "./pages/builder/BuilderMultipleNesting"
// import { BuilderParamDecorator } from "./pages/builder/BuilderParamDecorator"
import { BuilderParamWithLocalBuilder, BuilderParamWithLocalBuilderBuilderFunction } from "./pages/builder/BuilderParamWithLocalBuilder"
import { BuilderParamWithThis } from "./pages/builder/BuilderParamWithThis"
import { BuilderParamWithThisChanging } from "./pages/builder/BuilderParamWithThisChanging"
import { BuilderPrivateFunction } from "./pages/builder/BuilderPrivateFunction"
import { BuilderSeveralParams } from "./pages/builder/BuilderSeveralParams"
import { BuilderSomeTypes } from "./pages/builder/BuilderSomeTypes"
import { LocalBuilderDecorator, LocalBuilderDecoratorParamsByValue, LocalBuilderDecoratorMultipleValues } from "./pages/builder/LocalBuilderDecorator"
// import { ObjectLinkInitialization } from "./pages/observed/ObjectLinkInitialization"
// import { ObjectLinkInitializer } from "./pages/observed/ObjectLinkInitializer"
// import { ObservedArray } from "./pages/observed/ObservedArray"
// import { ObservedExtended } from "./pages/observed/ObservedExtended"
// import { ObservedObjectLink } from "./pages/observed/ObservedObjectLink"
// import { ObservedProp } from "./pages/observed/ObservedProp"
// import { ObservedUnion } from "./pages/observed/ObservedUnion"
import { ObservedObject } from "./pages/observed/ObservedObject"

import { registerPageByNameFunction } from "../utils"
import { LinkCollectionBindingTest } from "./pages/links/LinkCollectionBindingTest"

import { PropDateTest } from "./pages/props/PropDateTest"
import { PropArrayMutationTest } from "./pages/props/PropArrayMutationTest"
import { AboutToAppear } from "./pages/lifecycle/AboutToAppear"
import { PageCallbacks } from "./pages/lifecycle/PageCallbacks"
import { TrackObject } from "./pages/track/TrackObject"
import { RenderServiceNodePage } from './pages/RenderServiceNodePage';
import { ComponentArray } from "./pages/lifecycle/ComponentArray"
import { Reusable, ReusableArray, ReusableTwoArrays, ReusableParent } from "./pages/lifecycle/Reusable"
import { TraceDecorator } from "./pages/observedv2/TraceDecorator"
import { StaticTraceDecorator } from "./pages/observedv2/StaticTraceDecorator"
import { ScreenshotServiceTest } from "./pages/ScreenshotServiceTest"
import { PageSwitch } from "./pages/lifecycle/PageSwitch"

@memo
function pageByName(name: string): void {
    switch (name) {
        case "StateIncrement": StateIncrement(); break
        case "StateDecrement": StateDecrement(); break
        case "InitializationFromParent": InitializationFromParent(); break
        case "LinkDecorator": LinkDecorator(); break
        case "UndefinedStateVariable": UndefinedStateVariable(); break
        case "ObservableDate": ObservableDate(); break
        case "ObservableArray": ObservableArray(); break
        case "ObservableDateArray": ObservableDateArray(); break
        case "ObservableMap": ObservableMap(); break
        case "ObservableObject": ObservableObject(); break
        case "ObservableSet": ObservableSet(); break
        case "LinkSimpleNumberBinding": LinkSimpleNumberBinding(); break
        case "DateSyncTest": DateSyncTest(); break
        case "LinkUnionStringNullTest": LinkUnionStringNullTest(); break
        case "ObjectPropertyMutationTest": ObjectPropertyMutationTest(); break
        case "DeepLinkPropagationTest": DeepLinkPropagationTest(); break
        case "LinkArrayBindingTest": LinkArrayBindingTest(); break
        case "LinkBooleanTest": LinkBooleanTest(); break
        case "LinkEnumTest": LinkEnumTest(); break
        case "LinkMapTest": LinkMapTest(); break
        case "LinkObjectTest": LinkObjectTest(); break
        case "LinkSetTest": LinkSetTest(); break
        case "PropTest": PropTest(); break
        case "PropMutateTest": PropMutateTest(); break
        case "PropStringTest": PropStringTest(); break
        case "PropBoolTest": PropBoolTest(); break
        case "PropLocalInitTest": PropLocalInitTest(); break
        case "PropSetTest": PropSetTest(); break
        case "PropMapTest": PropMapTest(); break
        case "PropDateParentChildTest": PropDateParentChildTest(); break
        case "PropParentChildBasicTest": PropParentChildBasicTest(); break
        case "PropIndependentChildTest": PropIndependentChildTest(); break
        case "PropArrayChildElement": PropArrayChildElement(); break
        case "ProvideConsumeBaseTest": ProvideConsumeBaseTest(); break
        case "ProvideConsumeObject": ProvideConsumeObject(); break
        case "ProvideConsumeChildTest": ProvideConsumeChildTest(); break
        case "ProvideConsumeMapTest": ProvideConsumeMapTest(); break
        case "ProvideConsumeSetTest": ProvideConsumeSetTest(); break
        case "ProvideConsumeOverride": ProvideConsumeOverride(); break
        case "ProvideConsumeNoOverride": ProvideConsumeNoOverride(); break
        case "OnDidBuildSupport": OnDidBuildSupport(); break
        case "AboutToAppear": AboutToAppear(); break
        case "WatchAppStorageLink": WatchAppStorageLink(); break
        case "WatchAppStorageProp": WatchAppStorageProp(); break
        case "WatchLink": WatchLink(); break
        case "WatchLocalStorage": WatchLocalStorage(); break
        // case "WatchObjectLink": WatchObjectLink(); break
        case "WatchProp": WatchProp(); break
        case "WatchProvideConsume": WatchProvideConsume(); break
        case "WatchState": WatchState(); break
        case "AppStorageLinkTest": AppStorageLinkTest(); break
        case "AppStoragePropTest": AppStoragePropTest(); break
        case "LocalStorageLinkTest": LocalStorageLinkTest(); break
        case "LocalStoragePropTest": LocalStoragePropTest(); break
        case "StorageLinkUpdateTest": StorageLinkUpdateTest(); break
        case "LinkCollectionBindingTest": LinkCollectionBindingTest(); break
        case "PropDateTest": PropDateTest(); break
        case "PropArrayMutationTest": PropArrayMutationTest(); break
        case "AttributeUpdaterTest": AttributeUpdaterTest(); break
        case "BuilderGlobalFunction": BuilderGlobalFunction(); break
        case "BuilderMultipleNesting": BuilderMultipleNesting(); break
        // case "BuilderParamDecorator": BuilderParamDecorator(); break
        case "BuilderParamWithLocalBuilder": BuilderParamWithLocalBuilder(); break
        case "BuilderParamWithLocalBuilderBuilderFunction": BuilderParamWithLocalBuilderBuilderFunction(); break
        case "BuilderParamWithThis": BuilderParamWithThis(); break
        case "BuilderParamWithThisChanging": BuilderParamWithThisChanging(); break
        case "BuilderPrivateFunction": BuilderPrivateFunction(); break
        case "BuilderSeveralParams": BuilderSeveralParams(); break
        case "BuilderSomeTypes": BuilderSomeTypes(); break
        case "LocalBuilderDecorator": LocalBuilderDecorator(); break
        case "LocalBuilderDecoratorParamsByValue": LocalBuilderDecoratorParamsByValue(); break
        case "LocalBuilderDecoratorMultipleValues": LocalBuilderDecoratorMultipleValues(); break
        case "PageCallbacks": PageCallbacks(); break
        case "RenderServiceNodePage": RenderServiceNodePage(); break
        case "ComponentArray": ComponentArray(); break
        case "Reusable": Reusable(); break
        case "ReusableArray": ReusableArray(); break
        case "ReusableTwoArrays": ReusableTwoArrays(); break
        case "ReusableParent": ReusableParent(); break
        // case "ObjectLinkInitialization": ObjectLinkInitialization(); break
        // case "ObjectLinkInitializer": ObjectLinkInitializer(); break
        // case "ObservedArray": ObservedArray(); break
        // case "ObservedExtended": ObservedExtended(); break
        // case "ObservedObjectLink": ObservedObjectLink(); break
        // case "ObservedProp": ObservedProp(); break
        // case "ObservedUnion": ObservedUnion(); break
        case "ObservedObject": ObservedObject(); break
        case "TrackObject": TrackObject(); break
        case "ScreenshotServiceTest": ScreenshotServiceTest(); break
        case "DrawModifierTest": DrawModifierTest(); break
        case "TraceDecorator": TraceDecorator(); break
        case "StaticTraceDecorator": StaticTraceDecorator(); break
        case "PageSwitch": PageSwitch(); break
        case "": break
        default: throw new Error(`No test case ${name} provided!`)
    }
}

export function Suites(control: TestController) {
    registerPageByNameFunction(pageByName)
    suite("ETS_TESTS", () => {
        suiteComponentLifeCycle(control)
        suiteStateManagement(control)
        suiteLinkDecorator(control)
        suitePropDecorator(control)
        suiteProvideConsumeDecorators(control)
        suiteAppLocalStorage(control)
        suiteBuilderDecorator(control)
        suiteBuilderParamDecorator(control)
        suiteWatchDecorator(control)
        suiteObservedTest(control)
        suiteAttributeModifier(control)
        suiteDrawModifier(control)
        suiteTrackDecorator(control)
        suiteRenderServiceNode(control)
        suiteTraceDecorator(control)
        suiteScreenshotService(control)
    })
}