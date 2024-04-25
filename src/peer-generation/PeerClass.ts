import * as path from "path"
import { IndentedPrinter } from "../IndentedPrinter"
import { indentedBy, renameDtsToPeer, throwException } from "../util"
import { ImportsCollector } from "./ImportsCollector"
import { determineInheritanceRole, determineParentRole, InheritanceRole, isCommonMethod, isHeir, isRoot, isStandalone } from "./inheritance"
import { PeerMethod } from "./PeerMethod"
import { Printers } from "./Printers"

export class PeerClass {
    constructor(
        public readonly componentName: string,
        public readonly originalFilename: string,
    ) { }

    methods: PeerMethod[] = []
    get callableMethod(): PeerMethod | undefined {
        return this.methods.find(method => method.isCallSignature)
    }

    originalClassName: string | undefined = undefined
    originalParentName: string | undefined = undefined
    originalParentFilename: string | undefined = undefined
    parentComponentName: string | undefined = undefined

    get koalaComponentName(): string {
        return this.koalaComponentByComponent(this.componentName)
    }

    private koalaComponentByComponent(name: string): string {
        return "Ark" + name
    }

    get peerParentName(): string {
        const name = this.originalClassName
            ?? throwException(`By this time the class name should have been provided: ${this.componentName}`)

        if (isCommonMethod(name)) return "PeerNode"
        if (isStandalone(name)) return "PeerNode"
        if (isRoot(name)) return "Finalizable"

        const parent = this.parentComponentName
            ?? throwException(`Expected component to have parent: ${name}`)
        return `${this.koalaComponentByComponent(parent)}Peer`
    }

    peerClassHeader() {
        const peerParentName = this.peerParentName
        const extendsClause =
            peerParentName
                ? `extends ${peerParentName} `
                : ""
        return `export class ${this.koalaComponentName}Peer ${extendsClause} {`
    }

    private componentToAttribute(name: string): string {
        return "Ark" + name + "Attributes"
    }

    get attributesParentName(): string | undefined {
        if (!isHeir(this.originalClassName!)) return undefined
        return this.componentToAttribute(this.parentComponentName!)
    }

    attributeInterfaceHeader() {
        const parent = this.attributesParentName
        const extendsClause =
            parent
                ? ` extends ${parent} `
                : ""
        return `export interface ${this.componentToAttribute(this.componentName)} ${extendsClause} {`
    }
    private apiModifierHeader() {
        return `typedef struct ArkUI${this.componentName}Modifier {`
    }

    private generateConstructor(printer: IndentedPrinter): void {
        const parentRole = determineParentRole(this.originalClassName!, this.originalParentName)

        if (parentRole === InheritanceRole.Finalizable) {
            printer.print(`constructor(type?: ArkUINodeType, component?: ArkComponent, flags: int32 = 0) {`)
            printer.pushIndent()
            printer.print(`super(BigInt(42)) // for now`)
            printer.popIndent()
            printer.print(`}`)
            return
        }
        if (parentRole === InheritanceRole.PeerNode) {
            printer.print(`constructor(type: ArkUINodeType, component?: ArkComponent, flags: int32 = 0) {`)
            printer.pushIndent()
            printer.print(`super(type, flags)`)
            printer.print(`component?.setPeer(this)`)
            printer.popIndent()
            printer.print(`}`)
            return
        }

        if (parentRole === InheritanceRole.Heir || parentRole === InheritanceRole.Root) {
            printer.print(`constructor(type: ArkUINodeType, component?: ArkComponent, flags: int32 = 0) {`)
            printer.pushIndent()
            printer.print(`super(type, component, flags)`)
            printer.popIndent()
            printer.print(`}`)
            return
        }

        throwException(`Unexpected parent inheritance role: ${parentRole}`)
    }

    private generateApplyMethod(printer: IndentedPrinter): void {
        const name = this.originalClassName!
        const typeParam = this.koalaComponentName + "Attributes"
        if (isRoot(name)) {
            printer.print(`applyAttributes(attributes: ${typeParam}): void {`)
            printer.pushIndent()
            printer.print(`super.constructor(42)`)
            printer.popIndent()
            printer.print(`}`)
            return
        }

        printer.print(`applyAttributes<T extends ${typeParam}>(attributes: T): void {`)
        printer.pushIndent()
        printer.print(`super.applyAttributes(attributes)`)
        printer.popIndent()
        printer.print(`}`)
    }

    private printNodeModifier(printers: Printers) {
        const component = this.componentName
        printers.apiList.pushIndent()
        printers.apiList.print(`const ArkUI${component}Modifier* (*get${component}Modifier)();`)

        const modifierStructImpl = `ArkUI${component}ModifierImpl`
        printers.modifiers.print(`ArkUI${component}Modifier ${modifierStructImpl} {`)
        printers.modifiers.pushIndent()

        printers.modifierList.pushIndent()
        printers.modifierList.print(`Get${component}Modifier,`)
        printers.modifierList.popIndent()
    }

    collectPeerImports(imports: ImportsCollector) {
        if (!this.originalParentFilename) return
        const parentBasename = renameDtsToPeer(path.basename(this.originalParentFilename))
        imports.addFeatureByBasename(this.peerParentName, parentBasename)
        if (this.attributesParentName)
            imports.addFeatureByBasename(this.attributesParentName, parentBasename)
    }

    collectComponentImports(imports: ImportsCollector) {
        if (!this.canPrintComponent()) return
        imports.addFeature("NodeAttach", "@koalaui/runtime")
        const structPostfix = (this.callableMethod?.mappedParamsTypes?.length ?? 0) + 1
        imports.addFeature(`ArkCommonStruct${structPostfix}`, "./ArkStructCommon")
        imports.addFeatureByBasename(`${this.koalaComponentName}Peer`, renameDtsToPeer(path.basename(this.originalFilename)))
        imports.addFeature("ArkUINodeType", "./ArkUINodeType")
    }

    private canPrintComponent() {
        return determineInheritanceRole(this.originalClassName!) == InheritanceRole.Heir
    }

    printComponent(printer: IndentedPrinter) {
        if (!this.canPrintComponent()) return

        const method = this.callableMethod
        const componentClassName = `${this.koalaComponentName}Component`
        const componentFunctionName = this.koalaComponentName
        const peerClassName = `${this.koalaComponentName}Peer`
        const attributeClassName = `${this.componentName}Attribute`
        const parentStructClass = {
            name: `ArkCommonStruct${(method?.mappedParamsTypes?.length ?? 0) + 1}`,
            typesLines: [
                `${componentClassName},`,
                `/** @memo */`,
                `() => void${method?.mappedParamsTypes?.length ? "," : ""}`,
                (method?.mappedParamsTypes ?? []).join(", ")
            ]
        }
        printer.print(`
export class ${componentClassName} extends ${parentStructClass.name}<
${parentStructClass.typesLines.map(it => indentedBy(it, 1)).join("\n")}
> implements ${attributeClassName} {

  protected peer?: ${peerClassName}
`)
        printer.pushIndent()
        for (const method of this.methods)
            method.printComponentMethod(printer)
        printer.popIndent()

        printer.print(`
  /** @memo */
  _build(
    /** @memo */
    style: ((attributes: ${componentClassName}) => void) | undefined,
    /** @memo */
    content_: (() => void) | undefined,
    ${method?.mappedParams ?? ""} 
  ) {
    NodeAttach(() => new ${peerClassName}(ArkUINodeType.${this.componentName}, this), () => {
      style?.(this)
      ${method ? `this.${method?.methodName}(${method?.mappedParamValues})` : ""}
      content_?.()
      this.applyAttributesFinish()
    })
  }
}`)

        printer.print(`
/** @memo */
export function ${componentFunctionName}(
  /** @memo */
  style: ((attributes: ${componentClassName}) => void) | undefined,
  /** @memo */
  content_: (() => void) | undefined,
  ${method?.mappedParams ?? ""}
) {
  ${componentClassName}._instantiate<
${parentStructClass.typesLines.map(it => indentedBy(it, 2)).join("\n")}
  >(
    style,
    () => new ${componentClassName}(),
    content_,
    ${method?.mappedParamValues ?? ""}
  )
}
`)
    }

    printPeer(printer: IndentedPrinter) {
        printer.print(this.peerClassHeader())
        printer.pushIndent()
        this.generateConstructor(printer)
        this.methods.forEach(it => it.printPeerMethod(printer))
        this.generateApplyMethod(printer)
        printer.popIndent()
        printer.print(`}`)
    }

    private printGlobalProlog(printers: Printers) {
        printers.api.print(this.apiModifierHeader())
        printers.api.pushIndent()
        this.printNodeModifier(printers)
    }

    private printGlobalEpilog(printers: Printers) {
        if (this.methods.length == 0) {
            printers.api.print("int dummy;")
        }
        printers.api.popIndent()
        printers.api.print(`} ArkUI${this.componentName}Modifier;\n`)
        printers.apiList.popIndent()
        printers.modifiers.popIndent()
        printers.modifiers.print(`};\n`)
        const name = this.componentName
        printers.modifiers.print(`const ArkUI${name}Modifier* Get${name}Modifier() { return &ArkUI${name}ModifierImpl; }\n\n`)
    }

    printGlobal(printers: Printers) {
        this.printGlobalProlog(printers)
        this.methods.forEach(it => it.printGlobalMethod(printers))
        this.printGlobalEpilog(printers)
    }
}