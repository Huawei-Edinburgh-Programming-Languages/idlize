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

import { RenderNode } from './RenderNode';
import { Size, Position, Edges, LengthMetrics, SizeT } from './Graphics';
import { DrawContext } from './Graphics';
import { ComponentContent } from './ComponentContent';
import { BusinessError } from '../@ohos.base';
import { UIContext } from '@ohos.arkui.UIContext';
import { UICommonEvent, UIGestureEvent, CommonAttribute, CustomProperty } from './component/common';
import { SwiperAttribute, SwiperController } from './component/swiper';
import { ScrollAttribute, Scroller } from './component/scroll';
import { ListAttribute, ListOptions } from './component/list';
import { ListItemAttribute, ListItemOptions } from './component/listItem';
import { ListItemGroupAttribute, ListItemGroupOptions } from './component/listItemGroup';
import { WaterFlowAttribute, WaterFlowOptions } from './component/waterFlow';
import { FlowItemAttribute } from './component/flowItem';
import { GridAttribute, GridLayoutOptions } from './component/grid';
import { GridItemAttribute, GridItemOptions } from './component/gridItem';
import { Resource } from '../global/resource';
import { TextAttribute, TextOptions } from './component/text';
import { TextInputAttribute, TextInputOptions } from './component/textInput';
import { TextAreaAttribute, TextAreaOptions } from './component/textArea';
import { SearchAttribute, SearchOptions } from './component/search';
import { SymbolGlyphAttribute } from './component/symbolglyph';
import { MarqueeAttribute, MarqueeOptions } from './component/marquee';
import { ColumnAttribute, ColumnOptions, ColumnOptionsV2 } from './component/column';
import { RowAttribute, RowOptions, RowOptionsV2 } from './component/row';
import { StackAttribute, StackOptions } from './component/stack';
import { FlexAttribute, FlexOptions } from './component/flex';
import { RelativeContainerAttribute } from './component/relativeContainer';
import { DividerAttribute } from './component/divider';
import { BlankAttribute } from './component/blank';
import { GridRowAttribute, GridRowOptions } from './component/gridRow';
import { GridColAttribute, GridColOptions } from './component/gridCol';
import { ProgressAttribute, ProgressOptions } from './component/progress';
import { QRCodeAttribute } from './component/qrcode';
import { BadgeAttribute, BadgeParamWithNumber, BadgeParamWithString } from './component/badge';
import { TextClockAttribute, TextClockOptions } from './component/textClock';
import { TextTimerAttribute, TextTimerOptions } from './component/textTimer';
import { ImageAttribute, ImageContent } from './component/image';
import { DrawableDescriptor } from '../@ohos.arkui.drawableDescriptor';
import { ButtonAttribute, ButtonOptions } from './component/button';
import { CheckboxOptions, CheckboxAttribute } from './component/checkbox';
import { RadioOptions, RadioAttribute } from './component/radio';
import { SliderAttribute, SliderOptions } from './component/slider';
import { ToggleAttribute, ToggleOptions } from './component/toggle';
import { CheckboxGroupAttribute, CheckboxGroupOptions } from './component/checkboxgroup';
import { RatingAttribute, RatingOptions } from './component/rating';
import { XComponentAttribute, XComponentController, XComponentOptions, XComponentParameters, NativeXComponentParameters } from './component/xcomponent';

/**
 * Layout constraint, include the max size, the min size and the reference size for children to calculate percent.
 *
 * @interface LayoutConstraint
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface LayoutConstraint {
  /**
   * MaxSize
   *
   * @type { Size }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  maxSize: Size;

  /**
   * MinSize
   *
   * @type { Size }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  minSize: Size;

  /**
   * PercentReference, if the size unit of the child nodes is percentage, then they use PercentReference to calculate
   * the px size.
   *
   * @type { Size }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  percentReference: Size;
}

/**
 * Defines the cross-language options.
 *
 * @interface CrossLanguageOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
declare interface CrossLanguageOptions {
  /**
   * Defines if it enables setting attributes cross-language. Default value is false.
   *
   * @type { ?boolean }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  attributeSetting?: boolean;
}

/**
 * Enum for the expand mode.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export enum ExpandMode {
  /**
   * Do not expand the children of node.
   *
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  NOT_EXPAND = 0,

  /**
   * Expand the children of node.
   *
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  EXPAND = 1,

  /**
   * Expand the children of node if needed.
   *
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  LAZY_EXPAND = 2
}

/**
 * Defines FrameNode.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 * @noninterop
 */
export declare class FrameNode {
  /**
   * Constructor.
   *
   * @param { UIContext } uiContext - uiContext used to create the FrameNode
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  constructor(uiContext: UIContext);

  /**
   * Get the RenderNode in FrameNode.
   *
   * @returns { RenderNode | null } - Returns a RenderNode inside the FrameNode, or null if not contained.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  getRenderNode(): RenderNode | null;

  /**
   * Return a flag to indicate whether the current FrameNode can be modified.
   * Indicates whether the FrameNode supports appendChild, insertChildAfter, removeChild, clearChildren.
   *
   * @returns { boolean } - Returns true if the FrameNode can be modified, otherwise return false.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  isModifiable(): boolean;

  /**
   * Add child to the end of the FrameNode's children.
   *
   * @param { FrameNode } node - The node will be added.
   * @throws { BusinessError } 100021 - The FrameNode is not modifiable.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  appendChild(node: FrameNode): void;

  /**
   * Add child to the current FrameNode.
   *
   * @param { FrameNode } child - The node will be added.
   * @param { FrameNode | null } sibling - The new node is added after this node. When sibling is null, insert
   *     node as the first children of the node.
   * @throws { BusinessError } 100021 - The FrameNode is not modifiable.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  insertChildAfter(child: FrameNode, sibling: FrameNode | null): void;

  /**
   * Remove child from the current FrameNode.
   *
   * @param { FrameNode } node - The node will be removed.
   * @throws { BusinessError } 100021 - The FrameNode is not modifiable.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  removeChild(node: FrameNode): void;

  /**
   * Clear children of the current FrameNode.
   *
   * @throws { BusinessError } 100021 - The FrameNode is not modifiable.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  clearChildren(): void;

  /**
   * Get a child of the current FrameNode by index.
   *
   * @param { number } index - The index of the desired node in the children of FrameNode.
   * @param { ExpandMode | undefined } [expandMode] - The expand mode. Default value is ExpandMode.EXPAND.
   * @returns { FrameNode | null } - Returns a FrameNode. When the required node does not exist, returns null.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  getChild(index: number, expandMode?: ExpandMode | undefined): FrameNode | null;

  /**
   * Get the index of the current FrameNode's first child node which is on the tree.
   *
   * @returns { number } - Returns the index of the current FrameNode's first child node which is on the tree.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  getFirstChildIndexWithoutExpand(): number;

  /**
   * Get the index of the current FrameNode's last child node which is on the tree.
   *
   * @returns { number } - Returns the index of the current FrameNode's last child node which is on the tree.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  getLastChildIndexWithoutExpand(): number;

  /**
   * Get the first child of the current FrameNode.
   *
   * @returns {  FrameNode | null } - Returns a FrameNode, which is first child of the current FrameNode.
   * If current FrameNode does not have child node, returns null.
   * If current FrameNode does not have child node, returns null.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  getFirstChild(): FrameNode | null;

  /**
   * Get the next sibling node of the current FrameNode.
   *
   * @returns { FrameNode | null } - Returns a FrameNode. If current FrameNode does not have next sibling node,
   * returns null.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  getNextSibling(): FrameNode | null;

  /**
   * Get the previous sibling node of the current FrameNode.
   *
   * @returns { FrameNode | null } - Returns a FrameNode. If current FrameNode does not have previous sibling node,
   * returns null.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  getPreviousSibling(): FrameNode | null;

  /**
   * Get the parent node of the current FrameNode.
   *
   * @returns { FrameNode | null } - Returns a FrameNode. If current FrameNode does not have parent node, returns null.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  getParent(): FrameNode | null;

  /**
   * Get the children count of the current FrameNode.
   *
   * @returns { number } - Returns the number of the children of the current FrameNode.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  getChildrenCount(): number;

  /**
   * Move node to the target Framenode as child.
   *
   * @param { FrameNode } targetParent - The target parent node.
   * @param { number } [index] - The index which the node is moved to. If the value is a negative number or invalid,
   * the node is moved to the end of the target parent node. Moves to the end of the target parent node by default.
   * @throws { BusinessError } 100021 - The FrameNode is not modifiable.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  moveTo(targetParent: FrameNode, index?: number): void;

  /**
   * Dispose the FrameNode immediately.
   *
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  dispose(): void;

  /**
   * Get the position of the node relative to window.
   *
   * @returns { Position } - Returns position of the node relative to window.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  getPositionToWindow(): Position;

  /**
   * Get if the FrameNode is disposed.
   *
   * @returns { boolean } - Returns true if the FrameNode is disposed, false otherwise.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  isDisposed(): boolean;

  /**
   * Get the position of the node relative to its parent.
   *
   * @returns { Position } - Returns position of the node relative to its parent.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  getPositionToParent(): Position;

  /**
   * Get the size of the FrameNode after measure, with unit PX.
   *
   * @returns { Size } - Returns the size of the FrameNode after measure, with unit PX.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  getMeasuredSize(): Size;

  /**
   * Get the offset to the parent of the FrameNode after layout, with unit PX.
   *
   * @returns { Position } - Returns the offset to the parent of the FrameNode after layout, with unit PX.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  getLayoutPosition(): Position;

  /**
   * Get the user config border width of the FrameNode.
   *
   * @returns { Edges<LengthMetrics> } - Returns the user config border width of the FrameNode.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  getUserConfigBorderWidth(): Edges<LengthMetrics>;

  /**
   * Get the user config padding of the FrameNode.
   *
   * @returns { Edges<LengthMetrics> } - Returns the user config padding of the FrameNode.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  getUserConfigPadding(): Edges<LengthMetrics>;

  /**
   * Get the user config margin of the FrameNode.
   *
   * @returns { Edges<LengthMetrics> } - Returns the user config margin of the FrameNode.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  getUserConfigMargin(): Edges<LengthMetrics>;

  /**
   * Get the user config size of the FrameNode.
   *
   * @returns { SizeT<LengthMetrics> } - Returns the user config size of the FrameNode.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  getUserConfigSize(): SizeT<LengthMetrics>;

  /**
   * Get the id of the FrameNode.
   *
   * @returns { string } - Returns the id of the FrameNode.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  getId(): string;

  /**
   * Get the unique id of the FrameNode.
   *
   * @returns { number } - Returns the unique id of the FrameNode.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  getUniqueId(): number;

  /**
   * Get the type of the FrameNode. The type is the name of component, for example, the nodeType of Button is "Button",
   * and the nodeType of custom  component is "__Common__".
   *
   * @returns { string } - Returns the type of the FrameNode.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  getNodeType(): string;

  /**
   * Get the opacity of the FrameNode.
   *
   * @returns { number } - Returns the opacity of the FrameNode.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  getOpacity(): number;

  /**
   * Get if the FrameNode is visible.
   *
   * @returns { boolean } - Returns if the FrameNode is visible.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  isVisible(): boolean;

  /**
   * Get if the FrameNode is clip to frame.
   *
   * @returns { boolean } - Returns if the FrameNode is clip to frame.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  isClipToFrame(): boolean;

  /**
   * Get if the FrameNode is attached to the root node tree.
   *
   * @returns { boolean } - Returns if the FrameNode is attached to the root node tree.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  isAttached(): boolean;

  /**
   * Get the inspector information of the FrameNode.
   *
   * @returns { Object } - Returns the inspector information of the FrameNode.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  getInspectorInfo(): Object;

  /**
   * Get the custom property of the component corresponding to this FrameNode.
   *
   * @param { string } name - the name of the custom property.
   * @returns { CustomProperty } - Returns the value of the custom property.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  getCustomProperty(name: string): CustomProperty;

  /**
   * Set commonEvent response to the current FrameNode.
   *
   * @returns { UICommonEvent } - Returns a Object inside the FrameNode, which is used to set callbacks about different
   * events.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  get commonEvent(): UICommonEvent;

  /**
   * Get gestureEvent of the current FrameNode.
   *
   * @returns { UIGestureEvent } - Returns a Object inside the FrameNode, which is used to set callbacks about different
   * gesture events.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  get gestureEvent(): UIGestureEvent;

  /**
   * Get the CommonAttribute of the current FrameNode.
   *
   * @returns { CommonAttribute } - Returns the CommonAttribute which is used to modify the common attributes of the
   * FrameNode.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  get commonAttribute(): CommonAttribute;

  /**
   * Method to measure the FrameNode and its content to determine the measured size. Use this method to override the
   * default measure method when measuring the FrameNode.
   *
   * @param { LayoutConstraint } constraint - The layout constraint of the node, will be used when executed measure
   * method.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  onMeasure(constraint: LayoutConstraint): void;

  /**
   * Method to assign a position to the FrameNode and each of its children. Use this method to override the
   * default layout method.
   *
   * @param { Position } position - The position of the node, will be used when executed layout method.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  onLayout(position: Position): void;

  /**
   * Set the size of the FrameNode after measure, with unit PX.
   *
   * @param { Size } size - The size of the FrameNode after measure.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  setMeasuredSize(size: Size): void;

  /**
   * Set the position to the parent of the FrameNode after layout, with unit PX.
   *
   * @param { Position } position - The position to the parent of the FrameNode after layout.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  setLayoutPosition(position: Position): void;

  /**
   * This is called to find out how big the FrameNode should be. The parent node supplies constraint information. The
   * actual measurement work of the FrameNode is performed in onMeasure or the default measure method.
   *
   * @param { LayoutConstraint } constraint - The layout constraint of the node, supplied by the parent node.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  measure(constraint: LayoutConstraint): void;

  /**
   * This is called to assign position to the FrameNode and all of its descendants. The position is used to init
   * the position of the frameNode, and the actual layout work of FrameNode is performed in onLayout or the default
   * layout method.
   *
   * @param { Position } position - The position of the node, will be used when executed the layout method.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  layout(position: Position): void;

  /**
   * Mark the frame node as need layout.
   *
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  setNeedsLayout(): void;

  /**
   * Invalidate the RenderNode in the FrameNode, which will cause a re-render of the RenderNode.
   *
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  invalidate(): void;

  /**
   * Get the position of the node relative to screen.
   *
   * @returns { Position } - Returns position of the node relative to screen.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  getPositionToScreen(): Position;

  /**
   * Get the position of the node relative to unified display, in vp.
   *
   * @returns { Position } - Returns position of the node relative to unified display, in vp.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  getGlobalPositionOnDisplay(): Position;

  /**
   * Get the position of the node relative to window with transform.
   *
   * @returns { Position } - Returns position of the node relative to window with transform.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  getPositionToWindowWithTransform(): Position;

  /**
   * Get the position of the node relative to its parent with transform.
   *
   * @returns { Position } - Returns position of the node relative to its parent with transform.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  getPositionToParentWithTransform(): Position;

  /**
   * Get the position of the node relative to screen with transform.
   *
   * @returns { Position } - Returns position of the node relative to screen with transform.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  getPositionToScreenWithTransform(): Position;

  /**
   * Detach from parent and dispose all child recursively.
   *
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  disposeTree(): void;

  /**
   * Mount ComponentContent to FrameNode.
   * 
   * @param { ComponentContent<T> } content - Newly added ComponentContent.
   * @throws { BusinessError } 100021 - The FrameNode is not modifiable.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  addComponentContent<T extends Object>(content: ComponentContent<T>): void;

  /**
   * Set the cross-language options of the target FrameNode.
   *
   * @param { CrossLanguageOptions } value - The cross-language options.
   * @throws { BusinessError } 100022 - The FrameNode cannot be set whether to support cross-language common attribute
   *     setting.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  setCrossLanguageOptions(value: CrossLanguageOptions): void;

  /**
   * Get the cross-language options of the target FrameNode.
   *
   * @returns { CrossLanguageOptions } - Returns the cross-language options of the target FrameNode.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  getCrossLanguageOptions(): CrossLanguageOptions;

  /**
   * Recycle current FrameNode From JsFrameNode.
   *
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  recycle(): void;

  /**
   * Reuse current FrameNode From JsFrameNode.
   *
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  reuse(): void;

  /**
  * Returns a flag indicating whether the current FrameNode was obtained through dynamic-static conversion,
  * includes conversions in both directions: dynamic-to-static and static-to-dynamic.
  *
  * @returns { boolean } - Returns true if the FrameNode was converted between dynamic and static states,
  * otherwise returns false.
  * @syscap SystemCapability.ArkUI.ArkUI.Full
  * @since 20
  */
  isTransferred(): boolean;
}

/**
 * Used to define the FrameNode type.
 *
 * @extends FrameNode
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 * @noninterop
 */
export declare abstract class TypedFrameNode<T> extends FrameNode {
    /**
     * Get attribute instance of FrameNode to set attributes.
     *
     * @returns { T } - Returns the attribute instance of FrameNode.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    get attribute(): T;
}

/**
 * Provides methods to implement FrameNode.
 *
 * @namespace typeNode
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 * @noninterop
 */
export declare namespace typeNode {
  /**
   * Create a FrameNode. Overload for createNode functions.
   *
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  overload createNode {
    createTextNode,
    createSearchNode,
    createTextInputNode,
    createTextAreaNode,
    createSymbolGlyphNode,
    createMarqueeNode,
    createSwiperNode,
    createListNode,
    createListItemNode,
    createListItemGroupNode,
    createScrollNode,
    createGridNode,
    createGridItemNode,
    createWaterFlowNode,
    createFlowItemNode,
    createColumnNode,
    createRowNode,
    createStackNode,
    createFlexNode,
    createRelativeContainerNode,
    createGridRowNode,
    createGridColNode,
    createDividerNode,
    createBlankNode,
    createXComponentNodeDefault,
    createXComponentNodeWithOptions,
    createXComponentNodeWithNativeParameters
  }

  /**
   * Define the Column type of FrameNode.
   *
   * @extends TypedFrameNode<ColumnAttribute>
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  abstract class ColumnFrameNode extends TypedFrameNode<ColumnAttribute> {  
    /**
     * Initialize Column FrameNode.
     *
     * @param { ColumnOptions | ColumnOptionsV2} [options] - Column options.
     * @returns { ColumnAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    abstract initialize(options?: ColumnOptions | ColumnOptionsV2): ColumnAttribute;
  }

  /**
   * Define the FrameNode type for Column.
   *
   * @typedef { ColumnFrameNode } Column
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  type Column = ColumnFrameNode;

  /**
   * Create a FrameNode of Column type.
   *
   * @param { UIContext } context - uiContext used to create the FrameNode.
   * @param { 'Column' } nodeType - node type.
   * @returns { Column } - Return Column type FrameNode.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  export function createColumnNode(context: UIContext, nodeType: 'Column'): Column;

  /**
   * Define the Row type of FrameNode.
   *
   * @extends TypedFrameNode<RowAttribute>
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  abstract class RowFrameNode extends TypedFrameNode<RowAttribute> {  
    /**
     * Initialize Row FrameNode.
     *
     * @param { RowOptions | RowOptionsV2} [options] - Row options.
     * @returns { RowAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    abstract initialize(options?: RowOptions | RowOptionsV2): RowAttribute;
  }

  /**
   * Define the FrameNode type for Row.
   *
   * @typedef { RowFrameNode } Row
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  type Row = RowFrameNode;

  /**
   * Create a FrameNode of Row type.
   *
   * @param { UIContext } context - uiContext used to create the FrameNode.
   * @param { 'Row' } nodeType - node type.
   * @returns { Row } - Return Row type FrameNode.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  export function createRowNode(context: UIContext, nodeType: 'Row'): Row;

  /**
   * Define the Stack type of FrameNode.
   *
   * @extends TypedFrameNode<StackAttribute>
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  abstract class StackFrameNode extends TypedFrameNode<StackAttribute> {  
    /**
     * Initialize Stack FrameNode.
     *
     * @param { StackOptions } [options] - Stack options.
     * @returns { StackAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    abstract initialize(options?: StackOptions): StackAttribute;
  }

  /**
   * Define the FrameNode type for Stack.
   *
   * @typedef { StackFrameNode } Stack
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  type Stack = StackFrameNode;

  /**
   * Create a FrameNode of Stack type.
   *
   * @param { UIContext } context - uiContext used to create the FrameNode.
   * @param { 'Stack' } nodeType - node type.
   * @returns { Stack } - Return Stack type FrameNode.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  export function createStackNode(context: UIContext, nodeType: 'Stack'): Stack;

  /**
   * Define the GridRow type of FrameNode.
   *
   * @extends TypedFrameNode<GridRowAttribute>
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  abstract class GridRowFrameNode extends TypedFrameNode<GridRowAttribute> {  
    /**
     * Initialize GridRow FrameNode.
     *
     * @param { GridRowOptions } [options] - GridRow options.
     * @returns { GridRowAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    abstract initialize(options?: GridRowOptions): GridRowAttribute;
  }

  /**
   * Define the FrameNode type for GridRow.
   *
   * @typedef { GridRowFrameNode } GridRow
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  type GridRow = GridRowFrameNode;

  /**
   * Create a FrameNode of GridRow type.
   *
   * @param { UIContext } context - uiContext used to create the FrameNode.
   * @param { 'GridRow' } nodeType - node type.
   * @returns { GridRow } - Return GridRow type FrameNode.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  export function createGridRowNode(context: UIContext, nodeType: 'GridRow'): GridRow;

  /**
   * Define the GridCol type of FrameNode.
   *
   * @extends TypedFrameNode<GridColAttribute>
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  abstract class GridColFrameNode extends TypedFrameNode<GridColAttribute> {  
    /**
     * Initialize GridCol FrameNode.
     *
     * @param { GridColOptions } [options] - GridCol options.
     * @returns { GridColAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    abstract initialize(options?: GridColOptions): GridColAttribute;
  }

  /**
   * Define the FrameNode type for GridCol.
   *
   * @typedef { GridColFrameNode } GridCol
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  type GridCol = GridColFrameNode;

  /**
   * Create a FrameNode of GridCol type.
   *
   * @param { UIContext } context - uiContext used to create the FrameNode.
   * @param { 'GridCol' } nodeType - node type.
   * @returns { GridCol } - Return GridCol type FrameNode.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  export function createGridColNode(context: UIContext, nodeType: 'GridCol'): GridCol;

  /**
   * Define the Flex type of FrameNode.
   *
   * @extends TypedFrameNode<FlexAttribute>
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  abstract class FlexFrameNode extends TypedFrameNode<FlexAttribute> {  
    /**
     * Initialize Flex FrameNode.
     *
     * @param { FlexOptions } [value] - Flex options.
     * @returns { FlexAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    abstract initialize(value?: FlexOptions): FlexAttribute;
  }

  /**
   * Define the FrameNode type for Flex.
   *
   * @typedef { FlexFrameNode } Flex
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  type Flex = FlexFrameNode;

  /**
   * Create a FrameNode of Flex type.
   *
   * @param { UIContext } context - uiContext used to create the FrameNode.
   * @param { 'Flex' } nodeType - node type.
   * @returns { Flex } - Return Flex type FrameNode.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  export function createFlexNode(context: UIContext, nodeType: 'Flex'): Flex;

  /**
   * Define the RelativeContainer type of FrameNode.
   *
   * @extends TypedFrameNode<RelativeContainerAttribute>
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  abstract class RelativeContainerFrameNode extends TypedFrameNode<RelativeContainerAttribute> {  
    /**
     * Initialize RelativeContainer FrameNode.
     *
     * @returns { RelativeContainerAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    abstract initialize(): RelativeContainerAttribute;
  }

  /**
   * Define the FrameNode type for RelativeContainer.
   *
   * @typedef { RelativeContainerFrameNode } RelativeContainer
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  type RelativeContainer = RelativeContainerFrameNode;

  /**
   * Create a FrameNode of RelativeContainer type.
   *
   * @param { UIContext } context - uiContext used to create the FrameNode.
   * @param { 'RelativeContainer' } nodeType - node type.
   * @returns { RelativeContainer } - Return RelativeContainer type FrameNode.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  export function createRelativeContainerNode(context: UIContext, nodeType: 'RelativeContainer'): RelativeContainer;

  /**
   * Define the Divider type of FrameNode.
   *
   * @extends TypedFrameNode<DividerAttribute>
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  abstract class DividerFrameNode extends TypedFrameNode<DividerAttribute> {  
    /**
     * Initialize Divider FrameNode.
     *
     * @returns { DividerAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    abstract initialize(): DividerAttribute;
  }

  /**
   * Define the FrameNode type for Divider.
   *
   * @typedef { DividerFrameNode } Divider
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  type Divider = DividerFrameNode;

  /**
   * Create a FrameNode of Divider type.
   *
   * @param { UIContext } context - uiContext used to create the FrameNode.
   * @param { 'Divider' } nodeType - node type.
   * @returns { Divider } - Return Divider type FrameNode.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  export function createDividerNode(context: UIContext, nodeType: 'Divider'): Divider;

  /**
   * Define the Blank type of FrameNode.
   *
   * @extends TypedFrameNode<BlankAttribute>
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  abstract class BlankFrameNode extends TypedFrameNode<BlankAttribute> {  
    /**
     * Initialize Blank FrameNode.
     *
     * @param { number | string} [min] - Blank options.
     * @returns { BlankAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    abstract initialize(min?: number | string): BlankAttribute;
  }

  /**
   * Define the FrameNode type for Blank.
   *
   * @typedef { BlankFrameNode } Blank
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  type Blank = BlankFrameNode;

  /**
   * Create a FrameNode of Blank type.
   *
   * @param { UIContext } context - uiContext used to create the FrameNode.
   * @param { 'Blank' } nodeType - node type.
   * @returns { Blank } - Return Blank type FrameNode.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  export function createBlankNode(context: UIContext, nodeType: 'Blank'): Blank;

  /**
   * Define the List type of FrameNode.
   *
   * @extends TypedFrameNode<ListAttribute>
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  abstract class ListFrameNode extends TypedFrameNode<ListAttribute> {  
    /**
     * Initialize FrameNode.
     *
     * @param { ListOptions } [options] - list options
     * @returns { ListAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    abstract initialize(options?: ListOptions): ListAttribute;
  }

  /**
   * Define the FrameNode type for List.
   *
   * @typedef { ListFrameNode } List
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  type List = ListFrameNode;

  /**
   * Create a FrameNode of List type.
   *
   * @param { UIContext } context - uiContext used to create the FrameNode.
   * @param { 'List' } nodeType - node type.
   * @returns { List } - Return List type FrameNode.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  export function createListNode(context: UIContext, nodeType: 'List'): List;

  /**
   * Define the ListItem type of FrameNode.
   *
   * @extends TypedFrameNode<ListItemAttribute>
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  abstract class ListItemFrameNode extends TypedFrameNode<ListItemAttribute> {
    /**
     * Initialize ListItem FrameNode.
     *
     * @param { ListItemOptions } [options] - list item options.
     * @returns { ListItemAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    abstract initialize(options?: ListItemOptions): ListItemAttribute;
  }

  /**
   * Define the FrameNode type for ListItem.
   *
   * @typedef { ListItemFrameNode } ListItem
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  type ListItem = ListItemFrameNode;

  /**
   * Create a FrameNode of ListItem type.
   *
   * @param { UIContext } context - uiContext used to create the FrameNode.
   * @param { 'ListItem' } nodeType - node type.
   * @returns { ListItem } - Return ListItem type FrameNode.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  export function createListItemNode(context: UIContext, nodeType: 'ListItem'): ListItem;

  /**
   * Define the ListItemGroup type of FrameNode.
   *
   * @extends TypedFrameNode<ListItemGroupAttribute>
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  abstract class ListItemGroupFrameNode extends TypedFrameNode<ListItemGroupAttribute> {
    /**
     * Initialize ListItemGroup FrameNode.
     *
     * @param { ListItemGroupOptions } [options] - list item group options.
     * @returns { ListItemGroupAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    abstract initialize(options?: ListItemGroupOptions): ListItemGroupAttribute;
  }

  /**
   * Define the FrameNode type for ListItemGroup.
   *
   * @typedef { ListItemGroupFrameNode } ListItemGroup
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  type ListItemGroup = ListItemGroupFrameNode;

  /**
   * Create a FrameNode of ListItemGroup type.
   *
   * @param { UIContext } context - uiContext used to create the FrameNode.
   * @param { 'ListItemGroup' } nodeType - node type.
   * @returns { ListItemGroup } - Return ListItemGroup type FrameNode.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  export function createListItemGroupNode(context: UIContext, nodeType: 'ListItemGroup'): ListItemGroup;

  /**
   * Define the Scroll type of FrameNode.
   *
   * @extends TypedFrameNode<ScrollAttribute>
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  abstract class ScrollFrameNode extends TypedFrameNode<ScrollAttribute> {
    /**
     * Initialize Scroll FrameNode.
     *
     * @param { Scroller } [scroller] - The controller for scroll.
     * @returns { ScrollAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    abstract initialize(scroller?: Scroller): ScrollAttribute;
  }

  /**
   * Define the FrameNode type for Scroll.
   *
   * @typedef { ScrollFrameNode } Scroll
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  type Scroll = ScrollFrameNode;

  /**
   * Create a FrameNode of Scroll type.
   *
   * @param { UIContext } context - uiContext used to create the FrameNode.
   * @param { 'Scroll' } nodeType - node type.
   * @returns { Scroll } - Return Scroll type FrameNode.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  export function createScrollNode(context: UIContext, nodeType: 'Scroll'): Scroll;

  /**
   * Define the Grid type of FrameNode.
   *
   * @extends TypedFrameNode<GridAttribute>
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  abstract class GridFrameNode extends TypedFrameNode<GridAttribute> {
    /**
     * Initialize Grid FrameNode.
     *
     * @param { Scroller } [scroller] - The controller for grid.
     * @param { GridLayoutOptions } [layoutOptions] - Grid layout options.
     * @returns { GridAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    abstract initialize(scroller?: Scroller, layoutOptions?: GridLayoutOptions): GridAttribute;
  }

  /**
   * Define the FrameNode type for Grid.
   *
   * @typedef { GridFrameNode } Grid
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  type Grid = GridFrameNode;

  /**
   * Create a FrameNode of Grid type.
   *
   * @param { UIContext } context - uiContext used to create the FrameNode.
   * @param { 'Grid' } nodeType - node type.
   * @returns { Grid } - Return Grid type FrameNode.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  export function createGridNode(context: UIContext, nodeType: 'Grid'): Grid;

  /**
   * Define the GridItem type of FrameNode.
   *
   * @extends TypedFrameNode<GridItemAttribute>
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  abstract class GridItemFrameNode extends TypedFrameNode<GridItemAttribute> {
    /**
     * Initialize GridItem FrameNode.
     *
     * @param { GridItemOptions } [options] - Grid item options.
     * @returns { GridItemAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    abstract initialize(options?: GridItemOptions): GridItemAttribute;
  }

  /**
   * Define the FrameNode type for GridItem.
   *
   * @typedef { GridItemFrameNode } GridItem
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  type GridItem = GridItemFrameNode;

  /**
   * Create a FrameNode of GridItem type.
   *
   * @param { UIContext } context - uiContext used to create the FrameNode.
   * @param { 'GridItem' } nodeType - node type.
   * @returns { GridItem } - Return GridItem type FrameNode.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  export function createGridItemNode(context: UIContext, nodeType: 'GridItem'): GridItem;

  /**
   * Define the WaterFlow type of FrameNode.
   *
   * @extends TypedFrameNode<WaterFlowAttribute>
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  abstract class WaterFlowFrameNode extends TypedFrameNode<WaterFlowAttribute> {
    /**
     * Initialize WaterFlow FrameNode.
     *
     * @param { WaterFlowOptions } [options] - WaterFlow options.
     * @returns { WaterFlowAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    abstract initialize(options?: WaterFlowOptions): WaterFlowAttribute;
  }

  /**
   * Define the FrameNode type for WaterFlow.
   *
   * @typedef { WaterFlowFrameNode } WaterFlow
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  type WaterFlow = WaterFlowFrameNode;

  /**
   * Create a FrameNode of WaterFlow type.
   *
   * @param { UIContext } context - uiContext used to create the FrameNode.
   * @param { 'WaterFlow' } nodeType - node type.
   * @returns { WaterFlow } - Return WaterFlow type FrameNode.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  export function createWaterFlowNode(context: UIContext, nodeType: 'WaterFlow'): WaterFlow;

  /**
   * Define the FlowItem type of FrameNode.
   *
   * @extends TypedFrameNode<FlowItemAttribute>
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  abstract class FlowItemFrameNode extends TypedFrameNode<FlowItemAttribute> {
    /**
     * Initialize FlowItem FrameNode.
     *
     * @returns { FlowItemAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    abstract initialize(): FlowItemAttribute;
  }

  /**
   * Define the FrameNode type for FlowItem.
   *
   * @typedef { FlowItemFrameNode } FlowItem
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  type FlowItem = FlowItemFrameNode;

  /**
   * Create a FrameNode of FlowItem type.
   *
   * @param { UIContext } context - uiContext used to create the FrameNode.
   * @param { 'FlowItem' } nodeType - node type.
   * @returns { FlowItem } - Return FlowItem type FrameNode.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  export function createFlowItemNode(context: UIContext, nodeType: 'FlowItem'): FlowItem;

  /**
   * Define the Text type of FrameNode.
   *
   * @extends TypedFrameNode<TextAttribute>
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  abstract class TextFrameNode extends TypedFrameNode<TextAttribute> {
    /**
     * Initialize Text FrameNode.
     *
     * @param { string | Resource } [content] - text content
     * @param { TextOptions } [value] - text options
     * @returns { TextAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    abstract initialize(content?: string | Resource, value?: TextOptions): TextAttribute;
  }

  /**
   * Define the FrameNode type for Text.
   *
   * @typedef { TextFrameNode } Text
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  type Text = TextFrameNode;

  /**
   * Create a FrameNode of Text type.
   *
   * @param { UIContext } context - uiContext used to create the FrameNode.
   * @param { 'Text' } nodeType - node type.
   * @returns { Text } - Return Text type FrameNode.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  export function createTextNode(context: UIContext, nodeType: 'Text'): Text;

  /**
   * Define the Search type of FrameNode.
   *
   * @extends TypedFrameNode<SearchAttribute>
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  abstract class SearchFrameNode extends TypedFrameNode<SearchAttribute> {
    /**
     * Initialize Search FrameNode.
     *
     * @param { SearchOptions } [value] - search options
     * @returns { SearchAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    abstract initialize(value?: SearchOptions): SearchAttribute;
  }

  /**
   * Define the FrameNode type for Search.
   *
   * @typedef { SearchFrameNode } Search
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  type Search = SearchFrameNode;

  /**
   * Create a FrameNode of Search type.
   *
   * @param { UIContext } context - uiContext used to create the FrameNode.
   * @param { 'Search' } nodeType - node type.
   * @returns { Search } - Return Search type FrameNode.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  export function createSearchNode(context: UIContext, nodeType: 'Search'): Search;

  /**
   * Define the TextInput type of FrameNode.
   *
   * @extends TypedFrameNode<TextInputAttribute>
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  abstract class TextInputFrameNode extends TypedFrameNode<TextInputAttribute> {
    /**
     * Initialize TextInput FrameNode.
     *
     * @param { TextInputOptions } [value] - textInput options
     * @returns { TextInputAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    abstract initialize(value?: TextInputOptions): TextInputAttribute;
  }

  /**
   * Define the FrameNode type for TextInput.
   *
   * @typedef { TextInputFrameNode } TextInput
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  type TextInput = TextInputFrameNode;

  /**
   * Create a FrameNode of TextInput type.
   *
   * @param { UIContext } context - uiContext used to create the FrameNode.
   * @param { 'TextInput' } nodeType - node type.
   * @returns { TextInput } - Return TextInput type FrameNode.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  export function createTextInputNode(context: UIContext, nodeType: 'TextInput'): TextInput;

  /**
   * Define the TextArea type of FrameNode.
   *
   * @extends TypedFrameNode<TextAreaAttribute>
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  abstract class TextAreaFrameNode extends TypedFrameNode<TextAreaAttribute> {
    /**
     * Initialize TextArea FrameNode.
     *
     * @param { TextAreaOptions } [value] - textArea options
     * @returns { TextAreaAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    abstract initialize(value?: TextAreaOptions): TextAreaAttribute;
  }

  /**
   * Define the FrameNode type for TextArea.
   *
   * @typedef { TextAreaFrameNode } TextArea
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  type TextArea = TextAreaFrameNode;

  /**
   * Create a FrameNode of TextArea type.
   *
   * @param { UIContext } context - uiContext used to create the FrameNode.
   * @param { 'TextArea' } nodeType - node type.
   * @returns { TextArea } - Return TextArea type FrameNode.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  export function createTextAreaNode(context: UIContext, nodeType: 'TextArea'): TextArea;

  /**
   * Define the SymbolGlyph type of FrameNode.
   *
   * @extends TypedFrameNode<SymbolGlyphAttribute>
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  abstract class SymbolGlyphFrameNode extends TypedFrameNode<SymbolGlyphAttribute> {
    /**
     * Initialize SybolGlyph FrameNode.
     *
     * @param { Resource } [value] - symbolGlyph resource
     * @returns { SymbolGlyphAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    abstract initialize(value?: Resource): SymbolGlyphAttribute;
  }

  /**
   * Define the FrameNode type for SymbolGlyph.
   *
   * @typedef { SymbolGlyphFrameNode } SymbolGlyph
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  type SymbolGlyph = SymbolGlyphFrameNode;

  /**
   * Create a FrameNode of SymbolGlyph type.
   *
   * @param { UIContext } context - uiContext used to create the FrameNode.
   * @param { 'SymbolGlyph' } nodeType - node type.
   * @returns { SymbolGlyph } - Return SymbolGlyph type FrameNode.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  export function createSymbolGlyphNode(context: UIContext, nodeType: 'SymbolGlyph'): SymbolGlyph;

  /**
   * Define the Marquee type of FrameNode.
   *
   * @extends TypedFrameNode<MarqueeAttribute>
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  abstract class MarqueeFrameNode extends TypedFrameNode<MarqueeAttribute> {
    /**
     * Initialize Marquee FrameNode.
     *
     * @param { MarqueeOptions } value
     * @returns { MarqueeAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    abstract initialize(value: MarqueeOptions): MarqueeAttribute;
  }

  /**
   * Define the FrameNode type for Marquee.
   *
   * @typedef { MarqueeFrameNode } Marquee
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  type Marquee = MarqueeFrameNode;

  /**
   * Create a FrameNode of Marquee type.
   *
   * @param { UIContext } context - uiContext used to create the FrameNode.
   * @param { 'Marquee' } nodeType - node type.
   * @returns { Marquee } - Return Marquee type FrameNode.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  export function createMarqueeNode(context: UIContext, nodeType: 'Marquee'): Marquee;

  /**
   * Define the Swiper type of FrameNode.
   *
   * @extends TypedFrameNode<SwiperAttribute>
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  abstract class SwiperFrameNode extends TypedFrameNode<SwiperAttribute> {
    /**
     * Initialize FrameNode.
     *
     * @param { SwiperController } [controller] - a controller for Swiper container components.
     * @returns { SwiperAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    abstract initialize(controller?: SwiperController): SwiperAttribute;
  }

  /**
   * Define the FrameNode type for Swiper.
   *
   * @typedef { SwiperFrameNode } Swiper
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  type Swiper = SwiperFrameNode;

  /**
   * Create a FrameNode of Swiper type.
   *
   * @param { UIContext } context - uiContext used to create the FrameNode.
   * @param { 'Swiper' } nodeType - node type.
   * @returns { Swiper } - Return Swiper type FrameNode.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  export function createSwiperNode(context: UIContext, nodeType: 'Swiper'): Swiper;

  /**
   * Defines the XComponent type of FrameNode.
   * 
   * @extends TypedFrameNode<XComponentAttribute>
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  abstract class XComponentFrameNode extends TypedFrameNode<XComponentAttribute> {
    /**
     * Initialize XComponent FrameNode.
     * 
     * @param { XComponentParameters } value - Indicates the options of the xcomponent.
     * @returns { XComponentAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    abstract initialize(value: XComponentParameters): XComponentAttribute;

    /**
     * Initialize XComponent FrameNode.
     * 
     * @param { XComponentOptions } value - Indicates the options of the xcomponent.
     * @returns { XComponentAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    abstract initialize(value: XComponentOptions): XComponentAttribute;

    /**
     * Initialize XComponent FrameNode.
     * 
     * @param { NativeXComponentParameters } params - Indicates the constructor parameters of the
     *  xcomponent for native developing.
     *
     * @returns { XComponentAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    abstract initialize(params: NativeXComponentParameters): XComponentAttribute;
  }

  /**
   * Define the FrameNode type for XComponent.
   *
   * @typedef { XComponentFrameNode } XComponent
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  type XComponent = XComponentFrameNode;

  /**
   * Create a FrameNode of XComponent type.
   *
   * @param { UIContext } context - uiContext used to create the FrameNode.
   * @param { 'XComponent' } nodeType - node type.
   * @returns { XComponent } - Return XComponent type FrameNode.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  export function createXComponentNodeDefault(context: UIContext, nodeType: 'XComponent'): XComponent;

  /**
   * Create a FrameNode of XComponent type with options.
   *
   * @param { UIContext } context - uiContext used to create the FrameNode.
   * @param { 'XComponent' } nodeType - node type.
   * @param { XComponentOptions } value - initialization parameters.
   * @returns { XComponent } - Return XComponent type FrameNode.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  export function createXComponentNodeWithOptions(context: UIContext, nodeType: 'XComponent', value: XComponentOptions): XComponent;

  /**
   * Create a FrameNode of XComponent type with options for native developing.
   *
   * @param { UIContext } context - uiContext used to create the FrameNode.
   * @param { 'XComponent' } nodeType - node type.
   * @param { NativeXComponentParameters } parameters - initialization parameters.
   * @returns { XComponent } - Return XComponent type FrameNode.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  export function createXComponentNodeWithNativeParameters(
    context: UIContext, nodeType: 'XComponent', parameters: NativeXComponentParameters): XComponent;
}

/**
 * Used for lazy loading of typeNode.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 * @noninterop
 */
export declare class NodeAdapter {
  /**
   * Constructor.
   *
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  constructor();
  /**
   * Dispose the NodeAdapter immediately.
   *
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  dispose(): void;

  /**
   * Get if the NodeAdapter is disposed.
   *
   * @returns { boolean } - Returns true if the NodeAdapter is disposed, false otherwise.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  isDisposed(): boolean;
  /**
   * Set the total number of node count.
   *
   * @param { number } count - The total number of node count.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  set totalNodeCount(count: number);
  /**
   * Get the total number of node count.
   *
   * @returns { number } - Return the total number of node count.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  get totalNodeCount(): number;
  /**
   * Define the operation of reloading all data.
   *
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  reloadAllItems(): void;
  /**
   * Define the data reload operation.Reload a specified amount of data starting from the index value.
   *
   * @param { number } start - Start loading index values for data.
   * @param { number } count - Load the number of data.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  reloadItem(start: number, count: number): void;
  /**
   * Define data deletion operations.Delete a specified amount of data starting from the index value.
   *
   * @param { number } start - Start deleting index values for data.
   * @param { number } count - Delete the number of data.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  removeItem(start: number, count: number): void;
  /**
   * Define data insertion operations.Insert a specified amount of data starting from the index value.
   *
   * @param { number } start - Start Insert index values for data.
   * @param { number } count - Insert the number of data.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  insertItem(start: number, count: number): void;
  /**
   * Define data movement operations. Move data from the starting index to the ending index.
   *
   * @param { number } from - Starting index value.
   * @param { number } to - End index value.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  moveItem(from: number, to: number): void;
  /**
   * Obtain all data results.
   *
   * @returns { Array<FrameNode> } - Return all valid FrameNode collections.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  getAllAvailableItems(): Array<FrameNode>;
    /**
     * This callback will be triggered when a FrameNode is bound.
     *
     * @param { FrameNode } target - The bound FrameNode node.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onAttachToNode(target: FrameNode): void;
    /**
     * This callback will be triggered when the binding is released.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onDetachFromNode(): void;
    /**
     * Call this callback when loading for the first time or when a new node slides in.Used to generate custom IDs,
     * developers need to ensure the uniqueness of the IDs themselves.
     *
     * @param { number } index - Load the index value of the data.
     * @returns { number } - Returning the developer's custom ID requires the developer to ensure its uniqueness.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onGetChildId(index: number): number;
    /**
     * Call this callback when loading for the first time or when a new node slides in.
     *
     * @param { number } index - Load the index value of the data.
     * @returns { FrameNode } - Returns the FrameNode node that loads the node.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onCreateChild(index: number): FrameNode;
    /**
     * Called when the child node is about to be destroyed.
     *
     * @param { number } id - The child node ID that is about to be destroyed.
     * @param { FrameNode } node - The FrameNode node that is about to be destroyed.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onDisposeChild(id: number, node: FrameNode): void;
  /**
   * Call this callback when reloading or reusing.
   *
   * @param { number } id - The child node ID that is about to be reloaded.
   * @param { FrameNode } node - Reused FrameNode nodes.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  onUpdateChild(id: number, node: FrameNode): void;
  /**
   * Add a NodeAdapter to bind to the node.A node can only be bound to one NodeAdapter. Binding failure returns false.
   *
   * @param { NodeAdapter } adapter - Define lazy loading classes.
   * @param { FrameNode } node - The bound FrameNode node.
   * @returns { boolean } Return the binding result.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  static attachNodeAdapter(adapter: NodeAdapter, node: FrameNode): boolean;
  /**
   * Remove the bound NodeAdapter from the node.A node can only be bound to one NodeAdapter.
   *
   * @param { FrameNode } node - Unbind the FrameNode node.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  static detachNodeAdapter(node: FrameNode): void;
}
