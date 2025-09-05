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

import { F, FstCondition, IF } from "../fst.js";
import { Renderer } from "../render.js";

const $ = {
    space: (condition?: FstCondition) => F.text(' ', condition),
}

const simpleTree = F.group([
    F.group([
        F.group([
            F.text('function'),
            $.space(),
            F.text('example'),
            F.text('('),
            F.text(')'),
            F.text(':'),
            F.text('number'),
        ]),
        $.space(),
        F.text('{'),
        F.newline(),
        $.space(IF.not(IF.wrapped())),
        ///
        F.indent(),
        F.text('return'),
        $.space(),
        F.text('0'),
        F.text(';', IF.anyOf([ IF.allOf([IF.not(IF.wrapped()), /* IF.not(IF.lastChild()) */]), IF.rule('semi-colons')])),
        ///
        F.newline(),
        $.space(IF.not(IF.wrapped())),
        F.text('}'),
    ])
])

function main() {
    const r = new Renderer({
        ruleSet: new Set([])
    })
    console.log(r.render(simpleTree))
}
main()
