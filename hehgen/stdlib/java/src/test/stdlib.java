package src.test;

import java.util.ArrayList;

class Array<T> {
    private final ArrayList<T> mem = new ArrayList<>();

    public T get(int i) {
        return mem.get(i);
    }
    public void push(T x) {
        mem.add(x);
    }
    public int size() {
        return mem.size();
    }
}

class ByteReader {
    int readInt32() { return 0; }
    String readString() { return ""; }
}
class ByteWriter {
    void writeInt32(int x) {}
    void writeString(String x) {}
}
