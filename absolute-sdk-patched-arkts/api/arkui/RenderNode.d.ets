'use static';
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
import { DrawContext, Size, Offset, Position, Pivot, Scale, Translation, Matrix4, Rotation, Frame, BorderRadiuses, ShapeMask, ShapeClip, Edges, LengthMetricsUnit } from './Graphics';
import { BorderStyle } from './component/enums';

/**
 * Defines RenderNode. Contains node tree operations and render property operations on node.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare class RenderNode {
  /**
   * Constructor.
   *
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  constructor();

  /**
   * Add child to the end of the RenderNode's children.
   *
   * @param { RenderNode } node - The node will be added.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  appendChild(node: RenderNode): void;

  /**
   * Add child to the current RenderNode.
   *
   * @param { RenderNode } child - The node will be added.
   * @param { RenderNode | null } sibling - The new node is added after this node. When sibling is null,
   *     insert node as the first children of the node.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  insertChildAfter(child: RenderNode, sibling: RenderNode | null): void;

  /**
   * Remove child from the current RenderNode.
   *
   * @param { RenderNode } node - The node will be removed.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  removeChild(node: RenderNode): void;

  /**
   * Clear children of the current RenderNode.
   *
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  clearChildren(): void;

  /**
   * Get a child of the current RenderNode by index.
   *
   * @param { number } index - The index of the desired node in the children of RenderNode.
   * @returns { RenderNode | null } - Returns a RenderNode. When the required node does not exist, returns null.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  getChild(index: number): RenderNode | null;

  /**
   * Get the first child of the current RenderNode.
   *
   * @returns {  RenderNode | null } - Returns a RenderNode, which is first child of the current RenderNode.
   *     If current RenderNode does not have child node, returns null.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  getFirstChild(): RenderNode | null;

  /**
   * Get the next sibling node of the current RenderNode.
   *
   * @returns { RenderNode | null } - Returns a RenderNode. If current RenderNode does not have next
   *     sibling node, returns null.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  getNextSibling(): RenderNode | null;

  /**
   * Get the previous sibling node of the current RenderNode.
   *
   * @returns { RenderNode | null } - Returns a RenderNode.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  getPreviousSibling(): RenderNode | null;

  /**
   * Set the background color of the RenderNode.
   *
   * @param { number } color - The background color. Colors are defined as ARGB format represented by number.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  set backgroundColor(color: number);

  /**
   * Get the background color of the RenderNode.
   *
   * @returns { number } - Returns a background color. Colors are defined as ARGB format represented by number.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  get backgroundColor(): number;

  /**
   * Set whether the RenderNode clip to frame.
   *
   * @param { boolean } useClip - Whether the RenderNode clip to frame.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  set clipToFrame(useClip: boolean);

  /**
   * Get whether the RenderNode clip to frame.
   *
   * @returns { boolean } - Returns whether the RenderNode clip to frame.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  get clipToFrame(): boolean;

  /**
   * Set opacity of the RenderNode.
   *
   * @param { number } value - The opacity of the RenderNode.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  set opacity(value: number);

  /**
   * Get opacity of the RenderNode.
   *
   * @returns { number } Returns the opacity of the RenderNode.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  get opacity(): number;

  /**
   * Set frame size of the RenderNode.
   *
   * @param { Size } size - The size of the RenderNode frame.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  set size(size: Size);

  /**
   * Get frame size of the RenderNode.
   *
   * @returns { Size } The size of the RenderNode frame.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  get size(): Size;

  /**
   * Set frame position of the RenderNode.
   *
   * @param { Position } position - The position of the RenderNode frame.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  set position(position: Position);

  /**
   * Get frame position of the RenderNode.
   *
   * @returns { Position } - The position of the RenderNode frame.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  get position(): Position;

  /**
   * Set frame info of the RenderNode.
   *
   * @param { Frame } frame - The frame info of the RenderNode frame.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  set frame(frame: Frame);

  /**
   * Get frame info of the RenderNode.
   *
   * @returns { Frame } - Returns frame info of the RenderNode.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  get frame(): Frame;

  /**
   * Set pivot of the RenderNode.
   *
   * @param { Pivot } pivot - The pivot of the RenderNode.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  set pivot(pivot: Pivot);

  /**
   * Get pivot vector of the RenderNode.
   *
   * @returns { Pivot } - Returns pivot vector of the RenderNode.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  get pivot(): Pivot;

  /**
   * Set scale of the RenderNode.
   *
   * @param { Scale } scale - The scale of the RenderNode.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  set scale(scale: Scale);

  /**
   * Get scale vector of the RenderNode.
   *
   * @returns { Scale } - Returns scale vector of the RenderNode.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  get scale(): Scale;

  /**
   * Set translation of the RenderNode.
   *
   * @param { Translation } translation - the translate vector of the RenderNode.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  set translation(translation: Translation);

  /**
   * Get translation vector of the RenderNode.
   *
   * @returns { Translation } - Returns translation vector of the RenderNode.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  get translation(): Translation;

  /**
   * Set rotation vector of the RenderNode.
   *
   * @param { Rotation } rotation - The rotation vector of the RenderNode.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  set rotation(rotation: Rotation);

  /**
   * Get rotation vector of the RenderNode.
   *
   * @returns { Rotation } - Returns rotation vector of the RenderNode.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  get rotation(): Rotation;

  /**
   * Set transform info of the RenderNode.
   *
   * @param { Matrix4 } transform - the transform info of the RenderNode.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  set transform(transform: Matrix4);

  /**
   * Get transform info of the RenderNode.
   *
   * @returns {Matrix4 } - Returns transform info of the RenderNode.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  get transform(): Matrix4;

  /**
   * Set shadow color of the RenderNode.
   *
   * @param { number } color - the shadow color of the RenderNode. Colors are defined as ARGB format represented by
   * number.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  set shadowColor(color: number);

  /**
   * Get shadow color of the RenderNode.
   *
   * @returns { number } - Returns the shadow color of the RenderNode. Colors are defined as ARGB format represented by
   * number.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  get shadowColor(): number;

  /**
   * Set shadow offset of the RenderNode.
   *
   * @param { Offset } offset - the shadow offset of the RenderNode.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  set shadowOffset(offset: Offset);

  /**
   * Get shadow offset of the RenderNode.
   *
   * @returns { Offset } - Returns the shadow offset of the RenderNode.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  get shadowOffset(): Offset;

  /**
   * Set label of the RenderNode.
   *
   * @param { string } label - the label of the RenderNode.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  set label(label: string);

  /**
   * Get label of the RenderNode.
   *
   * @returns { string } - Returns the label of the RenderNode.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  get label(): string;

  /**
   * Set shadow alpha of the RenderNode.
   *
   * @param { number } alpha - the shadow alpha of the RenderNode.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  set shadowAlpha(alpha: number);

  /**
   * Get shadow alpha of the RenderNode.
   *
   * @returns { number } - Returns the shadow alpha of the RenderNode.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  get shadowAlpha(): number;

  /**
   * Set shadow elevation of the RenderNode.
   *
   * @param { number } elevation - the shadow elevation of the RenderNode.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  set shadowElevation(elevation: number);

  /**
   * Get shadow elevation of the RenderNode.
   *
   * @returns { number } - Returns the shadow elevation of the RenderNode.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  get shadowElevation(): number;

  /**
   * Set shadow radius of the RenderNode.
   *
   * @param { number } radius - the shadow radius of the RenderNode.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  set shadowRadius(radius: number);

  /**
   * Get shadow radius of the RenderNode.
   *
   * @returns { number } - Returns the shadow radius of the RenderNode.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  get shadowRadius(): number;

  /**
   * Set border style of the RenderNode.
   *
   * @param { Edges<BorderStyle> } style - the border style of the RenderNode.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  set borderStyle(style: Edges<BorderStyle>);

  /**
   * Get border style of the RenderNode.
   *
   * @returns { Edges<BorderStyle> } - Returns the border style of the RenderNode.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  get borderStyle(): Edges<BorderStyle>;

  /**
   * Set border width of the RenderNode.
   *
   * @param { Edges<number> } width - the border width of the RenderNode.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  set borderWidth(width: Edges<number>);

  /**
   * Get border width of the RenderNode.
   *
   * @returns { Edges<number> } - Returns the border width of the RenderNode.
   * @default 0
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  get borderWidth(): Edges<number>;

  /**
   * Set border color of the RenderNode.
   *
   * @param { Edges<number> } color - the border color of the RenderNode.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  set borderColor(color: Edges<number>);

  /**
   * Get border color of the RenderNode.
   *
   * @returns { Edges<number> } - Returns the border color of the RenderNode.
   * @default 0XFF000000
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  get borderColor(): Edges<number>;

  /**
   * Set border radius of the RenderNode.
   *
   * @param { BorderRadiuses } radius - the border radius of the RenderNode.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  set borderRadius(radius: BorderRadiuses);

  /**
   * Get border radius of the RenderNode.
   *
   * @returns { BorderRadiuses } - Returns the border radius of the RenderNode.
   * @default 0
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  get borderRadius(): BorderRadiuses;

  /**
   * Set shape mask of the RenderNode.
   *
   * @param { ShapeMask } shapeMask - the shape mask of the RenderNode.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  set shapeMask(shapeMask: ShapeMask);

  /**
   * Get shape mask of the RenderNode.
   *
   * @returns { ShapeMask } - Returns the shape mask of the RenderNode.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  get shapeMask(): ShapeMask;

  /**
   * Set shape clip of the RenderNode.
   *
   * @param { ShapeClip } shapeClip - the shape clip of the RenderNode.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  set shapeClip(shapeClip: ShapeClip);

  /**
   * Get shape clip of the RenderNode.
   *
   * @returns { ShapeClip } - Returns the shape clip of the RenderNode.
   * @syscap SystemCapability.ArkUI.ArkUI.clip
   * @since 20
   */
  get shapeClip(): ShapeClip;

  /**
   * Mark whether to preferentially draw the node and its children.
   *
   * @param { boolean } isNodeGroup - The parameter indicates whether to preferentially draw the node and its children.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  set markNodeGroup(isNodeGroup: boolean);

  /**
   * Get whether to preferentially draw the node and its children.
   *
   * @returns { boolean } - Return whether to preferentially draw the node and its children.
   * @default false
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  get markNodeGroup(): boolean;

  /**
   * Draw Method. Executed when the associated RenderNode is onDraw.
   *
   * @param { DrawContext } context - The DrawContext will be used when executed draw method.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  draw(context: DrawContext): void;

  /**
   * Invalidate the RenderNode, which will cause a re-render of the RenderNode.
   *
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  invalidate(): void;

  /**
   * Dispose the RenderNode immediately.
   *
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  dispose(): void;

  /**
   * Set the length metrics unit of RenderNode.
   *
   * @param { LengthMetricsUnit } unit - The length metrics unit of RenderNode.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  set lengthMetricsUnit(unit: LengthMetricsUnit);

  /**
   * Get the length metrics unit of RenderNode.
   *
   * @returns { LengthMetricsUnit } - Return the length metrics unit of RenderNode.
   * @default LengthMetricsUnit.DEFAULT
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  get lengthMetricsUnit(): LengthMetricsUnit;
}
