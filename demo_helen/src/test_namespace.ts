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

// function operationWithArrayOfInterface(value: object): boolean {
//     return value instanceof Array<test_namespace.UtilityInterface>
// }

function operationWithArrayOfGlobalInterface(value: object): boolean {
    return value instanceof Array<UtilityInterface_Global>
}

function operationWithArrayOfInterface_(value: Array<test_namespace.UtilityInterface>) {
    return value
}

function operationWithArrayOfInterface__() {
    return new Array<test_namespace.UtilityInterface>()
}

/**
 * > arktsc --arktsconfig arktsconfig.json
 * 
    [TID 0aad0c] E/es2panda:   In /home/twx1232375/idlize/demo_helen/src/demo.ts:
    [TID 0aad0c] E/es2panda:     IdentifierHasVariable:
    [TID 0aad0c] E/es2panda:       NULL_VARIABLE(AstNodeType::IDENTIFIER, line 16)
    [TID 0aad0c] F/es2panda: ASTVerifier found broken invariants. You may want to pass '--ast-verifier:json' option for more verbose output.
    FATAL ERROR
    Backtrace [tid=699660]:
    Received signal: SIGABRT from '$ /home/twx1232375/idlize/demo_helen> /home/twx1232375/idlize/external/incremental/tools/panda/node_modules/@panda/sdk/linux_host_tools/bin/es2panda --stdlib /home/twx1232375/idlize/external/incremental/tools/panda/node_modules/@panda/sdk/ets/stdlib --extension sts --list-files --arktsconfig arktsconfig.json'


 * > arktsc --version

    Es2panda Version 0.1

    Build date: 2025-03-08_05:26:35
    Last commit hash: 25f435a2b6fd71fda90bece4921cd05cc4111832

 */
