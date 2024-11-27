
// TODO: there should be no buffer in index-full.d.ts
type buffer = ArrayBuffer

// This is to workaround index-full.d.ts generation
declare interface ContentModifier<T> {
}
declare interface LinearGradient {
    angle?: number | KStringPtr;
    direction?: GradientDirection;
    colors: Array<[ ResourceColor, number ]>;
    repeating?: boolean;
}
declare interface LayoutChild {
    name: KStringPtr;
    id: KStringPtr;
    constraint: ConstraintSizeOptions;
    borderInfo: LayoutBorderInfo;
    position: Position;
}

