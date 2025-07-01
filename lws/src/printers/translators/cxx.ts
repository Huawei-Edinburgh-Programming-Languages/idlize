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
import { E, T, utils } from "../../builder";

const varMapping = new Map([
  [std.names.vars.base, 'base'],
  [std.names.vars.null, 'nullptr'],
  [std.names.vars.undef, 'nullptr'],
  [std.names.vars.print, 'printf'],
  [std.names.vars.self, 'this'],
])

export class ConvertCXXTypes extends IdentityTransformer {
  goConstType(type: lw.ConstType): lw.ConstType {
    switch (type.name) {
      case std.names.types.int: return T.cc('int')
      case std.names.types.void: return T.cc('void')
    }
    return type
  }
}

export class CXXPrinter {
  private readonly p = new IndentPrinter()
  private readonly parent: string[] = []

  printDirectType(type: lw.LWType, name: string) {
    switch (type.kind) {
      case lw.LWKind.ConstType: {
        this.printAbstractType(type)
        this.p.put(' ', name)
        break
      }
      case lw.LWKind.AppType: {
        /* std specification */
        // todo
        this.printAbstractType(type)
        this.p.put(' ', name)
        break
      }
      case lw.LWKind.FuncType: {
        this.printAbstractType(type.returnType)
        this.p.put(' ', '(', '*', name, ')', '(')
        type.params.forEach((param, i) => {
          if (i > 0) {
            this.p.put(',', ' ')
          }
          this.printAbstractType(param.type)
        })
        break
      }
    }
  }
  printAbstractType(type: lw.LWType) {
    switch (type.kind) {
      case lw.LWKind.ConstType: {
        this.p.put(type.name)
        break
      }
      case lw.LWKind.AppType: {
        // stdlib specification
        switch (type.head) {
          case std.names.types.pointer: {
            this.printAbstractType(type.args[0])
            this.p.put('*')
            return
          }
          case std.names.types.reference: {
            this.printAbstractType(type.args[0])
            this.p.put('&')
            return
          }
          case std.names.types.constant: {
            this.p.put('const', ' ')
            this.printAbstractType(type.args[0])
            return
          }
        }

        this.p.put(type.head)
        this.p.put('<')
        type.args.forEach((arg, i) => {
          if (i > 0) {
            this.p.put(',', ' ')
          }
          this.printAbstractType(arg)
        })
        this.p.put('>')
        break
      }
      case lw.LWKind.FuncType: {
        this.printAbstractType(type.returnType)
        this.p.put(' ', '(', '*', ')', '(')
        type.params.forEach((param, i) => {
          if (i > 0) {
            this.p.put(',', ' ')
          }
          this.printAbstractType(param.type)
        })
        this.p.put(')')
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
        if (utils.hasAnnotation(expression.base, std.names.annotations.ptrVal)) {
          this.p.put('->')
        } else {
          this.p.put('.')
        }
        this.p.put(expression.accessor)
        break
      }
      case lw.LWKind.CallExpression: {
        if (
          expression.callee.kind === lw.LWKind.VariableExpression
          && expression.callee.name === std.names.vars.print
        ) {
          this.p.put('printf', '(', '"%d\\n"')
          expression.args.forEach(arg => {
            this.p.put(',', ' ')
            this.printExpression(arg)
          })
          this.p.put(')')
          return
        }
        this.printExpression(expression.callee)
        if (expression.typeArgs && expression.typeArgs.length > 0) {
          this.p.put('<')
          expression.typeArgs.forEach((type, i) => {
            if (i > 0) {
              this.p.put(',', ' ')
            }
            this.printAbstractType(type)
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
            this.printExpression(arg)
          })
          this.p.put('}')
          return
        }
        this.p.put('new', ' ', expression.name)
        if (expression.typeArgs && expression.typeArgs.length > 0) {
          this.p.put('<')
          expression.typeArgs.forEach((type, i) => {
            if (i > 0) {
              this.p.put(',', ' ')
            }
            this.printAbstractType(type)
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
        this.p.put(';')
        break
      }
      case lw.LWKind.ExpressionStatement: {
        if (statement.expression) {
          this.printExpression(statement.expression)
        }
        this.p.put(';')
        break
      }
      case lw.LWKind.DeclarationStatement: {
        this.printDirectType(statement.varType, statement.varName)
        if (statement.expression) {
          if (!(
            statement.expression.kind === lw.LWKind.ConstructorExpression
            && utils.hasAnnotation(statement.expression, std.names.annotations.asStruct)
          )) {
            this.p.put(' ', '=', ' ')
          }
          this.printExpression(statement.expression)
        }
        this.p.put(';')
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
    this.printDirectType(type, name)
    this.p.put(';')
  }
  private maybePrintGenerics(generics: lw.GenericDescriptor[]): boolean {
    if (generics.length > 0) {
      this.p.put('template', ' ', '<')
      generics.forEach((g, i) => {
        if (i > 0) {
          this.p.put(',', ' ')
        }
        this.p.put('typename', ' ', g.name)
      })
      this.p.put('>')
      this.p.newline()
      return true
    }
    return false
  }
  printDeclaration(declaration: lw.LWDeclaration) {
    switch (declaration.kind) {
      case lw.LWKind.UnionDeclaration: {
        break
      }
      case lw.LWKind.StructureDeclaration: {
        this.p.put('struct', ' ', declaration.name, ' ', '{')
        this.p.inc().newline()
        declaration.members.forEach((member, i) => {
          if (i > 0) {
            this.p.newline()
          }
          this.printField(member.name, member.type)
        })
        this.p.dec().newline()
        this.p.put('}', ';')
        break
      }
      case lw.LWKind.ClassDeclaration: {
        this.maybePrintGenerics(declaration.generics)
        this.p.put('class', ' ', declaration.name)
        this.p.put(' ')
        if (declaration.oop !== undefined) {
          const bases = [declaration.oop.base].concat(declaration.oop.implementations)
            .filter(x => x !== undefined)

          if (bases.length > 0) {
            this.p.put(':', ' ')
            bases.forEach((type, i) => {
              if (i > 0) {
                this.p.put(',', ' ')
              }
              this.printAbstractType(type)
            })
          }
        }
        this.p.put('{')
        this.p.newline()
        this.p.put('public', ':')
        this.p.inc()
        declaration.fields.forEach(field => {
          this.p.newline()
          this.printField(field.name, field.type)
        })
        this.parent.push(declaration.name)
        declaration.methods.forEach(method => {
          this.p.newline()
          this.printDeclaration(method)
        })
        this.parent.pop()
        this.p.dec().newline()
        this.p.put('}', ';')
        break
      }
      case lw.LWKind.NamespaceDeclaration: {
        this.p.put('namespace', ' ', declaration.name, ' ', '{')
        this.p.inc().newline()
        declaration.members.forEach((member, i) => {
          if (i > 0) {
            this.p.newline()
          }
          this.printDeclaration(member)
        })
        this.p.dec().newline()
        this.p.put('}', ';')
        break
      }
      case lw.LWKind.TypedefDeclaration: {
        this.p.put('typedef', ' ')
        this.printDirectType(declaration.type, declaration.name)
        this.p.put(';')
        break
      }
      case lw.LWKind.FunctionDeclaration: {
        this.maybePrintGenerics(declaration.generics)
        const isCtor = std.names.members.ctor === declaration.name
        if (isCtor) {
          this.p.put(this.parent.at(-1)!)
        } else {
          this.printAbstractType(declaration.returnType)
          this.p.put(' ', declaration.name)
        }
        this.p.put('(')
        declaration.parameters.forEach((param, i) => {
          if (i > 0) {
            this.p.put(',', ' ')
          }
          this.printDirectType(param.type, param.name)
        })
        this.p.put(')')
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

export function processNPrintCXX(chunk: lw.LWDeclaration) {
  let tree = chunk

  tree = new ConvertCXXTypes().goDeclaration(tree)

  const printer = new CXXPrinter()
  printer.printDeclaration(tree)
  return '#include <cstdio>\n' + printer.render()
}
