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

import * as lw from './lws'

export const E = {
  v: (name: string, annotations: lw.Annotation[] = []): lw.VariableExpression => ({
    kind: lw.LWKind.VariableExpression,
    name,
    annotations,
  }),
  c: (value: string | number, annotations: lw.Annotation[] = []): lw.ConstantExpression => ({
    kind: lw.LWKind.ConstantExpression,
    value: value.toString(),
    annotations,
  }),
  s: (value: string, annotations: lw.Annotation[] = []): lw.StringExpression => ({
    kind: lw.LWKind.StringExpression,
    value,
    annotations,
  }),
  unary: (op: string, expression: lw.LWExpression, annotations: lw.Annotation[] = []): lw.UnaryExpression => ({
    kind: lw.LWKind.UnaryExpression,
    expression,
    op,
    annotations,
  }),
  bin: (op: string, left: lw.LWExpression, right: lw.LWExpression, annotations: lw.Annotation[] = []): lw.BinaryExpression => ({
    kind: lw.LWKind.BinaryExpression,
    op,
    left,
    right,
    annotations,
  }),
  call: (callee: lw.LWExpression, args: lw.LWExpression[], typeArgs?: lw.LWType[], annotations: lw.Annotation[] = []): lw.CallExpression => ({
    kind: lw.LWKind.CallExpression,
    args,
    callee,
    typeArgs,
    annotations,
  }),
  get: (base: lw.LWExpression, accessor: string | lw.LWExpression, annotations: lw.Annotation[] = []): lw.AccessorExpression => ({
    kind: lw.LWKind.AccessorExpression,
    base,
    accessor,
    annotations,
  }),
  instance: (name: string, args: lw.LWExpression[], typeArgs?: lw.LWType[], annotations: lw.Annotation[] = []): lw.ConstructorExpression => ({
    kind: lw.LWKind.ConstructorExpression,
    args,
    name,
    typeArgs,
    annotations,
  }),
}

export const S = {
  declaration: (varName: string, varType: lw.LWType, mutable: boolean, expression?: lw.LWExpression): lw.DeclarationStatement => ({
    kind: lw.LWKind.DeclarationStatement,
    varName,
    varType,
    mutable,
    expression,
  }),
  block: (statements: lw.LWStatement[]): lw.CompoundStatement => ({
    kind: lw.LWKind.CompoundStatement,
    statements,
  }),
  e: (expression?: lw.LWExpression): lw.ExpressionStatement => ({
    kind: lw.LWKind.ExpressionStatement,
    expression,
  }),
  return: (expression?: lw.LWExpression): lw.ReturnStatement => ({
    kind: lw.LWKind.ReturnStatement,
    expression,
  }),
  loop: (condition: lw.LWExpression, body: lw.LWStatement): lw.LoopStatement => ({
    kind: lw.LWKind.LoopStatement,
    condition,
    body,
  }),
  if: (condition: lw.LWExpression, thenBody: lw.LWStatement, elseBody?: lw.LWStatement): lw.IfStatement => ({
    kind: lw.LWKind.IfStatement,
    condition,
    thenBody,
    elseBody,
  })
}

export const T = {
  cc: (name: string): lw.ConstType => ({
    kind: lw.LWKind.ConstType,
    name
  }),
  c: (name: string, ...args: lw.LWType[]): lw.ConstType | lw.AppType => {
    if (args.length === 0) {
      return {
        kind: lw.LWKind.ConstType,
        name
      }
    }
    return {
      kind: lw.LWKind.AppType,
      head: name,
      args,
    }
  },
  fn: (params: [name: string, type: lw.LWType][], returnType: lw.LWType): lw.FuncType => ({
    kind: lw.LWKind.FuncType,
    params: params.map(([name, type]) => ({ name, type })),
    returnType
  }),
}

interface DDOptions {
  generics?: lw.GenericDescriptor[]
  modifiers?:lw.Modifier[]
}

export const DD = ({ generics = [], modifiers = [] }: DDOptions) => ({
  union: (name: string, variants: lw.UnionDeclaration['variants']): lw.UnionDeclaration => ({
    kind: lw.LWKind.UnionDeclaration,
    generics,
    modifiers,
    name,
    variants,
  }),
  enum: (name: string, members: lw.EnumDeclaration['members']): lw.EnumDeclaration => ({
    kind: lw.LWKind.EnumDeclaration,
    generics,
    modifiers,
    name,
    members,
  }),
  struct: (name: string, members: lw.StructureDeclaration['members']): lw.StructureDeclaration => ({
    kind: lw.LWKind.StructureDeclaration,
    generics,
    modifiers,
    name,
    members,
  }),
  class: (name: string, fields: lw.ClassDeclaration['fields'], methods: lw.FunctionDeclaration[], more?: lw.ClassDeclaration['oop']): lw.ClassDeclaration => ({
    kind: lw.LWKind.ClassDeclaration,
    generics,
    modifiers,
    name,
    fields,
    methods,
    oop: more
  }),
  ns: (name: string, members: lw.LWDeclaration[]): lw.NamespaceDeclaration => ({
    kind: lw.LWKind.NamespaceDeclaration,
    name,
    members,
  }),
  type: (name: string, type: lw.LWType): lw.TypedefDeclaration => ({
    kind: lw.LWKind.TypedefDeclaration,
    generics,
    modifiers,
    name,
    type,
  }),
  func: (name: string, parameters: lw.FunctionDeclaration['parameters'], returnType: lw.LWType, body: lw.LWStatement): lw.FunctionDeclaration => ({
    kind: lw.LWKind.FunctionDeclaration,
    generics,
    modifiers,
    name,
    parameters,
    returnType,
    body,
  })
})
export const D = DD({})

export const utils = {
  hasAnnotation(node: lw.LWExpression, annotation: string) {
    return node.annotations.find(x => x.name === annotation)
  },
  getAnnotation(node: lw.LWExpression, annotation: string) {
    return node.annotations.find(x => x.name === annotation)?.value
  }
}
