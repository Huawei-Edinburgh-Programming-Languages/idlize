import { LanguageWriter } from "../LanguageWriters";

export interface IdlSyntheticType {
    getName(): string
    setName(name: string): void
    isMadeFrom(source: Object): boolean
    print(writer: LanguageWriter): void
}
