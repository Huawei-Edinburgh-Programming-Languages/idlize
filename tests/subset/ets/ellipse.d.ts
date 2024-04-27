interface EllipseInterface {
    new (value?: { width?: string | number; height?: string | number }): EllipseAttribute;
}

declare class EllipseAttribute extends CommonShapeMethod<EllipseAttribute> {
}

declare const Ellipse: EllipseInterface;
declare const EllipseInstance: EllipseAttribute;
