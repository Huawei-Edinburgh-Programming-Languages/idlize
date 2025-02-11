export namespace samplestructs {
    export function currentOffset() : OffsetResult;

    export interface OffsetResult {
        xOffset: number;
        yOffset: number;
    }

    export function getItemRect(index: number): RectResult;

    export interface RectResult {
        x: number;
        y: number;
        width: number;
        height: number;
    }

}