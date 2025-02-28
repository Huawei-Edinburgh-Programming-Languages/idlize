declare namespace window {
  enum WindowType {}
  enum AvoidAreaType {}
  enum WindowMode {}
  enum WindowLayoutMode {}
  enum WindowStatusType {}
  interface SystemBarProperties {}
  interface SystemBarStyle {}
  interface SystemBarRegionTint {}
  interface SystemBarTintState {}
  interface Rect {}
  interface AvoidArea {}
  interface Size {}
  interface WindowInfo {}
  interface WindowDensityInfo {}
  interface WindowProperties {}
  interface DecorButtonStyle {}
  enum ColorSpace {}
  interface ScaleOptions {}
  interface RotateOptions {}
  interface TranslateOptions {}
  interface TransitionContext {}
  interface TransitionController {}
  interface Configuration {}
  interface WindowLimits {}
  interface TitleButtonRect {}
  interface RectChangeOptions {}
  interface AvoidAreaOptions {}
  enum RectChangeReason {}
  function createWindow(config: Configuration, callback: AsyncCallback<Window>): void;
  function createWindow(config: Configuration): Promise<Window>;
  function create(id: string, type: WindowType, callback: AsyncCallback<Window>): void;
  function create(id: string, type: WindowType): Promise<Window>;
  function create(ctx: BaseContext, id: string, type: WindowType): Promise<Window>;
  function create(ctx: BaseContext, id: string, type: WindowType, callback: AsyncCallback<Window>): void;
  function find(id: string, callback: AsyncCallback<Window>): void;
  function find(id: string): Promise<Window>;
  function findWindow(name: string): Window;
  function getTopWindow(callback: AsyncCallback<Window>): void;
  function getTopWindow(): Promise<Window>;
  function getTopWindow(ctx: BaseContext): Promise<Window>;
  function getTopWindow(ctx: BaseContext, callback: AsyncCallback<Window>): void;
  function getLastWindow(ctx: BaseContext, callback: AsyncCallback<Window>): void;
  function getLastWindow(ctx: BaseContext): Promise<Window>;
  function minimizeAll(id: number, callback: AsyncCallback<void>): void;
  function minimizeAll(id: number): Promise<void>;
  function toggleShownStateForAllAppWindows(callback: AsyncCallback<void>): void;
  function toggleShownStateForAllAppWindows(): Promise<void>;
  function setWindowLayoutMode(mode: WindowLayoutMode, callback: AsyncCallback<void>): void;
  function setWindowLayoutMode(mode: WindowLayoutMode): Promise<void>;
  function setGestureNavigationEnabled(enable: boolean, callback: AsyncCallback<void>): void;
  function setGestureNavigationEnabled(enable: boolean): Promise<void>;
  function setWaterMarkImage(pixelMap: image.PixelMap, enable: boolean): Promise<void>;
  function setWaterMarkImage(pixelMap: image.PixelMap, enable: boolean, callback: AsyncCallback<void>): void;
  function shiftAppWindowFocus(sourceWindowId: number, targetWindowId: number): Promise<void>;
  function shiftAppWindowPointerEvent(sourceWindowId: number, targetWindowId: number): Promise<void>;
  function getVisibleWindowInfo(): Promise<Array<WindowInfo>>;
  function getSnapshot(windowId: number): Promise<image.PixelMap>;
  function getWindowsByCoordinate(displayId: number, windowNumber?: number, x?: number, y?: number): Promise<Array<Window>>;
  function getAllWindowLayoutInfo(displayId: number): Promise<Array<WindowLayoutInfo>>;
  function on(type: 'systemBarTintChange', callback: Callback<SystemBarTintState>): void;
  function off(type: 'systemBarTintChange', callback?: Callback<SystemBarTintState>): void;
  function on(type: 'gestureNavigationEnabledChange', callback: Callback<boolean>): void;
  function off(type: 'gestureNavigationEnabledChange', callback?: Callback<boolean>): void;
  function on(type: 'waterMarkFlagChange', callback: Callback<boolean>): void;
  function off(type: 'waterMarkFlagChange', callback?: Callback<boolean>): void;
  enum Orientation {}
  enum BlurStyle {}
  enum WindowEventType {}
  enum MaximizePresentation {}
  interface MoveConfiguration {}
  type SpecificSystemBar = 'status' | 'navigation' | 'navigationIndicator';
  interface Window {}
  enum WindowStageEventType {}
  enum ModalityType {}
  interface SubWindowOptions {}
  interface WindowStage {}
  enum ExtensionWindowAttribute {}
  interface SystemWindowOptions {}
  interface ExtensionWindowConfig {}
  interface WindowLayoutInfo {}
}
export default window;
