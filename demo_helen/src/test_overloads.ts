export class ClassWithOverloads {
    myMethod(valNumber: number, valString: string): void {
        console.log('method(valNumber: number, valString: string)', valNumber, valString);
    }
    myMethod(valNumber?: number, valString?: string): void {
        console.log('method(valNumber?: number, valString?: string)', valNumber, valString);
    }
    // no error
    myMethod(): void {
        console.log('method()');
    }
    // TypeError: Function myMethod with this assembly signature already declared. [test_overloads.ts:5:5]
    // myMethod(valNumber: number, valString?: string): void {
    //     console.log('method(valNumber: number, valString?: string)', valNumber, valString);
    // }
}

let inst = new ClassWithOverloads()
inst.myMethod(123)
inst.myMethod(123, "hello")
inst.myMethod(undefined, "bye")
inst.myMethod(undefined, undefined)
inst.myMethod(123, undefined)
// inst.myMethod() // TypeError: Reference to myMethod is ambiguous [test_overloads.ts:22:1]

export class ClassWithMoreOverloads extends ClassWithOverloads {
    // no error
    myMethod(valNumber: number, valString?: string): void {
        console.log('method(valNumber: number, valString?: string)', valNumber, valString);
    }
}

let inst2 = new ClassWithMoreOverloads()
inst2.myMethod(123)
inst2.myMethod(123, "hello")
inst2.myMethod(undefined, "bye")
inst2.myMethod(undefined, undefined)
inst2.myMethod(123, undefined)


/* 

 > arktsc --version

    Es2panda Version 0.1

    Build date: 2025-03-08_05:26:35
    Last commit hash: 25f435a2b6fd71fda90bece4921cd05cc4111832

*/