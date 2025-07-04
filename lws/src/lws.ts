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

export enum LWKind {
  UnionDeclaration,
  StructureDeclaration,
  ClassDeclaration,
  NamespaceDeclaration,
  TypedefDeclaration,
  FunctionDeclaration,

  DeclarationStatement,
  CompoundStatement,
  ExpressionStatement,
  ReturnStatement,
  LoopStatement,
  IfStatement,

  VariableExpression,
  ConstantExpression,
  StringExpression,
  UnaryExpression,
  BinaryExpression,
  CallExpression,
  AccessorExpression,
  ConstructorExpression,

  ConstType,
  FuncType,
  AppType,
}

////////////////////////////////////////////////////////

export interface GenericDescriptor {
  name: string
}

////////////////////////////////////////////////////////

export enum DecoratorKind {
  Annotation = "Annotation",
  Modifier = "Modifier"
}

export interface Annotation {
  kind: DecoratorKind.Annotation,
  name: string
  value?: string
}
export interface Modifier {
  kind: DecoratorKind.Modifier,
  name: string
  value?: string
}

////////////////////////////////////////////////////////

/**
 * Should be emulated as tagged union
 */
export interface UnionDeclaration {
  kind: LWKind.UnionDeclaration
  generics: GenericDescriptor[]
  modifiers: Modifier[]
  name: string
  variants: {
    name: string
    type: LWType
  }[]
}
export interface StructureDeclaration {
  kind: LWKind.StructureDeclaration
  generics: GenericDescriptor[]
  modifiers: Modifier[]
  name: string
  members: {
    name: string
    type: LWType
  }[]
}
export interface ClassDeclaration {
  kind: LWKind.ClassDeclaration
  generics: GenericDescriptor[]
  modifiers: Modifier[]
  name: string
  fields: {
    name: string
    type: LWType
  }[]
  methods: FunctionDeclaration[]

  oop?: {
    base?: LWType
    implementations?: LWType[]
    sort: 'interface' | 'class'
  }
}
export interface NamespaceDeclaration {
  kind: LWKind.NamespaceDeclaration
  name: string
  members: LWDeclaration[]
}
export interface TypedefDeclaration {
  kind: LWKind.TypedefDeclaration
  generics: GenericDescriptor[]
  modifiers: Modifier[]
  name: string
  type: LWType
}
export interface FunctionDeclaration {
  kind: LWKind.FunctionDeclaration
  generics: GenericDescriptor[]
  modifiers: Modifier[]
  name: string
  parameters: {
    name: string
    type: LWType
  }[]
  returnType: LWType
  body: LWStatement
}
export type LWDeclaration =
    UnionDeclaration
  | StructureDeclaration
  | ClassDeclaration
  | NamespaceDeclaration
  | TypedefDeclaration
  | FunctionDeclaration

export interface DeclarationStatement {
  kind: LWKind.DeclarationStatement
  varName: string
  varType: LWType
  mutable: boolean
  expression?: LWExpression
}
export interface CompoundStatement {
  kind: LWKind.CompoundStatement
  statements: LWStatement[]
}
export interface ExpressionStatement {
  kind: LWKind.ExpressionStatement
  expression?: LWExpression
}
export interface ReturnStatement {
  kind: LWKind.ReturnStatement
  expression?: LWExpression
}
export interface LoopStatement {
  kind: LWKind.LoopStatement
  condition: LWExpression
  body: LWStatement
}
export interface IfStatement {
  kind: LWKind.IfStatement
  condition: LWExpression
  thenBody: LWStatement
  elseBody?: LWStatement
}
export type LWStatement =
    DeclarationStatement
  | CompoundStatement
  | ExpressionStatement
  | ReturnStatement
  | LoopStatement
  | IfStatement

export interface VariableExpression {
  kind: LWKind.VariableExpression
  name: string
  annotations: Annotation[]
}
export interface ConstantExpression {
  kind: LWKind.ConstantExpression
  value: string
  annotations: Annotation[]
}
export interface StringExpression {
  kind: LWKind.StringExpression
  value: string
  annotations: Annotation[]
}
export interface UnaryExpression {
  kind: LWKind.UnaryExpression
  expression: LWExpression
  op: string
  annotations: Annotation[]
}
export interface BinaryExpression {
  kind: LWKind.BinaryExpression
  left: LWExpression
  op: string
  right: LWExpression
  annotations: Annotation[]
}
export interface CallExpression {
  kind: LWKind.CallExpression
  callee: LWExpression
  args: LWExpression[]
  typeArgs?: LWType[]
  annotations: Annotation[]
}
export interface AccessorExpression {
  kind: LWKind.AccessorExpression
  base: LWExpression
  accessor: string | LWExpression
  annotations: Annotation[]
}
export interface ConstructorExpression {
  kind: LWKind.ConstructorExpression
  name: string
  args: LWExpression[]
  typeArgs?: LWType[]
  annotations: Annotation[]
}
export type LWExpression =
    VariableExpression
  | ConstantExpression
  | StringExpression
  | UnaryExpression
  | BinaryExpression
  | CallExpression
  | AccessorExpression
  | ConstructorExpression

export interface ConstType {
  kind: LWKind.ConstType
  name: string
}
export interface FuncType {
  kind: LWKind.FuncType
  params: {
    name: string
    type: LWType
  }[]
  returnType: LWType
}
export interface AppType {
  kind: LWKind.AppType
  head: string
  args: LWType[]
}
export type LWType =
    ConstType
  | FuncType
  | AppType

export interface LWProgramChunk {
  package: string
  traits: string[] // think about it
  meta: string // and about it
  declarations: LWDeclaration[]
}
