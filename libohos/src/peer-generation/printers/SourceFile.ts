/*
 * Copyright (c) 2024 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import { cStyleCopyright, makeIncludeGuardDefine } from "../FileGenerators"
import { ImportsCollector } from "../ImportsCollector"
import { CppLanguageWriter } from "../LanguageWriters"
import { Language, LanguageWriter, CJLanguageWriter, ETSLanguageWriter, TSLanguageWriter, createLanguageWriter, ReferenceResolver, JavaLanguageWriter } from "@idlizer/core"

export abstract class SourceFile {
    public readonly content: LanguageWriter

    public static make(name: string, language: Language): SourceFile {
        if (language === Language.CPP) {
            return new CppSourceFile(name)
        } else if (language === Language.TS) {
            return new TsSourceFile(name)
        } else if (language === Language.ARKTS) {
            return new ArkTSSourceFile(name)
        } else if (language === Language.CJ) {
            return new CJSourceFile(name)
        } else if (language === Language.JAVA) {
            return new JavaSourceFile(name)
        } else {
            return new GenericSourceFile(name, language)
        }
    }

    public static makeSameAs<T extends SourceFile>(file: T): T {
        return SourceFile.make(file.name, file.language) as T
    }

    /** @deprecated avoid using any of Source.wrap methods. Consider using content writer and imports collector provided by SourceFile */
    public static wrap(content: LanguageWriter, imports: ImportsCollector): SourceFile {
        return Object.assign(SourceFile.make("", content.language), { content, imports })
    }

    constructor (
        public readonly name: string,
        public readonly language: Language,
    ) {
        this.content = createLanguageWriter(language)
    }

    public merge(file: this) {
        if (this.language !== file.language) {
            throw new TypeError("language mismatch")
        }
        this.content.concat(file.content)
        this.onMerge(file)
    }

    public abstract printToString(): string;
    // TODO make protected
    public abstract printImports(writer: LanguageWriter): void;
    protected abstract onMerge(file: this): void;
}

export class CppSourceFile extends SourceFile {
    declare public readonly content: CppLanguageWriter

    public readonly includes: Set<string> = new Set();
    public readonly globalIncludes: Set<string> = new Set();

    constructor(name: string) {
        super(name, Language.CPP)
    }

    public addInclude(...includes: string[]) {
        includes.forEach(inc => this.includes.add(inc))
    }

    public addGlobalInclude(...includes: string[]) {
        includes.forEach(inc => this.globalIncludes.add(inc))
    }

    protected onMerge(file: this): void {
        this.addInclude(...file.includes);
        this.addGlobalInclude(...file.globalIncludes)
    }

    private get isHeaderFile(): boolean {
        return this.name.endsWith(".h")
    }

    public printToString(): string {
        let fileWriter = createLanguageWriter(Language.CPP) as CppLanguageWriter
        let includeGuard = ""

        fileWriter.writeLines(cStyleCopyright);
        if (this.isHeaderFile) {
            includeGuard = makeIncludeGuardDefine(this.name)
            fileWriter.print(`#ifndef ${includeGuard}\n#define ${includeGuard}\n`)
        } else {
            fileWriter.print("#define KOALA_INTEROP_MODULE NotSpecifiedInteropModule")
        }

        this.printImports(fileWriter)
        fileWriter.print("")
        fileWriter.concat(this.content)

        if (this.isHeaderFile) {
            fileWriter.print(`#endif // ${includeGuard}\n`)
        }

        return fileWriter.getOutput().join("\n")
    }

    public printImports(writer: LanguageWriter): void {
        if (!(writer instanceof CppLanguageWriter)) throw new TypeError("illegal language writer")

        for (const include of this.includes) {
            writer.writeInclude(include)
        }
        for (const include of this.globalIncludes) {
            writer.writeGlobalInclude(include)
        }
    }
}

abstract class TsLikeSourceFile extends SourceFile {
    declare public readonly content: TSLanguageWriter

    public readonly imports: ImportsCollector = new ImportsCollector()

    protected onMerge(file: this): void {
        this.imports.merge(file.imports)
    }

    private get moduleName(): string {
        // TODO set proper module name
        return `./${this.name.replace(/\.ts$/, "")}`
    }

    public printToString(): string {
        let fileWriter = createLanguageWriter(this.language) as TSLanguageWriter
        fileWriter.print(cStyleCopyright)
        this.printImports(fileWriter)
        fileWriter.print("")
        fileWriter.concat(this.content)
        return fileWriter.getOutput().join("\n")
    }

    public printImports(writer: LanguageWriter): void {
        if (!this.supportsWriter(writer)) throw new TypeError("illegal language writer")
        this.imports.print(writer, this.moduleName)
    }

    protected abstract supportsWriter(writer: LanguageWriter): boolean
}

export class TsSourceFile extends TsLikeSourceFile {
    declare public readonly content: TSLanguageWriter

    public static wrap(content: TSLanguageWriter, imports: ImportsCollector): TsSourceFile {
        return Object.assign(new TsSourceFile(""), { content, imports })
    }

    constructor(name: string) {
        super(name, Language.TS)
    }

    protected override supportsWriter(writer: LanguageWriter) {
        return writer instanceof TSLanguageWriter
    }
}

export class ArkTSSourceFile extends TsLikeSourceFile {
    declare public readonly content: ETSLanguageWriter

    public static wrap(content: ETSLanguageWriter, imports: ImportsCollector): ArkTSSourceFile {
        return Object.assign(new ArkTSSourceFile(""), { content, imports })
    }

    constructor(name: string) {
        super(name, Language.ARKTS)
    }

    protected override supportsWriter(writer: LanguageWriter) {
        return writer instanceof ETSLanguageWriter
    }
}

export class CJSourceFile extends SourceFile {
    declare public readonly content: CJLanguageWriter

    public static wrap(content: CJLanguageWriter): CJSourceFile {
        return Object.assign(new CJSourceFile(""), { content })
    }

    constructor(name: string) {
        super(name, Language.CJ)
    }

    public printToString(): string {
        let fileWriter = createLanguageWriter(this.language) as CJLanguageWriter
        fileWriter.print(cStyleCopyright)
        this.printImports(fileWriter)
        fileWriter.concat(this.content)
        fileWriter.print('\n')
        return fileWriter.getOutput().join("\n")
    }
    public printImports(writer: LanguageWriter): void {
        writer.print(`package idlize\n`)
        writer.print(`import std.collection.*`)
        writer.print(`import Interop.*\n`)
    }
    protected onMerge(file: this): void {

    }
}

export class JavaSourceFile extends SourceFile {
    declare public readonly content: JavaLanguageWriter
    public packageName: string = "org.koalaui.arkoala";

    public static wrap(content: JavaLanguageWriter): JavaSourceFile {
        return Object.assign(new JavaSourceFile(""), { content })
    }

    constructor(name: string) {
        super(name, Language.JAVA)
    }

    public printToString(): string {
        let printer = createLanguageWriter(Language.JAVA)
        printer.print(cStyleCopyright)
        printer.print(`package ${this.packageName};`)
        printer.print('')
        printer.concat(this.content)

        return printer.getOutput().join('\n')
    }

    public printImports(writer: LanguageWriter): void {
        // TODO implement
    }

    protected onMerge(file: this): void {
        // todo implement
    }

}

/** @deprecated Each destination language should have its own SourceFile implementation */
export class GenericSourceFile extends SourceFile {
    public printToString(): string {
        return this.content.getOutput().join("\n")
    }
    public printImports(writer: LanguageWriter): void {}
    protected onMerge(file: this): void {}
}
