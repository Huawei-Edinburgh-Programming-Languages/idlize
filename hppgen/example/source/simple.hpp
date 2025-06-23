
class A;
class B;
class C;

class A {
public:
    virtual int inspect() const;
};

class B : public A {
public:
    B(B &&) = delete;

    int f(int, int);
    void g(void* param);
    int h() const;
};

class C : public A {
public:
    int inspect() const override;
};
