import { Library } from "../Library";
import { Language } from "../util";

class SkoalaFile {
    constructor(
        public readonly originalFilename: string
    ) {}
}

export class SkoalaLibrary implements Library<SkoalaFile> {
    language: Language = Language.TS
    files: SkoalaFile[] = []
    findFileByOriginalFilename(filename: string): SkoalaFile | undefined {
        return this.files.find(it => it.originalFilename === filename)
    }
}