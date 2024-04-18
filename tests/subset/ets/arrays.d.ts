declare interface Arrays {
  bracket: string[]
  generic: Array<string>
}

declare class ArraysAttribute extends CommonMethod<ArraysAttribute> {
  testArray(value: Arrays): ArraysAttribute
  testGenericArray(value: Arrays): ArraysAttribute
}
