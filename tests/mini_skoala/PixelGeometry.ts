export enum PixelGeometry {
    /**
     * Unknown
     */
    UNKNOWN,

    /**
     * Primary colors rgb (red, green, blue) are ordered in horizontal stripes
     */
    RGB_H,

    /**
     * Primary colors bgr (blue, green, red) are ordered in horizontal stripes
     */
    BGR_H,

    /**
     * Primary colors rgb (red, green, blue) are ordered in vertical stripes
     */
    RGB_V,

    /**
     * Primary colors bgr (blue, green, red) are ordered in vertical stripes
     */
    BGR_V
}