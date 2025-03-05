import { CoreConfiguration } from "@idlizer/core/config";
import { IDLVisitorConfigurationJSON } from "./IDLVisitorConfigurationJSON";


export interface PeerGeneratorConfigurationJSON extends CoreConfiguration {
    readonly GenerateUnused: boolean;
    readonly ApiVersion: number;
    readonly dumpSerialized: boolean;
    readonly boundProperties: Map<string, string[]>;

    readonly cppPrefix: string;
    readonly components: {
        readonly ignoreComponents: string[];
        readonly ignorePeerMethod: string[];
        readonly invalidAttributes: string[];
        readonly customNodeTypes: string[];
        readonly ignoreEntry: string[];
        readonly ignoreEntryJava: string[];
        readonly ignoreMethodArkts: string[];
        readonly custom: string[];
        readonly handWritten: string[];
        readonly replaceThrowErrorReturn: string[];
    };
    readonly dummy: {
        readonly ignoreMethods: Map<string, string[]>;
    };
    readonly materialized: {
        readonly ignoreReturnTypes: string[];
    };
    readonly serializer: {
        readonly ignore: string[];
    };
    readonly constants: Map<string, string>;
    readonly patchMaterialized: Map<string, Record<string, string>>;
    readonly CollapseOverloadsARKTS: boolean;
    readonly IDLVisitor: IDLVisitorConfigurationJSON;
}
