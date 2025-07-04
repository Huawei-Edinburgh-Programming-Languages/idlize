/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
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

import { Language, NativeModuleType, PeerLibrary, toIDLFile } from "@idlizer/core"
import * as idl from "@idlizer/core/idl"
import { An, D, dumpToString, E, IdentityTransformer, lw, Op, processNPrintArkTS, processNPrintCJ, processNPrintCXX, processNPrintJava, processNPrintTS, S, T, transformer, Ts } from "lws"
import { LWType } from "lws/dist/lws"
import { copyFileSync, mkdirSync, readdirSync, statSync, writeFileSync } from "node:fs"
import { EOL } from "node:os"
import { dirname, join, normalize, relative, resolve } from "node:path"

////////////////////////////////////////////////////////////////
// Constants

const REFS = {
  ByteWriter: 'stdlib.ByteWriter',
  ByteReader: 'stdlib.ByteReader',
}

////////////////////////////////////////////////////////////////
// utils

function scan(root: string): string[] {
  return statSync(root).isDirectory()
    ? readdirSync(root).flatMap(p => scan(join(root, p)))
    : [root]
}

////////////////////////////////////////////////////////////////
// library

class GenLibrary extends PeerLibrary {
  toLWType(type: idl.IDLType): lw.LWType {
    if (idl.isPrimitiveType(type)) {
      switch (type) {
        case idl.IDLI32Type: return Ts.prim.int
        case idl.IDLStringType: return Ts.prim.str
      }
    }
    if (idl.isContainerType(type)) {
      if (idl.IDLContainerUtils.isSequence(type)) {
        return T.c('Array', this.toLWType(type.elementType[0]))
      }
    }
    if (idl.isReferenceType(type)) {
      const found = this.resolveTypeReference(type)
      if (!found) {
        throw new Error("NOT FOUND!")
      }
      return T.c(idl.getFQName(found))
    }
    throw new Error(`Not implemented "${idl.DebugUtils.debugPrintType(type)}"`)
  }

  makeEncode(type: idl.IDLType, what: lw.LWExpression, where: lw.LWExpression): lw.LWStatement {
    if (idl.isPrimitiveType(type)) {
      let methodName = '<oops>'
      switch (type) {
        case idl.IDLI32Type: { methodName = 'writeInt32'; break }
        case idl.IDLStringType: { methodName = 'writeString'; break }
      }
      return S.e(E.call(E.get(where, methodName), [what]))
    }
    if (idl.isContainerType(type)) {
      return S.e()
    }
    if (idl.isReferenceType(type)) {
      const declaration = this.resolveTypeReference(type)
      if (!declaration) {
        throw new Error("WOW!")
      }
      return S.e()
    }
    return S.e()
  }
  makeDecode(type: idl.IDLType, where: lw.LWExpression): [lw.LWStatement[], lw.LWExpression] {
    if (idl.isPrimitiveType(type)) {
      let methodName = '<oops>'
      switch (type) {
        case idl.IDLI32Type: { methodName = 'readInt32'; break }
        case idl.IDLStringType: { methodName = 'readString'; break }
      }
      return [
        [],
        E.call(E.get(where, methodName), [])
      ]
    }
    if (idl.isContainerType(type)) {
      return [
        [],
        E.v('HEH')
      ]
    }
    if (idl.isReferenceType(type)) {
      const declaration = this.resolveTypeReference(type)
      if (!declaration) {
        throw new Error("WOW!")
      }
      return [
        [],
        E.v('HEH')
      ]
    }
    return [
      [],
      E.v('HEH')
    ]
  }
}

////////////////////////////////////////////////////////////////
// generator

class Generator {
  constructor(
    private library: GenLibrary
  ) { }

  static create(library: GenLibrary) {
    return new Generator(library)
  }

  /////////////////////////////////////////

  private typeOf(entry: idl.IDLEntry) {
    return T.c(idl.getFQName(entry))
  }

  /////////////////////////////////////////

  private generateStructure(entry: idl.IDLInterface): lw.LWDeclaration {
    return D.struct(entry.name, entry.properties.map(prop => ({
      name: prop.name,
      type: this.library.toLWType(prop.type),
    })))
  }

  private generateEncoders(entry: idl.IDLInterface): lw.LWDeclaration[] {
    return [
      D.class(entry.name + 'Encoder', [], [
        D.func('encode', [{ name: 'value', type: Ts.ref(Ts.const(this.typeOf(entry))) }], T.c(REFS.ByteWriter), S.block([
          S.declaration('writer', T.c(REFS.ByteWriter), false, E.instance(REFS.ByteWriter, [])),
          entry.properties.map(prop => {
            return this.library.makeEncode(prop.type, E.get(E.v('value'), prop.name), E.v('writer'))
          }),
          S.return(E.v('writer'))
        ].flat())),
        D.func('decode', [{ name: 'reader', type: Ts.ref(T.c(REFS.ByteReader)) }], this.typeOf(entry), S.block([
          entry.properties.flatMap(prop => {
            const [statements, expression] = this.library.makeDecode(prop.type, E.v('reader'))
            return [
              ...statements,
              S.declaration(prop.name, this.library.toLWType(prop.type), false, expression)
            ]
          }),
          S.return(E.instance(idl.getFQName(entry), entry.properties.map(p => E.v(p.name, [An.named(p.name)])), [], [An.asStruct()]))
        ].flat())),
      ])
    ]
  }

  ///

  generate(entry: idl.IDLEntry): lw.LWDeclaration[] {
    const results: lw.LWDeclaration[] = []
    if (idl.isInterface(entry)) {
      results.push(this.generateStructure(entry))
      results.push(...this.generateEncoders(entry))
    }
    if (idl.isNamespace(entry)) {
      entry.members.forEach(member => {
        this.generate(member).forEach(prog => {
          results.push(prog)
        })
      })
    }
    return results
  }
}

////////////////////////////////////////////////////////////////
// transformers

class RefNameTransformer extends IdentityTransformer {
  goConstType(type: lw.ConstType): lw.LWType {
    if (type.name.startsWith('@')) {
      return super.goConstType(type)
    }
    const chunks = type.name.split('.')
    return T.c(chunks.at(-1)!)
  }
  goConstructorExpression(expr: lw.ConstructorExpression): lw.ConstructorExpression {
    const transformed = super.goConstructorExpression(expr)
    transformed.name = transformed.name.split('.').at(-1)!
    return transformed
  }
}

////////////////////////////////////////////////////////////////
// config ot smth

interface TargetInfo {
  tag: string
  outDir: string
  outFile: string
  prefix?: string,
  printer: typeof processNPrintTS
}

const printers: TargetInfo[] = [
  {
    tag: 'ts',
    outDir: 'ts',
    outFile: 'test.ts',
    printer: processNPrintTS,
    prefix: 'import { ByteWriter, ByteReader } from "./stdlib"'
  },
  {
    tag: 'cj',
    outDir: 'cj',
    outFile: 'test.cj',
    printer: processNPrintCJ,
    prefix: 'package test'
  },
  {
    tag: 'cpp',
    outDir: 'cpp',
    outFile: 'test.cpp',
    printer: processNPrintCXX,
    prefix: `#include "stdlib.h"`
  },
  {
    tag: 'java',
    outDir: join('java', 'src', 'test'),
    outFile: 'test.java',
    printer: processNPrintJava,
    prefix: 'package src.test;'
  },
  {
    tag: 'ets',
    outDir: 'ets',
    outFile: 'test.ets',
    printer: processNPrintArkTS,
    prefix: 'import { ByteWriter, ByteReader } from "./stdlib"'
  },
  {
    tag: 'dump',
    outDir: 'dump',
    outFile: 'test.dump',
    printer: dumpToString
  },
]

////////////////////////////////////////////////////////////////
// entry point

function main() {
  const fileNames = scan(resolve(__dirname, '..', '..', 'idl', 'test'))
  const lib = new GenLibrary(Language.TS, new NativeModuleType('__HEH__'))
  fileNames.forEach(fileName => {
    lib.files.push(toIDLFile(fileName)[0])
  })

  const decls = lib.files.flatMap(file => {
    return file.entries.flatMap(entry => {
      return Generator.create(lib).generate(entry)
    })
  })

  const OUT_DIR = resolve(__dirname, '..', '..', 'out')
  const STDLIB_DIR = resolve(__dirname, '..', '..', 'stdlib')

  const prepare = transformer(
    new RefNameTransformer()
  )

  const preparedDecls = prepare(decls)

  printers.forEach(({ prefix, outDir: dir, outFile, printer }) => {
    mkdirSync(join(OUT_DIR, dir), { recursive: true })
    let text = (prefix ?? '') + EOL
    preparedDecls.forEach(decl => {
      text += printer(decl)
      text += EOL
    })
    const stdlibDir = join(STDLIB_DIR, dir)
    const outDir = join(OUT_DIR, dir)

    scan(stdlibDir).forEach(file => {
      const target = normalize(join(outDir, relative(stdlibDir, file)))
      const targetDir = dirname(target)
      mkdirSync(targetDir, { recursive: true })
      copyFileSync(file, target)
    })
    writeFileSync(join(outDir, outFile), text, 'utf-8')
  })
}
main()
