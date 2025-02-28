export interface Size {}
export class DrawContext {}
interface Vector2 {}
 interface Vector2T<T> {}
interface Vector3 {}
export type Matrix4 = [];
export type Offset = Vector2;
export type Position = Vector2;
export type PositionT<T> = Vector2T<T>;
export type Pivot = Vector2;
export type Scale = Vector2;
export type Translation = Vector2;
export type Rotation = Vector3;
export declare interface Frame {}
export interface Edges<T> {}
declare enum LengthUnit {}
export interface SizeT<T> {}
export enum LengthMetricsUnit {}
declare class LengthMetrics {}
declare class ColorMetrics {}
interface Corners<T> {}
export type CornerRadius = Corners<Vector2>;
export type BorderRadiuses = Corners<number>;
export type Rect = common2D.Rect;
export interface RoundRect {}
export interface Circle {}
export interface CommandPath {}
export declare class ShapeMask {}
export declare class ShapeClip {}
export function edgeColors(all: number): Edges<number>;
export function edgeWidths(all: number): Edges<number>;
export function borderStyles(all: BorderStyle): Edges<BorderStyle>;
export function borderRadiuses(all: number): BorderRadiuses;
