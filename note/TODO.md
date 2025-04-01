# TODO

- [-] Make the generated code correct, fix intreface ColumnAttribute etc.
- [-] Make the structure of directories fit the requirements of es2panda
- [-] Make the filename fit the requirements of es2panda, ArkColumn.ts => column.ts etc.
- [-] Put the class from XXXBuilder.ts to it's original declaration. e.g. Move BottomTabBarStyle from `ArkBottomTabBarStyleBuilder.ts` to `tabContent.ts`
- [ ] Fix import from `arkui-external` and `arkui-pixelmap` etc.
- [ ] Fix callback declaration from `Callback_Literal_Number_code_Want_want_Void` to `Callback<UIExtensionProxy>` and import `Callback` class from where it really exist

## Generated Structure

Path of genereated file. e.g. `Column`

```txt
genereated/component/column.ts
genereated/component/impl/ArkColumn.ts
genereated/component/peers/ArkColumnPeer.ts
```

### Genereated File Content

`Column.ts` it should contain the content of the original ColumnInterface.ts and add a function Column into it

```ts
// >>>>>>>>>>>>>>>>>>>>>>>>
// >>>>>> common.ts >>>>>>>
// >>>>>>>>>>>>>>>>>>>>>>>>
interface CommonMethod {
    /* memo */
    width(len: number): this;
}

// >>>>>>>>>>>>>>>>>>>>>>>>
// >>>>>> column.ts >>>>>>>
// >>>>>>>>>>>>>>>>>>>>>>>>
interface ColumnAttribute extends CommonMethod {
    /* memo */
    setColumnOptions(options?: ColumnOptions): this;
}

/** @memo */
export function Column (
  /** @memo */
  style: ((attributes: ColumnAttribute) => void) | undefined,
  /** @memo */
  content_: (() => void) | undefined,
  options?: ColumnOptions | undefined
) {
    const receiver = remember(() => {
        return new ArkColumnComponent()
    })
    NodeAttach<ArkColumnPeer>((): ArkColumnPeer => ArkColumnPeer.create(receiver), (_: ArkColumnPeer) => {
        receiver.setColumnOptions(options)
        style?.(receiver)
        content_?.()
        receiver.applyAttributesFinish()
    })
}
```

`ArkColumn.ts` file should contain the class of `ArkColumnComponent` which should implements `ColumnAttribute`


```ts
// >>>>>>>>>>>>>>>>>>>>>>>>
// >>>>> ArkColumn.ts >>>>>
// >>>>>>>>>>>>>>>>>>>>>>>>
export class ArkColumnComponent extends ArkCommonMethodComponent implements ColumnAttribute {
    getPeer(): ArkColumnPeer {
        return (this.peer as ArkColumnPeer)
    }
    /** @memo */
    public setColumnOptions(options?: ColumnOptions): this {
        if (this.checkPriority("setColumnOptions")) {
            const options_casted = options as (ColumnOptions | undefined)
            this.getPeer()?.setColumnOptionsAttribute(options_casted)
            return this
        }
        return this
    }
}
```

### Class Declaration

Move the implimentation from `ArkBottomTabBarStyleBuilder.ts` to `tabContent.ts`.

```ts
// >>>>>>>>>>>>>>>>>>>>>>>>
// >>>> tabContent.ts >>>>>
// >>>>>>>>>>>>>>>>>>>>>>>>

export class BottomTabBarStyle {
    // ...
}

/** @memo */
export function TabContent(
  /** @memo */
  style: ((attributes: ArkTabContentComponent) => void) | undefined,
  /** @memo */
  content_: (() => void) | undefined,
) {
    const receiver = remember(() => {
        return new ArkTabContentComponent()
    })
    NodeAttach<ArkTabContentPeer>((): ArkTabContentPeer => ArkTabContentPeer.create(receiver), (_: ArkTabContentPeer) => {
        receiver.setTabContentOptions()
        style?.(receiver)
        content_?.()
        receiver.applyAttributesFinish()
    })
}
```
