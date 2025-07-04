
export class ByteReader {
    readInt32() { return 0 }
    readString() { return "" }
}
export class ByteWriter {
    writeInt32(x:number) {}
    writeString(x:string) {}

    asBuffer(): Buffer {
        return Buffer.alloc(42)
    }
}

export class Array<T> {
    constructor(
        private readonly mem: T[] = []
    ) {}

    size() {
        return this.mem.length
    }
    get(i:number) {
        return this.mem[i]
    }
    push(val:T) {
        this.mem.push(val)
    }
}
