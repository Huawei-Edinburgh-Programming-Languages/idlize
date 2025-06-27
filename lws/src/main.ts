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

import { D, DD, E, S, T } from "./builder"
import { TypeScriptPrinter } from "./printers/typescript"
import { Ts, Vs } from "./stdlib"

function main() {
  const test = D.ns('test', [
    D.struct('Point', [
      { name: 'x', type: Ts.prim.int },
      { name: 'y', type: Ts.prim.int },
    ]),
    DD([{ name: 'T' }])
      .class('Animal',
        [
          { name: 'position', type: T.c('Point') },
          { name: 'mass', type: Ts.prim.int }
        ],
        [
          D.func('eat', [{ name: 'dm', type: Ts.prim.int }], Ts.prim.void, S.block([
            S.e(E.bin('=',
              E.get(Vs.self, 'mass'),
              E.bin('+',
                E.get(Vs.self, 'mass'),
                E.v('dm')
              )
            ))
          ])),
          D.func('move', [{ name: 'dx', type: Ts.prim.int }], Ts.prim.void, S.block([
            S.e(E.bin('=',
              E.get(E.get(Vs.self, 'position'), 'x'),
              E.bin('+',
                E.get(E.get(Vs.self, 'position'), 'x'),
                E.v('dx')
              )
            ))
          ])),
          D.func('poly', [{ name: 'x', type: T.c('T') }], Ts.prim.int, S.block([
            S.return(E.get(Vs.self, 'mass'))
          ]))
        ]
    )
  ])

  const tsPrinter = new TypeScriptPrinter()
  tsPrinter.printDeclaration(test)
  const content = tsPrinter.render()
  console.log(content)
}
main()
