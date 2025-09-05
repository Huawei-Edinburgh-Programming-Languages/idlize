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

export enum FstConditionKind {
    Wrapped = "Wrapped",
    Rule = "Rule",
    Not = "Not",
    AnyOf = "AnyOf",
    AllOf = "AllOf",
}

export interface FstConditionWrapped {
    kind: FstConditionKind.Wrapped
}
export interface FstConditionRule {
    kind: FstConditionKind.Rule
    name: string
}
export interface FstConditionNot {
    kind: FstConditionKind.Not
    element: FstCondition
}
export interface FstConditionAnyOf {
    kind: FstConditionKind.AnyOf
    elements: FstCondition[]
}
export interface FstConditionAllOf {
    kind: FstConditionKind.AllOf
    elements: FstCondition[]
}

export type FstCondition =
      FstConditionWrapped
    | FstConditionRule
    | FstConditionNot
    | FstConditionAnyOf
    | FstConditionAllOf

//////////////////////////////////////////

export enum FstTraitKind {
    Simple = "Simple",
    Indented = "Indented",
}

export interface FstTraitSimple {
    kind: FstTraitKind.Simple
    name: string
}
export interface FstTraitIndented {
    kind: FstTraitKind.Indented
}
export type FstTraitRecord =
      FstTraitSimple
    | FstTraitIndented

//////////////////////////////////////////

export enum FstKind {
    Indent = "Indent",
    NewLine = "NewLine",
    Text = "Text",
    Group = "Group",
}

export interface FstIndent {
    kind: FstKind.Indent
    condition?: FstCondition
}
export interface FstNewLine {
    kind: FstKind.NewLine
    condition?: FstCondition
}
export interface FstText {
    kind: FstKind.Text
    text: string
    condition?: FstCondition
}
export interface FstGroup {
    kind: FstKind.Group
    elements: FstNode[]
    traits: FstTraitRecord[]
}

export type FstNode =
      FstIndent
    | FstNewLine
    | FstGroup
    | FstText

//////////////////////////////////////////

export const IF = {
    wrapped: (): FstConditionWrapped => ({
        kind: FstConditionKind.Wrapped,
    }),
    rule: (name:string): FstConditionRule => ({
        kind: FstConditionKind.Rule,
        name,
    }),
    not: (element: FstCondition): FstConditionNot => ({
        kind: FstConditionKind.Not,
        element,
    }),
    anyOf: (elements: FstCondition[]): FstConditionAnyOf => ({
        kind: FstConditionKind.AnyOf,
        elements,
    }),
    allOf: (elements: FstCondition[]): FstConditionAllOf => ({
        kind: FstConditionKind.AllOf,
        elements,
    }),
}

export const F = {
    indent: (condition?: FstCondition): FstIndent => ({
        kind: FstKind.Indent,
        condition,
    }),

    newline: (condition?: FstCondition): FstNewLine => ({
        kind: FstKind.NewLine,
        condition,
    }),
    group: (elements: FstNode[], traits: FstTraitRecord[] = []): FstGroup => ({
        kind: FstKind.Group,
        traits,
        elements,
    }),
    text: (text: string, condition?: FstCondition): FstText => ({
        kind: FstKind.Text,
        text,
        condition,
    }),
}
