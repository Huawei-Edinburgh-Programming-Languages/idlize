import * as fs from "fs"
import * as path from "path"
import { cStyleCopyright } from "./FileGenerators";

export interface CppFileOptions {
}

abstract class CppFileWriter {
    protected readonly output: fs.WriteStream

    constructor(filePath: string, protected readonly options: Partial<CppFileOptions> = {}) {
        this.output = fs.createWriteStream(filePath, { encoding: "utf-8" })
        this.writeIntro()
    }

    get stream() {
        return this.output;
    }

    writePragma(pragma: string) {
        this.output.write(`#pragma ${pragma}\n`)
    }

    writeInclude(path: string) {
        this.output.write(`#include "${path}"\n`)
    }

    writeLine(line = "") {
        this.output.write(line + "\n")
    }

    write(code: string) {
        this.output.write(code)
    }

    end() {
        this.writeOutro()
        this.output.end();
    }

    private writeIntro() {
        this.output.write(cStyleCopyright)
        this.writeLine()
    }

    private writeOutro() {
        this.writeLine()
    }
}

export interface CppHeaderFileGeneratorOptions extends CppFileOptions {
    includeGuardStyle: "pragma" | "ifndef"
}

export class CppHeaderFileGenerator extends CppFileWriter {
    private includeGuardDefine?: string;

    constructor(filePath: string, protected readonly options: Partial<CppHeaderFileGeneratorOptions> = {}) {
        super(filePath, options)
        if (options.includeGuardStyle == "pragma") {
            this.writePragma("once")
        } else {
            this.includeGuardDefine = makeIncludeGuardDefine(filePath)
            this.write(`#ifndef ${this.includeGuardDefine}\n`)
            this.write(`#define ${this.includeGuardDefine}\n`)
        }
    }

    end() {
        if (this.includeGuardDefine) {
            this.writeLine(`#endif // ${this.includeGuardDefine}`)
        }
        super.end()
    }
}

export interface CppSourceFileGeneratorOptions extends CppFileOptions {
    
}

export class CppSourceFileGenerator extends CppFileWriter {
    constructor(filePath: string, protected readonly options: Partial<CppSourceFileGeneratorOptions> = {}) {
        super(filePath, options)
    }
}

function makeIncludeGuardDefine(filePath: string) {
    let basename = path.basename(filePath);
    let ext = path.extname(basename);
    if (ext) ext = ext.slice(1); // remove leading dot

    return `${basename}_${ext}`.toUpperCase()
}