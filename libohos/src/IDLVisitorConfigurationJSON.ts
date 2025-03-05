export interface IDLVisitorConfigurationJSON {
    DeletedDeclarations: string[];
    StubbedDeclarations: string[];
    NameReplacements: Map<string, [string, string]>;
    TypeReplacementsFilePath: string;
}
