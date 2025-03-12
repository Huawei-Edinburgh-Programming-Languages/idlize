// declare namespace test_materialized_interface {
    interface InterfaceWithMethods {

        method1(valBoolean: boolean, valString: string): void
        // method1(valBoolean: boolean, valString?: string): void
        method1(valBoolean?: boolean, valString?: string): void
        method1(): void

        valNumber: number
        valBoolean: boolean

        method3(interface: UtilityInterface): UtilityInterface
        method4(array: number[]): string[]
        method5(arrayInterfaces: UtilityInterface[]): UtilityInterface[]

        valUtils: UtilityInterface
        // valUtilsArray: UtilityInterface[]
    }
// }