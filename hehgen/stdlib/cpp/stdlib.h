#include <memory>

template <typename T>
class Array {
public:
    Array(int size) {
        _mem = std::make_shared(new T[size])
    }
    Array(): Array(256) {}

    const T& get(int i) const {
        return _mem[i];
    }
    void push(const T& val) {
        _mem[i] = val;
    }
    int size() const {
        return 0;
    }
private:
    std::shared_ptr<T> _mem;
};

class ByteReader {
public:
    int readInt32() { return 0; }
    const char* readString() {  return ""; }
};
class ByteWriter {
public:
    void writeInt32(int) {}
    void writeString(const char*) {}
};
