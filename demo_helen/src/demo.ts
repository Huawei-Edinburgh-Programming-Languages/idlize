export namespace test_namespace {
    export interface UtilityInterface {
        fieldString: string,
        fieldBoolean: boolean,
        fieldArrayNumber: number[]
    }
}

export interface UtilityInterface_Global {
    fieldString: string,
    fieldBoolean: boolean,
    fieldArrayNumber: number[]
}

function operationWithArrayOfInterface(value: object): boolean {
    return value instanceof Array<test_namespace.UtilityInterface>
}

function operationWithArrayOfGlobalInterface(value: object): boolean {
    return value instanceof Array<UtilityInterface_Global>
}

function operationWithArrayOfInterface_(value: Array<test_namespace.UtilityInterface>) {
    return value
}

function operationWithArrayOfInterface__() {
    return new Array<test_namespace.UtilityInterface>()
}
