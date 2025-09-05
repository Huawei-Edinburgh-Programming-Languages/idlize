import { EOL } from "node:os";
import { FstCondition, FstConditionKind, FstKind, FstNode, FstTraitKind } from "./fst.js";

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
interface RenderConfig {
    ruleSet: Set<string>
}
interface RenderContext {
    wrapped: boolean
}

export class Renderer {
    constructor(
        private config: RenderConfig
    ) {}

    private evalCondition(cond:FstCondition, context:RenderContext): boolean {
        switch (cond.kind) {
            case FstConditionKind.Wrapped: {
                return context.wrapped
            }
            case FstConditionKind.Rule: {
                return this.config.ruleSet.has(cond.name)
            }
            case FstConditionKind.Not: {
                return !this.evalCondition(cond.element, context)
            }
            case FstConditionKind.AllOf: {
                return cond.elements.every(it => this.evalCondition(it, context))
            }
            case FstConditionKind.AnyOf: {
                return cond.elements.some(it => this.evalCondition(it, context))
            }
        }
    }

    private go(tree:FstNode, context:RenderContext): string {
        switch (tree.kind) {
            case FstKind.Indent: {
                return context.wrapped ? '  ' : ''
            }
            case FstKind.NewLine: {
                return context.wrapped ? EOL : ''
            }
            case FstKind.Group: {
                return tree.elements.map(it => this.go(it, context)).join('')
            }
            case FstKind.Text: {
                if (tree.condition && !this.evalCondition(tree.condition, context)) {
                    return ''
                }
                return tree.text
            }
        }
    }

    render(tree:FstNode): string {
        return this.go(tree, { wrapped: true })
    }
}
