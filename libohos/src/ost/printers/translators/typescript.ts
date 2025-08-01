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

import { IndentPrinter } from "../indent";
import * as lw from "../../lws"
import { std } from "../../stdlib";
import { IdentityTransformer } from "../../visitors/identity";
import { T, utils } from "../../builder";

const varMapping = new Map([
  [std.names.vars.base, 'super'],
  [std.names.vars.null, 'null'],
  [std.names.vars.undef, 'undefined'],
  [std.names.vars.print, 'console.log'],
  [std.names.vars.self, 'this'],
])

export class ConvertTSTypes extends IdentityTransformer {
  goConstType(type: lw.ConstType): lw.ConstType {
    switch (type.name) {
      case std.names.types.boolean: return T.cc('boolean')
      case std.names.types.buffer: return T.cc('ArrayBuffer')
      case std.names.types.int:
      case std.names.types.number: return T.cc('number')
      case std.names.types.string: return T.cc('string')
      case std.names.types.void: return T.cc('void')
    }
    return type
  }
}

export class TypeScriptPrinter {
  private readonly p = new IndentPrinter()
  private readonly scope: ('global' | 'member')[] = ['global']

  printType(type: lw.LWType) {
    switch (type.kind) {
      case lw.LWKind.ConstType: {
        this.p.put(type.name)
        break
      }
      case lw.LWKind.FuncType: {
        this.p.put('(')
        type.params.forEach((param, i) => {
          if (i > 0) {
            this.p.put(',', ' ')
          }
          this.p.put(param.name)
          this.p.put(':')
          this.printType(param.type)
        })
        this.p.put(')', ' ', '=>', ' ')
        this.printType(type.returnType)
        break
      }
      case lw.LWKind.AppType: {
        // stdlib specification
        switch (type.head) {
          case std.names.types.pointer: { this.printType(type.args[0]); return }
          case std.names.types.reference: { this.printType(type.args[0]); return }
          case std.names.types.constant: { this.printType(type.args[0]); return }
        }

        this.p.put(type.head)
        this.p.put('<')
        type.args.forEach((arg, i) => {
          if (i > 0) {
            this.p.put(',', ' ')
          }
          this.printType(arg)
        })
        this.p.put('>')
        break
      }
    }
  }

  printExpression(expression: lw.LWExpression) {
    switch (expression.kind) {
      case lw.LWKind.ConstantExpression: {
        this.p.put(expression.value)
        break
      }
      case lw.LWKind.VariableExpression: {
        /* stdlib specification */
        if (varMapping.has(expression.name)) {
          this.p.put(varMapping.get(expression.name)!)
        } else {
          this.p.put(expression.name)
        }
        break
      }
      case lw.LWKind.StringExpression: {
        this.p.put('"', expression.value, '"')
        break
      }
      case lw.LWKind.UnaryExpression: {
        this.p.put(expression.op)
        this.printExpression(expression.expression)
        break
      }
      case lw.LWKind.BinaryExpression: {
        this.printExpression(expression.left)
        this.p.put(' ', expression.op, ' ')
        this.printExpression(expression.right)
        break
      }
      case lw.LWKind.AccessorExpression: {
        this.printExpression(expression.base)
        if (typeof expression.accessor === 'string') {
          this.p.put('.', expression.accessor)
        } else {
          this.p.put('[')
          this.printExpression(expression.accessor)
          this.p.put(']')
        }
        break
      }
      case lw.LWKind.CallExpression: {
        this.printExpression(expression.callee)
        if (expression.typeArgs) {
          this.p.put('<')
          expression.typeArgs.forEach((type, i) => {
            if (i > 0) {
              this.p.put(',', ' ')
            }
            this.printType(type)
          })
          this.p.put('>')
        }
        this.p.put('(')
        expression.args.forEach((arg, i) => {
          if (i > 0) {
            this.p.put(',', ' ')
          }
          this.printExpression(arg)
        })
        this.p.put(')')
        break
      }
      case lw.LWKind.ConstructorExpression: {
        if (utils.hasAnnotation(expression, std.names.annotations.asStruct)) {
          this.p.put('{')
          expression.args.forEach((arg, i) => {
            if (i > 0) {
              this.p.put(',', ' ')
            }
            const filedName = utils.getAnnotation(arg, std.names.annotations.named)
            if (!filedName) {
              throw new Error("!!!")
            }
            this.p.put(filedName, ':')
            this.printExpression(arg)
          })
          this.p.put('}')
          return
        }
        this.p.put('new', ' ', expression.name)
        if (expression.typeArgs) {
          this.p.put('<')
          expression.typeArgs.forEach((type, i) => {
            if (i > 0) {
              this.p.put(',', ' ')
            }
            this.printType(type)
          })
          this.p.put('>')
        }
        this.p.put('(')
        expression.args.forEach((arg, i) => {
          if (i > 0) {
            this.p.put(',', ' ')
          }
          this.printExpression(arg)
        })
        this.p.put(')')
      }
    }
  }
  printStatement(statement: lw.LWStatement) {
    switch (statement.kind) {
      case lw.LWKind.CompoundStatement: {
        this.p.put('{')
        this.p.inc().newline()
        statement.statements.forEach((stmt, i) => {
          if (i > 0) {
            this.p.newline()
          }
          this.printStatement(stmt)
        })
        this.p.dec().newline()
        this.p.put('}')
        break
      }
      case lw.LWKind.ReturnStatement: {
        this.p.put('return')
        if (statement.expression) {
          this.p.put(' ')
          this.printExpression(statement.expression)
        }
        break
      }
      case lw.LWKind.ExpressionStatement: {
        if (statement.expression) {
          this.printExpression(statement.expression)
        }
        break
      }
      case lw.LWKind.DeclarationStatement: {
        let specifier = 'const'
        if (statement.mutable) {
          specifier = 'let'
        }
        this.p.put(specifier, ' ', statement.varName, ':')
        this.printType(statement.varType)
        if (statement.expression) {
          this.p.put(' ', '=', ' ')
          this.printExpression(statement.expression)
        }
        break
      }
      case lw.LWKind.IfStatement: {
        this.p.put('if', '(')
        this.printExpression(statement.condition)
        this.p.put(')', ' ')
        this.printStatement(statement.thenBody)
        if (statement.elseBody) {
          this.p.put(' ', 'else', ' ')
          this.printStatement(statement.elseBody)
        }
        break
      }
      case lw.LWKind.LoopStatement: {
        this.p.put('while', '(')
        this.printExpression(statement.condition)
        this.p.put(')', ' ')
        this.printStatement(statement.body)
        break
      }
    }
  }

  private printField(name: string, type: lw.LWType) {
    this.p.put(name)
    this.p.put(':')
    this.printType(type)
  }
  private printGeneric(generic: lw.GenericDescriptor) {
    this.p.put(generic.name)
  }
  private maybePrintGenerics(generics: lw.GenericDescriptor[]) {
    if (generics.length > 0) {
      this.p.put('<')
      generics.forEach((gen, i) => {
        if (i > 0) {
          this.p.put(',', ' ')
        }
        this.printGeneric(gen)
      })
      this.p.put('>')
    }
  }
  printDeclaration(declaration: lw.LWDeclaration) {
    switch (declaration.kind) {
      case lw.LWKind.UnionDeclaration: {
        break
      }
      case lw.LWKind.StructureDeclaration: {
        this.p.put('export', ' ', 'interface', ' ', declaration.name, ' ', '{')
        this.p.inc().newline()
        declaration.members.forEach((member, i) => {
          if (i > 0) {
            this.p.newline()
          }
          this.printField(member.name, member.type)
        })
        this.p.dec().newline()
        this.p.put('}')
        break
      }
      case lw.LWKind.ClassDeclaration: {
        const specifier = declaration.oop?.sort === 'interface'
          ? 'interface'
          : 'class'
        this.p.put('export', ' ', specifier, ' ', declaration.name)
        this.maybePrintGenerics(declaration.generics)
        this.p.put(' ')
        if (declaration.oop !== undefined) {
          if (declaration.oop.base) {
            this.p.put('extends', ' ')
            this.printType(declaration.oop.base)
          }
          if (declaration.oop.implementations && declaration.oop.implementations.length > 0) {
            this.p.put('implements', ' ')
            declaration.oop.implementations.forEach((iface, i) => {
              if (i > 0) {
                this.p.put(',', ' ')
              }
              this.printType(iface)
            })
          }
        }
        this.scope.push('member')
        this.p.put('{')
        this.p.inc()
        declaration.fields.forEach((field, i) => {
          this.p.newline()
          this.printField(field.name, field.type)
        })
        declaration.methods.forEach((method, i) => {
          this.p.newline()
          this.printDeclaration(method)
        })
        this.p.dec().newline()
        this.p.put('}')
        this.scope.pop()
        break
      }
      case lw.LWKind.NamespaceDeclaration: {
        this.p.put('export', ' ', 'namespace', ' ', declaration.name, ' ', '{')
        this.p.inc().newline()
        declaration.members.forEach((member, i) => {
          if (i > 0) {
            this.p.newline()
          }
          this.printDeclaration(member)
        })
        this.p.dec().newline()
        this.p.put('}')
        break
      }
      case lw.LWKind.TypedefDeclaration: {
        this.p.put('export', ' ', 'type', ' ', declaration.name)
        this.p.put(' ', '=', ' ')
        this.printType(declaration.type)
        break
      }
      case lw.LWKind.FunctionDeclaration: {
        declaration.modifiers.forEach(mod => {
          switch (mod.name) {
            case 'static': { this.p.put('static'); break }
          }
          this.p.put(' ')
        })
        if (this.scope.at(-1) !== 'member') {
          this.p.put('export', ' ', 'function', ' ')
        }
        const isCtor = std.names.members.ctor === declaration.name
        if (isCtor) {
          this.p.put('constructor')
        } else {
          this.p.put(declaration.name)
        }
        this.maybePrintGenerics(declaration.generics)
        this.p.put('(')
        declaration.parameters.forEach((param, i) => {
          if (i > 0) {
            this.p.put(',', ' ')
          }
          this.p.put(param.name)
          this.p.put(':')
          this.printType(param.type)
        })
        this.p.put(')')
        if (!isCtor) {
          this.p.put(':')
          this.printType(declaration.returnType)
        }
        this.p.put(' ')
        this.printStatement(declaration.body)
        break
      }
    }
  }

  printProgramChunk() {
    /// does nothing for now
  }

  render(): string {
    return this.p.render()
  }
}

export function processNPrintTS(chunk:lw.LWDeclaration) {
  let tree = chunk

  tree = new ConvertTSTypes().goDeclaration(tree)

  const printer = new TypeScriptPrinter()
  printer.printDeclaration(tree)
  return printer.render()
}
