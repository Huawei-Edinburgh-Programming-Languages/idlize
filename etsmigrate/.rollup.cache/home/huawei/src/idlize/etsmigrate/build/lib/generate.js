/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
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
import { camelCaseToUpperSnakeCase, capitalize, collapseTypes, filterRedundantAttributesOverloads, filterRedundantMethodsOverloads, generateSyntheticFunctionName, generateSyntheticIdlNodeName, Language, nameEnumValues, PeerLibrary, throwException, zip } from "@idlizer/core";
import * as arkts from "@koalaui/libarkts";
import * as idl from "@idlizer/core/idl";
import * as path from "node:path";
import * as fs from "node:fs";
import { NativeModule } from "@idlizer/libohos";
const MaxSyntheticTypeLength = 60;
// must be moved to config!
const TypeParameterMap = new Map([
    ["DirectionalEdgesT", new Map([
            ["T", idl.IDLNumberType]
        ])],
]);
class StatusRecord {
    constructor(fullPackage, pkg, parent, name, override, type, status, src) {
        this.fullPackage = fullPackage;
        this.pkg = pkg;
        this.parent = parent;
        this.name = name;
        this.override = override;
        this.type = type;
        this.status = status;
        this.src = src;
    }
    ToString() {
        let statusStr = this.status ? `Deleted because of ${this.status}` : '';
        return `| ${this.fullPackage} | ${this.pkg} | ${this.parent} | ${this.name} | ${this.override} | ${this.type} | ${statusStr} | \`${this.src}\` |`;
    }
    static Header() {
        return '| Full package | Package | Parent | Name | Override | Type | Status | Source |';
    }
}
class StatusTracker {
    constructor(enabled) {
        this.status = [];
        this.od = new Map();
        this.enabled = enabled;
    }
    Concat(src) {
        this.status.push(...src.status);
    }
    Print() {
        return [StatusRecord.Header(), ...this.status.map(it => it.ToString())].join("\n");
    }
}
function processFile(outDir, baseDir, file, configPath, config, status) {
    var _a;
    let input = fs.readFileSync(file).toString();
    //let module = arkts.createETSModuleFromSource(input, arkts.Es2pandaContextState.ES2PANDA_STATE_PARSED)
    const configText = fs.readFileSync(configPath, 'utf-8');
    const configContent = JSON.parse(configText);
    const paths = (_a = configContent.compilerOptions.paths) !== null && _a !== void 0 ? _a : {};
    const pathMap = new Map();
    for (const key in paths) {
        pathMap.set(key, path.normalize(path.join(path.dirname(configPath), paths[key][0])));
    }
    arkts.arktsGlobal.filePath = file;
    arkts.arktsGlobal.config = arkts.Config.create([
        '_',
        '--arktsconfig',
        configPath,
        file,
        '--extension',
        'ets',
        '--stdlib',
        path.join(process.env.PANDA_SDK_PATH, 'ets', 'stdlib'),
        '--output',
        'a.abc'
    ]).peer;
    arkts.arktsGlobal.compilerContext = arkts.Context.createFromString(input);
    arkts.proceedToState(arkts.Es2pandaContextState.ES2PANDA_STATE_PARSED);
    const script = arkts.createETSModuleFromContext();
    let localStatus = new StatusTracker(status.enabled);
    let idlVisitor = new IDLVisitor(baseDir, file, pathMap, config, localStatus);
    idlVisitor.visitor(script);
    const idlFile = idlVisitor.toIDLSuperFile();
    const fileRelativePath = path.relative(baseDir, file);
    const outFile = path.join(outDir, fileRelativePath.replace(".d.ets", ".idl"));
    const outFileDir = path.dirname(outFile);
    if (!fs.existsSync(outFileDir)) {
        fs.mkdirSync(outFileDir, { recursive: true });
    }
    if (!idlFile.file.entries.length) {
        idlFile.skipped = true;
    }
    else if (config.DeletedPackages.includes(idlFile.file.packageClause.join("."))) {
        console.log(`WARNING: Package ${idlFile.file.packageClause.join(".")} was deleted`);
        idlFile.skipped = true;
        localStatus.status.forEach(it => it.status = `DeletedPackages`);
    }
    if (!idlFile.skipped) {
        fs.writeFileSync(outFile, idl.toIDLString(idlFile.file, {}), 'utf8');
    }
    idlFile.writeFilePath = outFile;
    status.Concat(localStatus);
    return idlFile;
}
export function generateFromSts({ inputFiles, baseDir, outDir, etsConfigPath, config, traceStatus }) {
    if (!process.env.PANDA_SDK_PATH) {
        process.env.PANDA_SDK_PATH = path.resolve(__dirname, "../../external/incremental/tools/panda/node_modules/@panda/sdk");
    }
    arkts.checkSDK();
    if (!fs.existsSync(process.env.PANDA_SDK_PATH)) {
        throw new Error("PANDA_SDK_PATH points to unexisting directory");
    }
    if (!fs.existsSync(outDir)) {
        fs.mkdirSync(outDir, { recursive: true });
    }
    console.log(`Use Panda from ${process.env.PANDA_SDK_PATH}`);
    const doJob = processLogger(inputFiles.length);
    const library = [];
    let status = new StatusTracker(!!traceStatus);
    inputFiles.forEach(file => {
        try {
            doJob(file, () => {
                const idlFile = processFile(outDir, baseDir, file, etsConfigPath, config, status);
                if (config.DeletedPackages.includes(idlFile.file.packageClause.join("."))) {
                    console.log(`WARNING: Package ${idlFile.file.packageClause.join(".")} was deleted`);
                }
                else {
                    library.push(idlFile);
                }
                return idlFile;
            });
        }
        catch (e) {
            console.log(e);
            if (e.trace)
                console.log(e.trace);
            // But current es2panda just forcefully exits.
            // throw e
        }
    });
    if (traceStatus) {
        fs.writeFileSync(traceStatus, status.Print());
    }
    console.log('Adjusting imports...');
    const adjusted = adjustImports(library);
    const doAdjustJob = processLogger(adjusted.length);
    adjusted.forEach(file => {
        const fileName = file.writeFilePath;
        doAdjustJob(fileName, () => {
            const outFileDir = path.dirname(fileName);
            if (!fs.existsSync(outFileDir)) {
                fs.mkdirSync(outFileDir, { recursive: true });
            }
            fs.writeFileSync(fileName, idl.toIDLString(file.file, {}), 'utf8');
            return file;
        });
    });
    return new PeerLibrary(Language.ARKTS, NativeModule.Interop);
}
function adjustImports(library) {
    const map = new Map();
    library.forEach(file => {
        const pkg = file.file.packageClause.join('.');
        if (!map.has(pkg)) {
            map.set(pkg, []);
        }
        map.get(pkg).push(file);
    });
    const updatedFiles = [];
    library.forEach((file) => {
        let adjusted = false;
        file.file.entries.forEach(entry => {
            if (!idl.isImport(entry)) {
                return;
            }
            if (entry.name === "" || entry.clause.length < 2) {
                return;
            }
            const fileClause = entry.clause.slice(0, entry.clause.length - 1);
            let fileClauseString = fileClause.join('.');
            let fileExportName = entry.clause.at(-1);
            let oldFileClauseString = '';
            while (oldFileClauseString !== fileClauseString) {
                const referencedFiles = map.get(fileClauseString);
                if (!referencedFiles) {
                    break;
                }
                oldFileClauseString = fileClauseString;
                for (const refFile of referencedFiles) {
                    if (refFile.exports.has(fileExportName)) {
                        const clause = refFile.exports.get(fileExportName).split('.');
                        if (clause.length < 2) {
                            return;
                        }
                        fileClauseString = clause.slice(0, clause.length - 1).join('.');
                        fileExportName = clause.at(-1);
                        adjusted = true;
                        break;
                    }
                }
            }
            entry.clause = [...fileClauseString.split('.'), fileExportName];
        });
        if (adjusted) {
            updatedFiles.push(file);
        }
    });
    return updatedFiles;
}
function processLogger(amount) {
    let done = 1;
    return (fileName, op) => {
        console.log(`[ ${done.toString()}/${amount.toString()} ] Processing ${fileName}`);
        try {
            const outFile = op();
            if (outFile.skipped) {
                console.log(`  ... skipped (file is empty)`);
            }
            else {
                console.log(`  ... saved to ${outFile.writeFilePath}`);
            }
        }
        catch (ex) {
            console.log(`  ... failed`);
            throw ex;
        }
        finally {
            ++done;
        }
    };
}
export class NameSuggestion {
    constructor() {
        this.suggestions = [];
    }
    get name() {
        if (!this.hasSuggestion)
            throw new Error("Has not suggestions");
        return this.suggestions.at(-1).name;
    }
    get forced() {
        if (!this.hasSuggestion)
            throw new Error("Has not suggestions");
        return this.suggestions.at(-1).forced;
    }
    get hasSuggestion() {
        return this.suggestions.length > 0;
    }
    suggest(name, forced, op) {
        this.suggestions.push({ name, forced });
        const result = op();
        this.suggestions.pop();
        return result;
    }
    suggestWithTypePrefix(name, forcedOrOp, op) {
        if (typeof forcedOrOp === 'function')
            return this.suggestWithTypePrefix(name, false, forcedOrOp);
        return this.suggest(`Type_${name}`, forcedOrOp, op);
    }
    extend(postfix, forcedOrOp, op) {
        if (typeof forcedOrOp === 'function')
            return this.extend(postfix, false, forcedOrOp);
        const prefix = this.hasSuggestion ? this.name + "_" : "";
        return this.suggest(prefix + postfix, forcedOrOp, op);
    }
}
class IDLVisitor extends arkts.AbstractVisitor {
    contextualSelectName(synthetic) {
        if (!this.contextual.hasSuggestion)
            return synthetic;
        if (this.contextual.forced || synthetic.length > MaxSyntheticTypeLength)
            return this.contextual.name;
        return synthetic;
    }
    processNode(op, ...args) {
        this.processNodeStack.unshift(args[0]);
        let result = op.call(this, ...args);
        this.processNodeStack.shift();
        return result;
    }
    detectPackageNameByPath(fileName) {
        if (this.importPathMap.has(fileName)) {
            return this.detectPackageNameByPath(this.importPathMap.get(fileName));
        }
        return path.relative(this.basePath, fileName)
            .replaceAll('.d.ets', '')
            .replaceAll('.idl', '')
            .split(path.sep)
            .map(it => it.replaceAll('@', ''))
            .map(it => it.split('-').map((it, i) => i === 0 ? it : capitalize(it)).join('')) // kebab-case to camelCase
            .filter(it => it.length && it !== '.' && it !== '..');
    }
    constructor(basePath, originalFileName, importPathMap, config, status) {
        super();
        this.basePath = basePath;
        this.originalFileName = originalFileName;
        this.importPathMap = importPathMap;
        this.config = config;
        this.status = status;
        //writer = new IDLLanguageWriter()
        this.entries = [];
        this.packageClause = [];
        this.contextual = new NameSuggestion;
        this.processNodeStack = [];
        this.typeParamsStack = [];
        this.fileReExports = new Map();
        this.typeReplacements = [];
        this.mode = 'arkoala';
        // possible bug: entires collected here using .name, not FQName
        this.seenTypes = new Set();
        this.typeParamsTraps = [new Set()];
        this.fileName = this.originalFileName.replace(".d.ets", ".idl");
        this.packageClause = this.detectPackageNameByPath(this.originalFileName);
    }
    visitor(node) {
        var _a, _b;
        if (arkts.hasModifierFlag(node, arkts.Es2pandaModifierFlags.MODIFIER_FLAGS_DEFAULT_EXPORT)) {
            if (arkts.isInterfaceDecl(node)) {
                this.defaultExportName = node.id.name;
            }
            if (arkts.isTSInterfaceDeclaration(node)) {
                this.defaultExportName = node.id.name;
            }
            if (arkts.isTSModuleDeclaration(node)) {
                this.defaultExportName = node.name.name; // not sure about this
            }
            if (arkts.isETSModule(node)) {
                this.defaultExportName = (_a = node.ident) === null || _a === void 0 ? void 0 : _a.name;
            }
        }
        if (arkts.isExportNamedDeclaration(node)) {
            if (arkts.hasModifierFlag(node, arkts.Es2pandaModifierFlags.MODIFIER_FLAGS_DEFAULT_EXPORT) && node.specifiers.length === 1) {
                const [spec] = node.specifiers;
                this.defaultExportName = spec.local.name;
            }
        }
        if (arkts.isETSReExportDeclaration(node)) {
            let importString = node.eTSImportDeclarations.source.str;
            if (importString.startsWith('.')) {
                const currentFileBaseDir = path.dirname(this.originalFileName);
                const importFilePath = path.normalize(path.join(currentFileBaseDir, importString));
                importString = importFilePath;
            }
            const importedPackageClause = this.detectPackageNameByPath(importString);
            node.eTSImportDeclarations.specifiers.forEach(spec => {
                if (arkts.isImportSpecifier(spec)) {
                    this.fileReExports.set(spec.local.name, [...importedPackageClause, spec.imported.name].join('.'));
                }
            });
        }
        if (arkts.isExportDefaultDeclaration(node)) {
            if (arkts.isIdentifier(node.decl)) {
                this.defaultExportName = node.decl.name;
            }
        }
        //////////////////
        if (arkts.isScriptFunction(node)) {
            return this.processNode(this.visitScriptFunction, node);
        }
        if (arkts.isClassDeclaration(node)) {
            return this.processNode(this.visitClassDeclaration, node);
        }
        if (arkts.isInterfaceDecl(node) || arkts.isTSInterfaceDeclaration(node)) {
            return this.processNode(this.visitInterfaceDeclaration, node);
        }
        if (arkts.isImportDeclaration(node)) {
            return this.processNode(this.visitImportDeclaration, node);
        }
        if (arkts.isTSEnumDeclaration(node)) {
            return this.processNode(this.visitEnumDeclaration, node);
        }
        if (arkts.isTSTypeAliasDeclaration(node)) {
            return this.processNode(this.visitTSTypeAliasDeclaration, node);
        }
        if (arkts.isFunctionDeclaration(node)) {
            return this.processNode(this.visitFunctionDeclaration, node);
        }
        if (arkts.isETSModule(node) && ((_b = node.ident) === null || _b === void 0 ? void 0 : _b.name) !== 'ETSGLOBAL') {
            return this.processNode(this.visitETSModule, node);
        }
        //////////////////
        return this.visitEachChild(node);
    }
    visitETSModule(node) {
        const old = this.entries;
        this.entries = [];
        let extendedAttributes = this.traceAttrs();
        this.visitEachChild(node);
        const members = this.entries;
        this.entries = old;
        this.entries.push(idl.createNamespace(node.ident.name, members, {
            extendedAttributes,
            fileName: this.fileName,
        }));
        return node;
    }
    visitEnumDeclaration(node) {
        const name = node.key.name;
        if (this.config.DeletedDeclarations.includes(name)) {
            this.traceDeleted('DeletedDeclarations');
            return node;
        }
        let extendedAttributes = this.traceAttrs();
        let result = idl.createEnum(name, [], { extendedAttributes });
        let currentValue = 0;
        let enumNames = nameEnumValues(node.members.map(it => it.name));
        result.elements =
            node.members.map((it, index) => this.processNode((it, index) => {
                let element = it;
                let [type, value] = this.convertEnumInitializer(element.init);
                if (typeof value === 'number')
                    currentValue = value + 1;
                if (typeof value === 'undefined') {
                    value = currentValue;
                    currentValue++;
                }
                let extendedAttributes = this.traceAttrs();
                if (enumNames[index] != element.name) {
                    extendedAttributes.push({ name: idl.IDLExtendedAttributes.OriginalEnumMemberName, value: element.name });
                }
                return idl.createEnumMember(enumNames[index], result, type, value, { extendedAttributes });
            }, it, index));
        this.entries.push(result);
        return node;
    }
    convertEnumInitializer(expression) {
        let initializer;
        let type = idl.IDLNumberType;
        if (!expression) {
            return [type, initializer];
        }
        if (arkts.isNumberLiteral(expression) && expression.str !== "") {
            initializer = parseInt(expression.str);
            if (Number.isNaN(initializer)) {
                throw new Error("Initializator is not number!");
            }
        }
        if (arkts.isStringLiteral(expression)) {
            initializer = '"' + expression.str + '"';
            type = idl.IDLStringType;
        }
        return [type, initializer];
    }
    visitImportDeclaration(node) {
        let importString = node.source.str;
        if (importString.startsWith('.')) {
            const currentFileBaseDir = path.dirname(this.originalFileName);
            const importFilePath = path.normalize(path.join(currentFileBaseDir, node.source.str));
            importString = importFilePath;
        }
        const importedPackageClause = this.detectPackageNameByPath(importString);
        if (importedPackageClause.join('.') === this.packageClause.join('.')) {
            return node;
        }
        node.specifiers.forEach(spec => {
            var _a;
            if (arkts.isImportSpecifier(spec)) {
                const imported = spec.imported;
                const local = (_a = spec.local) !== null && _a !== void 0 ? _a : imported;
                this.entries.push(idl.createImport([...importedPackageClause, imported.name], local.name));
            }
            if (arkts.isImportDefaultSpecifier(spec)) {
                this.entries.push(idl.createImport([...importedPackageClause, 'default'], spec.local.name));
            }
            if (arkts.isImportNamespaceSpecifier(spec)) {
                this.entries.push(idl.createImport([...importedPackageClause, 'default'], spec.local.name));
            }
        });
        return node;
    }
    visitFunctionDeclaration(node) {
        var _a;
        const func = node.function;
        if (((_a = func.id) === null || _a === void 0 ? void 0 : _a.name) && this.config.DeletedDeclarations.includes(func.id.name)) {
            this.traceDeleted('DeletedDeclarations');
            return node;
        }
        const { set: paramsSet, parameters } = this.extractTypeParameters(func.typeParams);
        this.withTypeParamContext(paramsSet, () => this.contextual.suggestWithTypePrefix(func.id.name, false, () => {
            let extendedAttributes = this.traceAttrs();
            if (func.isExtensionMethod) {
                extendedAttributes.push({ name: idl.IDLExtendedAttributes.ExtensionMethod });
            }
            const method = idl.createMethod(func.id.name, func.params.map(it => {
                const param = it;
                let name = param.name;
                if (func.isExtensionMethod && name == '=t') {
                    name = 'this';
                }
                return idl.createParameter(name, this.serializeType(param.typeAnnotation), param.isOptional);
            }), this.serializeType(func.returnTypeAnnotation), {
                isAsync: func.isAsyncFunc,
                isFree: true,
                isOptional: false,
                isStatic: func.isStaticBlock
            }, {
                extendedAttributes: extendedAttributes,
                fileName: this.fileName,
            }, parameters);
            /* arkgen specialization */
            if (node.annotations.find(it => arkts.isIdentifier(it.expr) && it.expr.name === "ComponentBuilder")) {
                const callable = idl.createCallable("invoke", method.parameters.slice(0, method.parameters.length - 1), method.returnType, {
                    isAsync: method.isAsync,
                    isStatic: method.isStatic
                }, {
                    extendedAttributes: [
                        ...extendedAttributes,
                        { name: idl.IDLExtendedAttributes.CallSignature },
                    ]
                });
                const ifaceName = method.name + 'Interface';
                let iface;
                if (iface = this.entries.filter(idl.isInterface).find(it => it.name === ifaceName)) {
                    iface.callables.push(callable);
                }
                else if (!this.config.DeletedDeclarations.includes(ifaceName)) {
                    this.entries.push(idl.createInterface(ifaceName, idl.IDLInterfaceSubkind.Interface, [], [], [], [], [], [callable], method.typeParameters, {
                        fileName: this.fileName,
                        extendedAttributes: [
                            { name: idl.IDLExtendedAttributes.ComponentInterface },
                        ]
                    }));
                }
            }
            else {
                this.entries.push(method);
            }
        }));
        return node;
    }
    visitTSTypeAliasDeclaration(declaration) {
        const name = declaration.id.name;
        if (this.config.DeletedDeclarations.includes(name)) {
            this.traceDeleted('DeletedDeclarations');
            return declaration;
        }
        if (this.mode === 'arkoala') {
            if (['Dimension'].includes(name)) {
                this.entries.push(idl.createTypedef(name, idl.createUnionType([
                    idl.IDLStringType,
                    idl.IDLNumberType,
                    idl.createReferenceType('_Resource')
                ]), [], {
                    extendedAttributes: [],
                    fileName: this.fileName
                }));
                return declaration;
            }
        }
        if (arkts.isETSFunctionType(declaration.typeAnnotation)) {
            const typeParams = this.extractTypeParameters(declaration.typeParams);
            this.contextual.suggest(name, true, () => {
                this.entries.push(this.serializeFunctionType(declaration.typeAnnotation, typeParams)[0]);
            });
        }
        else if (arkts.isETSTuple(declaration.typeAnnotation)) {
            this.contextual.suggest(name, true, () => {
                this.entries.push(this.serializeTupleType(declaration.typeAnnotation)[0]);
            });
        }
        else {
            const { set: paramsSet, parameters } = this.extractTypeParameters(declaration.typeParams);
            this.withTypeParamContext(paramsSet, () => {
                let extendedAttributes = this.traceAttrs();
                this.entries.push(idl.createTypedef(name, this.serializeType(declaration.typeAnnotation), parameters, {
                    extendedAttributes,
                    fileName: this.fileName,
                }));
            });
        }
        return declaration;
    }
    visitScriptFunction(node) {
        return this.visitEachChild(node);
    }
    printNode(node) {
        let name = arkts.isIdentifier(node) ? `'${node.name}'` : "";
        return `${" ".repeat(4 * this.indentation) + node.constructor.name} ${name}`;
    }
    processBody(scopeName, members) {
        let hasMemoAnnotation = false;
        const properties = [];
        const methods = [];
        const constructors = [];
        members === null || members === void 0 ? void 0 : members.forEach(member => this.processNode((member) => {
            var _a, _b, _c, _d, _e;
            if (arkts.isClassProperty(member)) {
                if (this.shouldNotProcessMember(scopeName, member.id.name)) {
                    this.traceDeleted('DeletedMembers');
                    return;
                }
                properties.push(this.serializeClassProperty(member));
                const found = member.annotations.find(ann => arkts.isIdentifier(ann.expr) && ann.expr.name === 'memo');
                if (found) {
                    hasMemoAnnotation = true;
                }
                return;
            }
            if (arkts.isMethodDefinition(member)) {
                if (this.shouldNotProcessMember(scopeName, member.id.name)) {
                    this.traceDeleted('DeletedMembers');
                    return;
                }
                if (member.isGetter) {
                    const propType = member.function.returnTypeAnnotation;
                    const propName = member.key.name;
                    const prop = this.contextual.extend(propName, () => {
                        return idl.createProperty(propName, this.serializeType(propType));
                    });
                    (_a = prop.extendedAttributes) !== null && _a !== void 0 ? _a : (prop.extendedAttributes = []);
                    if (arkts.hasModifierFlag(member, arkts.Es2pandaModifierFlags.MODIFIER_FLAGS_STATIC)) {
                        prop.isStatic = true;
                    }
                    (_b = prop.extendedAttributes) === null || _b === void 0 ? void 0 : _b.push({ name: idl.IDLExtendedAttributes.Accessor, value: idl.IDLAccessorAttribute.Getter });
                    prop.extendedAttributes.push(...this.traceAttrs());
                    properties.push(prop);
                    return;
                }
                if (member.isSetter) {
                    const firstParameter = member.function.params[0];
                    const propType = arkts.isETSParameterExpression(firstParameter) ? firstParameter.typeAnnotation : throwException("Expected parameter");
                    const propName = member.key.name;
                    const prop = this.contextual.extend(propName, () => idl.createProperty(propName, this.serializeType(propType)));
                    (_c = prop.extendedAttributes) !== null && _c !== void 0 ? _c : (prop.extendedAttributes = []);
                    if (arkts.hasModifierFlag(member, arkts.Es2pandaModifierFlags.MODIFIER_FLAGS_STATIC)) {
                        prop.isStatic = true;
                    }
                    prop.extendedAttributes.push({ name: idl.IDLExtendedAttributes.Accessor, value: idl.IDLAccessorAttribute.Setter });
                    prop.extendedAttributes.push(...this.traceAttrs());
                    properties.push(prop);
                    return;
                }
                const serializedMethod = this.serializeMethod(member, scopeName);
                const key = scopeName + '.' + serializedMethod.name;
                if (this.config.ForceCallback.has(key) && idl.isMethod(serializedMethod)) {
                    const syntheticName = generateSyntheticFunctionName(serializedMethod.parameters, serializedMethod.returnType, serializedMethod.isAsync);
                    const syntheticCallback = idl.createCallback(syntheticName, serializedMethod.parameters, serializedMethod.returnType, {
                        extendedAttributes: ((_d = serializedMethod.extendedAttributes) !== null && _d !== void 0 ? _d : []).concat({ name: idl.IDLExtendedAttributes.Synthetic })
                    });
                    if (!this.seenTypes.has(syntheticCallback.name)) {
                        this.seenTypes.add(syntheticCallback.name);
                        this.addSyntheticType(syntheticCallback);
                    }
                    let propertyPostfix = "";
                    let extendedAttributes = ((_e = serializedMethod.extendedAttributes) !== null && _e !== void 0 ? _e : []);
                    const extraCallback = this.config.ForceCallback.get(key) === idl.IDLExtendedAttributes.ExtraMethod;
                    if (extraCallback) {
                        propertyPostfix = "_callback";
                        extendedAttributes = extendedAttributes.concat([{ name: idl.IDLExtendedAttributes.ExtraMethod, value: serializedMethod.name }]);
                    }
                    properties.push(idl.createProperty(serializedMethod.name + propertyPostfix, idl.createReferenceType(syntheticName), false, serializedMethod.isStatic, serializedMethod.isOptional, {
                        extendedAttributes: extendedAttributes
                    }));
                }
                else if (idl.isConstructor(serializedMethod)) {
                    constructors.push(serializedMethod);
                }
                else {
                    methods.push(serializedMethod);
                }
                const found = member.function.annotations.find(ann => arkts.isIdentifier(ann.expr) && ann.expr.name === 'memo');
                if (found) {
                    hasMemoAnnotation = true;
                }
                return;
            }
            console.error(member);
            throw new Error("Unhandled member!");
        }, member));
        return {
            properties,
            constructors,
            methods,
            hasMemoAnnotation,
        };
    }
    visitClassDeclaration(declaration) {
        const name = declaration.definition.ident.name;
        if (this.config.DeletedDeclarations.includes(name)) {
            this.traceDeleted('DeletedDeclarations');
            return declaration;
        }
        const definition = declaration.definition;
        const { set: paramsSet, parameters } = this.extractTypeParameters(definition.typeParams);
        this.withReplacementContext(name, (replacementUsed) => {
            this.withTypeParamContext(paramsSet, () => this.contextual.suggestWithTypePrefix(name, false, () => {
                var _a, _b;
                const inheritance = [];
                if (definition.super) {
                    const sup = this.serializeType(definition.super);
                    if (!idl.isReferenceType(sup)) {
                        throw new Error("Expected reference type");
                    }
                    (_a = sup.extendedAttributes) !== null && _a !== void 0 ? _a : (sup.extendedAttributes = []);
                    sup.extendedAttributes.push({ name: idl.IDLExtendedAttributes.Extends });
                    inheritance.push(sup);
                }
                if (definition.implements.length) {
                    definition.implements.forEach(int => {
                        const type = this.serializeType(int.expr);
                        if (!idl.isReferenceType(type)) {
                            throw new Error("Expected reference type");
                        }
                        inheritance.push(type);
                    });
                }
                const attrs = [
                    ...this.traceAttrs(),
                    { name: idl.IDLExtendedAttributes.Entity, value: idl.IDLEntity.Class }
                ];
                const { properties, methods, constructors } = this.processBody(name, (_b = declaration.definition) === null || _b === void 0 ? void 0 : _b.body);
                this.entries.push(idl.createInterface(name, idl.IDLInterfaceSubkind.Class, inheritance, constructors, // ctors
                undefined, // constants
                properties, methods, [], // callables
                replacementUsed ? undefined : parameters, {
                    fileName: this.fileName,
                    extendedAttributes: attrs.length === 0 ? undefined : attrs
                }));
            }));
        });
        return declaration;
    }
    visitInterfaceDeclaration(declaration) {
        const name = declaration.id.name;
        if (this.config.DeletedDeclarations.includes(name)) {
            this.traceDeleted('DeletedDeclarations');
            return declaration;
        }
        if (this.config.StubbedDeclarations.includes(name)) {
            this.traceDeleted('StubbedDeclarations');
            this.entries.push(idl.createInterface(name, idl.IDLInterfaceSubkind.Interface, [], [], [], [idl.createProperty('_stub', idl.IDLI32Type)], [], [], [], {
                fileName: this.fileName
            }));
            return declaration;
        }
        const { set: paramsSet, parameters } = this.extractTypeParameters(declaration.typeParams);
        this.withReplacementContext(name, (replacementUsed) => {
            this.withTypeParamContext(paramsSet, () => this.contextual.suggestWithTypePrefix(name, () => {
                var _a;
                const inheritance = [];
                if (declaration.extends.length) {
                    declaration.extends.forEach(int => {
                        const type = this.serializeType(int.expr);
                        if (!idl.isReferenceType(type)) {
                            throw new Error("Expected reference type");
                        }
                        inheritance.push(type);
                    });
                }
                const attrs = this.traceAttrs();
                const { properties, methods, constructors } = this.processBody(name, (_a = declaration.body) === null || _a === void 0 ? void 0 : _a.getChildren());
                this.entries.push(idl.createInterface(name, idl.IDLInterfaceSubkind.Interface, inheritance, constructors, // ctors
                undefined, // constants
                properties, methods, [], // callables
                replacementUsed ? undefined : parameters, {
                    fileName: this.fileName,
                    extendedAttributes: attrs.length === 0 ? undefined : attrs
                }));
            }));
        });
        return declaration;
    }
    processMethodLiteralParameters(method) {
        let methodName = method.id.name;
        const extendedAttributes = [];
        const filteredParameters = method.function.params.map(it => it)
            .filter((param, paramIndex) => {
            const paramName = param.name;
            let tag;
            if (arkts.isETSStringLiteralType(param.typeAnnotation)) {
                tag = param.typeAnnotation.dumpSrc();
            }
            if (!tag)
                return true;
            const dtsTagIndexDefault = 0; // see idl.DtsTag specification
            const dtsTagNameDefault = 'type'; // see idl.DtsTag specification
            let extendedAttributeValues = [];
            if (paramIndex != dtsTagIndexDefault || paramName != dtsTagNameDefault) {
                extendedAttributeValues.push(paramIndex.toString());
                extendedAttributeValues.push(paramName);
            }
            extendedAttributeValues.push(tag);
            extendedAttributes.push({
                name: idl.IDLExtendedAttributes.DtsTag,
                value: extendedAttributeValues.map(value => value.replaceAll('|', '\\x7c')).join('|')
            });
            if (!extendedAttributes.some(it => it.name === idl.IDLExtendedAttributes.DtsName)) {
                extendedAttributes.push({
                    name: idl.IDLExtendedAttributes.DtsName,
                    value: methodName,
                });
            }
            methodName = methodName + capitalize(tag.replaceAll('"', '').replaceAll("'", ''));
            return false;
        });
        return {
            methodName: methodName,
            parameters: filteredParameters,
            extendedAttributes,
        };
    }
    serializeMethod(method, parentName) {
        var _a;
        const { set: paramsSet, parameters: typeParameters } = this.extractTypeParameters((_a = method.value.function) === null || _a === void 0 ? void 0 : _a.typeParams);
        return this.withTypeParamContext(paramsSet, () => {
            const { methodName, parameters: arktsParameters, extendedAttributes } = this.processMethodLiteralParameters(method);
            let traceAttrs = this.traceAttrs();
            extendedAttributes.push(...traceAttrs);
            return this.contextual.extend(methodName, () => {
                const key = parentName + '.' + methodName;
                if (this.config.Throws.includes(key)) {
                    extendedAttributes.push({
                        name: idl.IDLExtendedAttributes.Throws
                    });
                }
                const parameters = arktsParameters.map(param => {
                    return idl.createParameter(param.name, this.serializeType(param.typeAnnotation), param.isOptional);
                });
                let ii = parameters.length - 1;
                while (ii >= 0) {
                    const last = parameters.at(-1);
                    if (last.type === idl.IDLUndefinedType) {
                        parameters.pop();
                    }
                    else {
                        break;
                    }
                    --ii;
                }
                const returnType = this.serializeType(method.function.returnTypeAnnotation);
                if (method.id.name === 'constructor') {
                    return idl.createConstructor(parameters, returnType, {
                        extendedAttributes: traceAttrs,
                    });
                }
                return idl.createMethod(methodName, parameters, returnType, {
                    isStatic: !!(method.modifierFlags & arkts.Es2pandaModifierFlags.MODIFIER_FLAGS_STATIC),
                    isAsync: false,
                    isFree: false,
                    isOptional: false,
                }, {
                    extendedAttributes: extendedAttributes,
                }, typeParameters);
            });
        });
    }
    serializeClassProperty(property) {
        const name = property.key.name;
        return this.contextual.extend(name, false, () => {
            var _a;
            const prop = idl.createProperty(name, this.serializeType(property.typeAnnotation));
            (_a = prop.extendedAttributes) !== null && _a !== void 0 ? _a : (prop.extendedAttributes = []);
            prop.extendedAttributes.push(...this.traceAttrs());
            if (arkts.hasModifierFlag(property, arkts.Es2pandaModifierFlags.MODIFIER_FLAGS_OPTIONAL)) {
                prop.isOptional = true;
                prop.extendedAttributes.push({ name: idl.IDLExtendedAttributes.Optional });
            }
            if (arkts.hasModifierFlag(property, arkts.Es2pandaModifierFlags.MODIFIER_FLAGS_STATIC)) {
                prop.isStatic = true;
            }
            if (arkts.hasModifierFlag(property, arkts.Es2pandaModifierFlags.MODIFIER_FLAGS_READONLY)) {
                prop.isReadonly = true;
            }
            return prop;
        });
    }
    static isFunctionTypeReference(name) {
        return IDLVisitor.etsFunctionTypeReferencePattern.test(name)
            || name === 'Callback';
    }
    maybeSerializeETSFunctionReference(type) {
        var _a, _b, _c;
        let name = type.baseName.name;
        if (!IDLVisitor.isFunctionTypeReference(name))
            return undefined;
        const [typeArgs, trappedParams] = this.useTypeParametersTrap(() => {
            var _a, _b;
            const typeArgs = (_b = (_a = type.part) === null || _a === void 0 ? void 0 : _a.typeParams) === null || _b === void 0 ? void 0 : _b.params.map(it => this.serializeType(it));
            return typeArgs;
        });
        const orderedTrappedParams = Array.from(trappedParams);
        const returnType = name === 'Callback' ? (_a = typeArgs === null || typeArgs === void 0 ? void 0 : typeArgs.at(1)) !== null && _a !== void 0 ? _a : idl.IDLVoidType : (_b = typeArgs === null || typeArgs === void 0 ? void 0 : typeArgs.at(0)) !== null && _b !== void 0 ? _b : idl.IDLVoidType;
        let paramsTypes = name === 'Callback' ? [typeArgs.at(0)] : typeArgs === null || typeArgs === void 0 ? void 0 : typeArgs.slice(0, -1);
        if ((paramsTypes === null || paramsTypes === void 0 ? void 0 : paramsTypes.length) === 1 && paramsTypes[0] === idl.IDLVoidType) {
            paramsTypes = [];
        }
        const parameters = (_c = paramsTypes === null || paramsTypes === void 0 ? void 0 : paramsTypes.map((it, index) => idl.createParameter(`value${index}`, it))) !== null && _c !== void 0 ? _c : [];
        const callback = idl.createCallback(this.contextualSelectName(generateSyntheticFunctionName(parameters, returnType, arkts.hasModifierFlag(type, arkts.Es2pandaModifierFlags.MODIFIER_FLAGS_ASYNC))), parameters, returnType, { fileName: this.fileName, extendedAttributes: [{ name: idl.IDLExtendedAttributes.Synthetic }] }, orderedTrappedParams.length === 0 ? undefined : orderedTrappedParams);
        return [callback, orderedTrappedParams];
    }
    serializeType(type) {
        var _a, _b, _c;
        if (!type)
            return idl.IDLVoidType;
        if (arkts.isTSAnyKeyword(type))
            return idl.IDLAnyType;
        if (arkts.isTSThisType(type))
            return idl.IDLThisType;
        if (arkts.isTSObjectKeyword(type))
            return idl.IDLObjectType;
        if (arkts.isETSUndefinedType(type))
            return idl.IDLUndefinedType;
        if (arkts.isETSStringLiteralType(type))
            return idl.IDLStringType;
        if (arkts.isTSStringKeyword(type))
            return idl.IDLStringType;
        if (arkts.isETSNullType(type))
            return idl.IDLUndefinedType;
        if (arkts.isTSArrayType(type))
            return idl.createContainerType('sequence', [this.serializeType(type.elementType)]);
        if (arkts.isETSUnionType(type))
            return collapseTypes(type.types.map((it) => this.serializeType(it)));
        if (arkts.isETSPrimitiveType(type))
            return this.serializePrimitive(type.primitiveType);
        if (arkts.isETSTypeReference(type)) {
            let name = type.baseName.name;
            if (type.part && arkts.isTSQualifiedName(type.part.name)) {
                const names = [];
                let current = type.part.name;
                while (current && arkts.isTSQualifiedName(current)) {
                    names.unshift(current.right.name);
                    current = (_a = current.left) !== null && _a !== void 0 ? _a : throwException("!!!");
                }
                names.unshift(name);
                name = names.join('.');
            }
            if (this.isTypeParameter(name)) {
                const replacementMapping = this.typeReplacements.find(it => it.has(name));
                if (replacementMapping) {
                    return replacementMapping.get(name);
                }
                this.typeParameterFound(name);
                return idl.createTypeParameterReference(name);
            }
            const mbEtsCallback = this.maybeSerializeETSFunctionReference(type);
            if (mbEtsCallback) {
                const [etsCallback, args] = mbEtsCallback;
                if (!this.seenTypes.has(etsCallback.name)) {
                    this.seenTypes.add(etsCallback.name);
                    this.addSyntheticType(etsCallback);
                }
                return idl.createReferenceType(etsCallback.name, args.length === 0 ? undefined : args.map(it => {
                    this.typeParameterFound(it);
                    return idl.createTypeParameterReference(it);
                }));
            }
            const typeWillBeReplaced = TypeParameterMap.has(name);
            const typeArgs = typeWillBeReplaced ? undefined : (_c = (_b = type.part) === null || _b === void 0 ? void 0 : _b.typeParams) === null || _c === void 0 ? void 0 : _c.params.map(it => this.serializeType(it));
            // special cases //
            switch (name) {
                case 'string': return idl.IDLStringType;
                case 'Promise': return idl.createContainerType('Promise', typeArgs !== null && typeArgs !== void 0 ? typeArgs : [] /* better check here? */);
                case 'Record': return idl.createContainerType('record', typeArgs !== null && typeArgs !== void 0 ? typeArgs : [] /* better check here? */);
                case 'Map': return idl.createContainerType('record', typeArgs !== null && typeArgs !== void 0 ? typeArgs : [] /* better check here? */);
                case 'Array': return idl.createContainerType('sequence', typeArgs !== null && typeArgs !== void 0 ? typeArgs : [] /* better check here? */);
                case 'Date': return idl.IDLDate;
                case 'date': return idl.IDLDate;
                case 'Object': return idl.IDLObjectType;
                case 'object': return idl.IDLObjectType;
                case 'ArrayBuffer': return idl.IDLBufferType;
                case 'Uint8Array': return idl.IDLBufferType;
                case 'Uint8ClampedArray': return idl.IDLBufferType;
                case 'Boolean': return idl.IDLBooleanType;
                case 'Int32Array': return idl.createContainerType('sequence', [idl.IDLI32Type]);
                case 'IterableIterator': return idl.createContainerType('sequence', typeArgs !== null && typeArgs !== void 0 ? typeArgs : [] /* better check here? */);
                case 'ReadonlyArray': return idl.createContainerType('sequence', typeArgs !== null && typeArgs !== void 0 ? typeArgs : [] /* better check here? */);
                case 'number': return idl.IDLNumberType;
                case 'ErrorCallback': return idl.createReferenceType(name);
                case 'BusinessError': return idl.createReferenceType(name);
                case 'Required':
                case 'Readonly': return typeArgs[0];
                case 'Optional': return idl.createOptionalType(typeArgs[0]);
                case 'ParticleTuple': {
                    const typeParameters = new Set();
                    typeArgs === null || typeArgs === void 0 ? void 0 : typeArgs.forEach(arg => {
                        idl.forEachChild(arg, node => {
                            if (idl.isTypeParameterType(node)) {
                                typeParameters.add(node.name);
                            }
                        });
                    });
                    const typeParametersOrdered = typeParameters.size === 0 ? undefined : Array.from(typeParameters);
                    const tuple = this.createTuple(typeArgs, typeParametersOrdered);
                    if (!this.seenTypes.has(tuple.name)) {
                        this.seenTypes.add(tuple.name);
                        this.addSyntheticType(tuple);
                    }
                    return idl.createReferenceType(tuple.name, typeParametersOrdered === null || typeParametersOrdered === void 0 ? void 0 : typeParametersOrdered.map(it => idl.createTypeParameterReference(it)));
                }
            }
            return idl.createReferenceType(name, typeArgs);
        }
        if (arkts.isETSFunctionType(type)) {
            const [funcType, typeArguments] = this.serializeFunctionType(type);
            if (!this.seenTypes.has(funcType.name)) {
                this.seenTypes.add(funcType.name);
                this.addSyntheticType(funcType);
            }
            return idl.createReferenceType(funcType.name, typeArguments.length === 0 ? undefined : typeArguments.map(arg => {
                this.typeParameterFound(arg);
                return idl.createTypeParameterReference(arg);
            }));
        }
        if (arkts.isETSTuple(type)) {
            const [tupleType, typeArguments] = this.serializeTupleType(type);
            if (!this.seenTypes.has(tupleType.name)) {
                this.seenTypes.add(tupleType.name);
                this.addSyntheticType(tupleType);
            }
            return idl.createReferenceType(tupleType.name, typeArguments.length === 0 ? undefined : typeArguments.map(arg => {
                this.typeParameterFound(arg);
                return idl.createTypeParameterReference(arg);
            }));
        }
        throw new Error(`Failed type conversion for ${type ? this.printNode(type) : "undefined"}`);
    }
    serializePrimitive(type) {
        switch (type) {
            case arkts.Es2pandaPrimitiveType.PRIMITIVE_TYPE_BYTE: return idl.IDLI8Type;
            case arkts.Es2pandaPrimitiveType.PRIMITIVE_TYPE_INT: return idl.IDLI32Type;
            case arkts.Es2pandaPrimitiveType.PRIMITIVE_TYPE_LONG: return idl.IDLI64Type;
            case arkts.Es2pandaPrimitiveType.PRIMITIVE_TYPE_SHORT: return idl.IDLI16Type;
            case arkts.Es2pandaPrimitiveType.PRIMITIVE_TYPE_FLOAT: return idl.IDLF32Type;
            case arkts.Es2pandaPrimitiveType.PRIMITIVE_TYPE_DOUBLE: return idl.IDLF64Type;
            case arkts.Es2pandaPrimitiveType.PRIMITIVE_TYPE_BOOLEAN: return idl.IDLBooleanType;
            case arkts.Es2pandaPrimitiveType.PRIMITIVE_TYPE_CHAR: return idl.IDLU16Type;
            case arkts.Es2pandaPrimitiveType.PRIMITIVE_TYPE_VOID: return idl.IDLVoidType;
            default: throw new Error(`Unknown primitive type ${type}`);
        }
    }
    serializeFunctionType(type, parentTypeParams) {
        var _a, _b;
        const [[parameters, returnType], typeParams] = this.useTypeParametersTrap(() => {
            const parameters = type.params.map(it => {
                let param = it;
                return idl.createParameter(param.name, this.serializeType(param.typeAnnotation), param.isOptional, param.isRestParameter);
            });
            const returnType = this.serializeType(type.returnType);
            return [parameters, returnType];
        });
        const orderedTypeParameters = ((_a = parentTypeParams === null || parentTypeParams === void 0 ? void 0 : parentTypeParams.parameters) !== null && _a !== void 0 ? _a : []).concat(Array.from(typeParams));
        const result = idl.createCallback(this.contextualSelectName(generateSyntheticFunctionName(parameters, returnType, arkts.hasModifierFlag(type, arkts.Es2pandaModifierFlags.MODIFIER_FLAGS_ASYNC))), parameters, returnType, { fileName: this.fileName }, orderedTypeParameters.length ? orderedTypeParameters : undefined);
        (_b = result.extendedAttributes) !== null && _b !== void 0 ? _b : (result.extendedAttributes = []);
        if (!this.contextual.hasSuggestion || !this.contextual.forced)
            result.extendedAttributes.push({ name: idl.IDLExtendedAttributes.Synthetic });
        else
            result.extendedAttributes.push(...this.traceAttrs());
        return [result, orderedTypeParameters];
    }
    serializeTupleType(type) {
        const [properties, typeParameters] = this.useTypeParametersTrap(() => {
            return type.tupleTypeAnnotationsList.map(it => {
                return this.serializeType(it);
            });
        });
        const orderedTypeParameters = Array.from(typeParameters);
        const result = this.createTuple(properties, orderedTypeParameters.length ? orderedTypeParameters : undefined);
        return [result, orderedTypeParameters];
    }
    createTuple(properties, typeParameters) {
        const extendedAttributes = [
            { name: idl.IDLExtendedAttributes.Entity, value: idl.IDLEntity.Tuple }
        ];
        if (!this.contextual.hasSuggestion || !this.contextual.forced)
            extendedAttributes.push({ name: idl.IDLExtendedAttributes.Synthetic });
        else
            extendedAttributes.push(...this.traceAttrs());
        return idl.createInterface(this.contextualSelectName('Tuple_' + properties.map(it => generateSyntheticIdlNodeName(it)).join('_')), idl.IDLInterfaceSubkind.Tuple, [], [], [], properties.map((it, idx) => {
            return idl.createProperty(`value${idx}`, it);
        }), [], [], typeParameters, {
            fileName: this.fileName,
            extendedAttributes
        });
    }
    shouldNotProcessMember(scopeName, entryName) {
        var _a, _b;
        return (_b = (_a = this.config.DeletedMembers.get(scopeName)) === null || _a === void 0 ? void 0 : _a.includes(entryName)) !== null && _b !== void 0 ? _b : false;
    }
    addSyntheticType(entry) {
        this.entries.push(entry);
    }
    extractTypeParameters(node) {
        const result = [];
        node === null || node === void 0 ? void 0 : node.params.forEach(param => {
            var _a;
            if (param.name) {
                // constraint and default value lost here
                result.push((_a = param.name) === null || _a === void 0 ? void 0 : _a.name);
            }
        });
        if (result.length === 0) {
            return {
                parameters: undefined,
                set: new Set(),
                attrs: []
            };
        }
        return {
            set: new Set(result),
            attrs: [{ name: idl.IDLExtendedAttributes.TypeParameters, value: result.join(',') }],
            parameters: result
        };
    }
    withTypeParamContext(params, op) {
        this.typeParamsStack.push(params);
        const r = op();
        this.typeParamsStack.pop();
        return r;
    }
    withReplacementContext(name, op) {
        if (TypeParameterMap.has(name)) {
            const mapping = TypeParameterMap.get(name);
            this.typeReplacements.push(mapping);
            const r = op(true);
            this.typeReplacements.pop();
            return r;
        }
        return op(false);
    }
    isTypeParameter(name) {
        return this.typeParamsStack.find(bucket => bucket.has(name)) !== undefined;
    }
    useTypeParametersTrap(op) {
        this.typeParamsTraps.push(new Set());
        const r = op();
        const record = this.typeParamsTraps.pop();
        return [r, record];
    }
    typeParameterFound(name) {
        var _a;
        (_a = this.typeParamsTraps.at(-1)) === null || _a === void 0 ? void 0 : _a.add(name);
    }
    markDefaultExport() {
        if (this.defaultExportName) {
            this.entries.forEach(entry => {
                var _a;
                if (entry.name === this.defaultExportName) {
                    (_a = entry.extendedAttributes) !== null && _a !== void 0 ? _a : (entry.extendedAttributes = []);
                    entry.extendedAttributes.push({
                        name: idl.IDLExtendedAttributes.DefaultExport
                    });
                }
            });
        }
    }
    postprocessComponent(iface) {
        var _a;
        (_a = iface.extendedAttributes) !== null && _a !== void 0 ? _a : (iface.extendedAttributes = []);
        iface.extendedAttributes.push({ name: idl.IDLExtendedAttributes.Component });
    }
    postprocessEntires() {
        if (this.mode === 'arkoala') {
            /* arkgen specialization */
            const componentInterface = this.entries.find(it => idl.hasExtAttribute(it, idl.IDLExtendedAttributes.ComponentInterface));
            if (componentInterface) {
                if (!idl.isInterface(componentInterface)) {
                    throw new Error("ComponentInterface must be interface!");
                }
                const componentAttributeNameRef = componentInterface.callables.at(0).returnType;
                if (!idl.isReferenceType(componentAttributeNameRef)) {
                    throw new Error("Expected @ComponentBuilder function return type to be a reference");
                }
                const componentAttributeName = componentAttributeNameRef.name;
                const processedEntries = [];
                this.entries.forEach(entry => {
                    if (entry.name === componentInterface.name && entry !== componentInterface) {
                        return;
                    }
                    if (entry.name === componentAttributeName && idl.isInterface(entry)) {
                        this.postprocessComponent(entry);
                    }
                    if (idl.isCallback((entry))) {
                        let hasComponentInReferences = false;
                        idl.forEachChild(entry, (node) => {
                            if (idl.isNamedNode(node) && [componentAttributeName].includes(node.name))
                                hasComponentInReferences = true;
                        });
                        if (hasComponentInReferences) {
                            return;
                        }
                    }
                    processedEntries.push(entry);
                });
                this.entries = processedEntries;
            }
            this.entries.forEach(entry => {
                if (idl.isInterface(entry) && this.config.Components.includes(entry.name)) {
                    this.postprocessComponent(entry);
                }
            });
            // convert components methods to attributes
            for (const entry of this.entries) {
                if (idl.isInterface(entry) && idl.hasExtAttribute(entry, idl.IDLExtendedAttributes.Component)) {
                    entry.methods = entry.methods.filter(method => {
                        var _a, _b;
                        if (method.parameters.length === 1) {
                            entry.properties.push(idl.createProperty(method.name, method.parameters[0].type, false, false, method.parameters[0].isOptional, {
                                extendedAttributes: ((_a = method.extendedAttributes) !== null && _a !== void 0 ? _a : []).concat([{ name: idl.IDLExtendedAttributes.CommonMethod }])
                            }));
                            return false;
                        }
                        (_b = method.extendedAttributes) !== null && _b !== void 0 ? _b : (method.extendedAttributes = []);
                        method.extendedAttributes.push({ name: idl.IDLExtendedAttributes.CommonMethod });
                        return true;
                    });
                }
            }
        }
        /* remove synthetic duplicates */
        function removeDuplicatedByScope(entries) {
            const namesCount = new Map();
            const result = [];
            entries.forEach(entry => {
                var _a;
                namesCount.set(entry.name, ((_a = namesCount.get(entry.name)) !== null && _a !== void 0 ? _a : 0) + 1);
            });
            entries.forEach(entry => {
                if (idl.isNamespace(entry)) {
                    entry.members = removeDuplicatedByScope(entry.members);
                }
                const count = namesCount.get(entry.name);
                if (count > 1) {
                    if (idl.hasExtAttribute(entry, idl.IDLExtendedAttributes.Synthetic)) {
                        result.push(entry);
                    }
                }
                else {
                    result.push(entry);
                }
            });
            return result;
        }
        const mappers = [
            (node) => {
                if (idl.isInterface(node))
                    this.escapeSameNamedMethods(node);
            },
            (node) => {
                if (idl.isInterface(node)) {
                    node.properties = filterRedundantAttributesOverloads(node.properties);
                    node.methods = filterRedundantMethodsOverloads(node.methods);
                }
            }
        ];
        for (const entry of this.entries) {
            idl.forEachChild(entry, () => { }, (node) => mappers.forEach(it => it(node)));
            mappers.forEach(it => it(entry));
        }
        this.entries = removeDuplicatedByScope(this.entries);
    }
    /**
     * Just syntax equality
     */
    isTypesEq(a, b) {
        return idl.printType(a) === idl.printType(b);
    }
    isParametersEq(a, b) {
        return a.name === b.name
            && a.isOptional === b.isOptional
            && a.isVariadic === b.isVariadic
            && this.isTypesEq(a.type, b.type);
    }
    isMethodPerfectlyTheSame(a, b) {
        return a.name === b.name
            && a.parameters.length === b.parameters.length
            && zip(a.parameters, b.parameters).every(([x, y]) => this.isParametersEq(x, y));
    }
    escapeSameNamedMethods(decl) {
        const checkedNames = new Set(["attributeModifier"]);
        for (const method of decl.methods) {
            if (checkedNames.has(method.name))
                continue;
            const sameNamedMethods = decl.methods.filter(it => this.isMethodPerfectlyTheSame(it, method));
            if (sameNamedMethods.length > 1) {
                console.log(`WARNING: escaping ${decl.name}.${method.name}. Same named methods currently are not supported in etsgen`);
                sameNamedMethods.forEach((it, index) => it.name = it.name + index);
            }
            checkedNames.add(method.name);
        }
    }
    toIDLFile() {
        this.markDefaultExport();
        this.postprocessEntires();
        return idl.linkParentBack(idl.createFile(this.entries, this.fileName, this.packageClause));
    }
    toIDLSuperFile() {
        return {
            originalFileName: this.originalFileName,
            generatedFileName: this.fileName,
            writeFilePath: this.fileName,
            skipped: false,
            file: this.toIDLFile(),
            exports: this.fileReExports,
        };
    }
    getNodeType(node) {
        if (arkts.isClassDeclaration(node))
            return 'class';
        if (arkts.isInterfaceDecl(node) || arkts.isTSInterfaceDeclaration(node))
            return 'interface';
        if (arkts.isTSEnumDeclaration(node))
            return 'enum_class';
        if (arkts.isTSEnumMember(node))
            return 'enum_instance';
        if (arkts.isFunctionDeclaration(node))
            return 'function';
        if (arkts.isETSModule(node))
            return 'namespace';
        if (arkts.isClassProperty(node))
            return 'field';
        if (arkts.isMethodDefinition(node))
            return 'method';
        if (arkts.isTSTypeAliasDeclaration(node))
            return 'field'; // !!!
        throw new Error("Unknown node type!");
    }
    getNodeName(node) {
        if (arkts.isClassDeclaration(node))
            return node.definition.ident.name;
        if (arkts.isInterfaceDecl(node) || arkts.isTSInterfaceDeclaration(node))
            return node.id.name;
        if (arkts.isTSEnumDeclaration(node))
            return node.key.name;
        if (arkts.isTSEnumMember(node))
            return node.name;
        if (arkts.isFunctionDeclaration(node))
            return node.function.id.name;
        if (arkts.isETSModule(node))
            return node.ident.name;
        if (arkts.isClassProperty(node))
            return node.id.name;
        if (arkts.isMethodDefinition(node))
            return node.id.name;
        if (arkts.isTSTypeAliasDeclaration(node))
            return node.id.name;
        throw new Error("Unknown node type!");
    }
    saveStatus(status) {
        var _a, _b;
        let pkg = camelCaseToUpperSnakeCase((_a = this.packageClause.at(-1)) !== null && _a !== void 0 ? _a : '').toLowerCase();
        let fpkg = this.packageClause.join('.');
        const [node, ...tail] = this.processNodeStack;
        let name = this.getNodeName(node);
        let parent = tail.map(it => this.getNodeName(it)).reverse().join('.');
        if (parent == '')
            parent = 'unnamed';
        let type = this.getNodeType(node);
        let ok = `${parent}:${name}`;
        let override = ((_b = this.status.od.get(ok)) !== null && _b !== void 0 ? _b : -1) + 1;
        this.status.od.set(ok, override);
        this.status.status.push(new StatusRecord(fpkg, pkg, parent, name, override, type, status !== null && status !== void 0 ? status : '', node.dumpSrc().split("\n")[0]));
        return `${fpkg}:${parent}:${name}:${override}`;
    }
    traceAttrs() {
        let traceKey = this.saveStatus();
        return this.status.enabled ? [{ name: idl.IDLExtendedAttributes.TraceKey, value: traceKey }] : [];
    }
    traceDeleted(reason) {
        this.saveStatus(reason);
    }
}
IDLVisitor.etsFunctionTypeReferencePattern = new RegExp(/^Function[0-9]+$/g);
//# sourceMappingURL=generate.js.map