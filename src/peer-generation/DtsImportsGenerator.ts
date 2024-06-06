const dtsImports = `import {
    AltOffset,
    AttributeModifier,
    BackgroundBlurStyleOptions,
    BindOptions,
    BlankAttribute,
    BlurOptions,
    BlurStyle,
    BlurStyleOptions,
    Color,
    CommonAttribute,
    CommonMethod,
    CommonShapeMethod,
    DragInteractionOptions,
    DragPreviewOptions,
    Length,
    Offset,
    Padding,
    Position,
    Resource,
    ResourceStr,
    ResourceColor,
    ScrollableCommonMethod,
    SheetOptions,
    SheetSize,
    StateStyles,
    SheetTitleOptions,
    CustomComponent
} from "./dts-exports"
`

export function collectDtsImports() {
    return dtsImports // for now
}