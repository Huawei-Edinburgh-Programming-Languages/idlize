
template <typename T>
class Array {
public:
    Array(int size) {
        _mem = new T[size];
    }
    Array(): Array(256) {}

    Array(Array const&) = delete
    Array(Array&&) = delete;
private:
    T *_mem;
};

class ByteReader {};
class ByteWriter {};
