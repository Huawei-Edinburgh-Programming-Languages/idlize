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

import { writeFileSync } from "node:fs"
import { D, DD, E, S, T } from "../src/builder"
import { An, Op, std, Ts, Vs } from "../src/stdlib"

import { processNPrintCJ } from "../src/printers/translators/cangjie"
import { processNPrintTS } from "../src/printers/translators/typescript"
import { processNPrintCXX } from "../src/printers/translators/cxx"
import { processNPrintJava } from "../src/printers/translators/java"
import { processNPrintArkTS } from "../src/printers/translators/arkts"
import { dumpToString } from "../src/printers/dump"

function main() {
  const test = D.ns('test', [
    D.struct('Point', [
      { name: 'x', type: Ts.prim.int },
      { name: 'y', type: Ts.prim.int },
    ]),
    DD({ generics: [{ name: 'T' }] })
      .class('Animal',
        [
          { name: 'position', type: T.c('Point') },
          { name: 'mass', type: Ts.prim.int }
        ],
        [
          D.func(
            std.names.members.ctor,
            [
              { name: 'p', type: T.c('Point') },
              { name: 'm', type: Ts.prim.int }
            ],
            Ts.prim.void,
            S.block([
              S.e(E.bin('=', E.get(Vs.self, 'position'), E.v('p'))),
              S.e(E.bin('=', E.get(Vs.self, 'mass'), E.v('m'))),
            ])
          ),
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
          DD({ generics: [{ name: 'U' }] }).func('poly', [{ name: 'x', type: T.c('T') }, { name: 'y', type: T.c('U') }], Ts.prim.int, S.block([
            S.return(E.get(Vs.self, 'mass'))
          ]))
        ]
    ),
    D.class('Box', [], [
      D.func('test1', [], Ts.prim.void, S.block([
        S.declaration('p', T.c('Point'), true,
          E.instance('Point', [ E.c(5, [An.named('x')]), E.c(5, [An.named('y')])], [], [An.asStruct()])
        ),
        S.e(E.call(Vs.print, [E.get(E.v('p'), 'x')]))
      ])),
      D.func('test2', [], Ts.prim.void, S.block([
        S.declaration('i', Ts.prim.int, true, E.c(0)),
        S.loop(E.bin(Op.lt, E.v('i'), E.c(42)), S.block([
          S.e(E.bin('=', E.v('i'), E.bin('+', E.v('i'), E.c(1))))
        ])),
        S.if(E.bin(Op.eq, E.v('i'), E.c(42)),
          S.block([
            S.e(E.call(Vs.print, [E.v('i')]))
          ]),
          S.block([
            S.e(E.bin('=', E.v('i'), E.bin('+', E.v('i'), E.c(1))))
          ])
        )
      ]))
    ])
  ])

  const printers: [string, typeof processNPrintTS][] = [
    [ 'test.ts'   , processNPrintTS    ],
    [ 'test.cj'   , processNPrintCJ    ],
    [ 'test.cpp'  , processNPrintCXX   ],
    [ 'test.java' , processNPrintJava  ],
    [ 'test.ets'  , processNPrintArkTS ],
    [ 'test.dump' , dumpToString       ]
  ]

  printers.forEach(([name, printer]) => {
    writeFileSync(`out/${name}`, printer(test), 'utf-8')
  })
}
main()
