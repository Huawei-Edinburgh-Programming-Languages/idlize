import { Language } from "@idlizer/core";
import { IDLVisitorConfiguration } from "./IDLVisitorConfig";
import { PeerGeneratorConfigurationJSON } from "./PeerGeneratorConfigurationJSON";

export interface PeerGeneratorConfiguration extends PeerGeneratorConfigurationJSON {
    readonly IDLVisitor: IDLVisitorConfiguration;

    mapComponentName(originalName: string): string;
    ignoreEntry(name: string, language: Language): boolean;
    ignoreMethod(name: string, language: Language): boolean;
    isHandWritten(component: string): boolean;
    isKnownParametrized(name: string | undefined): boolean;
    isShouldReplaceThrowingError(name: string): boolean;
    noDummyGeneration(component: string, method?: string): boolean;
}
