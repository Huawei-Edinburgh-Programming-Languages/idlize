declare enum HorizontalAlign {
    Start,
    Center,
    End,
}

declare class ColumnAttribute extends CommonMethod<ColumnAttribute> {

    alignItems(value: HorizontalAlign): ColumnAttribute;

    bindContentCover(isShow: boolean, builder: CustomBuilder, type?: ModalTransition): ColumnAttribute;
    bindContentCover(isShow: boolean, builder: CustomBuilder, options?: ContentCoverOptions): ColumnAttribute;
}