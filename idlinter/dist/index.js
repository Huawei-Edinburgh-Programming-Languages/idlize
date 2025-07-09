#!/usr/bin/env node

/**
* @license
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


'use strict';

var commander = require('commander');
var fs = require('fs');
var path = require('path');
var ts = require('typescript');
var console$1 = require('console');
require('node:os');

function _interopNamespaceDefault(e) {
  var n = Object.create(null);
  if (e) {
    Object.keys(e).forEach(function (k) {
      if (k !== 'default') {
        var d = Object.getOwnPropertyDescriptor(e, k);
        Object.defineProperty(n, k, d.get ? d : {
          enumerable: true,
          get: function () { return e[k]; }
        });
      }
    });
  }
  n.default = e;
  return Object.freeze(n);
}

var fs__namespace = /*#__PURE__*/_interopNamespaceDefault(fs);
var path__namespace = /*#__PURE__*/_interopNamespaceDefault(path);
var ts__namespace = /*#__PURE__*/_interopNamespaceDefault(ts);

/**
 * @param {string} text
 */
function lastLine(text) {
  const splitted = text.split("\n");
  return splitted[splitted.length - 1];
}

function appendIfExist(base, target) {
  let result = base;
  if (target) {
    result += ` ${target}`;
  }
  return result;
}

function contextAsText(node) {
  const hierarchy = [node];
  while (node && node.parent) {
    const { parent } = node;
    hierarchy.unshift(parent);
    node = parent;
  }
  return hierarchy.map((n) => appendIfExist(n.type, n.name)).join(" -> ");
}

/**
 * @typedef {object} WebIDL2ErrorOptions
 * @property {"error" | "warning"} [level]
 * @property {Function} [autofix]
 * @property {string} [ruleName]
 *
 * @typedef {ReturnType<typeof error>} WebIDLErrorData
 *
 * @param {string} message error message
 * @param {*} position
 * @param {*} current
 * @param {*} message
 * @param {"Syntax" | "Validation"} kind error type
 * @param {WebIDL2ErrorOptions=} options
 */
function error(
  source,
  position,
  current,
  message,
  kind,
  { level = "error", autofix, ruleName } = {},
) {
  /**
   * @param {number} count
   */
  function sliceTokens(count) {
    return count > 0
      ? source.slice(position, position + count)
      : source.slice(Math.max(position + count, 0), position);
  }

  /**
   * @param {import("./tokeniser.js").Token[]} inputs
   * @param {object} [options]
   * @param {boolean} [options.precedes]
   * @returns
   */
  function tokensToText(inputs, { precedes } = {}) {
    const text = inputs.map((t) => t.trivia + t.value).join("");
    const nextToken = source[position];
    if (nextToken.type === "eof") {
      return text;
    }
    if (precedes) {
      return text + nextToken.trivia;
    }
    return text.slice(nextToken.trivia.length);
  }

  const maxTokens = 5; // arbitrary but works well enough
  const line =
    source[position].type !== "eof"
      ? source[position].line
      : source.length > 1
        ? source[position - 1].line
        : 1;

  const precedingLastLine = lastLine(
    tokensToText(sliceTokens(-maxTokens), { precedes: true }),
  );

  const subsequentTokens = sliceTokens(maxTokens);
  const subsequentText = tokensToText(subsequentTokens);
  const subsequentFirstLine = subsequentText.split("\n")[0];

  const spaced = " ".repeat(precedingLastLine.length) + "^";
  const sourceContext = precedingLastLine + subsequentFirstLine + "\n" + spaced;

  const contextType = kind === "Syntax" ? "since" : "inside";
  const inSourceName = source.name ? ` in ${source.name}` : "";
  const grammaticalContext =
    current && current.name
      ? `, ${contextType} \`${current.partial ? "partial " : ""}${contextAsText(
          current,
        )}\``
      : "";
  const context = `${kind} error at line ${line}${inSourceName}${grammaticalContext}:\n${sourceContext}`;
  return {
    message: `${context} ${message}`,
    bareMessage: message,
    context,
    line,
    sourceName: source.name,
    level,
    ruleName,
    autofix,
    input: subsequentText,
    tokens: subsequentTokens,
  };
}

/**
 * @param {string} message error message
 */
function syntaxError(source, position, current, message) {
  return error(source, position, current, message, "Syntax");
}

/**
 * @param {string} message error message
 * @param {WebIDL2ErrorOptions} [options]
 */
function validationError(
  token,
  current,
  ruleName,
  message,
  options = {},
) {
  options.ruleName = ruleName;
  return error(
    current.source,
    token.index,
    current,
    message,
    "Validation",
    options,
  );
}

class Base {
  /**
   * @param {object} initializer
   * @param {Base["source"]} initializer.source
   * @param {Base["tokens"]} initializer.tokens
   */
  constructor({ source, tokens }) {
    Object.defineProperties(this, {
      source: { value: source },
      tokens: { value: tokens, writable: true },
      parent: { value: null, writable: true },
      this: { value: this }, // useful when escaping from proxy
    });
  }

  toJSON() {
    const json = { type: undefined, name: undefined, inheritance: undefined };
    let proto = this;
    while (proto !== Object.prototype) {
      const descMap = Object.getOwnPropertyDescriptors(proto);
      for (const [key, value] of Object.entries(descMap)) {
        if (value.enumerable || value.get) {
          // @ts-ignore - allow indexing here
          json[key] = this[key];
        }
      }
      proto = Object.getPrototypeOf(proto);
    }
    return json;
  }
}

/**
 * @typedef {import("../validator.js").Definitions} Definitions
 * @typedef {import("../productions/dictionary.js").Dictionary} Dictionary
 * @typedef {import("../../lib/productions/type").Type} Type
 *
 * @param {Type} idlType
 * @param {Definitions} defs
 * @param {object} [options]
 * @param {boolean} [options.useNullableInner] use when the input idlType is nullable and you want to use its inner type
 * @return {{ reference: *, dictionary: Dictionary }} the type reference that ultimately includes dictionary.
 */
function idlTypeIncludesDictionary(
  idlType,
  defs,
  { useNullableInner } = {},
) {
  if (!idlType.union) {
    const def = defs.unique.get(idlType.idlType);
    if (!def) {
      return;
    }
    if (def.type === "typedef") {
      const { typedefIncludesDictionary } = defs.cache;
      if (typedefIncludesDictionary.has(def)) {
        // Note that this also halts when it met indeterminate state
        // to prevent infinite recursion
        return typedefIncludesDictionary.get(def);
      }
      defs.cache.typedefIncludesDictionary.set(def, undefined); // indeterminate state
      const result = idlTypeIncludesDictionary(def.idlType, defs);
      defs.cache.typedefIncludesDictionary.set(def, result);
      if (result) {
        return {
          reference: idlType,
          dictionary: result.dictionary,
        };
      }
    }
    if (def.type === "dictionary" && (useNullableInner || !idlType.nullable)) {
      return {
        reference: idlType,
        dictionary: def,
      };
    }
  }
  for (const subtype of idlType.subtype) {
    const result = idlTypeIncludesDictionary(subtype, defs);
    if (result) {
      if (subtype.union) {
        return result;
      }
      return {
        reference: subtype,
        dictionary: result.dictionary,
      };
    }
  }
}

/**
 * @param {Dictionary} dict dictionary type
 * @param {Definitions} defs
 * @return {boolean}
 */
function dictionaryIncludesRequiredField(dict, defs) {
  if (defs.cache.dictionaryIncludesRequiredField.has(dict)) {
    return defs.cache.dictionaryIncludesRequiredField.get(dict);
  }
  // Set cached result to indeterminate to short-circuit circular definitions.
  // The final result will be updated to true or false.
  defs.cache.dictionaryIncludesRequiredField.set(dict, undefined);
  let result = dict.members.some((field) => field.required);
  if (!result && dict.inheritance) {
    const superdict = defs.unique.get(dict.inheritance);
    if (!superdict) {
      // Assume required members in the supertype if it is unknown.
      result = true;
    } else if (dictionaryIncludesRequiredField(superdict, defs)) {
      result = true;
    }
  }
  defs.cache.dictionaryIncludesRequiredField.set(dict, result);
  return result;
}

/**
 * For now this only checks the most frequent cases:
 * 1. direct inclusion of [EnforceRange]
 * 2. typedef of that
 *
 * More complex cases with dictionaries and records are not covered yet.
 *
 * @param {Type} idlType
 * @param {Definitions} defs
 */
function idlTypeIncludesEnforceRange(idlType, defs) {
  if (idlType.union) {
    // TODO: This should ideally be checked too
    return false;
  }

  if (idlType.extAttrs.some((e) => e.name === "EnforceRange")) {
    return true;
  }

  const def = defs.unique.get(idlType.idlType);
  if (def?.type !== "typedef") {
    return false;
  }

  return def.idlType.extAttrs.some((e) => e.name === "EnforceRange");
}

class ArrayBase extends Array {
  constructor({ source, tokens }) {
    super();
    Object.defineProperties(this, {
      source: { value: source },
      tokens: { value: tokens },
      parent: { value: null, writable: true },
    });
  }
}

class WrappedToken extends Base {
  /**
   * @param {import("../tokeniser.js").Tokeniser} tokeniser
   * @param {string} type
   */
  static parser(tokeniser, type) {
    return () => {
      const value = tokeniser.consumeKind(type);
      if (value) {
        return new WrappedToken({
          source: tokeniser.source,
          tokens: { value },
        });
      }
    };
  }

  get value() {
    return unescape(this.tokens.value.value);
  }

  /** @param {import("../writer.js").Writer} w */
  write(w) {
    return w.ts.wrap([
      w.token(this.tokens.value),
      w.token(this.tokens.separator),
    ]);
  }
}

class Eof extends WrappedToken {
  /**
   * @param {import("../tokeniser.js").Tokeniser} tokeniser
   */
  static parse(tokeniser) {
    const value = tokeniser.consumeKind("eof");
    if (value) {
      return new Eof({ source: tokeniser.source, tokens: { value } });
    }
  }

  get type() {
    return "eof";
  }
}

/**
 * @param {import("../tokeniser.js").Tokeniser} tokeniser
 * @param {string} tokenName
 */
function tokens(tokeniser, tokenName) {
  return list(tokeniser, {
    parser: WrappedToken.parser(tokeniser, tokenName),
    listName: tokenName + " list",
  });
}

const extAttrValueSyntax = ["identifier", "decimal", "integer", "string"];

const shouldBeLegacyPrefixed = [
  "NoInterfaceObject",
  "LenientSetter",
  "LenientThis",
  "TreatNonObjectAsNull",
  "Unforgeable",
];

const renamedLegacies = new Map([
  .../** @type {[string, string][]} */ (
    shouldBeLegacyPrefixed.map((name) => [name, `Legacy${name}`])
  ),
  ["NamedConstructor", "LegacyFactoryFunction"],
  ["OverrideBuiltins", "LegacyOverrideBuiltIns"],
  ["TreatNullAs", "LegacyNullToEmptyString"],
]);

/**
 * This will allow a set of extended attribute values to be parsed.
 * @param {import("../tokeniser.js").Tokeniser} tokeniser
 */
function extAttrListItems(tokeniser) {
  for (const syntax of extAttrValueSyntax) {
    const toks = tokens(tokeniser, syntax);
    if (toks.length) {
      return toks;
    }
  }
  tokeniser.error(
    `Expected identifiers, strings, decimals, or integers but none found`,
  );
}

class ExtendedAttributeParameters extends Base {
  /**
   * @param {import("../tokeniser.js").Tokeniser} tokeniser
   */
  static parse(tokeniser) {
    const tokens = { assign: tokeniser.consume("=") };
    const ret = autoParenter(
      new ExtendedAttributeParameters({ source: tokeniser.source, tokens }),
    );
    ret.list = [];
    if (tokens.assign) {
      tokens.asterisk = tokeniser.consume("*");
      if (tokens.asterisk) {
        return ret.this;
      }
      tokens.secondaryName = tokeniser.consumeKind(...extAttrValueSyntax);
    }
    tokens.open = tokeniser.consume("(");
    if (tokens.open) {
      ret.list = ret.rhsIsList
        ? // [Exposed=(Window,Worker)]
          extAttrListItems(tokeniser)
        : // [LegacyFactoryFunction=Audio(DOMString src)] or [Constructor(DOMString str)]
          argument_list(tokeniser);
      tokens.close =
        tokeniser.consume(")") ||
        tokeniser.error("Unexpected token in extended attribute argument list");
    } else if (tokens.assign && !tokens.secondaryName) {
      tokeniser.error("No right hand side to extended attribute assignment");
    }
    return ret.this;
  }

  get rhsIsList() {
    return (
      this.tokens.assign && !this.tokens.asterisk && !this.tokens.secondaryName
    );
  }

  get rhsType() {
    if (this.rhsIsList) {
      return this.list[0].tokens.value.type + "-list";
    }
    if (this.tokens.asterisk) {
      return "*";
    }
    if (this.tokens.secondaryName) {
      return this.tokens.secondaryName.type;
    }
    return null;
  }

  /** @param {import("../writer.js").Writer} w */
  write(w) {
    const { rhsType } = this;
    return w.ts.wrap([
      w.token(this.tokens.assign),
      w.token(this.tokens.asterisk),
      w.reference_token(this.tokens.secondaryName, this.parent),
      w.token(this.tokens.open),
      ...this.list.map((p) => {
        return rhsType === "identifier-list"
          ? w.identifier(p, this.parent)
          : p.write(w);
      }),
      w.token(this.tokens.close),
    ]);
  }
}

class SimpleExtendedAttribute extends Base {
  /**
   * @param {import("../tokeniser.js").Tokeniser} tokeniser
   */
  static parse(tokeniser) {
    const name = tokeniser.consumeKind("identifier");
    if (name) {
      return new SimpleExtendedAttribute({
        source: tokeniser.source,
        tokens: { name },
        params: ExtendedAttributeParameters.parse(tokeniser),
      });
    }
  }

  constructor({ source, tokens, params }) {
    super({ source, tokens });
    params.parent = this;
    Object.defineProperty(this, "params", { value: params });
  }

  get type() {
    return "extended-attribute";
  }
  get name() {
    return this.tokens.name.value;
  }
  get rhs() {
    const { rhsType: type, tokens, list } = this.params;
    if (!type) {
      return null;
    }
    const value = this.params.rhsIsList
      ? list
      : this.params.tokens.secondaryName
        ? unescape(tokens.secondaryName.value)
        : null;
    return { type, value };
  }
  get arguments() {
    const { rhsIsList, list } = this.params;
    if (!list || rhsIsList) {
      return [];
    }
    return list;
  }

  *validate(defs) {
    const { name } = this;
    if (name === "LegacyNoInterfaceObject") {
      const message = `\`[LegacyNoInterfaceObject]\` extended attribute is an \
undesirable feature that may be removed from Web IDL in the future. Refer to the \
[relevant upstream PR](https://github.com/whatwg/webidl/pull/609) for more \
information.`;
      yield validationError(
        this.tokens.name,
        this,
        "no-nointerfaceobject",
        message,
        { level: "warning" },
      );
    } else if (renamedLegacies.has(name)) {
      const message = `\`[${name}]\` extended attribute is a legacy feature \
that is now renamed to \`[${renamedLegacies.get(name)}]\`. Refer to the \
[relevant upstream PR](https://github.com/whatwg/webidl/pull/870) for more \
information.`;
      yield validationError(this.tokens.name, this, "renamed-legacy", message, {
        level: "warning",
        autofix: renameLegacyExtendedAttribute(this),
      });
    }
    for (const arg of this.arguments) {
      yield* arg.validate(defs);
    }
  }

  /** @param {import("../writer.js").Writer} w */
  write(w) {
    return w.ts.wrap([
      w.ts.trivia(this.tokens.name.trivia),
      w.ts.extendedAttribute(
        w.ts.wrap([
          w.ts.extendedAttributeReference(this.name),
          this.params.write(w),
        ]),
      ),
      w.token(this.tokens.separator),
    ]);
  }
}

/**
 * @param {SimpleExtendedAttribute} extAttr
 */
function renameLegacyExtendedAttribute(extAttr) {
  return () => {
    const { name } = extAttr;
    extAttr.tokens.name.value = renamedLegacies.get(name);
    if (name === "TreatNullAs") {
      extAttr.params.tokens = {};
    }
  };
}

// Note: we parse something simpler than the official syntax. It's all that ever
// seems to be used
class ExtendedAttributes extends ArrayBase {
  /**
   * @param {import("../tokeniser.js").Tokeniser} tokeniser
   */
  static parse(tokeniser) {
    const tokens = {};
    tokens.open = tokeniser.consume("[");
    const ret = new ExtendedAttributes({ source: tokeniser.source, tokens });
    if (!tokens.open) return ret;
    ret.push(
      ...list(tokeniser, {
        parser: SimpleExtendedAttribute.parse,
        listName: "extended attribute",
      }),
    );
    tokens.close =
      tokeniser.consume("]") ||
      tokeniser.error(
        "Expected a closing token for the extended attribute list",
      );
    if (!ret.length) {
      tokeniser.unconsume(tokens.close.index);
      tokeniser.error("An extended attribute list must not be empty");
    }
    if (tokeniser.probe("[")) {
      tokeniser.error(
        "Illegal double extended attribute lists, consider merging them",
      );
    }
    return ret;
  }

  *validate(defs) {
    for (const extAttr of this) {
      yield* extAttr.validate(defs);
    }
  }

  /** @param {import("../writer.js").Writer} w */
  write(w) {
    if (!this.length) return "";
    return w.ts.wrap([
      w.token(this.tokens.open),
      ...this.map((ea) => ea.write(w)),
      w.token(this.tokens.close),
    ]);
  }
}

const genericsHolder = new Set([
  "FrozenArray",
  "ObservableArray",
  "Promise",
  "sequence",
  "record",
]);

class ParserState extends Base {
  static get generics() {
    return genericsHolder;
  }

  /**
   * @param {import("../tokeniser.js").Tokeniser} tokeniser
   */
  static update(tokeniser) {
    const startPosition = tokeniser.position;
    do {
      /** @type {Base["tokens"]} */
      const tokens = {};
      tokens.open1 = tokeniser.consume("[");
      if (!tokens.open1) break;

      tokens.open2 = tokeniser.consume("[");
      if (!tokens.open2) break;

      tokens.mode =
        tokeniser.consumeKind("identifier") ||
        tokeniser.error("Parser state mode-identifier expected");

      if (tokens.mode.value === "generics") {
        ParserState.updateGenerics(tokeniser, tokens);
      } else
        tokeniser.error(
          `Parser state mode not supported: ${tokens.mode.value}`,
        );

      tokens.close1 =
        tokeniser.consume("]") ||
        tokeniser.error("Parser state terminator expected");

      tokens.close2 =
        tokeniser.consume("]") ||
        tokeniser.error("Parser state terminator expected");

      return new ParserState({
        source: tokeniser.source,
        tokens,
      });
    } while (false);

    tokeniser.unconsume(startPosition);
  }

  /**
   * @param {import("../tokeniser.js").Tokeniser} tokeniser
   * @param {Base["tokens"]} tokens
   */
  static updateGenerics(tokeniser, tokens) {
    tokens.operation1 =
      tokeniser.consumeKind("other") ||
      tokeniser.error("Parser state generic operation required");
    let operation = tokens.operation1.value;
    tokens.operation2 =
      tokeniser.consume("=") ||
      tokeniser.error("Parser state generic operation required");
    operation += tokens.operation2.value;

    for (let i = 0; ; ++i) {
      if (tokeniser.probe("]")) break;

      const subtype =
        tokeniser.consumeKind("identifier") ||
        tokeniser.error(
          `Parser state generic ${operation} requires an identifier`,
        );

      switch (operation) {
        case "+=":
          ParserState.generics.add(subtype.value);
          break;
        case "-=":
          ParserState.generics.delete(subtype.value);
          break;
        default:
          tokeniser.error(
            `Unknown parser state generic operation: ${operation}`,
          );
      }
      const delimeter = tokeniser.consume(",");

      tokens[`subtype_${i}`] = subtype;
      tokens[`delimeter_${i}`] = delimeter;

      if (!delimeter) break;
    }
  }

  /** @param {import("../writer.js").Writer} w */
  write(w) {
    return w.ts.wrap([
      ...Object.values(this.tokens).map((token) => w.token(token)),
    ]);
  }
}

/**
 * @param {import("../tokeniser.js").Tokeniser} tokeniser
 * @param {string} typeName
 */
function generic_type(tokeniser, typeName) {
  let base = tokeniser.consume(...ParserState.generics.values());
  if (!base) {
    const tokenizerPosition = tokeniser.position;
    base = tokeniser.consumeKind("identifier");
    if (base && !ParserState.generics.has(base.value)) {
      tokeniser.unconsume(tokenizerPosition);
      base = undefined;
    }
  }
  if (!base) {
    return;
  }
  const ret = autoParenter(
    new Type({ source: tokeniser.source, tokens: { base } }),
  );
  ret.tokens.open =
    tokeniser.consume("<") ||
    tokeniser.error(`No opening bracket after ${base.value}`);
  switch (base.value) {
    case "Promise": {
      const subtype =
        type_with_extended_attributes(tokeniser, typeName) ||
        return_type(tokeniser, typeName) ||
        tokeniser.error("Missing Promise subtype");
      ret.subtype.push(subtype);
      break;
    }
    case "sequence":
    case "FrozenArray":
    case "ObservableArray": {
      const subtype =
        type_with_extended_attributes(tokeniser, typeName) ||
        tokeniser.error(`Missing ${base.value} subtype`);
      ret.subtype.push(subtype);
      break;
    }
    case "record": {
      const keyType =
        type_with_extended_attributes(tokeniser, typeName) ||
        tokeniser.error("Error parsing generic type record");
      keyType.tokens.separator =
        tokeniser.consume(",") ||
        tokeniser.error("Missing comma after record key type");
      const valueType =
        type_with_extended_attributes(tokeniser, typeName) ||
        tokeniser.error("Error parsing generic type record");
      ret.subtype.push(keyType, valueType);
      break;
    }
    default: {
      ret.subtype = list(tokeniser, {
        parser: () => {
          if (tokeniser.probe(",")) return;
          return (
            type_with_extended_attributes(tokeniser, typeName) ||
            tokeniser.error(`Missing ${base.value} subtype`)
          );
        },
      });
      break;
    }
  }
  if (!ret.idlType) tokeniser.error(`Error parsing generic type ${base.value}`);
  ret.tokens.close =
    tokeniser.consume(">") ||
    tokeniser.error(`Missing closing bracket after ${base.value}`);
  return ret.this;
}

/**
 * @param {import("../tokeniser.js").Tokeniser} tokeniser
 */
function type_suffix(tokeniser, obj) {
  const nullable = tokeniser.consume("?");
  if (nullable) {
    obj.tokens.nullable = nullable;
  }
  if (tokeniser.probe("?")) tokeniser.error("Can't nullable more than once");
}

/**
 * @param {import("../tokeniser.js").Tokeniser} tokeniser
 * @param {string} typeName
 */
function single_type(tokeniser, typeName) {
  let ret = generic_type(tokeniser, typeName) || primitive_type(tokeniser);
  if (!ret) {
    const base =
      tokeniser.consumeKind("identifier") ||
      tokeniser.consume(...typeNameKeywords);
    if (!base) {
      return;
    }
    ret = new Type({ source: tokeniser.source, tokens: { base } });
    if (tokeniser.probe("<"))
      tokeniser.error(`Unsupported generic type ${base.value}`);
  }
  if (ret.generic === "Promise" && tokeniser.probe("?")) {
    tokeniser.error("Promise type cannot be nullable");
  }
  ret.type = typeName || null;
  type_suffix(tokeniser, ret);
  if (ret.nullable && ret.idlType === "any")
    tokeniser.error("Type `any` cannot be made nullable");
  return ret;
}

/**
 * @param {import("../tokeniser.js").Tokeniser} tokeniser
 * @param {string} type
 */
function union_type(tokeniser, type) {
  const tokens = {};
  tokens.open = tokeniser.consume("(");
  if (!tokens.open) return;
  const ret = autoParenter(new Type({ source: tokeniser.source, tokens }));
  ret.type = type || null;
  while (true) {
    const typ =
      type_with_extended_attributes(tokeniser, type) ||
      tokeniser.error("No type after open parenthesis or 'or' in union type");
    if (typ.idlType === "any")
      tokeniser.error("Type `any` cannot be included in a union type");
    if (typ.generic === "Promise")
      tokeniser.error("Type `Promise` cannot be included in a union type");
    ret.subtype.push(typ);
    const or = tokeniser.consume("or");
    if (or) {
      typ.tokens.separator = or;
    } else break;
  }
  if (ret.idlType.length < 2) {
    tokeniser.error(
      "At least two types are expected in a union type but found less",
    );
  }
  tokens.close =
    tokeniser.consume(")") || tokeniser.error("Unterminated union type");
  type_suffix(tokeniser, ret);
  return ret.this;
}

class Type extends Base {
  /**
   * @param {import("../tokeniser.js").Tokeniser} tokeniser
   * @param {string} typeName
   */
  static parse(tokeniser, typeName) {
    return single_type(tokeniser, typeName) || union_type(tokeniser, typeName);
  }

  constructor({ source, tokens }) {
    super({ source, tokens });
    Object.defineProperty(this, "subtype", { value: [], writable: true });
    this.extAttrs = new ExtendedAttributes({ source, tokens: {} });
  }

  get generic() {
    if (this.subtype.length && this.tokens.base) {
      return this.tokens.base.value;
    }
    return "";
  }
  get nullable() {
    return Boolean(this.tokens.nullable);
  }
  get union() {
    return Boolean(this.subtype.length) && !this.tokens.base;
  }
  get idlType() {
    if (this.subtype.length) {
      return this.subtype;
    }
    // Adding prefixes/postfixes for "unrestricted float", etc.
    const name = [this.tokens.prefix, this.tokens.base, this.tokens.postfix]
      .filter((t) => t)
      .map((t) => t.value)
      .join(" ");
    return unescape(name);
  }

  *validate(defs) {
    yield* this.extAttrs.validate(defs);

    if (this.idlType === "BufferSource") {
      // XXX: For now this is a hack. Consider moving parents' extAttrs into types as the spec says:
      // https://webidl.spec.whatwg.org/#idl-annotated-types
      for (const extAttrs of [this.extAttrs, this.parent?.extAttrs]) {
        for (const extAttr of extAttrs) {
          if (extAttr.name !== "AllowShared") {
            continue;
          }
          const message = `\`[AllowShared] BufferSource\` is now replaced with AllowSharedBufferSource.`;
          yield validationError(
            this.tokens.base,
            this,
            "migrate-allowshared",
            message,
            { autofix: replaceAllowShared(this, extAttr, extAttrs) },
          );
        }
      }
    }

    if (this.idlType === "void") {
      const message = `\`void\` is now replaced by \`undefined\`. Refer to the \
[relevant GitHub issue](https://github.com/whatwg/webidl/issues/60) \
for more information.`;
      yield validationError(this.tokens.base, this, "replace-void", message, {
        autofix: replaceVoid(this),
      });
    }

    /*
     * If a union is nullable, its subunions cannot include a dictionary
     * If not, subunions may include dictionaries if each union is not nullable
     */
    const typedef = !this.union && defs.unique.get(this.idlType);
    const target = this.union
      ? this
      : typedef && typedef.type === "typedef"
        ? typedef.idlType
        : undefined;
    if (target && this.nullable) {
      // do not allow any dictionary
      const { reference } = idlTypeIncludesDictionary(target, defs) || {};
      if (reference) {
        const targetToken = (this.union ? reference : this).tokens.base;
        const message = "Nullable union cannot include a dictionary type.";
        yield validationError(
          targetToken,
          this,
          "no-nullable-union-dict",
          message,
        );
      }
    } else {
      // allow some dictionary
      for (const subtype of this.subtype) {
        yield* subtype.validate(defs);
      }
    }
  }

  /** @param {import("../writer.js").Writer} w */
  write(w) {
    const type_body = () => {
      if (this.union || this.generic) {
        return w.ts.wrap([
          w.token(this.tokens.base, w.ts.generic),
          w.token(this.tokens.open),
          ...this.subtype.map((t) => t.write(w)),
          w.token(this.tokens.close),
        ]);
      }
      const firstToken = this.tokens.prefix || this.tokens.base;
      const prefix = this.tokens.prefix
        ? [this.tokens.prefix.value, w.ts.trivia(this.tokens.base.trivia)]
        : [];
      const ref = w.reference(
        w.ts.wrap([
          ...prefix,
          this.tokens.base.value,
          w.token(this.tokens.postfix),
        ]),
        {
          unescaped: /** @type {string} (because it's not union) */ (
            this.idlType
          ),
          context: this,
        },
      );
      return w.ts.wrap([w.ts.trivia(firstToken.trivia), ref]);
    };
    return w.ts.wrap([
      w.token(this.tokens.openRT),
      this.extAttrs.write(w),
      type_body(),
      w.token(this.tokens.nullable),
      w.token(this.tokens.closeRT),
      w.token(this.tokens.separator),
    ]);
  }
}

/**
 * @param {Type} type
 * @param {import("./extended-attributes.js").SimpleExtendedAttribute} extAttr
 * @param {ExtendedAttributes} extAttrs
 */
function replaceAllowShared(type, extAttr, extAttrs) {
  return () => {
    const index = extAttrs.indexOf(extAttr);
    extAttrs.splice(index, 1);
    if (!extAttrs.length && type.tokens.base.trivia.match(/^\s$/)) {
      type.tokens.base.trivia = ""; // (let's not remove comments)
    }

    type.tokens.base.value = "AllowSharedBufferSource";
  };
}

/**
 * @param {Type} type
 */
function replaceVoid(type) {
  return () => {
    type.tokens.base.value = "undefined";
  };
}

class Default extends Base {
  /**
   * @param {import("../tokeniser.js").Tokeniser} tokeniser
   */
  static parse(tokeniser) {
    const assign = tokeniser.consume("=");
    if (!assign) {
      return null;
    }
    const def =
      const_value(tokeniser) ||
      tokeniser.consumeKind("string") ||
      tokeniser.consume("null", "[", "{") ||
      tokeniser.error("No value for default");
    const expression = [def];
    if (def.value === "[") {
      const close =
        tokeniser.consume("]") ||
        tokeniser.error("Default sequence value must be empty");
      expression.push(close);
    } else if (def.value === "{") {
      const close =
        tokeniser.consume("}") ||
        tokeniser.error("Default dictionary value must be empty");
      expression.push(close);
    }
    return new Default({
      source: tokeniser.source,
      tokens: { assign },
      expression,
    });
  }

  constructor({ source, tokens, expression }) {
    super({ source, tokens });
    expression.parent = this;
    Object.defineProperty(this, "expression", { value: expression });
  }

  get type() {
    return const_data(this.expression[0]).type;
  }
  get value() {
    return const_data(this.expression[0]).value;
  }
  get negative() {
    return const_data(this.expression[0]).negative;
  }

  /** @param {import("../writer.js").Writer} w */
  write(w) {
    return w.ts.wrap([
      w.token(this.tokens.assign),
      ...this.expression.map((t) => w.token(t)),
    ]);
  }
}

class Argument extends Base {
  /**
   * @param {import("../tokeniser.js").Tokeniser} tokeniser
   */
  static parse(tokeniser) {
    const start_position = tokeniser.position;
    /** @type {Base["tokens"]} */
    const tokens = {};
    const ret = autoParenter(
      new Argument({ source: tokeniser.source, tokens }),
    );
    ret.extAttrs = ExtendedAttributes.parse(tokeniser);
    tokens.optional = tokeniser.consume("optional");
    ret.idlType = type_with_extended_attributes(tokeniser, "argument-type");
    if (!ret.idlType) {
      return tokeniser.unconsume(start_position);
    }
    if (!tokens.optional) {
      tokens.variadic = tokeniser.consume("...");
    }
    tokens.name =
      tokeniser.consumeKind("identifier") ||
      tokeniser.consume(...argumentNameKeywords);
    if (!tokens.name) {
      return tokeniser.unconsume(start_position);
    }
    ret.default = tokens.optional ? Default.parse(tokeniser) : null;
    return ret.this;
  }

  get type() {
    return "argument";
  }
  get optional() {
    return !!this.tokens.optional;
  }
  get variadic() {
    return !!this.tokens.variadic;
  }
  get name() {
    return unescape(this.tokens.name.value);
  }

  /**
   * @param {import("../validator.js").Definitions} defs
   */
  *validate(defs) {
    yield* this.extAttrs.validate(defs);
    yield* this.idlType.validate(defs);
    const result = idlTypeIncludesDictionary(this.idlType, defs, {
      useNullableInner: true,
    });
    if (result) {
      if (this.idlType.nullable) {
        const message = `Dictionary arguments cannot be nullable.`;
        yield validationError(
          this.tokens.name,
          this,
          "no-nullable-dict-arg",
          message,
        );
      } else if (!this.optional) {
        if (
          this.parent &&
          !dictionaryIncludesRequiredField(result.dictionary, defs) &&
          isLastRequiredArgument(this)
        ) {
          const message = `Dictionary argument must be optional if it has no required fields`;
          yield validationError(
            this.tokens.name,
            this,
            "dict-arg-optional",
            message,
            {
              autofix: autofixDictionaryArgumentOptionality(this),
            },
          );
        }
      } else if (!this.default) {
        const message = `Optional dictionary arguments must have a default value of \`{}\`.`;
        yield validationError(
          this.tokens.name,
          this,
          "dict-arg-default",
          message,
          {
            autofix: autofixOptionalDictionaryDefaultValue(this),
          },
        );
      }
    }
  }

  /** @param {import("../writer.js").Writer} w */
  write(w) {
    return w.ts.wrap([
      this.extAttrs.write(w),
      w.token(this.tokens.optional),
      w.ts.type(this.idlType.write(w)),
      w.token(this.tokens.variadic),
      w.name_token(this.tokens.name, { data: this }),
      this.default ? this.default.write(w) : "",
      w.token(this.tokens.separator),
    ]);
  }
}

/**
 * @param {Argument} arg
 */
function isLastRequiredArgument(arg) {
  const list = arg.parent.arguments || arg.parent.list;
  const index = list.indexOf(arg);
  const requiredExists = list.slice(index + 1).some((a) => !a.optional);
  return !requiredExists;
}

/**
 * @param {Argument} arg
 */
function autofixDictionaryArgumentOptionality(arg) {
  return () => {
    const firstToken = getFirstToken(arg.idlType);
    arg.tokens.optional = {
      ...firstToken,
      type: "optional",
      value: "optional",
    };
    firstToken.trivia = " ";
    autofixOptionalDictionaryDefaultValue(arg)();
  };
}

/**
 * @param {Argument} arg
 */
function autofixOptionalDictionaryDefaultValue(arg) {
  return () => {
    arg.default = Default.parse(new Tokeniser(" = {}"));
  };
}

class Operation extends Base {
  /**
   * @param {import("../tokeniser.js").Tokeniser} tokeniser
   * @param {object} [options]
   * @param {import("../tokeniser.js").Token} [options.special]
   * @param {boolean} [options.regular]
   * @param {boolean} [options.noneOnFail]
   */
  static parse(tokeniser, { special, regular, noneOnFail } = {}) {
    const begin_position = tokeniser.position;
    const tokens = { special };
    const ret = autoParenter(
      new Operation({ source: tokeniser.source, tokens }),
    );
    if (special && special.value === "stringifier") {
      tokens.termination = tokeniser.consume(";");
      if (tokens.termination) {
        ret.arguments = [];
        return ret;
      }
    }
    if (!special && !regular) {
      tokens.special = tokeniser.consume("getter", "setter", "deleter");
    }
    const async_position = tokeniser.position;
    tokens.async = tokeniser.consume("async");
    if (tokens.async && tokens.special && tokens.special.value !== "static") {
      if (noneOnFail) {
        tokeniser.unconsume(begin_position);
        return;
      } else {
        tokeniser.unconsume(async_position);
        tokeniser.error("Async is not allowed here");
      }
    }
    ret.idlType = return_type(tokeniser);
    if (!ret.idlType) {
      if (noneOnFail) {
        tokeniser.unconsume(begin_position);
        return;
      } else tokeniser.error("Missing return type");
    }
    tokens.name =
      tokeniser.consumeKind("identifier") ||
      tokeniser.consume(...argumentNameKeywords);
    tokens.open = tokeniser.consume("(");
    if (!tokens.open) {
      if (noneOnFail) {
        tokeniser.unconsume(begin_position);
        return;
      } else tokeniser.error("Invalid operation");
    }
    ret.arguments = argument_list(tokeniser);
    tokens.close = tokeniser.consume(")");
    if (!tokens.close) {
      if (noneOnFail) {
        tokeniser.unconsume(begin_position);
        return;
      } else tokeniser.error("Unterminated operation");
    }
    tokens.termination = tokeniser.consume(";");
    if (!tokens.termination) {
      if (noneOnFail) {
        tokeniser.unconsume(begin_position);
        return;
      } else tokeniser.error("Unterminated operation, expected `;`");
    }
    return ret.this;
  }

  get type() {
    return "operation";
  }
  get name() {
    const { name } = this.tokens;
    if (!name) {
      return "";
    }
    return unescape(name.value);
  }
  get special() {
    if (!this.tokens.special) {
      return "";
    }
    return this.tokens.special.value;
  }
  get async() {
    return !!this.tokens.async;
  }

  *validate(defs) {
    yield* this.extAttrs.validate(defs);
    if (!this.name && ["", "static"].includes(this.special)) {
      const message = `Regular or static operations must have both a return type and an identifier.`;
      yield validationError(this.tokens.open, this, "incomplete-op", message);
    }
    if (this.async && this.special && this.special !== "static") {
      const message = `Operations with ${this.special} special must not be async.`;
      yield validationError(this.tokens.open, this, "incomplete-op", message);
    }
    if (this.idlType) {
      yield* this.idlType.validate(defs);
    }
    for (const argument of this.arguments) {
      yield* argument.validate(defs);
    }
  }

  /** @param {import("../writer.js").Writer} w */
  write(w) {
    const { parent } = this;
    const body = this.idlType
      ? [
          w.ts.type(this.idlType.write(w)),
          w.name_token(this.tokens.name, { data: this, parent }),
          w.token(this.tokens.open),
          w.ts.wrap(this.arguments.map((arg) => arg.write(w))),
          w.token(this.tokens.close),
        ]
      : [];
    return w.ts.definition(
      w.ts.wrap([
        this.extAttrs.write(w),
        this.tokens.name
          ? w.token(this.tokens.special)
          : w.token(this.tokens.special, w.ts.nameless, { data: this, parent }),
        w.token(this.tokens.async),
        ...body,
        w.token(this.tokens.termination),
      ]),
      { data: this, parent },
    );
  }
}

class Attribute extends Base {
  /**
   * @param {import("../tokeniser.js").Tokeniser} tokeniser
   * @param {object} [options]
   * @param {import("../tokeniser.js").Token} [options.special]
   * @param {boolean} [options.noInherit]
   * @param {boolean} [options.readonly]
   */
  static parse(
    tokeniser,
    { special, noInherit = false, readonly = false } = {},
  ) {
    const start_position = tokeniser.position;
    const tokens = { special };
    const ret = autoParenter(
      new Attribute({ source: tokeniser.source, tokens }),
    );
    if (!special && !noInherit) {
      tokens.special = tokeniser.consume("inherit");
    }
    if (ret.special === "inherit" && tokeniser.probe("readonly")) {
      tokeniser.error("Inherited attributes cannot be read-only");
    }
    tokens.readonly = tokeniser.consume("readonly");
    if (readonly && !tokens.readonly && tokeniser.probe("attribute")) {
      tokeniser.error("Attributes must be readonly in this context");
    }
    tokens.base = tokeniser.consume("attribute");
    if (!tokens.base) {
      tokeniser.unconsume(start_position);
      return;
    }
    ret.idlType =
      type_with_extended_attributes(tokeniser, "attribute-type") ||
      tokeniser.error("Attribute lacks a type");
    tokens.name =
      tokeniser.consumeKind("identifier") ||
      tokeniser.consume(...argumentNameKeywords) ||
      tokeniser.error("Attribute lacks a name");
    tokens.termination =
      tokeniser.consume(";") ||
      tokeniser.error("Unterminated attribute, expected `;`");
    return ret.this;
  }

  get type() {
    return "attribute";
  }
  get special() {
    if (!this.tokens.special) {
      return "";
    }
    return this.tokens.special.value;
  }
  get readonly() {
    return !!this.tokens.readonly;
  }
  get name() {
    return unescape(this.tokens.name.value);
  }

  *validate(defs) {
    yield* this.extAttrs.validate(defs);
    yield* this.idlType.validate(defs);

    if (["sequence", "record"].includes(this.idlType.generic)) {
      const message = `Attributes cannot accept ${this.idlType.generic} types.`;
      yield validationError(
        this.tokens.name,
        this,
        "attr-invalid-type",
        message,
      );
    }

    {
      const { reference } = idlTypeIncludesDictionary(this.idlType, defs) || {};
      if (reference) {
        const targetToken = (this.idlType.union ? reference : this.idlType)
          .tokens.base;
        const message = "Attributes cannot accept dictionary types.";
        yield validationError(targetToken, this, "attr-invalid-type", message);
      }
    }

    if (this.readonly) {
      if (idlTypeIncludesEnforceRange(this.idlType, defs)) {
        const targetToken = this.idlType.tokens.base;
        const message =
          "Readonly attributes cannot accept [EnforceRange] extended attribute.";
        yield validationError(targetToken, this, "attr-invalid-type", message);
      }
    }
  }

  /** @param {import("../writer.js").Writer} w */
  write(w) {
    const { parent } = this;
    return w.ts.definition(
      w.ts.wrap([
        this.extAttrs.write(w),
        w.token(this.tokens.special),
        w.token(this.tokens.readonly),
        w.token(this.tokens.base),
        w.ts.type(this.idlType.write(w)),
        w.name_token(this.tokens.name, { data: this, parent }),
        w.token(this.tokens.termination),
      ]),
      { data: this, parent },
    );
  }
}

class CallbackFunction extends Base {
  /**
   * @param {import("../tokeniser.js").Tokeniser} tokeniser
   */
  static parse(tokeniser, base) {
    const tokens = { base };
    const ret = autoParenter(
      new CallbackFunction({ source: tokeniser.source, tokens }),
    );
    tokens.name =
      tokeniser.consumeKind("identifier") ||
      tokeniser.error("Callback lacks a name");
    tokeniser.current = ret.this;
    tokens.assign =
      tokeniser.consume("=") || tokeniser.error("Callback lacks an assignment");
    ret.idlType =
      return_type(tokeniser) || tokeniser.error("Callback lacks a return type");
    tokens.open =
      tokeniser.consume("(") ||
      tokeniser.error("Callback lacks parentheses for arguments");
    ret.arguments = argument_list(tokeniser);
    tokens.close =
      tokeniser.consume(")") || tokeniser.error("Unterminated callback");
    tokens.termination =
      tokeniser.consume(";") ||
      tokeniser.error("Unterminated callback, expected `;`");
    return ret.this;
  }

  get type() {
    return "callback";
  }
  get name() {
    return unescape(this.tokens.name.value);
  }

  *validate(defs) {
    yield* this.extAttrs.validate(defs);
    yield* this.idlType.validate(defs);
  }

  /** @param {import("../writer.js").Writer} w */
  write(w) {
    return w.ts.definition(
      w.ts.wrap([
        this.extAttrs.write(w),
        w.token(this.tokens.base),
        w.name_token(this.tokens.name, { data: this }),
        w.token(this.tokens.assign),
        w.ts.type(this.idlType.write(w)),
        w.token(this.tokens.open),
        ...this.arguments.map((arg) => arg.write(w)),
        w.token(this.tokens.close),
        w.token(this.tokens.termination),
      ]),
      { data: this },
    );
  }
}

/**
 * @param {import("../tokeniser.js").Tokeniser} tokeniser
 */
function inheritanceItem(tokeniser) {
  const extAttrs = ExtendedAttributes.parse(tokeniser);
  const inheritance = tokeniser.consumeKind("identifier");
  if (!inheritance) {
    return undefined;
  }
  return {
    extAttrs,
    inheritance,
    tokens: {},
  };
}

/**
 * @param {import("../tokeniser.js").Tokeniser} tokeniser
 * @param {boolean} multipleInheritance
 */
function inheritance(tokeniser, multipleInheritance) {
  const colon = tokeniser.consume(":");
  if (!colon) {
    return {};
  }
  const first =
    inheritanceItem(tokeniser) || tokeniser.error("Inheritance lacks a type");
  if (!multipleInheritance) {
    return {
      colon,
      extAttrs: first.extAttrs,
      inheritance: first.inheritance,
    };
  }
  first.tokens.separator = tokeniser.consume(",");
  if (!first.tokens.separator) {
    return {
      colon,
      inheritance: [first],
    };
  }
  const rest = list(tokeniser, {
    parser: inheritanceItem,
    listName: "inheritance-list",
    allowDangler: false,
  });
  return {
    colon,
    inheritance: [first, ...rest],
  };
}

/**
 * Parser callback.
 * @callback ParserCallback
 * @param {import("../tokeniser.js").Tokeniser} tokeniser
 * @param {...*} args
 */

/**
 * A parser callback and optional option object.
 * @typedef AllowedMember
 * @type {[ParserCallback, object?]}
 */

class Container extends Base {
  /**
   * @param {import("../tokeniser.js").Tokeniser} tokeniser
   * @param {*} instance TODO: This should be {T extends Container}, but see https://github.com/microsoft/TypeScript/issues/4628
   * @param {*} args
   */
  static parse(
    tokeniser,
    instance,
    { inheritable, allowedMembers, multipleInheritance = false },
  ) {
    const { tokens, type } = instance;
    tokens.name =
      tokeniser.consumeKind("identifier") ||
      tokeniser.error(`Missing name in ${type}`);
    tokeniser.current = instance;
    instance = autoParenter(instance);
    if (inheritable) {
      const inheritanceParsed = inheritance(tokeniser, multipleInheritance);
      tokens.colon = inheritanceParsed.colon;
      tokens.inheritance = inheritanceParsed.inheritance;
      if (!multipleInheritance) {
        instance.inheritanceExtAttrs = inheritanceParsed.extAttrs;
      }
    }
    tokens.open = tokeniser.consume("{") || tokeniser.error(`Bodyless ${type}`);
    instance.members = [];
    while (true) {
      tokens.close = tokeniser.consume("}");
      if (tokens.close) {
        tokens.termination =
          tokeniser.consume(";") ||
          tokeniser.error(`Missing semicolon after ${type}`);
        return instance.this;
      }
      const psu1 = ParserState.update(tokeniser);
      if (psu1) {
        instance.members.push(psu1);
        continue;
      }
      const ea = ExtendedAttributes.parse(tokeniser);
      let mem;
      for (const [parser, ...args] of allowedMembers) {
        mem = autoParenter(parser(tokeniser, ...args));
        if (mem) {
          break;
        }
      }
      if (!mem) {
        tokeniser.error("Unknown member");
      }
      mem.extAttrs = ea;
      instance.members.push(mem.this);
    }
  }

  get partial() {
    return !!this.tokens.partial;
  }
  get name() {
    return unescape(this.tokens.name.value);
  }
  get inheritance() {
    if (!this.tokens.inheritance) {
      return null;
    }
    if (Array.isArray(this.tokens.inheritance)) {
      return this.tokens.inheritance.map((it) => {
        return {
          extAttrs: it.extAttrs,
          inheritance: unescape(it.inheritance.value),
        };
      });
    }
    return unescape(this.tokens.inheritance.value);
  }

  *validate(defs) {
    for (const member of this.members) {
      if (member.validate) {
        yield* member.validate(defs);
      }
    }
  }

  /** @param {import("../writer.js").Writer} w */
  write(w) {
    const inheritance = () => {
      if (!this.tokens.inheritance) {
        return "";
      }
      return w.ts.wrap([
        w.token(this.tokens.colon),
        this.inheritanceExtAttrs?.write(w),
        w.ts.trivia(this.tokens.inheritance.trivia),
        w.ts.inheritance(
          w.reference(this.tokens.inheritance.value, { context: this }),
        ),
      ]);
    };

    return w.ts.definition(
      w.ts.wrap([
        this.extAttrs.write(w),
        w.token(this.tokens.callback),
        w.token(this.tokens.partial),
        w.token(this.tokens.base),
        w.token(this.tokens.mixin),
        w.name_token(this.tokens.name, { data: this }),
        inheritance(),
        w.token(this.tokens.open),
        w.ts.wrap(this.members.map((m) => m.write(w))),
        w.token(this.tokens.close),
        w.token(this.tokens.termination),
      ]),
      { data: this },
    );
  }
}

class Constant extends Base {
  /**
   * @param {import("../tokeniser.js").Tokeniser} tokeniser
   */
  static parse(tokeniser) {
    /** @type {Base["tokens"]} */
    const tokens = {};
    tokens.base = tokeniser.consume("const");
    if (!tokens.base) {
      return;
    }
    let idlType = primitive_type(tokeniser);
    if (!idlType) {
      const base =
        tokeniser.consumeKind("identifier") ||
        tokeniser.error("Const lacks a type");
      idlType = new Type({ source: tokeniser.source, tokens: { base } });
    }
    if (tokeniser.probe("?")) {
      tokeniser.error("Unexpected nullable constant type");
    }
    idlType.type = "const-type";
    tokens.name =
      tokeniser.consumeKind("identifier") ||
      tokeniser.error("Const lacks a name");
    tokens.assign =
      tokeniser.consume("=") || tokeniser.error("Const lacks value assignment");
    tokens.value =
      const_value(tokeniser) || tokeniser.error("Const lacks a value");
    tokens.termination =
      tokeniser.consume(";") ||
      tokeniser.error("Unterminated const, expected `;`");
    const ret = new Constant({ source: tokeniser.source, tokens });
    autoParenter(ret).idlType = idlType;
    return ret;
  }

  get type() {
    return "const";
  }
  get name() {
    return unescape(this.tokens.name.value);
  }
  get value() {
    return const_data(this.tokens.value);
  }

  /** @param {import("../writer.js").Writer} w */
  write(w) {
    const { parent } = this;
    return w.ts.definition(
      w.ts.wrap([
        this.extAttrs.write(w),
        w.token(this.tokens.base),
        w.ts.type(this.idlType.write(w)),
        w.name_token(this.tokens.name, { data: this, parent }),
        w.token(this.tokens.assign),
        w.token(this.tokens.value),
        w.token(this.tokens.termination),
      ]),
      { data: this, parent },
    );
  }
}

class IterableLike extends Base {
  /**
   * @param {import("../tokeniser.js").Tokeniser} tokeniser
   */
  static parse(tokeniser) {
    const start_position = tokeniser.position;
    const ret = autoParenter(
      new IterableLike({ source: tokeniser.source, tokens: {} }),
    );
    const { tokens } = ret;
    tokens.readonly = tokeniser.consume("readonly");
    if (!tokens.readonly) {
      tokens.async = tokeniser.consume("async");
    }
    tokens.base = tokens.readonly
      ? tokeniser.consume("maplike", "setlike")
      : tokens.async
        ? tokeniser.consume("iterable")
        : tokeniser.consume("iterable", "maplike", "setlike");
    if (!tokens.base) {
      tokeniser.unconsume(start_position);
      return;
    }

    const { type } = ret;
    const secondTypeRequired = type === "maplike";
    const secondTypeAllowed = secondTypeRequired || type === "iterable";
    const argumentAllowed = ret.async && type === "iterable";

    tokens.open =
      tokeniser.consume("<") ||
      tokeniser.error(`Missing less-than sign \`<\` in ${type} declaration`);
    const first =
      type_with_extended_attributes(tokeniser) ||
      tokeniser.error(`Missing a type argument in ${type} declaration`);
    ret.idlType = [first];
    ret.arguments = [];

    if (secondTypeAllowed) {
      first.tokens.separator = tokeniser.consume(",");
      if (first.tokens.separator) {
        ret.idlType.push(type_with_extended_attributes(tokeniser));
      } else if (secondTypeRequired) {
        tokeniser.error(`Missing second type argument in ${type} declaration`);
      }
    }

    tokens.close =
      tokeniser.consume(">") ||
      tokeniser.error(`Missing greater-than sign \`>\` in ${type} declaration`);

    if (tokeniser.probe("(")) {
      if (argumentAllowed) {
        tokens.argsOpen = tokeniser.consume("(");
        ret.arguments.push(...argument_list(tokeniser));
        tokens.argsClose =
          tokeniser.consume(")") ||
          tokeniser.error("Unterminated async iterable argument list");
      } else {
        tokeniser.error(`Arguments are only allowed for \`async iterable\``);
      }
    }

    tokens.termination =
      tokeniser.consume(";") ||
      tokeniser.error(`Missing semicolon after ${type} declaration`);

    return ret.this;
  }

  get type() {
    return this.tokens.base.value;
  }
  get readonly() {
    return !!this.tokens.readonly;
  }
  get async() {
    return !!this.tokens.async;
  }

  *validate(defs) {
    for (const type of this.idlType) {
      yield* type.validate(defs);
    }
    for (const argument of this.arguments) {
      yield* argument.validate(defs);
    }
  }

  /** @param {import("../writer.js").Writer} w */
  write(w) {
    return w.ts.definition(
      w.ts.wrap([
        this.extAttrs.write(w),
        w.token(this.tokens.readonly),
        w.token(this.tokens.async),
        w.token(this.tokens.base, w.ts.generic),
        w.token(this.tokens.open),
        w.ts.wrap(this.idlType.map((t) => t.write(w))),
        w.token(this.tokens.close),
        w.token(this.tokens.argsOpen),
        w.ts.wrap(this.arguments.map((arg) => arg.write(w))),
        w.token(this.tokens.argsClose),
        w.token(this.tokens.termination),
      ]),
      { data: this, parent: this.parent },
    );
  }
}

/**
 * @param {import("../validator.js").Definitions} defs
 * @param {import("../productions/container.js").Container} i
 */
function* checkInterfaceMemberDuplication(defs, i) {
  const opNames = groupOperationNames(i);
  const partials = defs.partials.get(i.name) || [];
  const mixins = defs.mixinMap.get(i.name) || [];
  for (const ext of [...partials, ...mixins]) {
    const additions = getOperations(ext);
    const statics = additions.filter((a) => a.special === "static");
    const nonstatics = additions.filter((a) => a.special !== "static");
    yield* checkAdditions(statics, opNames.statics, ext, i);
    yield* checkAdditions(nonstatics, opNames.nonstatics, ext, i);
    statics.forEach((op) => opNames.statics.add(op.name));
    nonstatics.forEach((op) => opNames.nonstatics.add(op.name));
  }

  /**
   * @param {import("../productions/operation.js").Operation[]} additions
   * @param {Set<string>} existings
   * @param {import("../productions/container.js").Container} ext
   * @param {import("../productions/container.js").Container} base
   */
  function* checkAdditions(additions, existings, ext, base) {
    for (const addition of additions) {
      const { name } = addition;
      if (name && existings.has(name)) {
        const isStatic = addition.special === "static" ? "static " : "";
        const message = `The ${isStatic}operation "${name}" has already been defined for the base interface "${base.name}" either in itself or in a mixin`;
        yield validationError(
          addition.tokens.name,
          ext,
          "no-cross-overload",
          message,
        );
      }
    }
  }

  /**
   * @param {import("../productions/container.js").Container} i
   * @returns {import("../productions/operation.js").Operation[]}
   */
  function getOperations(i) {
    return i.members.filter(({ type }) => type === "operation");
  }

  /**
   * @param {import("../productions/container.js").Container} i
   */
  function groupOperationNames(i) {
    const ops = getOperations(i);
    return {
      statics: new Set(
        ops.filter((op) => op.special === "static").map((op) => op.name),
      ),
      nonstatics: new Set(
        ops.filter((op) => op.special !== "static").map((op) => op.name),
      ),
    };
  }
}

class Constructor extends Base {
  /**
   * @param {import("../tokeniser.js").Tokeniser} tokeniser
   */
  static parse(tokeniser) {
    const base = tokeniser.consume("constructor");
    if (!base) {
      return;
    }
    /** @type {Base["tokens"]} */
    const tokens = { base };
    tokens.open =
      tokeniser.consume("(") ||
      tokeniser.error("No argument list in constructor");
    const args = argument_list(tokeniser);
    tokens.close =
      tokeniser.consume(")") || tokeniser.error("Unterminated constructor");
    tokens.termination =
      tokeniser.consume(";") ||
      tokeniser.error("No semicolon after constructor");
    const ret = new Constructor({ source: tokeniser.source, tokens });
    autoParenter(ret).arguments = args;
    return ret;
  }

  get type() {
    return "constructor";
  }

  *validate(defs) {
    for (const argument of this.arguments) {
      yield* argument.validate(defs);
    }
  }

  /** @param {import("../writer.js").Writer} w */
  write(w) {
    const { parent } = this;
    return w.ts.definition(
      w.ts.wrap([
        this.extAttrs.write(w),
        w.token(this.tokens.base, w.ts.nameless, { data: this, parent }),
        w.token(this.tokens.open),
        w.ts.wrap(this.arguments.map((arg) => arg.write(w))),
        w.token(this.tokens.close),
        w.token(this.tokens.termination),
      ]),
      { data: this, parent },
    );
  }
}

/**
 * @param {import("../tokeniser.js").Tokeniser} tokeniser
 */
function static_member(tokeniser) {
  const special = tokeniser.consume("static");
  if (!special) return;
  const member =
    Attribute.parse(tokeniser, { special }) ||
    Operation.parse(tokeniser, { special }) ||
    tokeniser.error("No body in static member");
  return member;
}

class Interface extends Container {
  /**
   * @param {import("../tokeniser.js").Tokeniser} tokeniser
   * @param {import("../tokeniser.js").Token} base
   * @param {object} [options]
   * @param {import("./container.js").AllowedMember[]} [options.extMembers]
   * @param {import("../tokeniser.js").Token|null} [options.partial]
   */
  static parse(tokeniser, base, { extMembers = [], partial = null } = {}) {
    const tokens = { partial, base };
    return Container.parse(
      tokeniser,
      new Interface({ source: tokeniser.source, tokens }),
      {
        inheritable: !partial,
        allowedMembers: [
          ...extMembers,
          [Constant.parse],
          [Constructor.parse],
          [static_member],
          [stringifier],
          [IterableLike.parse],
          [Attribute.parse],
          [Operation.parse],
        ],
        multipleInheritance: true,
      },
    );
  }

  get type() {
    return "interface";
  }

  *validate(defs) {
    yield* this.extAttrs.validate(defs);
    if (
      !this.partial &&
      this.extAttrs.every((extAttr) => extAttr.name !== "Exposed")
    ) {
      const message = `Interfaces must have \`[Exposed]\` extended attribute. \
To fix, add, for example, \`[Exposed=Window]\`. Please also consider carefully \
if your interface should also be exposed in a Worker scope. Refer to the \
[WebIDL spec section on Exposed](https://heycam.github.io/webidl/#Exposed) \
for more information.`;
      yield validationError(
        this.tokens.name,
        this,
        "require-exposed",
        message,
        {
          autofix: autofixAddExposedWindow(this),
        },
      );
    }
    const oldConstructors = this.extAttrs.filter(
      (extAttr) => extAttr.name === "Constructor",
    );
    for (const constructor of oldConstructors) {
      const message = `Constructors should now be represented as a \`constructor()\` operation on the interface \
instead of \`[Constructor]\` extended attribute. Refer to the \
[WebIDL spec section on constructor operations](https://heycam.github.io/webidl/#idl-constructors) \
for more information.`;
      yield validationError(
        constructor.tokens.name,
        this,
        "constructor-member",
        message,
        {
          autofix: autofixConstructor(this, constructor),
        },
      );
    }

    const isGlobal = this.extAttrs.some((extAttr) => extAttr.name === "Global");
    if (isGlobal) {
      const factoryFunctions = this.extAttrs.filter(
        (extAttr) => extAttr.name === "LegacyFactoryFunction",
      );
      for (const named of factoryFunctions) {
        const message = `Interfaces marked as \`[Global]\` cannot have factory functions.`;
        yield validationError(
          named.tokens.name,
          this,
          "no-constructible-global",
          message,
        );
      }

      const constructors = this.members.filter(
        (member) => member.type === "constructor",
      );
      for (const named of constructors) {
        const message = `Interfaces marked as \`[Global]\` cannot have constructors.`;
        yield validationError(
          named.tokens.base,
          this,
          "no-constructible-global",
          message,
        );
      }
    }

    yield* super.validate(defs);
    if (!this.partial) {
      yield* checkInterfaceMemberDuplication(defs, this);
    }
  }
}

function autofixConstructor(interfaceDef, constructorExtAttr) {
  interfaceDef = autoParenter(interfaceDef);
  return () => {
    const indentation = getLastIndentation(
      interfaceDef.extAttrs.tokens.open.trivia,
    );
    const memberIndent = interfaceDef.members.length
      ? getLastIndentation(getFirstToken(interfaceDef.members[0]).trivia)
      : getMemberIndentation(indentation);
    const constructorOp = Constructor.parse(
      new Tokeniser(`\n${memberIndent}constructor();`),
    );
    constructorOp.extAttrs = new ExtendedAttributes({
      source: interfaceDef.source,
      tokens: {},
    });
    autoParenter(constructorOp).arguments = constructorExtAttr.arguments;

    const existingIndex = findLastIndex(
      interfaceDef.members,
      (m) => m.type === "constructor",
    );
    interfaceDef.members.splice(existingIndex + 1, 0, constructorOp);

    const { close } = interfaceDef.tokens;
    if (!close.trivia.includes("\n")) {
      close.trivia += `\n${indentation}`;
    }

    const { extAttrs } = interfaceDef;
    const index = extAttrs.indexOf(constructorExtAttr);
    const removed = extAttrs.splice(index, 1);
    if (!extAttrs.length) {
      extAttrs.tokens.open = extAttrs.tokens.close = undefined;
    } else if (extAttrs.length === index) {
      extAttrs[index - 1].tokens.separator = undefined;
    } else if (!extAttrs[index].tokens.name.trivia.trim()) {
      extAttrs[index].tokens.name.trivia = removed[0].tokens.name.trivia;
    }
  };
}

class Mixin extends Container {
  /**
   * @param {import("../tokeniser.js").Tokeniser} tokeniser
   * @param {import("../tokeniser.js").Token} base
   * @param {object} [options]
   * @param {import("./container.js").AllowedMember[]} [options.extMembers]
   * @param {import("../tokeniser.js").Token} [options.partial]
   */
  static parse(tokeniser, base, { extMembers = [], partial } = {}) {
    const tokens = { partial, base };
    tokens.mixin = tokeniser.consume("mixin");
    if (!tokens.mixin) {
      return;
    }
    return Container.parse(
      tokeniser,
      new Mixin({ source: tokeniser.source, tokens }),
      {
        allowedMembers: [
          ...extMembers,
          [Constant.parse],
          [stringifier],
          [Attribute.parse, { noInherit: true }],
          [Operation.parse, { regular: true }],
        ],
      },
    );
  }

  get type() {
    return "interface mixin";
  }
}

class CallbackInterface extends Container {
  /**
   * @param {import("../tokeniser.js").Tokeniser} tokeniser
   * @param {*} callback
   * @param {object} [options]
   * @param {import("./container.js").AllowedMember[]} [options.extMembers]
   */
  static parse(tokeniser, callback, { extMembers = [] } = {}) {
    const tokens = { callback };
    tokens.base = tokeniser.consume("interface");
    if (!tokens.base) {
      return;
    }
    return Container.parse(
      tokeniser,
      new CallbackInterface({ source: tokeniser.source, tokens }),
      {
        allowedMembers: [
          ...extMembers,
          [Constant.parse],
          [Operation.parse, { regular: true }],
        ],
      },
    );
  }

  get type() {
    return "callback interface";
  }
}

class Field extends Base {
  /**
   * @param {import("../tokeniser.js").Tokeniser} tokeniser
   */
  static parse(tokeniser) {
    /** @type {Base["tokens"]} */
    const tokens = {};
    const ret = autoParenter(new Field({ source: tokeniser.source, tokens }));
    ret.extAttrs = ExtendedAttributes.parse(tokeniser);
    tokens.required = tokeniser.consume("required");
    ret.idlType =
      type_with_extended_attributes(tokeniser, "dictionary-type") ||
      tokeniser.error("Dictionary member lacks a type");
    tokens.name =
      tokeniser.consumeKind("identifier") ||
      tokeniser.consume(...argumentNameKeywords) ||
      tokeniser.error("Dictionary member lacks a name");
    ret.default = Default.parse(tokeniser);
    if (tokens.required && ret.default)
      tokeniser.error("Required member must not have a default");
    tokens.termination =
      tokeniser.consume(";") ||
      tokeniser.error("Unterminated dictionary member, expected `;`");
    return ret.this;
  }

  get type() {
    return "field";
  }
  get name() {
    return unescape(this.tokens.name.value);
  }
  get required() {
    return !!this.tokens.required;
  }

  *validate(defs) {
    yield* this.idlType.validate(defs);
  }

  /** @param {import("../writer.js").Writer} w */
  write(w) {
    const { parent } = this;
    return w.ts.definition(
      w.ts.wrap([
        this.extAttrs.write(w),
        w.token(this.tokens.required),
        w.ts.type(this.idlType.write(w)),
        w.name_token(this.tokens.name, { data: this, parent }),
        this.default ? this.default.write(w) : "",
        w.token(this.tokens.termination),
      ]),
      { data: this, parent },
    );
  }
}

class Dictionary extends Container {
  /**
   * @param {import("../tokeniser.js").Tokeniser} tokeniser
   * @param {object} [options]
   * @param {import("./container.js").AllowedMember[]} [options.extMembers]
   * @param {import("../tokeniser.js").Token} [options.partial]
   */
  static parse(tokeniser, { extMembers = [], partial } = {}) {
    const tokens = { partial };
    tokens.base = tokeniser.consume("dictionary");
    if (!tokens.base) {
      return;
    }
    return Container.parse(
      tokeniser,
      new Dictionary({ source: tokeniser.source, tokens }),
      {
        inheritable: !partial,
        allowedMembers: [...extMembers, [Field.parse]],
      },
    );
  }

  get type() {
    return "dictionary";
  }
}

class Version extends Base {
  /**
   * @param {import("../tokeniser.js").Tokeniser} tokeniser
   */
  static parse(tokeniser) {
    const startTokeniserPosition = tokeniser.position;
    const extAttrs = ExtendedAttributes.parse(tokeniser);

    /** @type {Base["tokens"]} */
    const tokens = {};
    tokens.base = tokeniser.consume("version");
    if (!tokens.base) {
      tokeniser.unconsume(startTokeniserPosition);
      return;
    }

    let value = "";
    for (let i = 0; i < 10; ++i) {
      tokens.termination = tokeniser.consume(";");
      if (tokens.termination) {
        break;
      }
      const token =
        tokeniser.consumeKind("decimal") ||
        tokeniser.consumeKind("integer") ||
        tokeniser.consumeKind("identifier") ||
        tokeniser.consumeKind("other") ||
        tokeniser.error("version lacks a value");

      tokens[`value${i}`] = token;
      value += token.value;
    }

    if (!tokens.termination || !value) {
      tokeniser.error("Malformed version value");
    }

    const ret = new Version({ source: tokeniser.source, tokens });
    autoParenter(ret).value = value.split(".");
    autoParenter(ret).extAttrs = extAttrs;
    return ret;
  }

  get type() {
    return "version";
  }

  /** @param {import("../writer.js").Writer} w */
  write(w) {
    const { parent } = this;
    const valueTokens = [];
    for (let i = 0; i < 10; ++i) {
      valueTokens.push(w.token(this.tokens[`value${i}`]));
    }
    return w.ts.definition(
      w.ts.wrap([
        this.extAttrs.write(w),
        w.token(this.tokens.base),
        ...valueTokens,
        w.token(this.tokens.termination),
      ]),
      { data: this, parent },
    );
  }
}

class EnumValue extends WrappedToken {
  /**
   * @param {import("../tokeniser.js").Tokeniser} tokeniser
   */
  static parse(tokeniser) {
    const value = tokeniser.consumeKind("string");
    if (value) {
      return new EnumValue({ source: tokeniser.source, tokens: { value } });
    }
  }

  get type() {
    return "enum-value";
  }
  get value() {
    return super.value.slice(1, -1);
  }

  /** @param {import("../writer.js").Writer} w */
  write(w) {
    const { parent } = this;
    return w.ts.wrap([
      w.ts.trivia(this.tokens.value.trivia),
      w.ts.definition(
        w.ts.wrap(['"', w.ts.name(this.value, { data: this, parent }), '"']),
        { data: this, parent },
      ),
      w.token(this.tokens.separator),
    ]);
  }
}

class Enum extends Base {
  /**
   * @param {import("../tokeniser.js").Tokeniser} tokeniser
   */
  static parse(tokeniser) {
    /** @type {Base["tokens"]} */
    const tokens = {};
    tokens.base = tokeniser.consume("enum");
    if (!tokens.base) {
      return;
    }
    tokens.name =
      tokeniser.consumeKind("identifier") ||
      tokeniser.error("No name for enum");
    const ret = autoParenter(new Enum({ source: tokeniser.source, tokens }));
    tokeniser.current = ret.this;
    tokens.open = tokeniser.consume("{") || tokeniser.error("Bodyless enum");
    ret.values = list(tokeniser, {
      parser: EnumValue.parse,
      allowDangler: true,
      listName: "enumeration",
    });
    if (tokeniser.probeKind("string")) {
      tokeniser.error("No comma between enum values");
    }
    tokens.close =
      tokeniser.consume("}") || tokeniser.error("Unexpected value in enum");
    if (!ret.values.length) {
      tokeniser.error("No value in enum");
    }
    tokens.termination =
      tokeniser.consume(";") || tokeniser.error("No semicolon after enum");
    return ret.this;
  }

  get type() {
    return "enum";
  }
  get name() {
    return unescape(this.tokens.name.value);
  }

  /** @param {import("../writer.js").Writer} w */
  write(w) {
    return w.ts.definition(
      w.ts.wrap([
        this.extAttrs.write(w),
        w.token(this.tokens.base),
        w.name_token(this.tokens.name, { data: this }),
        w.token(this.tokens.open),
        w.ts.wrap(this.values.map((v) => v.write(w))),
        w.token(this.tokens.close),
        w.token(this.tokens.termination),
      ]),
      { data: this },
    );
  }
}

class Typedef extends Base {
  /**
   * @param {import("../tokeniser.js").Tokeniser} tokeniser
   */
  static parse(tokeniser) {
    /** @type {Base["tokens"]} */
    const tokens = {};
    const ret = autoParenter(new Typedef({ source: tokeniser.source, tokens }));
    tokens.base = tokeniser.consume("typedef");
    if (!tokens.base) {
      return;
    }
    ret.idlType =
      type_with_extended_attributes(tokeniser, "typedef-type") ||
      tokeniser.error("Typedef lacks a type");
    tokens.name =
      tokeniser.consumeKind("identifier") ||
      tokeniser.error("Typedef lacks a name");
    tokeniser.current = ret.this;
    tokens.termination =
      tokeniser.consume(";") ||
      tokeniser.error("Unterminated typedef, expected `;`");
    return ret.this;
  }

  get type() {
    return "typedef";
  }
  get name() {
    return unescape(this.tokens.name.value);
  }

  *validate(defs) {
    yield* this.idlType.validate(defs);
  }

  /** @param {import("../writer.js").Writer} w */
  write(w) {
    return w.ts.definition(
      w.ts.wrap([
        this.extAttrs.write(w),
        w.token(this.tokens.base),
        w.ts.type(this.idlType.write(w)),
        w.name_token(this.tokens.name, { data: this }),
        w.token(this.tokens.termination),
      ]),
      { data: this },
    );
  }
}

class Namespace extends Container {
  /**
   * @param {import("../tokeniser.js").Tokeniser} tokeniser
   * @param {object} [options]
   * @param {import("./container.js").AllowedMember[]} [options.extMembers]
   * @param {import("../tokeniser.js").Token} [options.partial]
   */
  static parse(tokeniser, { extMembers = [], partial } = {}) {
    const tokens = { partial };
    tokens.base = tokeniser.consume("namespace");
    if (!tokens.base) {
      return;
    }
    return Container.parse(
      tokeniser,
      new Namespace({ source: tokeniser.source, tokens }),
      {
        allowedMembers: [
          ...extMembers,
          [parseCallback],
          [parseInterface],
          [parsePartial],
          [Namespace.parse],
          [Dictionary.parse],
          [Enum.parse],
          [Typedef.parse],
          [Version.parse],
          [Attribute.parse, { noInherit: true, readonly: true }],
          [Constant.parse],
          [Operation.parse, { regular: true }],
        ],
      },
    );
  }

  get type() {
    return "namespace";
  }

  *validate(defs) {
    if (
      !this.partial &&
      this.extAttrs.every((extAttr) => extAttr.name !== "Exposed")
    ) {
      const message = `Namespaces must have [Exposed] extended attribute. \
To fix, add, for example, [Exposed=Window]. Please also consider carefully \
if your namespace should also be exposed in a Worker scope. Refer to the \
[WebIDL spec section on Exposed](https://heycam.github.io/webidl/#Exposed) \
for more information.`;
      yield validationError(
        this.tokens.name,
        this,
        "require-exposed",
        message,
        {
          autofix: autofixAddExposedWindow(this),
        },
      );
    }
    yield* super.validate(defs);
  }
}

/**
 * @param {string} identifier
 */
function unescape(identifier) {
  return identifier;
}

/** @typedef {'callbackInterface'|'dictionary'|'interface'|'mixin'|'namespace'} ExtendableInterfaces */
/** @typedef {{ extMembers?: import("./container.js").AllowedMember[]}} Extension */
/** @typedef {Partial<Record<ExtendableInterfaces, Extension>>} Extensions */

/**
 * Parses comma-separated list
 * @param {import("../tokeniser.js").Tokeniser} tokeniser
 * @param {object} args
 * @param {Function} args.parser parser function for each item
 * @param {boolean} [args.allowDangler] whether to allow dangling comma
 * @param {string} [args.listName] the name to be shown on error messages
 */
function list(tokeniser, { parser, allowDangler, listName = "list" }) {
  const first = parser(tokeniser);
  if (!first) {
    return [];
  }
  first.tokens.separator = tokeniser.consume(",");
  const items = [first];
  while (first.tokens.separator) {
    const item = parser(tokeniser);
    if (!item) {
      if (!allowDangler) {
        tokeniser.error(`Trailing comma in ${listName}`);
      }
      break;
    }
    item.tokens.separator = tokeniser.consume(",");
    items.push(item);
    if (!item.tokens.separator) break;
  }
  return items;
}

/**
 * @param {import("../tokeniser.js").Tokeniser} tokeniser
 */
function const_value(tokeniser) {
  return (
    tokeniser.consumeKind("decimal", "integer", "string") ||
    tokeniser.consume("true", "false", "Infinity", "-Infinity", "NaN")
  );
}

/**
 * @param {object} token
 * @param {string} token.type
 * @param {string} token.value
 */
function const_data({ type, value }) {
  switch (type) {
    case "decimal":
    case "integer":
      return { type: "number", value };
    case "string":
      return { type: "string", value: value.slice(1, -1) };
  }

  switch (value) {
    case "true":
    case "false":
      return { type: "boolean", value: value === "true" };
    case "Infinity":
    case "-Infinity":
      return { type: "Infinity", negative: value.startsWith("-") };
    case "[":
      return { type: "sequence", value: [] };
    case "{":
      return { type: "dictionary" };
    default:
      return { type: value };
  }
}

/**
 * @param {import("../tokeniser.js").Tokeniser} tokeniser
 */
function primitive_type(tokeniser) {
  function integer_type() {
    const prefix = tokeniser.consume("unsigned");
    const base = tokeniser.consume("short", "long", "String", "number");
    if (base) {
      const postfix = tokeniser.consume("long");
      return new Type({ source, tokens: { prefix, base, postfix } });
    }
    if (prefix) tokeniser.error("Failed to parse integer type");
  }

  function decimal_type() {
    const prefix = tokeniser.consume("unrestricted");
    const base = tokeniser.consume("float", "double");
    if (base) {
      return new Type({ source, tokens: { prefix, base } });
    }
    if (prefix) tokeniser.error("Failed to parse float type");
  }

  const { source } = tokeniser;
  const num_type = integer_type() || decimal_type();
  if (num_type) return num_type;
  const base = tokeniser.consume(
    "bigint",
    "boolean",
    "byte",
    "octet",
    "undefined",
  );
  if (base) {
    return new Type({ source, tokens: { base } });
  }
}

/**
 * @param {import("../tokeniser.js").Tokeniser} tokeniser
 */
function argument_list(tokeniser) {
  return list(tokeniser, {
    parser: Argument.parse,
    listName: "arguments list",
  });
}

/**
 * @param {import("../tokeniser.js").Tokeniser} tokeniser
 * @param {string=} typeName (TODO: See Type.type for more details)
 */
function type_with_extended_attributes(tokeniser, typeName) {
  const extAttrs = ExtendedAttributes.parse(tokeniser);
  const ret = Type.parse(tokeniser, typeName);
  if (ret) autoParenter(ret).extAttrs = extAttrs;
  return ret;
}

/**
 * @param {import("../tokeniser.js").Tokeniser} tokeniser
 * @param {string=} typeName (TODO: See Type.type for more details)
 */
function return_type(tokeniser, typeName) {
  const startPosition = tokeniser.position;
  do {
    const openRT = tokeniser.consume("(");
    if (!openRT) {
      tokeniser.unconsume(startPosition);
      break;
    }
    const extAttrs = ExtendedAttributes.parse(tokeniser);
    if (!extAttrs) {
      tokeniser.unconsume(startPosition);
      break;
    }
    const typ = Type.parse(tokeniser, typeName || "return-type");
    if (!typ) {
      tokeniser.unconsume(startPosition);
      break;
    }
    const closeRT = tokeniser.consume(")");
    if (!closeRT) {
      tokeniser.unconsume(startPosition);
      break;
    }
    autoParenter(typ).extAttrs = extAttrs;
    typ.tokens.openRT = openRT;
    typ.tokens.closeRT = closeRT;
    return typ;
  } while (false);
  const typ = Type.parse(tokeniser, typeName || "return-type");
  if (typ) {
    return typ;
  }
  const voidToken = tokeniser.consume("void");
  if (voidToken) {
    const ret = new Type({
      source: tokeniser.source,
      tokens: { base: voidToken },
    });
    ret.type = "return-type";
    return ret;
  }
}

/**
 * @param {import("../tokeniser.js").Tokeniser} tokeniser
 */
function stringifier(tokeniser) {
  const special = tokeniser.consume("stringifier");
  if (!special) return;
  const member =
    Attribute.parse(tokeniser, { special }) ||
    Operation.parse(tokeniser, { special }) ||
    tokeniser.error("Unterminated stringifier");
  return member;
}

/**
 * @param {string} str
 */
function getLastIndentation(str) {
  const lines = str.split("\n");
  // the first line visually binds to the preceding token
  if (lines.length) {
    const match = lines[lines.length - 1].match(/^\s+/);
    if (match) {
      return match[0];
    }
  }
  return "";
}

/**
 * @param {string} parentTrivia
 */
function getMemberIndentation(parentTrivia) {
  const indentation = getLastIndentation(parentTrivia);
  const indentCh = indentation.includes("\t") ? "\t" : "  ";
  return indentation + indentCh;
}

/**
 * @param {import("./interface.js").Interface} def
 */
function autofixAddExposedWindow(def) {
  return () => {
    if (def.extAttrs.length) {
      const tokeniser = new Tokeniser("Exposed=Window,");
      const exposed = SimpleExtendedAttribute.parse(tokeniser);
      exposed.tokens.separator = tokeniser.consume(",");
      const existing = def.extAttrs[0];
      if (!/^\s/.test(existing.tokens.name.trivia)) {
        existing.tokens.name.trivia = ` ${existing.tokens.name.trivia}`;
      }
      def.extAttrs.unshift(exposed);
    } else {
      autoParenter(def).extAttrs = ExtendedAttributes.parse(
        new Tokeniser("[Exposed=Window]"),
      );
      const trivia = def.tokens.base.trivia;
      def.extAttrs.tokens.open.trivia = trivia;
      def.tokens.base.trivia = `\n${getLastIndentation(trivia)}`;
    }
  };
}

/**
 * Get the first syntax token for the given IDL object.
 * @param {*} data
 */
function getFirstToken(data) {
  if (data.extAttrs.length) {
    return data.extAttrs.tokens.open;
  }
  if (data.type === "operation" && !data.special) {
    return getFirstToken(data.idlType);
  }
  const tokens = Object.values(data.tokens).sort((x, y) => x.index - y.index);
  return tokens[0];
}

/**
 * @template T
 * @param {T[]} array
 * @param {(item: T) => boolean} predicate
 */
function findLastIndex(array, predicate) {
  const index = array.slice().reverse().findIndex(predicate);
  if (index === -1) {
    return index;
  }
  return array.length - index - 1;
}

/**
 * Returns a proxy that auto-assign `parent` field.
 * @template {Record<string | symbol, any>} T
 * @param {T} data
 * @param {*} [parent] The object that will be assigned to `parent`.
 *                     If absent, it will be `data` by default.
 * @return {T}
 */
function autoParenter(data, parent) {
  if (!parent) {
    // Defaults to `data` unless specified otherwise.
    parent = data;
  }
  if (!data) {
    // This allows `autoParenter(undefined)` which again allows
    // `autoParenter(parse())` where the function may return nothing.
    return data;
  }
  const proxy = new Proxy(data, {
    get(target, p) {
      const value = target[p];
      if (Array.isArray(value) && p !== "source") {
        // Wraps the array so that any added items will also automatically
        // get their `parent` values.
        return autoParenter(value, target);
      }
      return value;
    },
    set(target, p, value) {
      // @ts-ignore https://github.com/microsoft/TypeScript/issues/47357
      target[p] = value;
      if (!value) {
        return true;
      } else if (Array.isArray(value)) {
        // Assigning an array will add `parent` to its items.
        for (const item of value) {
          if (typeof item.parent !== "undefined") {
            item.parent = parent;
          }
        }
      } else if (typeof value.parent !== "undefined") {
        value.parent = parent;
      }
      return true;
    },
  });
  return proxy;
}

/**
 * Parser options.
 * @typedef {Object} ParserOptions
 * @property {string} [sourceName]
 * @property {boolean} [concrete]
 * @property {Function[]} [productions]
 * @property {Extensions} [extensions]
 */

/**
 * @param {Tokeniser} tokeniser
 * @param {ParserOptions} options
 */
function parseCallback(tokeniser, options) {
  const callback = tokeniser.consume("callback");
  if (!callback) return;
  if (tokeniser.probe("interface")) {
    return CallbackInterface.parse(tokeniser, callback, {
      ...options?.extensions?.callbackInterface,
    });
  }
  return CallbackFunction.parse(tokeniser, callback);
}

/**
 * @param {Tokeniser} tokeniser
 * @param {ParserOptions} options
 */
function parseInterface(tokeniser, options, opts) {
  const base = tokeniser.consume("interface");
  if (!base) return;
  return (
    Mixin.parse(tokeniser, base, {
      ...opts,
      ...options?.extensions?.mixin,
    }) ||
    Interface.parse(tokeniser, base, {
      ...opts,
      ...options?.extensions?.interface,
    }) ||
    tokeniser.error("Interface has no proper body")
  );
}

/**
 * @param {Tokeniser} tokeniser
 * @param {ParserOptions} options
 */
function parsePartial(tokeniser, options) {
  const partial = tokeniser.consume("partial");
  if (!partial) return;
  return (
    Dictionary.parse(tokeniser, {
      partial,
      ...options?.extensions?.dictionary,
    }) ||
    parseInterface(tokeniser, options, { partial }) ||
    Namespace.parse(tokeniser, {
      partial,
      ...options?.extensions?.namespace,
    }) ||
    tokeniser.error("Partial doesn't apply to anything")
  );
}

// These regular expressions use the sticky flag so they will only match at
// the current location (ie. the offset of lastIndex).
const tokenRe = {
  // This expression uses a lookahead assertion to catch false matches
  // against integers early.
  decimal:
    /-?(?=[0-9]*\.|[0-9]+[eE])(([0-9]+\.[0-9]*|[0-9]*\.[0-9]+)([Ee][-+]?[0-9]+)?|[0-9]+[Ee][-+]?[0-9]+)/y,
  integer: /-?(0([Xx][0-9A-Fa-f]+|[0-7]*)|[1-9][0-9]*)/y,
  identifier: /[-$_A-Za-z](\.?[$0-9A-Z_a-z-])*/y,
  string: /"(\\"|[^"])*"/y,
  whitespace: /[\t\n\r ]+/y,
  comment: /\/\/.*|\/\*[\s\S]*?\*\//y,
  other: /[^\t\n\r 0-9A-Za-z]/y,
};

const typeNameKeywords = [
  "ArrayBuffer",
  "SharedArrayBuffer",
  "DataView",
  "Int8Array",
  "Int16Array",
  "Int32Array",
  "Uint8Array",
  "Uint16Array",
  "Uint32Array",
  "Uint8ClampedArray",
  "BigInt64Array",
  "BigUint64Array",
  "Float16Array",
  "Float32Array",
  "Float64Array",
  "any",
  "object",
  "symbol",
];

const argumentNameKeywords = [
  "async",
  "attribute",
  "callback",
  "const",
  "constructor",
  "deleter",
  "dictionary",
  "enum",
  "getter",
  "includes",
  "inherit",
  "interface",
  "iterable",
  "maplike",
  "namespace",
  "partial",
  "required",
  "setlike",
  "setter",
  "static",
  "stringifier",
  "typedef",
  "unrestricted",
  "package",
  "import",
  "as",
  "version",
];

const nonRegexTerminals = [
  "-Infinity",
  "FrozenArray",
  "Infinity",
  "NaN",
  "ObservableArray",
  "Promise",
  "bigint",
  "boolean",
  "byte",
  "double",
  "false",
  "float",
  "long",
  "mixin",
  "null",
  "octet",
  "optional",
  "or",
  "readonly",
  "record",
  "sequence",
  "short",
  "true",
  "undefined",
  "unsigned",
  "void",
].concat(argumentNameKeywords);

const punctuations = [
  "(",
  ")",
  ",",
  "...",
  ":",
  ";",
  "<",
  "=",
  ">",
  "?",
  "*",
  "[",
  "]",
  "{",
  "}",
];

const reserved = [
  // "constructor" is now a keyword
  "_constructor",
];

/**
 * @typedef {ArrayItemType<ReturnType<typeof tokenise>>} Token
 * @param {string} str
 */
function tokenise(str) {
  const tokens = [];
  let lastCharIndex = 0;
  let trivia = "";
  let line = 1;
  let index = 0;
  while (lastCharIndex < str.length) {
    const nextChar = str.charAt(lastCharIndex);
    let result = -1;

    if (/[\t\n\r ]/.test(nextChar)) {
      result = attemptTokenMatch("whitespace", { noFlushTrivia: true });
    } else if (nextChar === "/") {
      result = attemptTokenMatch("comment", { noFlushTrivia: true });
    }

    if (result !== -1) {
      const currentTrivia = tokens.pop().value;
      line += (currentTrivia.match(/\n/g) || []).length;
      trivia += currentTrivia;
      index -= 1;
    } else if (/[-$0-9.A-Z_a-z]/.test(nextChar)) {
      result = attemptTokenMatch("decimal");
      if (result === -1) {
        result = attemptTokenMatch("integer");
      }
      if (result === -1) {
        result = attemptTokenMatch("identifier");
        const lastIndex = tokens.length - 1;
        const token = tokens[lastIndex];
        if (result !== -1) {
          if (reserved.includes(token.value)) {
            const message = `${unescape(token.value)} is a reserved identifier and must not be used.`;
            throw new WebIDLParseError(
              syntaxError(tokens, lastIndex, null, message),
            );
          } else if (nonRegexTerminals.includes(token.value)) {
            token.type = "inline";
          }
        }
      }
    } else if (nextChar === '"') {
      result = attemptTokenMatch("string");
    }

    for (const punctuation of punctuations) {
      if (str.startsWith(punctuation, lastCharIndex)) {
        tokens.push({
          type: "inline",
          value: punctuation,
          trivia,
          line,
          index,
          position: lastCharIndex,
        });
        trivia = "";
        lastCharIndex += punctuation.length;
        result = lastCharIndex;
        break;
      }
    }

    // other as the last try
    if (result === -1) {
      result = attemptTokenMatch("other");
    }
    if (result === -1) {
      throw new Error("Token stream not progressing");
    }
    lastCharIndex = result;
    index += 1;
  }

  // remaining trivia as eof
  tokens.push({
    type: "eof",
    value: "",
    trivia,
    line,
    index,
    position: lastCharIndex,
  });

  return tokens;

  /**
   * @param {keyof typeof tokenRe} type
   * @param {object} options
   * @param {boolean} [options.noFlushTrivia]
   */
  function attemptTokenMatch(type, { noFlushTrivia } = {}) {
    const re = tokenRe[type];
    re.lastIndex = lastCharIndex;
    const result = re.exec(str);
    if (result) {
      tokens.push({
        type,
        value: result[0],
        trivia,
        line,
        index,
        position: lastCharIndex,
      });
      if (!noFlushTrivia) {
        trivia = "";
      }
      return re.lastIndex;
    }
    return -1;
  }
}

class Tokeniser {
  /**
   * @param {string} idl
   */
  constructor(idl) {
    this.source = tokenise(idl);
    this.position = 0;
  }

  /**
   * @param {string} message
   * @return {never}
   */
  error(message) {
    throw new WebIDLParseError(
      syntaxError(this.source, this.position, this.current, message),
    );
  }

  /**
   * @param {string} type
   */
  probeKind(type) {
    return (
      this.source.length > this.position &&
      this.source[this.position].type === type
    );
  }

  /**
   * @param {string} value
   */
  probe(value) {
    return (
      this.probeKind("inline") && this.source[this.position].value === value
    );
  }

  /**
   * @param {...string} candidates
   */
  consumeKind(...candidates) {
    for (const type of candidates) {
      if (!this.probeKind(type)) continue;
      const token = this.source[this.position];
      this.position++;
      return token;
    }
  }

  /**
   * @param {...string} candidates
   */
  consume(...candidates) {
    if (!this.probeKind("inline")) return;
    const token = this.source[this.position];
    for (const value of candidates) {
      if (token.value !== value) continue;
      this.position++;
      return token;
    }
  }

  /**
   * @param {string} value
   */
  consumeIdentifier(value) {
    if (!this.probeKind("identifier")) {
      return;
    }
    if (this.source[this.position].value !== value) {
      return;
    }
    return this.consumeKind("identifier");
  }

  /**
   * @param {number} position
   */
  unconsume(position) {
    this.position = position;
  }
}

class WebIDLParseError extends Error {
  /**
   * @param {object} options
   * @param {string} options.message
   * @param {string} options.bareMessage
   * @param {string} options.context
   * @param {number} options.line
   * @param {*} options.sourceName
   * @param {string} options.input
   * @param {*[]} options.tokens
   */
  constructor({
    message,
    bareMessage,
    context,
    line,
    sourceName,
    input,
    tokens,
  }) {
    super(message);

    this.name = "WebIDLParseError"; // not to be mangled
    this.bareMessage = bareMessage;
    this.context = context;
    this.line = line;
    this.sourceName = sourceName;
    this.input = input;
    this.tokens = tokens;
  }
}

class Includes extends Base {
  /**
   * @param {import("../tokeniser.js").Tokeniser} tokeniser
   */
  static parse(tokeniser) {
    const target = tokeniser.consumeKind("identifier");
    if (!target) {
      return;
    }
    const tokens = { target };
    tokens.includes = tokeniser.consume("includes");
    if (!tokens.includes) {
      tokeniser.unconsume(target.index);
      return;
    }
    tokens.mixin =
      tokeniser.consumeKind("identifier") ||
      tokeniser.error("Incomplete includes statement");
    tokens.termination =
      tokeniser.consume(";") ||
      tokeniser.error("No terminating ; for includes statement");
    return new Includes({ source: tokeniser.source, tokens });
  }

  get type() {
    return "includes";
  }
  get target() {
    return unescape(this.tokens.target.value);
  }
  get includes() {
    return unescape(this.tokens.mixin.value);
  }

  /** @param {import("../writer.js").Writer} w */
  write(w) {
    return w.ts.definition(
      w.ts.wrap([
        this.extAttrs.write(w),
        w.reference_token(this.tokens.target, this),
        w.token(this.tokens.includes),
        w.reference_token(this.tokens.mixin, this),
        w.token(this.tokens.termination),
      ]),
      { data: this },
    );
  }
}

class Package extends Base {
  static parse(tokeniser) {
    const packageKeyword = tokeniser.consume("package");
    if (!packageKeyword) {
      return;
    }
    const tokens = { base: packageKeyword };
    tokens.clause =
      tokeniser.consumeKind("string") ||
      tokeniser.consumeKind("identifier") ||
      tokeniser.error("No clause for package");
    tokens.termination =
      tokeniser.consume(";") || tokeniser.error("No semicolon after package");
    const ret = autoParenter(new Package({ source: tokeniser.source, tokens }));
    ret.clause = tokens.clause.value;
    return ret.this;
  }

  get type() {
    return "package";
  }

  write(w) {
    return w.ts.definition(
      w.ts.wrap([
        w.token(this.tokens.base),
        w.reference_token(this.tokens.clause, this),
        w.token(this.tokens.termination),
      ]),
      { data: this },
    );
  }
}

class Import extends Base {
  static parse(tokeniser) {
    const importKeyword = tokeniser.consume("import");
    if (!importKeyword) {
      return;
    }
    const tokens = { import: importKeyword };
    tokens.clause =
      tokeniser.consumeKind("string") ||
      tokeniser.consumeKind("identifier") ||
      tokeniser.error("Incomplete import statement");
    tokens.as = tokeniser.consume("as");
    if (tokens.as)
      tokens.alias =
        tokeniser.consumeKind("identifier") ||
        tokeniser.error("Incomplete import statement");
    tokens.termination =
      tokeniser.consume(";") ||
      tokeniser.error("No terminating ; for import statement");
    const ret = autoParenter(new Import({ source: tokeniser.source, tokens }));
    ret.clause = tokens.clause.value;
    ret.alias = tokens.alias?.value;
    return ret.this;
  }

  get type() {
    return "import";
  }

  write(w) {
    return w.ts.definition(
      w.ts.wrap([
        w.token(this.tokens.import),
        w.reference_token(this.tokens.clause, this),
        w.token(this.tokens.as),
        w.token(this.tokens.alias),
        w.token(this.tokens.termination),
      ]),
      { data: this },
    );
  }
}

/** @typedef {import("./productions/helpers.js").ParserOptions} ParserOptions */

/**
 * @param {Tokeniser} tokeniser
 * @param {ParserOptions} options
 */
function parseByTokens(tokeniser, options) {
  const source = tokeniser.source;

  function definition() {
    if (options.productions) {
      for (const production of options.productions) {
        const result = production(tokeniser);
        if (result) {
          return result;
        }
      }
    }

    return (
      parseCallback(tokeniser, options) ||
      parseInterface(tokeniser, options) ||
      parsePartial(tokeniser, options) ||
      Dictionary.parse(tokeniser, options?.extensions?.dictionary) ||
      Enum.parse(tokeniser) ||
      Typedef.parse(tokeniser) ||
      Includes.parse(tokeniser) ||
      Package.parse(tokeniser) ||
      Import.parse(tokeniser) ||
      Namespace.parse(tokeniser, options?.extensions?.namespace) ||
      Version.parse(tokeniser) ||
      Attribute.parse(tokeniser, { noInherit: true, readonly: true }) ||
      Constant.parse(tokeniser) ||
      Operation.parse(tokeniser, { regular: true, noneOnFail: true })
    );
  }

  function definitions() {
    if (!source.length) return [];
    const defs = [];
    while (true) {
      const psu1 = ParserState.update(tokeniser);
      if (psu1) defs.push(psu1);
      const ea = ExtendedAttributes.parse(tokeniser);
      const def = definition();
      if (!def) {
        if (ea.length) tokeniser.error("Stray extended attributes");
        break;
      }
      autoParenter(def).extAttrs = ea;
      defs.push(def);

      const psu2 = ParserState.update(tokeniser);
      if (psu2) defs.push(psu2);
    }
    const eof = Eof.parse(tokeniser);
    if (options.concrete) {
      defs.push(eof);
    }
    return defs;
  }

  const res = definitions();
  if (tokeniser.position < source.length)
    tokeniser.error("Unrecognised tokens");
  return res;
}

/**
 * @param {string} str
 * @param {ParserOptions} [options]
 */
function parse(str, options = {}) {
  const tokeniser = new Tokeniser(str);
  if (typeof options.sourceName !== "undefined") {
    // @ts-ignore (See Tokeniser.source in supplement.d.ts)
    tokeniser.source.name = options.sourceName;
  }
  return parseByTokens(tokeniser, options);
}

/**
 * @param {string} str
 * @param {string} fileName
 */
function parseType(str, fileName) {
  const tokeniser = new Tokeniser(str);
  // @ts-ignore (See Tokeniser.source in supplement.d.ts)
  tokeniser.source.name = fileName;
  return (
    type_with_extended_attributes(tokeniser, "type") ||
    return_type(tokeniser, "return-type")
  );
}

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
class Language {
    constructor(name, extension, needsUnionDiscrimination) {
        this.name = name;
        this.extension = extension;
        this.needsUnionDiscrimination = needsUnionDiscrimination;
    }
    toString() {
        return this.name;
    }
    get directory() {
        return this.name.toLowerCase();
    }
    static fromString(name) {
        switch (name) {
            case "arkts": return Language.ARKTS;
            case "java": return Language.JAVA;
            case "ts": return Language.TS;
            case "cangjie": return Language.CJ;
            case "cpp": return Language.CPP;
            case "kotlin": return Language.KOTLIN;
            default: throw new Error(`Unsupported language ${name}`);
        }
    }
}
Language.TS = new Language("TS", ".ts", true);
Language.ARKTS = new Language("ArkTS", ".ts", true); // using .ts for ArkTS until we get rit of tsc preprocessing
Language.JAVA = new Language("Java", ".java", false);
Language.CPP = new Language("C++", ".cc", false);
Language.CJ = new Language("CangJie", ".cj", false);
Language.KOTLIN = new Language("Kotlin", ".kt", false);

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
function generateSyntheticIdlNodeName(type) {
    if (isPrimitiveType(type))
        return capitalize(type.name);
    if (isContainerType(type)) {
        const typeArgs = type.elementType.map(it => generateSyntheticIdlNodeName(it)).join("_").replaceAll(".", "_");
        switch (type.containerKind) {
            case "sequence": return "Array_" + typeArgs;
            case "record": return "Map_" + typeArgs;
            case "Promise": return "Promise_" + typeArgs;
            default: throw new Error(`Unknown container type ${DebugUtils.debugPrintType(type)}`);
        }
    }
    if (isNamedNode(type))
        return type.name.split('.').map(capitalize).join('_');
    if (isOptionalType(type))
        return `Opt_${generateSyntheticIdlNodeName(type.type)}`;
    throw `Can not compute type name of ${IDLKind[type.kind]}`;
}
function qualifiedName(decl, languageOrDelimiter, pattern) {
    if (!isNamedNode(decl))
        throw new Error("internal error, name required for no-named node");
    const delimiter = languageOrDelimiter
        ;
    if (!isEntry(decl))
        throw new Error(`Expected to have an IDLEntry, got ${IDLKind[decl.kind]}`);
    return getQualifiedName(decl, pattern).split(".").join(delimiter);
}
function collapseTypes(types, name) {
    const seenNames = new Set();
    const uniqueTypes = types.filter(it => {
        const typeName = printType(it);
        if (seenNames.has(typeName))
            return false;
        seenNames.add(typeName);
        return true;
    });
    return uniqueTypes.length === 1 ? uniqueTypes[0] : createUnionType(uniqueTypes, name);
}
function generateSyntheticUnionName(types) {
    return `Union_${types.map(it => generateSyntheticIdlNodeName(it)).join("_").replaceAll(".", "_")}`;
}
function generateSyntheticFunctionParameterName(parameter) {
    if (parameter.isOptional) {
        return generateSyntheticIdlNodeName(createOptionalType(parameter.type));
    }
    return generateSyntheticIdlNodeName(parameter.type);
}
function generateSyntheticFunctionName(parameters, returnType, isAsync = false) {
    let prefix = isAsync ? "AsyncCallback" : "Callback";
    const names = parameters.map(generateSyntheticFunctionParameterName).concat(generateSyntheticIdlNodeName(returnType));
    return `${prefix}_${names.join("_").replaceAll(".", "_")}`;
}
function isImportAttr(decl) {
    return hasExtAttribute(decl, IDLExtendedAttributes.Import);
}

// See https://en.cppreference.com/w/cpp/keyword.
const cppKeywords = new Set([
    `alignas`, `alignof`, `and`,
    `and_eq`, `asm`, `atomic_cancel`, `atomic_commit`,
    `atomic_noexcept`, `auto`, `bitand`, `bitor`, `bool`,
    `break`, `case`, `catch`, `char`, `char8_t`, `char16_t`,
    `char32_t`, `class`, `compl`, `concept`, `const`, `consteval`,
    `constexpr`, `constinit`, `const_cast`, `continue`, `co_await`,
    `co_return`, `co_yield`, `decltype`, `default`, `delete`, `do`,
    `double`, `dynamic_cast`, `else`, `enum`, `explicit`, `export`,
    `extern`, `false`, `float`, `for`, `friend`, `goto`, `if`,
    `inline`, `int`, `long`, `mutable`, `namespace`, `new`, `noexcept`,
    `not`, `not_eq`, `nullptr`, `operator`, `or`, `or_eq`, `private`,
    `protected`, `public`, `reflexpr`, `register`, `reinterpret_cast`,
    `requires`, `return`, `short`, `signed`,
    `sizeof`, `static`, `static_assert`, `static_cast`,
    `struct`, `switch`, `synchronized`, `template`,
    `this`, `thread_local`, `throw`, `true`, `try`,
    `typedef`, `typeid`, `typename`, `union`,
    `unsigned`, `using`, `virtual`, `void`,
    `volatile`, `wchar_t`, `while`, `xor`,
    `xor_eq`
]);
const CJKeywords = new Set([
    'Int8', 'Int16', 'Int32', 'Int64', 'IntNative',
    'UInt8', 'UInt16', 'UInt32', 'UInt64', 'UIntNative',
    'Float16', 'Float32', 'Float64', 'Rune',
    'Bool', 'Unit', 'Nothing', 'struct',
    'enum', 'This', 'package', 'import',
    'class', 'interface', 'func', 'main',
    'let', 'var', 'const', 'type', 'init',
    'this', 'super', 'if', 'else', 'case',
    'try', 'catch', 'finally', 'for', 'do',
    'while', 'throw', 'return', 'continue',
    'break', 'is', 'as', 'in', 'match',
    'from', 'where', 'extend', 'spawn',
    'synchronized', 'macro', 'quote', 'true',
    /*'false', */ 'static', 'public', 'private',
    'protected', 'override', 'redef', 'abstract',
    'open', 'operator', 'foreign', 'inout',
    'prop', 'mut', 'unsafe', 'get', 'set', 'type'
]);
const TSKeywords = new Set([
    "namespace"
]);

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
var IDLKind;
(function (IDLKind) {
    IDLKind["Interface"] = "Interface";
    IDLKind["Import"] = "Import";
    IDLKind["Callback"] = "Callback";
    IDLKind["Const"] = "Const";
    IDLKind["Property"] = "Property";
    IDLKind["Parameter"] = "Parameter";
    IDLKind["Method"] = "Method";
    IDLKind["Callable"] = "Callable";
    IDLKind["Constructor"] = "Constructor";
    IDLKind["Enum"] = "Enum";
    IDLKind["EnumMember"] = "EnumMember";
    IDLKind["Typedef"] = "Typedef";
    IDLKind["PrimitiveType"] = "PrimitiveType";
    IDLKind["ContainerType"] = "ContainerType";
    IDLKind["UnspecifiedGenericType"] = "UnspecifiedGenericType";
    IDLKind["ReferenceType"] = "ReferenceType";
    IDLKind["UnionType"] = "UnionType";
    IDLKind["TypeParameterType"] = "TypeParameterType";
    IDLKind["OptionalType"] = "OptionalType";
    IDLKind["Version"] = "Version";
    IDLKind["Namespace"] = "Namespace";
    IDLKind["File"] = "File";
})(IDLKind || (IDLKind = {}));
var IDLEntity;
(function (IDLEntity) {
    IDLEntity["Class"] = "Class";
    IDLEntity["Interface"] = "Interface";
    IDLEntity["Import"] = "Import";
    IDLEntity["Intersection"] = "Intersection";
    IDLEntity["Literal"] = "Literal";
    IDLEntity["NamedTuple"] = "NamedTuple";
    IDLEntity["Tuple"] = "Tuple";
})(IDLEntity || (IDLEntity = {}));
var IDLExtendedAttributes;
(function (IDLExtendedAttributes) {
    IDLExtendedAttributes["Accessor"] = "Accessor";
    IDLExtendedAttributes["Async"] = "Async";
    IDLExtendedAttributes["CallSignature"] = "CallSignature";
    IDLExtendedAttributes["CommonMethod"] = "CommonMethod";
    IDLExtendedAttributes["Component"] = "Component";
    IDLExtendedAttributes["ComponentInterface"] = "ComponentInterface";
    IDLExtendedAttributes["Deprecated"] = "Deprecated";
    IDLExtendedAttributes["Documentation"] = "Documentation";
    IDLExtendedAttributes["DtsName"] = "DtsName";
    IDLExtendedAttributes["DtsTag"] = "DtsTag";
    IDLExtendedAttributes["Entity"] = "Entity";
    IDLExtendedAttributes["Extends"] = "Extends";
    IDLExtendedAttributes["Import"] = "Import";
    IDLExtendedAttributes["DefaultExport"] = "DefaultExport";
    IDLExtendedAttributes["IndexSignature"] = "IndexSignature";
    IDLExtendedAttributes["Interfaces"] = "Interfaces";
    IDLExtendedAttributes["NativeModule"] = "NativeModule";
    IDLExtendedAttributes["Optional"] = "Optional";
    IDLExtendedAttributes["OriginalEnumMemberName"] = "OriginalEnumMemberName";
    IDLExtendedAttributes["Predefined"] = "Predefined";
    IDLExtendedAttributes["Protected"] = "Protected";
    IDLExtendedAttributes["Synthetic"] = "Synthetic";
    IDLExtendedAttributes["Throws"] = "Throws";
    IDLExtendedAttributes["TraceKey"] = "TraceKey";
    IDLExtendedAttributes["TypeArguments"] = "TypeArguments";
    IDLExtendedAttributes["TypeParameters"] = "TypeParameters";
    IDLExtendedAttributes["VerbatimDts"] = "VerbatimDts";
    IDLExtendedAttributes["HandWrittenImplementation"] = "HandWrittenImplementation";
    IDLExtendedAttributes["ExtraMethod"] = "ExtraMethod";
})(IDLExtendedAttributes || (IDLExtendedAttributes = {}));
var IDLAccessorAttribute;
(function (IDLAccessorAttribute) {
    IDLAccessorAttribute["Getter"] = "Getter";
    IDLAccessorAttribute["Setter"] = "Setter";
})(IDLAccessorAttribute || (IDLAccessorAttribute = {}));
const innerIdlSymbol = Symbol("innerIdlSymbol");
var IDLInterfaceSubkind;
(function (IDLInterfaceSubkind) {
    IDLInterfaceSubkind[IDLInterfaceSubkind["Interface"] = 0] = "Interface";
    IDLInterfaceSubkind[IDLInterfaceSubkind["Class"] = 1] = "Class";
    IDLInterfaceSubkind[IDLInterfaceSubkind["AnonymousInterface"] = 2] = "AnonymousInterface";
    IDLInterfaceSubkind[IDLInterfaceSubkind["Tuple"] = 3] = "Tuple";
})(IDLInterfaceSubkind || (IDLInterfaceSubkind = {}));
function forEachChild(node, cbEnter, cbLeave) {
    var _a, _b, _c;
    const cleanup = cbEnter(node);
    switch (node.kind) {
        case IDLKind.File:
            node.entries.forEach((value) => forEachChild(value, cbEnter, cbLeave));
            break;
        case IDLKind.Namespace:
            node.members.forEach((value) => forEachChild(value, cbEnter, cbLeave));
            break;
        case IDLKind.Interface: {
            let concrete = node;
            concrete.inheritance.forEach((value) => forEachChild(value, cbEnter, cbLeave));
            concrete.constructors.forEach((value) => forEachChild(value, cbEnter, cbLeave));
            concrete.properties.forEach((value) => forEachChild(value, cbEnter, cbLeave));
            concrete.methods.forEach((value) => forEachChild(value, cbEnter, cbLeave));
            concrete.callables.forEach((value) => forEachChild(value, cbEnter, cbLeave));
            break;
        }
        case IDLKind.Method:
        case IDLKind.Callable:
        case IDLKind.Callback:
        case IDLKind.Constructor: {
            let concrete = node;
            (_a = concrete.parameters) === null || _a === void 0 ? void 0 : _a.forEach((value) => forEachChild(value, cbEnter, cbLeave));
            if (concrete.returnType)
                forEachChild(concrete.returnType, cbEnter, cbLeave);
            break;
        }
        case IDLKind.UnionType: {
            let concrete = node;
            (_b = concrete.types) === null || _b === void 0 ? void 0 : _b.forEach((value) => forEachChild(value, cbEnter, cbLeave));
            break;
        }
        case IDLKind.OptionalType: {
            let concrete = node;
            forEachChild(concrete.type, cbEnter, cbLeave);
            break;
        }
        case IDLKind.Const: {
            forEachChild(node.type, cbEnter, cbLeave);
            break;
        }
        case IDLKind.Enum: {
            node.elements.forEach((value) => forEachChild(value, cbEnter, cbLeave));
            break;
        }
        case IDLKind.Property: {
            forEachChild(node.type, cbEnter, cbLeave);
            break;
        }
        case IDLKind.Parameter: {
            const concrete = node;
            if (concrete.type)
                forEachChild(concrete.type, cbEnter, cbLeave);
            break;
        }
        case IDLKind.Typedef: {
            forEachChild(node.type, cbEnter, cbLeave);
            break;
        }
        case IDLKind.ContainerType: {
            node.elementType.forEach((value) => forEachChild(value, cbEnter, cbLeave));
            break;
        }
        case IDLKind.UnspecifiedGenericType: {
            node.typeArguments.forEach((value) => forEachChild(value, cbEnter, cbLeave));
            break;
        }
        case IDLKind.ReferenceType: {
            (_c = node.typeArguments) === null || _c === void 0 ? void 0 : _c.forEach((value) => forEachChild(value, cbEnter, cbLeave));
            break;
        }
        case IDLKind.TypeParameterType:
        case IDLKind.EnumMember:
        case IDLKind.Import:
        case IDLKind.PrimitiveType:
        case IDLKind.Version:
            break;
        default: {
            throw new Error(`Unhandled ${node.kind}`);
        }
    }
    cbLeave === null || cbLeave === void 0 ? void 0 : cbLeave(node);
    cleanup === null || cleanup === void 0 ? void 0 : cleanup();
}
/** Updates tree in place! */
function updateEachChild(node, op, cbLeave) {
    var _a;
    const old = node;
    node = op(old);
    if (node.kind !== old.kind) {
        throw new Error("Kinds must be the same!");
    }
    switch (node.kind) {
        case IDLKind.File: {
            const concrete = node;
            concrete.entries = concrete.entries.map(it => updateEachChild(it, op, cbLeave));
            break;
        }
        case IDLKind.Namespace: {
            const concrete = node;
            concrete.members = concrete.members.map((it) => updateEachChild(it, op, cbLeave));
            break;
        }
        case IDLKind.Interface: {
            const concrete = node;
            concrete.inheritance = concrete.inheritance.map((it) => updateEachChild(it, op, cbLeave));
            concrete.constructors = concrete.constructors.map((it) => updateEachChild(it, op, cbLeave));
            concrete.properties = concrete.properties.map((it) => updateEachChild(it, op, cbLeave));
            concrete.methods = concrete.methods.map((it) => updateEachChild(it, op, cbLeave));
            concrete.callables = concrete.callables.map((it) => updateEachChild(it, op, cbLeave));
            break;
        }
        case IDLKind.Method:
        case IDLKind.Callable:
        case IDLKind.Callback:
        case IDLKind.Constructor: {
            const concrete = node;
            concrete.parameters = concrete.parameters.map((it) => updateEachChild(it, op, cbLeave));
            if (concrete.returnType) {
                concrete.returnType = updateEachChild(concrete.returnType, op, cbLeave);
            }
            break;
        }
        case IDLKind.UnionType: {
            const concrete = node;
            concrete.types = concrete.types.map((it) => updateEachChild(it, op, cbLeave));
            break;
        }
        case IDLKind.OptionalType: {
            const concrete = node;
            concrete.type = updateEachChild(concrete.type, op, cbLeave);
            break;
        }
        case IDLKind.Const: {
            const concrete = node;
            concrete.type = updateEachChild(concrete.type, op, cbLeave);
            break;
        }
        case IDLKind.Enum: {
            const concrete = node;
            concrete.elements = concrete.elements.map((it) => updateEachChild(it, op, cbLeave));
            break;
        }
        case IDLKind.Property: {
            const concrete = node;
            concrete.type = updateEachChild(concrete.type, op, cbLeave);
            break;
        }
        case IDLKind.Parameter: {
            const concrete = node;
            if (concrete.type)
                concrete.type = updateEachChild(concrete.type, op, cbLeave);
            break;
        }
        case IDLKind.Typedef: {
            const concrete = node;
            concrete.type = updateEachChild(concrete.type, op, cbLeave);
            break;
        }
        case IDLKind.ContainerType: {
            const concrete = node;
            concrete.elementType = concrete.elementType.map(it => updateEachChild(it, op, cbLeave));
            break;
        }
        case IDLKind.UnspecifiedGenericType: {
            const concrete = node;
            concrete.typeArguments = concrete.typeArguments.map(it => updateEachChild(it, op, cbLeave));
            break;
        }
        case IDLKind.ReferenceType: {
            const concrete = node;
            concrete.typeArguments = (_a = concrete.typeArguments) === null || _a === void 0 ? void 0 : _a.map(it => updateEachChild(it, op, cbLeave));
            break;
        }
        case IDLKind.TypeParameterType:
        case IDLKind.EnumMember:
        case IDLKind.Import:
        case IDLKind.PrimitiveType:
        case IDLKind.Version:
            break;
        default: {
            throw new Error(`Unhandled ${node.kind}`);
        }
    }
    if (cbLeave) {
        cbLeave === null || cbLeave === void 0 ? void 0 : cbLeave(node);
    }
    return node;
}
function isNamedNode(type) {
    return "_idlNamedNodeBrand" in type;
}
function forceAsNamedNode(type) {
    if (!isNamedNode(type)) {
        throw new Error(`Expected to be an IDLNamedNode, but got '${IDLKind[type.kind]}'`);
    }
    return type;
}
function isFile(node) {
    return node.kind === IDLKind.File;
}
function isVoidType(type) {
    return isPrimitiveType(type) && type.name === IDLVoidType.name;
}
function isPrimitiveType(type) {
    return type.kind == IDLKind.PrimitiveType;
}
function isContainerType(type) {
    return type.kind == IDLKind.ContainerType;
}
function isReferenceType(type) {
    return type.kind == IDLKind.ReferenceType;
}
function isUnspecifiedGenericType(type) {
    return type.kind == IDLKind.UnspecifiedGenericType;
}
function isEnum$1(type) {
    return type.kind == IDLKind.Enum;
}
function isEnumMember(type) {
    return type.kind == IDLKind.EnumMember;
}
function isUnionType(type) {
    return type.kind == IDLKind.UnionType;
}
function isTypeParameterType(type) {
    return type.kind == IDLKind.TypeParameterType;
}
function isInterface$1(node) {
    return node.kind === IDLKind.Interface;
}
function isImport(type) {
    return type.kind == IDLKind.Import;
}
function isCallable(node) {
    return node.kind === IDLKind.Callable;
}
function isMethod(node) {
    return node.kind === IDLKind.Method;
}
function isParameter(node) {
    return node.kind === IDLKind.Parameter;
}
function isConstructor$1(node) {
    return node.kind === IDLKind.Constructor;
}
function isProperty(node) {
    return node.kind === IDLKind.Property;
}
function isCallback$1(node) {
    return node.kind === IDLKind.Callback;
}
function isInterfaceSubkind(idl) {
    return idl.subkind === IDLInterfaceSubkind.Interface;
}
function isClassSubkind(idl) {
    return idl.subkind === IDLInterfaceSubkind.Class;
}
function isConstant$1(node) {
    return node.kind === IDLKind.Const;
}
function isTypedef$1(node) {
    return node.kind === IDLKind.Typedef;
}
function isType(node) {
    return "_idlTypeBrand" in node;
}
function isEntry(node) {
    return "_idlEntryBrand" in node;
}
function isNamespace(node) {
    return node.kind === IDLKind.Namespace;
}
function isSyntheticEntry(node) {
    var _a;
    return isDefined((_a = node.extendedAttributes) === null || _a === void 0 ? void 0 : _a.find(it => it.name === IDLExtendedAttributes.Synthetic));
}
function isOptionalType(type) {
    return type.kind === IDLKind.OptionalType;
}
function isVersion(node) {
    return node.kind === IDLKind.Version;
}
function createPrimitiveType(name) {
    return {
        kind: IDLKind.PrimitiveType,
        name: name,
        _idlNodeBrand: innerIdlSymbol,
        _idlTypeBrand: innerIdlSymbol,
        _idlNamedNodeBrand: innerIdlSymbol,
    };
}
function createOptionalType(element, nodeInitializer) {
    if (isOptionalType(element) && !nodeInitializer) {
        return element;
    }
    if (isOptionalType(element)) {
        return Object.assign(Object.assign({ kind: IDLKind.OptionalType, type: element.type }, nodeInitializer), { _idlNodeBrand: innerIdlSymbol, _idlTypeBrand: innerIdlSymbol });
    }
    return Object.assign(Object.assign({ kind: IDLKind.OptionalType, type: element }, nodeInitializer), { _idlNodeBrand: innerIdlSymbol, _idlTypeBrand: innerIdlSymbol });
}
// must match with toIDLType in deserialize.ts
const IDLPointerType = createPrimitiveType('pointer');
const IDLVoidType = createPrimitiveType('void');
const IDLBooleanType = createPrimitiveType('boolean');
const IDLI8Type = createPrimitiveType('i8');
const IDLU8Type = createPrimitiveType('u8');
const IDLI16Type = createPrimitiveType('i16');
const IDLU16Type = createPrimitiveType('u16');
const IDLI32Type = createPrimitiveType('i32');
const IDLU32Type = createPrimitiveType('u32');
const IDLI64Type = createPrimitiveType('i64');
const IDLU64Type = createPrimitiveType('u64');
const IDLF16Type = createPrimitiveType('f16');
const IDLF32Type = createPrimitiveType('f32');
const IDLF64Type = createPrimitiveType('f64');
const IDLBigintType = createPrimitiveType("bigint");
const IDLNumberType = createPrimitiveType('number');
const IDLStringType = createPrimitiveType('String');
const IDLAnyType = createPrimitiveType('any');
const IDLUndefinedType = createPrimitiveType('undefined');
const IDLUnknownType = createPrimitiveType('unknown');
const IDLObjectType = createPrimitiveType('Object');
const IDLThisType = createPrimitiveType('this');
const IDLDate = createPrimitiveType('date');
const IDLBufferType = createPrimitiveType('buffer');
createContainerType('sequence', [IDLU8Type]);
const IDLSerializerBuffer = createPrimitiveType('SerializerBuffer');
// Stub for IdlPeerLibrary
const IDLFunctionType = createPrimitiveType('Function');
const IDLCustomObjectType = createPrimitiveType('CustomObject');
const IDLInteropReturnBufferType = createPrimitiveType('InteropReturnBuffer');
function createNamespace(name, members, nodeInitializer) {
    return Object.assign(Object.assign({ kind: IDLKind.Namespace, members: members !== null && members !== void 0 ? members : [], name: name }, nodeInitializer), { _idlNodeBrand: innerIdlSymbol, _idlEntryBrand: innerIdlSymbol, _idlNamedNodeBrand: innerIdlSymbol });
}
function linkParentBack(node) {
    const parentStack = [];
    updateEachChild(node, (node) => {
        if (isPrimitiveType(node)) {
            return node;
        }
        if (parentStack.length) {
            const top = parentStack[parentStack.length - 1];
            if (node.parent !== undefined && node.parent !== top) {
                node = clone(node);
            }
            node.parent = top;
        }
        parentStack.push(node);
        return node;
    }, (node) => {
        if (isPrimitiveType(node)) {
            return;
        }
        parentStack.pop();
    });
    return node;
}
function getNamespacesPathFor(node) {
    let iterator = node.parent;
    const result = [];
    while (iterator) {
        if (isNamespace(iterator))
            result.unshift(iterator);
        iterator = iterator.parent;
    }
    return result;
}
function getFileFor(node) {
    let iterator = node;
    while (iterator) {
        if (isFile(iterator))
            return iterator;
        iterator = iterator.parent;
    }
    console.warn(`Node ${getQualifiedName(node, "namespace.name")} does not have IDLFile in parents`);
    return undefined;
}
function getPackageClause(node) {
    var _a;
    const file = getFileFor(node);
    return (_a = file === null || file === void 0 ? void 0 : file.packageClause) !== null && _a !== void 0 ? _a : [];
}
function getPackageName(node) {
    return getPackageClause(node).join(".");
}
function isInPackage(entry, packageName, exactMatch = false) {
    const entryPackageName = getPackageName(entry);
    return exactMatch
        ? entryPackageName === packageName
        : entryPackageName.startsWith(packageName);
}
function getNamespaceName(a) {
    return getNamespacesPathFor(a).map(it => it.name).join('.');
}
function getQualifiedName(a, pattern) {
    const result = [];
    if ("package.namespace.name" === pattern)
        result.push(...getPackageClause(a), ...getNamespacesPathFor(a).map(it => it.name));
    else if ("namespace.name" === pattern)
        result.push(...getNamespacesPathFor(a).map(it => it.name));
    if (isNamedNode(a) && a.name)
        result.push(a.name);
    return result.join(".");
}
function getFQName(a) {
    return getQualifiedName(a, "package.namespace.name");
}
function createVersion(value, nodeInitializer) {
    return Object.assign(Object.assign({ kind: IDLKind.Version, value, name: "version" }, nodeInitializer), { _idlNodeBrand: innerIdlSymbol, _idlEntryBrand: innerIdlSymbol, _idlNamedNodeBrand: innerIdlSymbol });
}
function createReferenceType(nameOrSource, typeArguments, nodeInitializer) {
    let name;
    if (typeof nameOrSource === 'string') {
        name = nameOrSource;
    }
    else {
        name = getFQName(nameOrSource);
    }
    return Object.assign(Object.assign({ kind: IDLKind.ReferenceType, name,
        typeArguments }, nodeInitializer), { _idlNodeBrand: innerIdlSymbol, _idlTypeBrand: innerIdlSymbol, _idlNamedNodeBrand: innerIdlSymbol });
}
function createUnspecifiedGenericType(name, typeArguments, nodeInitializer) {
    return Object.assign(Object.assign({ kind: IDLKind.UnspecifiedGenericType, name,
        typeArguments }, nodeInitializer), { _idlNodeBrand: innerIdlSymbol, _idlTypeBrand: innerIdlSymbol, _idlNamedNodeBrand: innerIdlSymbol });
}
function createContainerType(container, element, nodeInitializer) {
    return Object.assign(Object.assign({ kind: IDLKind.ContainerType, containerKind: container, elementType: element }, nodeInitializer), { _idlNodeBrand: innerIdlSymbol, _idlTypeBrand: innerIdlSymbol });
}
function createUnionType(types, name, nodeInitializer) {
    if (types.length < 2)
        throw new Error("IDLUnionType should contain at least 2 types");
    return Object.assign(Object.assign({ kind: IDLKind.UnionType, name: name !== null && name !== void 0 ? name : "Union_" + types.map(it => generateSyntheticIdlNodeName(it)).join("_"), types: types }, nodeInitializer), { _idlNodeBrand: innerIdlSymbol, _idlTypeBrand: innerIdlSymbol, _idlNamedNodeBrand: innerIdlSymbol });
}
function createFile(entries, fileName, packageClause = [], nodeInitializer) {
    return Object.assign(Object.assign({ kind: IDLKind.File, packageClause, entries: entries, fileName }, nodeInitializer), { _idlNodeBrand: innerIdlSymbol });
}
function createImport(clause, name, nodeInitializer) {
    return Object.assign(Object.assign({ kind: IDLKind.Import, name: name !== null && name !== void 0 ? name : "", clause }, nodeInitializer), { _idlNodeBrand: innerIdlSymbol, _idlEntryBrand: innerIdlSymbol, _idlNamedNodeBrand: innerIdlSymbol });
}
function createEnum(name, elements, nodeInitializer) {
    return Object.assign(Object.assign({ kind: IDLKind.Enum, name: name, elements: elements }, nodeInitializer), { _idlNodeBrand: innerIdlSymbol, _idlEntryBrand: innerIdlSymbol, _idlNamedNodeBrand: innerIdlSymbol });
}
function createEnumMember(name, parent, type, initializer, nodeInitializer = {}) {
    return Object.assign(Object.assign({ kind: IDLKind.EnumMember, name: name, parent,
        type,
        initializer }, nodeInitializer), { _idlNodeBrand: innerIdlSymbol, _idlEntryBrand: innerIdlSymbol, _idlNamedNodeBrand: innerIdlSymbol });
}
function createInterface(name, subkind, inheritance = [], constructors = [], constants = [], properties = [], methods = [], callables = [], typeParameters = [], nodeInitializer = {}) {
    return Object.assign(Object.assign({ kind: IDLKind.Interface, name,
        subkind,
        typeParameters,
        inheritance,
        constructors,
        constants,
        properties,
        methods,
        callables }, nodeInitializer), { _idlNodeBrand: innerIdlSymbol, _idlEntryBrand: innerIdlSymbol, _idlNamedNodeBrand: innerIdlSymbol });
}
function createProperty(name, type, isReadonly = false, isStatic = false, isOptional = false, nodeInitializer = {}) {
    return Object.assign(Object.assign({ name, kind: IDLKind.Property, type,
        isReadonly,
        isStatic,
        isOptional }, nodeInitializer), { _idlNodeBrand: innerIdlSymbol, _idlEntryBrand: innerIdlSymbol, _idlNamedNodeBrand: innerIdlSymbol });
}
function createParameter(name, type, isOptional = false, isVariadic = false, nodeInitializer = {}) {
    return Object.assign(Object.assign({ kind: IDLKind.Parameter, name: name, type: type, isOptional,
        isVariadic }, nodeInitializer), { _idlNodeBrand: innerIdlSymbol, _idlEntryBrand: innerIdlSymbol, _idlNamedNodeBrand: innerIdlSymbol });
}
function createMethod(name, parameters, returnType, methodInitializer = {
    isAsync: false,
    isStatic: false,
    isOptional: false,
    isFree: false,
}, nodeInitializer = {}, typeParameters = []) {
    return Object.assign(Object.assign(Object.assign({ kind: IDLKind.Method, name,
        parameters,
        returnType,
        typeParameters }, methodInitializer), nodeInitializer), { _idlNodeBrand: innerIdlSymbol, _idlEntryBrand: innerIdlSymbol, _idlNamedNodeBrand: innerIdlSymbol });
}
function createCallable(
// TODO name here seems useless
name, parameters, returnType, callableInitializer, nodeInitializer, typeParameters = []) {
    return Object.assign(Object.assign(Object.assign({ kind: IDLKind.Callable, name,
        parameters,
        returnType }, callableInitializer), nodeInitializer), { _idlNodeBrand: innerIdlSymbol, _idlEntryBrand: innerIdlSymbol, _idlNamedNodeBrand: innerIdlSymbol });
}
function createConstructor(parameters, returnType, nodeInitializer = {}) {
    return Object.assign(Object.assign({ kind: IDLKind.Constructor, name: "$CONSTRUCTOR%", parameters,
        returnType }, nodeInitializer), { _idlNodeBrand: innerIdlSymbol, _idlEntryBrand: innerIdlSymbol, _idlNamedNodeBrand: innerIdlSymbol });
}
function createCallback(name, parameters, returnType, nodeInitializer = {}, typeParameters = []) {
    return Object.assign(Object.assign({ kind: IDLKind.Callback, name, parameters, returnType, typeParameters }, nodeInitializer), { _idlNodeBrand: innerIdlSymbol, _idlEntryBrand: innerIdlSymbol, _idlNamedNodeBrand: innerIdlSymbol });
}
function createTypeParameterReference(name, nodeInitializer) {
    return Object.assign(Object.assign({ kind: IDLKind.TypeParameterType, name: name }, nodeInitializer), { _idlNodeBrand: innerIdlSymbol, _idlTypeBrand: innerIdlSymbol, _idlNamedNodeBrand: innerIdlSymbol });
}
function createTypedef(name, type, typeParameters = [], nodeInitializer = {}) {
    return Object.assign(Object.assign({ name, type, typeParameters, kind: IDLKind.Typedef }, nodeInitializer), { _idlNodeBrand: innerIdlSymbol, _idlEntryBrand: innerIdlSymbol, _idlNamedNodeBrand: innerIdlSymbol });
}
function createConstant(name, type, value, nodeInitializer = {}) {
    return Object.assign(Object.assign({ kind: IDLKind.Const, name,
        type,
        value }, nodeInitializer), { _idlNodeBrand: innerIdlSymbol, _idlEntryBrand: innerIdlSymbol, _idlNamedNodeBrand: innerIdlSymbol });
}
function clone(node) {
    var _a, _b, _c, _d, _e, _f, _g, _h, _j, _k, _l, _m, _o, _p, _q, _r, _s, _t, _u, _v, _w, _x, _y, _z, _0;
    const make = (node) => node;
    const get = (node) => node;
    switch (node.kind) {
        case IDLKind.Interface: {
            const entry = get(node);
            return make(createInterface(entry.name, entry.subkind, (_a = entry.inheritance) === null || _a === void 0 ? void 0 : _a.map(clone), (_b = entry.constructors) === null || _b === void 0 ? void 0 : _b.map(clone), entry.constants.map(clone), entry.properties.map(clone), entry.methods.map(clone), entry.callables.map(clone), (_c = entry.typeParameters) === null || _c === void 0 ? void 0 : _c.map(it => it), {
                documentation: node.documentation,
                extendedAttributes: (_d = node.extendedAttributes) === null || _d === void 0 ? void 0 : _d.slice(),
                fileName: node.fileName
            }));
        }
        case IDLKind.Import: {
            const entry = get(node);
            return make(createImport(entry.clause, entry.name, {
                documentation: entry.documentation,
                extendedAttributes: (_e = entry.extendedAttributes) === null || _e === void 0 ? void 0 : _e.slice(),
                fileName: entry.fileName
            }));
        }
        case IDLKind.Callback: {
            const entry = get(node);
            return make(createCallback(entry.name, entry.parameters.map(clone), clone(entry.returnType), {
                documentation: entry.documentation,
                extendedAttributes: (_f = entry.extendedAttributes) === null || _f === void 0 ? void 0 : _f.slice(),
                fileName: entry.fileName
            }, entry.typeParameters));
        }
        case IDLKind.Const: {
            const entry = get(node);
            return make(createConstant(entry.name, clone(entry.type), entry.value, {
                documentation: entry.documentation,
                extendedAttributes: (_g = entry.extendedAttributes) === null || _g === void 0 ? void 0 : _g.slice(),
                fileName: entry.fileName
            }));
        }
        case IDLKind.Property: {
            const entry = get(node);
            return make(createProperty(entry.name, clone(entry.type), entry.isReadonly, entry.isStatic, entry.isOptional, {
                documentation: entry.documentation,
                extendedAttributes: (_h = entry.extendedAttributes) === null || _h === void 0 ? void 0 : _h.slice(),
                fileName: entry.fileName
            }));
        }
        case IDLKind.Parameter: {
            const entry = get(node);
            return make(createParameter(entry.name, clone(entry.type), entry.isOptional, entry.isVariadic, {
                documentation: entry.documentation,
                extendedAttributes: (_j = entry.extendedAttributes) === null || _j === void 0 ? void 0 : _j.slice(),
                fileName: entry.fileName
            }));
        }
        case IDLKind.Method: {
            const entry = get(node);
            return make(createMethod(entry.name, entry.parameters.map(clone), clone(entry.returnType), {
                isAsync: entry.isAsync,
                isFree: entry.isFree,
                isOptional: entry.isOptional,
                isStatic: entry.isStatic
            }, {
                documentation: entry.documentation,
                extendedAttributes: (_k = entry.extendedAttributes) === null || _k === void 0 ? void 0 : _k.slice(),
                fileName: entry.fileName
            }, entry.typeParameters));
        }
        case IDLKind.Callable: {
            const entry = get(node);
            return make(createCallable(entry.name, entry.parameters.map(clone), clone(entry.returnType), {
                isAsync: entry.isAsync,
                isStatic: entry.isStatic
            }, {
                documentation: entry.documentation,
                extendedAttributes: (_l = entry.extendedAttributes) === null || _l === void 0 ? void 0 : _l.slice(),
                fileName: entry.documentation
            }, entry.typeParameters));
        }
        case IDLKind.Constructor: {
            const entry = get(node);
            return make(createConstructor(entry.parameters.map(clone), entry.returnType ? clone(entry.returnType) : undefined, {
                documentation: entry.documentation,
                extendedAttributes: (_m = entry.extendedAttributes) === null || _m === void 0 ? void 0 : _m.slice(),
                fileName: entry.fileName
            }));
        }
        case IDLKind.Enum: {
            const entry = get(node);
            const cloned = createEnum(entry.name, entry.elements.map(clone), {
                documentation: entry.documentation,
                extendedAttributes: (_o = entry.extendedAttributes) === null || _o === void 0 ? void 0 : _o.slice(),
                fileName: entry.fileName
            });
            cloned.elements.forEach(it => {
                it.parent = cloned;
            });
            return make(cloned);
        }
        case IDLKind.EnumMember: {
            const entry = get(node);
            return make(createEnumMember(entry.name, entry.parent, clone(entry.type), entry.initializer, {
                documentation: entry.documentation,
                extendedAttributes: (_p = entry.extendedAttributes) === null || _p === void 0 ? void 0 : _p.slice(),
                fileName: entry.fileName
            }));
        }
        case IDLKind.Typedef: {
            const entry = get(node);
            return make(createTypedef(entry.name, clone(entry.type), entry.typeParameters, {
                documentation: entry.documentation,
                extendedAttributes: (_q = entry.extendedAttributes) === null || _q === void 0 ? void 0 : _q.slice(),
                fileName: entry.fileName
            }));
        }
        case IDLKind.PrimitiveType: {
            return node;
        }
        case IDLKind.ContainerType: {
            const type = get(node);
            return make(createContainerType(type.containerKind, type.elementType.map(clone), {
                documentation: type.documentation,
                extendedAttributes: (_r = type.extendedAttributes) === null || _r === void 0 ? void 0 : _r.slice(),
                fileName: type.fileName
            }));
        }
        case IDLKind.UnspecifiedGenericType: {
            const type = get(node);
            return make(createUnspecifiedGenericType(type.name, type.typeArguments.map(clone), {
                documentation: type.documentation,
                extendedAttributes: (_s = type.extendedAttributes) === null || _s === void 0 ? void 0 : _s.slice(),
                fileName: type.fileName
            }));
        }
        case IDLKind.ReferenceType: {
            const type = get(node);
            return make(createReferenceType(type.name, (_t = type.typeArguments) === null || _t === void 0 ? void 0 : _t.map(clone), {
                documentation: type.documentation,
                extendedAttributes: (_u = type.extendedAttributes) === null || _u === void 0 ? void 0 : _u.slice(),
                fileName: type.fileName
            }));
        }
        case IDLKind.UnionType: {
            const type = get(node);
            return make(createUnionType(type.types.map(clone), type.name, {
                documentation: type.documentation,
                extendedAttributes: (_v = type.extendedAttributes) === null || _v === void 0 ? void 0 : _v.slice(),
                fileName: type.fileName
            }));
        }
        case IDLKind.TypeParameterType: {
            const type = get(node);
            return make(createTypeParameterReference(type.name, {
                documentation: type.documentation,
                extendedAttributes: (_w = type.extendedAttributes) === null || _w === void 0 ? void 0 : _w.slice(),
                fileName: type.fileName
            }));
        }
        case IDLKind.OptionalType: {
            const type = get(node);
            return make(createOptionalType(clone(type.type), {
                documentation: type.documentation,
                extendedAttributes: (_x = type.extendedAttributes) === null || _x === void 0 ? void 0 : _x.slice(),
                fileName: type.fileName
            }));
        }
        case IDLKind.Version: {
            const entry = get(node);
            return make(createVersion(entry.value, {
                documentation: entry.documentation,
                extendedAttributes: (_y = entry.extendedAttributes) === null || _y === void 0 ? void 0 : _y.slice(),
                fileName: entry.fileName
            }));
        }
        case IDLKind.Namespace: {
            const ns = get(node);
            return make(createNamespace(ns.name, ns.members.map(clone), {
                documentation: ns.documentation,
                extendedAttributes: (_z = ns.extendedAttributes) === null || _z === void 0 ? void 0 : _z.slice(),
                fileName: ns.fileName
            }));
        }
        case IDLKind.File: {
            const file = get(node);
            return make(createFile(file.entries.map(clone), file.fileName, file.packageClause, {
                documentation: file.documentation,
                extendedAttributes: (_0 = file.extendedAttributes) === null || _0 === void 0 ? void 0 : _0.slice(),
                fileName: file.fileName
            }));
        }
    }
}
function printType(type, options) {
    if (!type)
        throw new Error("Missing type");
    if (isInterface$1(type))
        return type.name;
    if (isOptionalType(type))
        return `(${printType(type.type)} or ${IDLUndefinedType.name})`;
    if (isPrimitiveType(type))
        return type.name;
    if (isContainerType(type))
        return `${type.containerKind}<${type.elementType.map(it => printType(it)).join(", ")}>`;
    if (isReferenceType(type)) {
        const extAttrs = type.extendedAttributes ? Array.from(type.extendedAttributes) : [];
        if (type.typeArguments)
            extAttrs.push({ name: IDLExtendedAttributes.TypeArguments, value: type.typeArguments.map(it => printType(it)).join(",") });
        if (!extAttrs.length)
            return type.name;
        let res = `[${quoteAttributeValues(extAttrs)}] ${type.name}`;
        return res;
    }
    if (isUnspecifiedGenericType(type))
        return `${type.name}<${type.typeArguments.map(it => printType(it)).join(", ")}>`;
    if (isUnionType(type))
        return `(${type.types.map(it => printType(it)).join(" or ")})`;
    if (isTypeParameterType(type))
        return type.name;
    throw new Error(`Cannot map type: ${IDLKind[type.kind]}`);
}
const attributesToQuote = new Set([
    IDLExtendedAttributes.Documentation,
    IDLExtendedAttributes.DtsName,
    IDLExtendedAttributes.DtsTag,
    IDLExtendedAttributes.Import,
    IDLExtendedAttributes.Interfaces,
    IDLExtendedAttributes.TraceKey,
    IDLExtendedAttributes.TypeArguments,
    IDLExtendedAttributes.TypeParameters,
]);
function quoteAttributeValues(attributes) {
    return attributes === null || attributes === void 0 ? void 0 : attributes.map(it => {
        let attr = it.name;
        if (it.value) {
            let value = it.value;
            if (value.includes('"') && !value.includes("'"))
                value = value.replaceAll('"', "'");
            value = value.replaceAll('\\', '\\\\').replaceAll('"', '\\"');
            attr += `=${attributesToQuote.has(it.name) ? `"${value}"` : it.value}`;
        }
        return attr;
    }).join(", ");
}
function hasExtAttribute(node, attribute) {
    var _a;
    return ((_a = node.extendedAttributes) === null || _a === void 0 ? void 0 : _a.find((it) => it.name == attribute)) != undefined;
}
function getExtAttribute(node, name) {
    var _a, _b;
    return (_b = (_a = node.extendedAttributes) === null || _a === void 0 ? void 0 : _a.find(it => it.name === name)) === null || _b === void 0 ? void 0 : _b.value;
}
const IDLContainerUtils = {
    isRecord: (x) => isContainerType(x) && x.containerKind === 'record',
    isSequence: (x) => isContainerType(x) && x.containerKind === 'sequence',
    isPromise: (x) => isContainerType(x) && x.containerKind === 'Promise'
};
function maybeUnwrapOptionalType(type) {
    if (isOptionalType(type)) {
        return type.type;
    }
    return type;
}
function maybeOptional(type, optional = false) {
    if (optional) {
        return createOptionalType(type);
    }
    return type;
}
const DebugUtils = {
    debugPrintType: (type) => {
        if (isContainerType(type)) {
            return `[IDLType, name: '${printType(type)}', kind: '${IDLKind[type.kind]}', elements: [${type.elementType.map(DebugUtils.debugPrintType).join(', ')}]]`;
        }
        return `[IDLType, name: '${printType(type)}', kind: '${IDLKind[type.kind]}']`;
    },
};
function asPromise(type) {
    if (!type)
        return undefined;
    if (!isContainerType(type))
        return undefined;
    const container = type;
    if (!IDLContainerUtils.isPromise(container))
        return undefined;
    return container;
}
function isHandwritten(decl) {
    return hasExtAttribute(decl, IDLExtendedAttributes.HandWrittenImplementation);
}
function isStringEnum(decl) {
    return decl.elements.some(e => e.type === IDLStringType);
}
function extremumOfOrdinals(enumEntry) {
    let low = 0;
    let high = 0;
    enumEntry.elements.forEach((member, index) => {
        let value = index;
        if ((typeof member.initializer === 'number') && !isStringEnum(enumEntry)) {
            value = member.initializer;
        }
        if (low > value)
            low = value;
        if (high < value)
            high = value;
    });
    return { low, high };
}

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
function isDefined(value) {
    return !!value;
}
function capitalize(string) {
    return string.charAt(0).toUpperCase() + string.slice(1);
}
function indentedBy(input, indentedBy) {
    if (input.length > 0 || input.endsWith('\n')) {
        let space = "";
        for (let i = 0; i < indentedBy; i++)
            space += "    ";
        return `${space}${input}`;
    }
    else {
        return "";
    }
}
function zip(left, right) {
    if (left.length != right.length)
        throw new Error("Arrays of different length");
    return left.map((_, i) => [left[i], right[i]]);
}
({
    target: ts__namespace.ScriptTarget.ES5,
    module: ts__namespace.ModuleKind.CommonJS});
function throwException(message) {
    throw new Error(message);
}
function warn(message) {
    console.log(`WARNING: ${message}`);
}
function hashCodeFromString(value) {
    let hash = 5381;
    for (let i = 0; i < value.length; i++) {
        hash = (hash * 33) ^ value.charCodeAt(i);
        hash |= 0;
    }
    return hash;
}
class Lazy {
    constructor(factory) {
        this.instantiated = false;
        this.factory = factory;
    }
    get value() {
        if (!this.instantiated) {
            this.instance = this.factory();
            this.instantiated = true;
        }
        return this.instance;
    }
}
function lazy(factory) {
    return new Lazy(factory);
}
function rightmostIndexOf(array, predicate) {
    let result = -1;
    array.forEach((it, index) => {
        if (predicate(it)) {
            result = index;
        }
    });
    return result;
}
function getExtractorName(target, language, toPtr = true) {
    // TODO: Update for CJ
    const name = target.name.split(`.`).map(it => capitalize(it)).join("");
    return toPtr ? `to${name}Ptr` : `from${name}Ptr`;
}

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
class ValidationBox {
    constructor(box) {
        this.box = box;
    }
    static fail(errorMessage) {
        return new ValidationBox({ success: false, errorMessage });
    }
    static ok(value) {
        return new ValidationBox({ success: true, value });
    }
    success() {
        return this.box.success;
    }
    unwrap(message) {
        if (this.box.success) {
            return this.box.value;
        }
        throw new Error(message !== null && message !== void 0 ? message : 'panic');
    }
    error() {
        if (!this.box.success) {
            return this.box.errorMessage;
        }
        throw new Error("");
    }
    get() {
        return this.box;
    }
    or(x) {
        if (this.box.success) {
            return new ValidationBox(this.box);
        }
        return new ValidationBox({
            success: true,
            value: x
        });
    }
}
class ConfigDescriberBase {
    constructor() {
        this.$ = {
            mergeStrategy: 'merge'
        };
    }
    onMerge(strategy) {
        this.$.mergeStrategy = strategy;
        return this;
    }
}
class ConfigDescriberLeaf extends ConfigDescriberBase {
    constructor(validate, printSchema) {
        super();
        this.validate = validate;
        this.printSchema = printSchema;
    }
}
class ConfigDescriberOptionalLeaf extends ConfigDescriberLeaf {
    constructor(validate, printSchema) { super(validate, printSchema); }
}
class ConfigDescriberObjectLeaf extends ConfigDescriberLeaf {
    constructor(validate, printSchema, schema) {
        super(validate, printSchema);
        this.schema = schema;
    }
}
function mk(typeName, check, config) {
    return new ConfigDescriberLeaf(x => {
        if (check(x)) {
            return new ValidationBox({
                success: true,
                value: x
            });
        }
        if (config !== undefined && 'default' in config) {
            return new ValidationBox({
                success: true,
                value: config.default
            });
        }
        return new ValidationBox({
            success: false,
            errorMessage: `Expected "${typeName}"`
        });
    }, () => {
        const base = {
            type: typeName,
        };
        if (config === null || config === void 0 ? void 0 : config.description) {
            base.description = config === null || config === void 0 ? void 0 : config.description;
        }
        return base;
    });
}
const D = {
    ////////////////////////////////////////
    // Basics
    number(config) {
        return mk('number', x => typeof x === 'number', config);
    },
    string(config) {
        return mk('string', x => typeof x === 'string', config);
    },
    boolean(config) {
        return mk('boolean', x => typeof x === 'boolean', config);
    },
    bigint(config) {
        return mk('bigint', x => typeof x === 'bigint', config);
    },
    null(config) {
        return mk('null', x => x === null, config);
    },
    undefined(config) {
        return mk('undefined', x => x === undefined, config);
    },
    object(schema) {
        return new ConfigDescriberObjectLeaf(x => {
            if (x !== undefined) {
                if (typeof x !== 'object') {
                    return ValidationBox.fail(`Expected object, but got "${typeof x}"`);
                }
                if (x === null) {
                    return ValidationBox.fail(`Expected object, but got "null"`);
                }
            }
            const obj = x;
            const sh = schema;
            const result = {};
            const errors = [];
            for (const key in schema) {
                const box = sh[key].validate(obj === undefined ? undefined : obj[key]);
                if (box.success()) {
                    const val = box.unwrap();
                    if (val === undefined && obj !== undefined && !(key in obj)) {
                        continue;
                    }
                    result[key] = val;
                }
                else {
                    errors.push(`"${key}":\n${box.error().split('\n').map(s => '\t' + s).join('\n')}`);
                }
            }
            if (errors.length) {
                return ValidationBox.fail(errors.join('\n'));
            }
            return new ValidationBox({
                success: true,
                value: result
            });
        }, () => {
            const properties = {};
            const required = [];
            for (const key in schema) {
                const leaf = schema[key];
                properties[key] = leaf.printSchema();
                if (!(leaf instanceof ConfigDescriberOptionalLeaf)) {
                    required.push(key);
                }
            }
            return {
                additionalProperties: false,
                properties,
                required,
                type: "object"
            };
        }, schema);
    },
    ////////////////////////////////////////
    // Advanced
    maybe(type) {
        return new ConfigDescriberOptionalLeaf(x => {
            if (x === undefined) {
                return ValidationBox.ok(undefined);
            }
            return type.validate(x);
        }, () => {
            return type.printSchema();
        });
    },
    default(type, def) {
        return new ConfigDescriberOptionalLeaf(x => {
            return type.validate(x).or(def);
        }, () => {
            return type.printSchema();
        });
    },
    array(type, initAsEmpty = true) {
        return new ConfigDescriberLeaf(xs => {
            if ((xs === undefined || xs === null) && initAsEmpty) {
                return ValidationBox.ok([]);
            }
            if (!Array.isArray(xs)) {
                return ValidationBox.fail("Expected array");
            }
            const result = [];
            for (const x of xs) {
                const box = type.validate(x);
                if (!box.success()) {
                    return ValidationBox.fail("Array item: " + box.error());
                }
                result.push(box.unwrap());
            }
            return ValidationBox.ok(result);
        }, () => {
            return {
                type: 'array',
                items: type.printSchema()
            };
        });
    },
    map(keySchema, valSchema) {
        return new ConfigDescriberLeaf(x => {
            if (x === undefined) {
                return ValidationBox.fail(`Expected Map, but got "undefined"`);
            }
            if (typeof x !== 'object' || x === null) {
                return ValidationBox.fail(`Expected Map, but got "${x === null ? 'null' : typeof x}"`);
            }
            const result = new Map();
            const iterable = x instanceof Map ? x : Object.entries(x);
            for (const [key, val] of iterable) {
                const keyResult = keySchema.validate(key);
                if (!keyResult.success()) {
                    return ValidationBox.fail("Map key: " + keyResult.error());
                }
                const valResult = valSchema.validate(val);
                if (!valResult.success()) {
                    return ValidationBox.fail("Map value: " + valResult.error());
                }
                result.set(keyResult.unwrap(), valResult.unwrap());
            }
            return ValidationBox.ok(result);
        }, () => {
            return {
                type: 'object',
                additionalProperties: valSchema.printSchema()
            };
        });
    },
    tuple(...items) {
        return new ConfigDescriberLeaf(xs => {
            if (!Array.isArray(xs)) {
                return ValidationBox.fail('Expected tuple');
            }
            if (xs.length !== items.length) {
                return ValidationBox.fail(`Expected tuple of size ${items.length}, but size was ${xs.length}`);
            }
            const result = [];
            zip(xs, items).forEach(([val, leaf], i) => {
                const r = leaf.validate(val);
                if (!r.success()) {
                    return ValidationBox.fail(`Tuple position ${i}: ${r.error()}`);
                }
                result.push(r.unwrap());
            });
            return ValidationBox.ok(result);
        }, () => {
            return {
                items: items.map(it => it.printSchema())
            };
        });
    },
    union(...items) {
        return new ConfigDescriberLeaf(xs => {
            for (const item of items) {
                const r = item.validate(xs);
                if (r.success()) {
                    return r;
                }
            }
            return ValidationBox.fail('Not matched');
        }, () => {
            return {
                oneOf: items.map(it => it.printSchema())
            };
        });
    },
    literal: {
        string(x) {
            return new ConfigDescriberLeaf(xs => {
                if (typeof xs === 'string' && x === xs) {
                    return ValidationBox.ok(xs);
                }
                return ValidationBox.fail('Not matched');
            }, () => {
                return {
                    'const': x
                };
            });
        },
        number(x) {
            return new ConfigDescriberLeaf(xs => {
                if (typeof xs === 'number' && x === xs) {
                    return ValidationBox.ok(xs);
                }
                return ValidationBox.fail('Not matched');
            }, () => {
                return {
                    'const': x
                };
            });
        },
        boolean(x) {
            return new ConfigDescriberLeaf(xs => {
                if (typeof xs === 'boolean' && x === xs) {
                    return ValidationBox.ok(xs);
                }
                return ValidationBox.fail('Not matched');
            }, () => {
                return {
                    'const': x
                };
            });
        },
        null() {
            return new ConfigDescriberLeaf(xs => {
                if (typeof xs === 'object' && xs === null) {
                    return ValidationBox.ok(null);
                }
                return ValidationBox.fail('Expected null');
            }, () => {
                return {
                    'const': null
                };
            });
        }
    },
    ////////////////////////////////////////
    // Utils
    combine(a, b) {
        const keysA = new Set(Object.keys(a.schema));
        const keysB = Object.keys(b.schema);
        for (const key of keysB) {
            if (keysA.has(key)) {
                throw new Error(`Can not combine objects with same keys. Key: "${key}"`);
            }
        }
        return D.object(Object.assign(Object.assign({}, a.schema), b.schema));
    },
    ////////////////////////////////////////
    // Helpers
    printJSONSchema(schema) {
        const configSchema = schema.printSchema();
        if ("properties" in configSchema) {
            configSchema.properties.$schema = {
                type: "string",
                description: "The schema to verify this document against."
            };
        }
        const json = {
            $schema: "http://json-schema.org/draft-07/schema#",
            $ref: "#/definitions/configSchema",
            definitions: {
                configSchema
            }
        };
        return JSON.stringify(json, null, 4);
    }
};

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
const T = {
    stringArray: () => D.array(D.string())
};
const ModuleConfigurationSchema = D.object({
    name: D.string(),
    packages: T.stringArray(),
    useFoldersLayout: D.maybe(D.boolean()),
});
const HookMethodSchema = D.object({
    hookName: D.string(),
});
D.object({
    TypePrefix: D.string(),
    LibraryPrefix: D.string(),
    OptionalPrefix: D.string(),
    rootComponents: T.stringArray(),
    standaloneComponents: T.stringArray(),
    parameterized: T.stringArray(),
    ignoreMaterialized: T.stringArray(),
    builderClasses: T.stringArray(),
    forceMaterialized: T.stringArray(),
    forceCallback: D.map(D.string(), T.stringArray()).onMerge('replace'),
    forceResource: T.stringArray(),
    forceContext: T.stringArray(),
    hooks: D.map(D.string(), D.map(D.string(), HookMethodSchema)).onMerge('replace'),
    externalTypes: D.map(D.string(), D.string()).onMerge('replace'),
    externalPackages: T.stringArray(),
    moduleName: D.string(),
    modules: D.map(D.string(), ModuleConfigurationSchema).onMerge('replace'),
    globalPackages: T.stringArray()
});
const defaultCoreConfiguration = {
    TypePrefix: "",
    LibraryPrefix: "",
    OptionalPrefix: "",
    rootComponents: [],
    standaloneComponents: [],
    parameterized: [],
    ignoreMaterialized: [],
    builderClasses: [],
    forceMaterialized: [],
    forceCallback: new Map(),
    forceResource: [],
    forceContext: [],
    hooks: new Map(),
    externalTypes: new Map(),
    externalPackages: [],
    moduleName: "",
    modules: new Map(),
    globalPackages: []
};
let currentConfig = defaultCoreConfiguration;
function generatorConfiguration() {
    return currentConfig;
}
function generatorTypePrefix() {
    const conf = generatorConfiguration();
    return `${conf.TypePrefix}${conf.LibraryPrefix}`;
}

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
function resolveNamedNode(target, pov, corpus) {
    let result;
    let povScope = [];
    while (pov) {
        if (isFile(pov)) {
            if (result = resolveDownFromFile(target, pov, corpus))
                return result;
            const importUsings = pov.entries.filter(it => isImport(it) && !it.name).map(it => it);
            for (const importUsing of importUsings)
                if (result = resolveDownFromRoot([...importUsing.clause, ...target], corpus))
                    return result;
            povScope = pov.packageClause.slice();
            break;
        }
        else {
            if (result = resolveDownFromNode(target, pov, false, corpus))
                return result;
        }
        pov = pov.parent;
    }
    for (;;) {
        if (result = resolveDownFromRoot([...povScope, ...target], corpus))
            return result;
        if (povScope.length)
            povScope.pop();
        else
            break;
    }
    return undefined;
}
function resolveDownFromNode(target, pov, withSelf, corpus) {
    if (withSelf && isNamedNode(pov)) {
        if (isReferenceType(pov) || !pov.name.length)
            return undefined;
        let nameMatched = target[0] === pov.name;
        if (!nameMatched)
            nameMatched = target[0] === "default" && hasExtAttribute(pov, IDLExtendedAttributes.DefaultExport);
        if (!nameMatched)
            return undefined;
        target = target.slice(1);
        if (isImport(pov)) {
            return resolveDownFromRoot([...pov.clause, ...target], corpus);
        }
        if (!target.length)
            return pov;
    }
    let candidates;
    if (isNamespace(pov))
        candidates = pov.members;
    else if (isEnum$1(pov))
        candidates = pov.elements;
    else if (isInterface$1(pov))
        candidates = pov.constants;
    else
        return undefined;
    let result;
    for (const candidate of candidates) {
        if (result = resolveDownFromNode(target, candidate, true, corpus))
            return result;
    }
    return undefined;
}
function resolveDownFromFile(target, pov, corpus) {
    let result;
    for (const candidate of pov.entries) {
        if (result = resolveDownFromNode(target, candidate, true, corpus))
            return result;
    }
    return undefined;
}
function resolveDownFromRoot(target, corpus) {
    let result;
    for (const file of corpus) {
        if (file.packageClause.length >= target.length)
            continue;
        let match = true;
        for (let index = 0; index < file.packageClause.length; ++index)
            if (file.packageClause[index] !== target[index]) {
                match = false;
                break;
            }
        if (!match)
            continue;
        if (result = resolveDownFromFile(target.slice(file.packageClause.length), file, corpus))
            return result;
    }
    return undefined;
}

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
function createLibrary(files) {
    return {
        files
    };
}
function toLibrary(ii) {
    return {
        files: Array.from(ii)
    };
}
function serializeParam(params) {
    if (typeof params === 'undefined') {
        return 'undefined';
    }
    if (typeof params === 'boolean') {
        return params ? 'true' : 'false';
    }
    if (typeof params === 'string') {
        return `"${params}"`;
    }
    if (typeof params === 'number') {
        return params.toString();
    }
    if (typeof params === 'object') {
        if (params === null) {
            return 'null';
        }
        if (Array.isArray(params)) {
            return '[' + params.map(serializeParam).join(', ') + ']';
        }
        const keys = Object.keys(params);
        keys.sort();
        return '{' +
            keys.map((key) => {
                if (typeof key !== 'string') {
                    throw new Error(`Unsupported key! "${typeof key}"`);
                }
                const objectKey = key;
                return `${key}=${serializeParam(params[objectKey])}`;
            }).join(',')
            + '}';
    }
    throw new Error(`Unsupported type! "${typeof params}"`);
}
const queryCache = new Map();
function cached(key, f) {
    return x => {
        if (queryCache.has(key)) {
            return queryCache.get(key);
        }
        const v = f(x);
        queryCache.set(key, v);
        return v;
    };
}
function reduce(key, f) {
    return {
        fn: cached(key, f),
        key,
        _redBrand: {}
    };
}
function req(key, fn) {
    return {
        fn,
        key,
        _reqBrand: {}
    };
}
function compose(base, next) {
    const key = base.key + '.' + next.key;
    return {
        fn: cached(key, x => next.fn(base.fn(x))),
        key,
        _redBrand: {}
    };
}
function concat(f, g) {
    const key = `$pair{${f.key},${g.key}}`;
    return {
        fn: cached(key, x => {
            const r1 = f.fn(x);
            const r2 = g.fn(x);
            return [r1, r2];
        }),
        key,
        _reqBrand: {}
    };
}
class LensBuilder {
    constructor(req) {
        this.req = req;
    }
    static make(r) {
        return new LensBuilder(r);
    }
    pipe(r) {
        return new LensBuilder(compose(this.req, r));
    }
    row(key, f) {
        return this.pipe(req(key, f));
    }
    query() {
        return this.req;
    }
}
function lens(r) {
    return LensBuilder.make(r);
}
function query(lib, input) {
    const request = input instanceof LensBuilder ? input.query() : input;
    return request.fn(lib);
}
// UTILS
const utils = {
    idx: (x) => req('idx', xs => xs.at(x)),
    fst: () => req('fst', xs => xs.at(0)),
    lst: () => req('lst', xs => xs.at(-1)),
};
const select = {
    files() {
        return reduce('files', x => x.files);
    },
    nodes(params) {
        const key = 'entities' + serializeParam(params);
        function go(node) {
            if (isNamespace(node) && (params === null || params === void 0 ? void 0 : params.expandNamespaces)) {
                return node.members.flatMap(go);
            }
            return [node];
        }
        return req(key, xs => {
            return xs.flatMap(x => x.entries).flatMap(go);
        });
    },
    entries() {
        return req('entries', xs => xs.filter(isEntry));
    },
    interfaces() {
        return req('interfaces', it => it.filter(isInterface$1));
    },
    hasExt(attr) {
        return req('with_attr=' + serializeParam(attr), it => it.filter(x => hasExtAttribute(x, attr)));
    },
    names() {
        return req('names', xs => xs.flatMap(x => isNamedNode(x) ? [x.name] : []));
    },
    name(name) {
        return reduce(`select.by.name.${name}`, lib => {
            return lib.files.flatMap(it => {
                return it.entries.flatMap(it => {
                    if (isNamedNode(it) && it.name === name) {
                        return [it];
                    }
                    return [];
                });
            });
        });
    },
};
const lib = {
    createLibrary,
    toLibrary,
    lens,
    query,
    select,
    utils,
    req,
    compose,
    concat,
    other: {
        serializeParam
    }
};

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
const PACKAGE_IDLIZE_INTERNAL = "idlize.internal";
function isInIdlizeInternal(entry) {
    return isInPackage(entry, PACKAGE_IDLIZE_INTERNAL);
}

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
var InheritanceRole;
(function (InheritanceRole) {
    InheritanceRole[InheritanceRole["Finalizable"] = 0] = "Finalizable";
    InheritanceRole[InheritanceRole["PeerNode"] = 1] = "PeerNode";
    InheritanceRole[InheritanceRole["Root"] = 2] = "Root";
    InheritanceRole[InheritanceRole["Heir"] = 3] = "Heir";
    InheritanceRole[InheritanceRole["Standalone"] = 4] = "Standalone";
})(InheritanceRole || (InheritanceRole = {}));

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
class IndentedPrinter {
    constructor(output = []) {
        this.output = output;
        this.indent = 0;
    }
    print(value) {
        if (value != undefined)
            this.output.push(this.indented(value));
    }
    pushIndent(level = 1) {
        this.indent += level;
    }
    popIndent(level = 1) {
        this.indent -= level;
    }
    indentDepth() {
        return this.indent;
    }
    append(printer) {
        this.output = [...this.output, ...printer.output];
    }
    indented(input) {
        return indentedBy(input, this.indent);
    }
    getOutput() {
        return this.output;
    }
    printTo(file) {
        fs__namespace.mkdirSync(path.dirname(file), { recursive: true });
        fs__namespace.writeFileSync(file, this.getOutput().join("\n"));
    }
    withIndent(prints) {
        this.pushIndent();
        prints(this);
        this.popIndent();
    }
}

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
var RuntimeType;
(function (RuntimeType) {
    RuntimeType[RuntimeType["UNEXPECTED"] = -1] = "UNEXPECTED";
    RuntimeType[RuntimeType["NUMBER"] = 1] = "NUMBER";
    RuntimeType[RuntimeType["STRING"] = 2] = "STRING";
    RuntimeType[RuntimeType["OBJECT"] = 3] = "OBJECT";
    RuntimeType[RuntimeType["BOOLEAN"] = 4] = "BOOLEAN";
    RuntimeType[RuntimeType["UNDEFINED"] = 5] = "UNDEFINED";
    RuntimeType[RuntimeType["BIGINT"] = 6] = "BIGINT";
    RuntimeType[RuntimeType["FUNCTION"] = 7] = "FUNCTION";
    RuntimeType[RuntimeType["SYMBOL"] = 8] = "SYMBOL";
    RuntimeType[RuntimeType["MATERIALIZED"] = 9] = "MATERIALIZED";
})(RuntimeType || (RuntimeType = {}));
class NativeModuleType {
    constructor(name) {
        this.name = name;
    }
}

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
class TernaryExpression {
    constructor(condition, trueExpression, falseExpression) {
        this.condition = condition;
        this.trueExpression = trueExpression;
        this.falseExpression = falseExpression;
    }
    asString() {
        return `(${this.condition.asString()}) ? (${this.trueExpression.asString()}) : (${this.falseExpression.asString()})`;
    }
}
class NaryOpExpression {
    constructor(op, args) {
        this.op = op;
        this.args = args;
    }
    asString() {
        if (this.args.length === 1)
            return this.args[0].asString();
        return `${this.args.map(arg => `(${arg.asString()})`).join(` ${this.op} `)}`;
    }
}
class StringExpression {
    constructor(value) {
        this.value = value;
    }
    asString() {
        return this.value;
    }
}
class NewObjectExpression {
    constructor(objectName, params) {
        this.objectName = objectName;
        this.params = params;
    }
    asString() {
        return `new ${this.objectName}(${this.params.map(it => it.asString()).join(", ")})`;
    }
}
class FunctionCallExpression {
    constructor(name, params) {
        this.name = name;
        this.params = params;
    }
    asString() {
        return `${this.name}(${this.params.map(it => it.asString()).join(", ")})`;
    }
}
class MethodCallExpression extends FunctionCallExpression {
    constructor(receiver, method, params, nullable = false) {
        super(method, params);
        this.receiver = receiver;
        this.nullable = nullable;
    }
    asString() {
        return `${this.receiver}${this.nullable ? "?" : ""}.${super.asString()}`;
    }
}
class MethodStaticCallExpression extends MethodCallExpression {
    constructor(receiver, method, params, nullable = false) {
        super(receiver, method, params, nullable);
        this.receiver = receiver;
        this.nullable = nullable;
    }
}
class ThisCallExpression extends FunctionCallExpression {
    constructor(params) {
        super("this", params);
    }
}
class FieldAccessExpression {
    constructor(receiver, field, nullable = false) {
        this.receiver = receiver;
        this.field = field;
        this.nullable = nullable;
    }
    asString() {
        return `${this.receiver}${this.nullable ? "?" : ""}.${this.field}`;
    }
}
class CheckDefinedExpression {
    constructor(value) {
        this.value = value;
    }
    asString() {
        return `${this.value} != undefined`;
    }
}
class ProxyStatement {
    constructor(cb) {
        this.cb = cb;
    }
    write(writer) {
        this.cb(writer);
    }
}
class AssignStatement {
    constructor(variableName, type, expression, isDeclared = true, isConst = true, options) {
        this.variableName = variableName;
        this.type = type;
        this.expression = expression;
        this.isDeclared = isDeclared;
        this.isConst = isConst;
        this.options = options;
    }
    write(writer) {
        var _a, _b, _c;
        if (this.isDeclared) {
            const typeSpec = ((_a = this.options) === null || _a === void 0 ? void 0 : _a.overrideTypeName)
                ? `: ${this.options.overrideTypeName}`
                : this.type
                    ? `: ${writer.getNodeName(this.type)}${ /*SHOULD BE REMOVED*/isOptionalType(this.type) ? "|undefined" : ""}`
                    : "";
            const initValue = this.expression ? `= ${this.expression.asString()}` : "";
            const constSpec = this.isConst ? "const" : "let";
            writer.print(`${constSpec} ${this.variableName}${typeSpec} ${initValue}`);
        }
        else {
            const receiver = (_b = this.options) === null || _b === void 0 ? void 0 : _b.receiver;
            const withReceiver = receiver ? `${receiver}.` : "";
            writer.print(`${withReceiver}${this.variableName} = ${(_c = this.expression) === null || _c === void 0 ? void 0 : _c.asString()}`);
        }
    }
}
class ExpressionStatement {
    constructor(expression) {
        this.expression = expression;
    }
    write(writer) {
        const text = this.expression.asString();
        if (text.length > 0) {
            writer.print(`${this.expression.asString()}${writer.maybeSemicolon()}`);
        }
    }
}
class BlockStatement {
    constructor(statements, inScope = true) {
        this.statements = statements;
        this.inScope = inScope;
    }
    write(writer) {
        if (this.inScope) {
            writer.print("{");
            writer.pushIndent();
        }
        this.statements.forEach(s => s.write(writer));
        if (this.inScope) {
            writer.popIndent();
            writer.print("}");
        }
    }
}
class IfStatement {
    constructor(condition, thenStatement, elseStatement, insideIfOp, insideElseOp) {
        this.condition = condition;
        this.thenStatement = thenStatement;
        this.elseStatement = elseStatement;
        this.insideIfOp = insideIfOp;
        this.insideElseOp = insideElseOp;
    }
    write(writer) {
        writer.print(`if (${this.condition.asString()})`);
        this.writeBody(writer, this.thenStatement, () => {
            if (this.insideIfOp) {
                this.insideIfOp();
            }
        });
        if (this.elseStatement !== undefined) {
            writer.print("else");
            this.writeBody(writer, this.elseStatement, () => {
                if (this.insideElseOp) {
                    this.insideElseOp();
                }
            });
        }
    }
    writeBody(writer, body, op) {
        if (!(body instanceof BlockStatement)) {
            writer.pushIndent();
        }
        body.write(writer);
        op();
        if (!(body instanceof BlockStatement)) {
            writer.popIndent();
        }
    }
}
class MultiBranchIfStatement {
    constructor(statements, elseStatement) {
        this.statements = statements;
        this.elseStatement = elseStatement;
    }
    write(writer) {
        this.statements.forEach((value, index) => {
            const { expr, stmt } = value;
            if (index == 0) {
                writer.print(`if (${expr.asString()}) {`);
            }
            else {
                writer.print(`else if (${expr.asString()}) {`);
            }
            writer.pushIndent();
            stmt.write(writer);
            writer.popIndent();
            writer.print("}");
        });
        if (this.statements.length > 0 && this.elseStatement !== undefined) {
            writer.print("else {");
            writer.pushIndent();
            this.elseStatement.write(writer);
            writer.popIndent();
            writer.print("}");
        }
    }
}
class CheckOptionalStatement {
    constructor(undefinedValue, optionalExpression, doStatement) {
        this.undefinedValue = undefinedValue;
        this.optionalExpression = optionalExpression;
        this.doStatement = doStatement;
    }
    write(writer) {
        writer.print(`if (${this.optionalExpression.asString()} != ${this.undefinedValue})`);
        writer.pushIndent();
        this.doStatement.write(writer);
        writer.popIndent();
    }
}
// maybe rename or move of fix
class TsEnumEntityStatement {
    constructor(enumEntity, options) {
        this.enumEntity = enumEntity;
        this.options = options;
    }
    write(writer) {
        // writer.print(this.enumEntity.comment)
        writer.print(`${this.options.isExport ? "export " : ""}${this.options.isDeclare ? "declare " : ""}enum ${this.enumEntity.name} {`);
        writer.pushIndent();
        this.enumEntity.elements.forEach((member, index) => {
            // writer.print(member.comment)
            const initValue = member.initializer
                ? ` = ${this.maybeQuoted(member.initializer)}` : ``;
            writer.print(`${member.name}${initValue},`);
            let originalName = getExtAttribute(member, IDLExtendedAttributes.OriginalEnumMemberName);
            if (originalName) {
                const initValue = ` = ${member.name}`;
                writer.print(`${originalName}${initValue},`);
            }
        });
        writer.popIndent();
        writer.print(`}`);
    }
    maybeQuoted(value) {
        if (typeof value == "string")
            return `"${value}"`;
        else
            return `${value}`;
    }
}
class ReturnStatement {
    constructor(expression) {
        this.expression = expression;
    }
    write(writer) {
        writer.print(this.expression ? `return ${this.expression.asString()}` : "return");
    }
}
class LambdaExpression {
    constructor(originalWriter, signature, resolver, body) {
        this.originalWriter = originalWriter;
        this.signature = signature;
        this.resolver = resolver;
        this.body = body;
    }
    bodyAsString() {
        var _a;
        const writer = this.originalWriter.fork();
        if (this.body) {
            for (const stmt of this.body) {
                stmt.write(writer);
            }
        }
        writer.features.forEach(([feature, module]) => {
            this.originalWriter.addFeature(feature, module);
        });
        return (this.body ? ((_a = this.body) === null || _a === void 0 ? void 0 : _a.length) > 1 ? '\n' : '' : '').concat(writer.getOutput()
            .filter(line => line !== "")
            .map(line => indentedBy(line.endsWith('{') || line.endsWith('}') || line.endsWith(';') ? line : `${line};`, 1))
            .join("\n"));
    }
}
////////////////////////////////////////////////////////////////
//                         SIGNATURES                         //
////////////////////////////////////////////////////////////////
var ArgumentModifier;
(function (ArgumentModifier) {
    ArgumentModifier[ArgumentModifier["OPTIONAL"] = 0] = "OPTIONAL";
})(ArgumentModifier || (ArgumentModifier = {}));
var FieldModifier;
(function (FieldModifier) {
    FieldModifier[FieldModifier["READONLY"] = 0] = "READONLY";
    FieldModifier[FieldModifier["PRIVATE"] = 1] = "PRIVATE";
    FieldModifier[FieldModifier["PUBLIC"] = 2] = "PUBLIC";
    FieldModifier[FieldModifier["STATIC"] = 3] = "STATIC";
    FieldModifier[FieldModifier["PROTECTED"] = 4] = "PROTECTED";
    FieldModifier[FieldModifier["FINAL"] = 5] = "FINAL";
    FieldModifier[FieldModifier["VOLATILE"] = 6] = "VOLATILE";
    FieldModifier[FieldModifier["INTERNAL"] = 7] = "INTERNAL";
    FieldModifier[FieldModifier["OVERRIDE"] = 8] = "OVERRIDE";
})(FieldModifier || (FieldModifier = {}));
var MethodModifier;
(function (MethodModifier) {
    MethodModifier[MethodModifier["PUBLIC"] = 0] = "PUBLIC";
    MethodModifier[MethodModifier["PRIVATE"] = 1] = "PRIVATE";
    MethodModifier[MethodModifier["PROTECTED"] = 2] = "PROTECTED";
    MethodModifier[MethodModifier["STATIC"] = 3] = "STATIC";
    MethodModifier[MethodModifier["NATIVE"] = 4] = "NATIVE";
    MethodModifier[MethodModifier["INLINE"] = 5] = "INLINE";
    MethodModifier[MethodModifier["GETTER"] = 6] = "GETTER";
    MethodModifier[MethodModifier["SETTER"] = 7] = "SETTER";
    MethodModifier[MethodModifier["THROWS"] = 8] = "THROWS";
    MethodModifier[MethodModifier["FREE"] = 9] = "FREE";
    MethodModifier[MethodModifier["FORCE_CONTEXT"] = 10] = "FORCE_CONTEXT";
    MethodModifier[MethodModifier["OVERRIDE"] = 11] = "OVERRIDE";
})(MethodModifier || (MethodModifier = {}));
var ClassModifier;
(function (ClassModifier) {
    ClassModifier[ClassModifier["PUBLIC"] = 0] = "PUBLIC";
    ClassModifier[ClassModifier["PRIVATE"] = 1] = "PRIVATE";
    ClassModifier[ClassModifier["PROTECTED"] = 2] = "PROTECTED";
})(ClassModifier || (ClassModifier = {}));
var DelegationType;
(function (DelegationType) {
    DelegationType[DelegationType["THIS"] = 0] = "THIS";
    DelegationType[DelegationType["SUPER"] = 1] = "SUPER";
})(DelegationType || (DelegationType = {}));
class Method {
    constructor(name, signature, modifiers = undefined, generics) {
        this.name = name;
        this.signature = signature;
        this.modifiers = modifiers;
        this.generics = generics;
    }
}
// Mostly for synthetic methods.
Method.knownReferenceTypes = [
    'KInt', 'KPointer', 'undefined' /* This one looks like a bug */
];
class PrintHint {
    constructor(hint) {
        this.hint = hint;
    }
}
PrintHint.AsPointer = new PrintHint('AsPointer');
PrintHint.AsConstPointer = new PrintHint('AsConstPointer');
PrintHint.AsValue = new PrintHint('AsValue');
PrintHint.AsConstReference = new PrintHint('AsConstReference');
PrintHint.AsReference = new PrintHint('AsReference');
class MethodSignature {
    constructor(returnType, args, defaults = undefined, argsModifiers = undefined, printHints, argNames) {
        this.returnType = returnType;
        this.args = args;
        this.defaults = defaults;
        this.printHints = printHints;
        this.argNames = argNames;
        this.argsModifiers = argsModifiers === null || argsModifiers === void 0 ? void 0 : argsModifiers.map(it => it === undefined ? [] : Array.isArray(it) ? it : [it]);
    }
    argName(index) {
        var _a, _b;
        return (_b = (_a = this === null || this === void 0 ? void 0 : this.argNames) === null || _a === void 0 ? void 0 : _a.at(index)) !== null && _b !== void 0 ? _b : `arg${index}`;
    }
    argDefault(index) {
        var _a;
        return (_a = this.defaults) === null || _a === void 0 ? void 0 : _a[index];
    }
    isArgOptional(index) {
        var _a, _b, _c;
        return (_c = (_b = (_a = this.argsModifiers) === null || _a === void 0 ? void 0 : _a[index]) === null || _b === void 0 ? void 0 : _b.includes(ArgumentModifier.OPTIONAL)) !== null && _c !== void 0 ? _c : false;
    }
    retHint() {
        var _a;
        return (_a = this.printHints) === null || _a === void 0 ? void 0 : _a[0];
    }
    argHint(index) {
        var _a;
        return (_a = this.printHints) === null || _a === void 0 ? void 0 : _a[index + 1];
    }
    toString() {
        return `${this.args.map(it => forceAsNamedNode(it).name)} => ${this.returnType}`;
    }
}
class NamedMethodSignature extends MethodSignature {
    constructor(returnType, args = [], argsNames = [], defaults = undefined, argsModifiers = undefined, printHints) {
        super(returnType, args, defaults, argsModifiers, printHints);
        this.argsNames = argsNames;
    }
    static make(returnType, args) {
        return new NamedMethodSignature(returnType, args.map(it => it.type), args.map(it => it.name));
    }
    argName(index) {
        return this.argsNames[index];
    }
}
////////////////////////////////////////////////////////////////
//                    LANGUAGE WRITER                         //
////////////////////////////////////////////////////////////////
class LanguageWriter {
    constructor(printer, resolver, // TODO make protected again (or better rework LWs)
    language) {
        this.printer = printer;
        this.resolver = resolver;
        this.language = language;
        this.namespaceStack = [];
        this.features = [];
    }
    indentDepth() {
        return this.printer.indentDepth();
    }
    maybeSemicolon() { return ";"; }
    addFeature(feature, module) {
        this.features.push([feature, module]);
    }
    // version of makeCast which uses TypeCheck.typeCast<T>(value) call for ETS language writer
    // Use it only if TypeChecker class is added as import to the generated file
    makeTypeCast(value, type, options) {
        return this.makeCast(value, type, options);
    }
    makeUnwrapOptional(expression) {
        return expression;
    }
    concat(other) {
        other.getOutput().forEach(it => this.print(it));
        return this;
    }
    printTo(file) {
        fs__namespace.writeFileSync(file, this.getOutput().join("\n"));
    }
    writeLines(lines) {
        lines.split("\n").forEach(it => this.print(it));
    }
    writeGetterImplementation(method, op) {
        var _a;
        this.writeMethodImplementation(new Method(method.name, method.signature, [MethodModifier.GETTER].concat((_a = method.modifiers) !== null && _a !== void 0 ? _a : [])), op);
    }
    writeSetterImplementation(method, op) {
        var _a;
        this.writeMethodImplementation(new Method(method.name, method.signature, [MethodModifier.SETTER].concat((_a = method.modifiers) !== null && _a !== void 0 ? _a : [])), op);
    }
    // Deprecated
    // Use instead declarationCall parameter in writeConstructorImplementation(...)
    writeSuperCall(params) {
        this.printer.print(`super(${params.join(", ")})${this.maybeSemicolon()}`);
    }
    writeMethodCall(receiver, method, params, nullable = false) {
        this.printer.print(`${receiver}${nullable ? "?" : ""}.${method}(${params.join(", ")})`);
    }
    writeStaticMethodCall(receiver, method, params, nullable = false) {
        this.writeMethodCall(receiver, method, params, nullable);
    }
    writeStatement(stmt) {
        stmt.write(this);
    }
    writeStatements(...statements) {
        statements.forEach(it => this.writeStatement(it));
    }
    writeExpressionStatement(smth) {
        this.writeStatement(new ExpressionStatement(smth));
    }
    writeExpressionStatements(...statements) {
        statements.forEach(it => this.writeExpressionStatement(it));
    }
    writeStaticBlock(op) {
        this.print("static {");
        this.pushIndent();
        op(this);
        this.popIndent();
        this.print("}");
    }
    makeRef(type, _options) {
        return type;
    }
    makeThis() {
        return new StringExpression("this");
    }
    makeNull(value) {
        return new StringExpression("null");
    }
    makeVoid() {
        return this.makeUndefined();
    }
    makeLambdaReturn(expr) {
        return this.makeReturn(expr);
    }
    makeRuntimeTypeCondition(typeVarName, equals, type, varName) {
        const op = equals ? "==" : "!=";
        return this.makeNaryOp(op, [this.makeRuntimeType(type), this.makeString(typeVarName)]);
    }
    makeValueFromOption(value, destinationConvertor) {
        return this.makeString(`${value}!`);
    }
    makeNewObject(objectName, params = []) {
        return new NewObjectExpression(objectName, params);
    }
    makeFunctionCall(name, params) {
        if (typeof name === "string") {
            return new FunctionCallExpression(name, params);
        }
        return new FunctionCallExpression(name.asString(), params);
    }
    makeMethodCall(receiver, method, params, nullable) {
        return new MethodCallExpression(receiver, method, params, nullable);
    }
    // Deprecated
    // Use instead declarationCall parameter in writeConstructorImplementation(...) with DelegationType.THIS
    makeThisCall(params) {
        return new ThisCallExpression(params);
    }
    makeStaticMethodCall(receiver, method, params, nullable) {
        return new MethodStaticCallExpression(receiver, method, params, nullable);
    }
    makeFieldAccess(receiver, method, nullable) {
        return new FieldAccessExpression(receiver, method, nullable);
    }
    makeNativeCall(nativeModule, method, params, nullable) {
        return new MethodCallExpression(this.nativeReceiver(nativeModule), method, params, nullable);
    }
    makeBlock(statements, inScope = true) {
        return new BlockStatement(statements, inScope);
    }
    nativeReceiver(nativeModule) {
        return nativeModule.name;
    }
    makeDefinedCheck(value) {
        return new CheckDefinedExpression(value);
    }
    makeRuntimeTypeDefinedCheck(runtimeType) {
        return this.makeRuntimeTypeCondition(runtimeType, false, RuntimeType.UNDEFINED);
    }
    makeCondition(condition, thenStatement, elseStatement, insideIfOp, insideElseOp) {
        return new IfStatement(condition, thenStatement, elseStatement, insideIfOp, insideElseOp);
    }
    makeMultiBranchCondition(conditions, elseStatement) {
        return new MultiBranchIfStatement(conditions, elseStatement);
    }
    makeTernary(condition, trueExpression, falseExpression) {
        return new TernaryExpression(condition, trueExpression, falseExpression);
    }
    makeArrayLength(array, length) {
        return this.makeString(`${array}.length`);
    }
    makeArrayAccess(value, indexVar) {
        return this.makeString(`${value}[${indexVar}]`);
    }
    makeTupleAccess(value, index) {
        return this.makeString(`${value}[${index}]`);
    }
    makeUnionSelector(value, valueType) {
        return this.makeAssign(valueType, undefined, this.makeString(`runtimeType(${value})`), false);
    }
    makeUnionVariantCondition(_convertor, _valueName, valueType, type, _convertorIndex, _runtimeTypeIndex) {
        return this.makeString(`RuntimeType.${type.toUpperCase()} == ${valueType}`);
    }
    makeUnionVariantCast(value, type, convertor, index) {
        return this.makeString(`unsafeCast<${type}>(${value})`);
    }
    makeUnionTypeDefaultInitializer() {
        return this.makeRuntimeType(RuntimeType.UNDEFINED);
    }
    makeArrayResize(array, arrayType, length, deserializer) {
        return new ExpressionStatement(new StringExpression(""));
    }
    makeMapResize(mapTypeName, keyType, valueType, map, size, deserializer) {
        return new ExpressionStatement(new StringExpression("// TODO: TS map resize"));
    }
    makeMapSize(map) {
        return this.makeString(`${map}.size`);
    }
    makeTupleAlloc(option) {
        return new ExpressionStatement(new StringExpression(""));
    }
    makeSetUnionSelector(value, index) {
        // empty expression
        return new ExpressionStatement(new StringExpression(""));
    }
    makeSetOptionTag(value, tag) {
        // empty expression
        return new ExpressionStatement(new StringExpression(""));
    }
    makeString(value) {
        return new StringExpression(value);
    }
    makeNaryOp(op, args) {
        return new NaryOpExpression(op, args);
    }
    makeStatement(expr) {
        return new ExpressionStatement(expr);
    }
    writeNativeMethodDeclaration(method) {
        this.writeMethodDeclaration(method.name, method.signature);
    }
    writeUnsafeNativeMethodDeclaration(name, signature) {
        return;
    }
    pushIndent() {
        this.printer.pushIndent();
    }
    popIndent() {
        this.printer.popIndent();
    }
    print(string) {
        this.printer.print(string);
    }
    getOutput() {
        return this.printer.getOutput();
    }
    makeSignature(returnType, parameters) {
        return new MethodSignature(returnType, parameters.map(it => it.type));
    }
    makeNamedSignature(returnType, parameters) {
        return NamedMethodSignature.make(returnType, parameters.map(it => ({
            name: it.name,
            type: it.isOptional ? createOptionalType(it.type) : it.type
        })));
    }
    makeNativeMethodNamedSignature(returnType, parameters) {
        return this.makeNamedSignature(returnType, parameters);
    }
    makeSerializerConstructorSignatures() {
        return undefined;
    }
    mapFieldModifier(modifier) {
        return `${FieldModifier[modifier].toLowerCase()}`;
    }
    mapMethodModifier(modifier) {
        return `${MethodModifier[modifier].toLowerCase()}`;
    }
    /**
     * TODO: replace me with {@link makeUnsafeCast_}
     */
    makeUnsafeCast(param) {
        return `unsafeCast<int32>(${param})`;
    }
    makeUnsafeCast_(value, type, typeOptions) {
        return `(${value.asString()} as ${this.getNodeName(type)})`;
    }
    runtimeType(param, valueType, value) {
        this.writeStatement(this.makeAssign(valueType, IDLI32Type, this.makeFunctionCall("runtimeType", [this.makeString(value)]), false));
    }
    makeDiscriminatorFromFields(convertor, value, accessors, duplicates) {
        return this.makeString(`(${this.makeNaryOp("||", accessors.map(it => this.makeString(`${value}!.hasOwnProperty("${it}")`))).asString()})`);
    }
    makeIsTypeCall(value, decl) {
        return this.makeString(`is${decl.name}(${value})`);
    }
    makeEnumEntity(enumEntity, options) {
        return new TsEnumEntityStatement(enumEntity, { isExport: options.isExport, isDeclare: !!options.isDeclare });
    }
    makeFieldModifiersList(modifiers, customFieldFilter) {
        let allowedModifiers = this.supportedFieldModifiers;
        let modifierFilter = customFieldFilter ? customFieldFilter : function (field) {
            return allowedModifiers.includes(field);
        };
        let prefix = modifiers === null || modifiers === void 0 ? void 0 : modifiers.filter(modifierFilter).map(it => this.mapFieldModifier(it)).join(" ");
        return prefix ? prefix : "";
    }
    escapeKeyword(keyword) {
        return keyword;
    }
    makeCastCustomObject(customName, _isGenericType) {
        return this.makeString(customName);
    }
    makeHasOwnProperty(value, _valueTypeName, property, propertyTypeName) {
        const expressions = [this.makeString(`${value}.hasOwnProperty("${property}")`)];
        if (propertyTypeName) {
            expressions.push(this.makeString(`isInstanceOf("${propertyTypeName}", ${value}.${property})`));
        }
        return this.makeNaryOp("&&", expressions);
    }
    discriminatorFromExpressions(value, runtimeType, exprs) {
        return this.makeNaryOp("&&", [
            this.makeNaryOp("==", [this.makeRuntimeType(runtimeType), this.makeString(`${value}_type`)]),
            ...exprs
        ]);
    }
    makeDiscriminatorConvertor(_convertor, _value, _index) {
        return undefined;
    }
    makeNot(expr) {
        return this.makeString(`!(${expr.asString()})`);
    }
    makeSerializedBufferGetter(serializer) {
        return this.makeMethodCall(serializer, `asBuffer`, []);
    }
    makeEquals(args) {
        return this.makeNaryOp("===", args);
    }
    castToInt(value, bitness) { return value; }
    castToBoolean(value) { return value; }
    makeCallIsObject(value) {
        return this.makeString(`typeof ${value} === "object"`);
    }
    makeStaticBlock(op) {
        op(this);
    }
    instanceOf(convertor, value, _duplicateMembers) {
        return this.makeString(`${value} instanceof ${this.getNodeName(convertor.idlType)}`);
    }
    // The version of instanceOf() which does not use ArgConvertors
    typeInstanceOf(type, value, members) {
        return this.makeString(`${value} instanceof ${this.getNodeName(type)}`);
    }
    stringifyTypeOrEmpty(type) {
        if (type === undefined)
            return "";
        return this.getNodeName(type);
    }
    /**
     * Writes `namespace <namespace> {` and adds extra indent
     * @param namespace Namespace to begin
     */
    pushNamespace(namespace, options) {
        this.print(`namespace ${namespace} {`);
        if (options.ident)
            this.pushIndent();
    }
    /**
     * Writes closing brace of namespace block and removes one level of indent
     */
    popNamespace(options) {
        this.namespaceStack.pop();
        if (options.ident)
            this.popIndent();
        this.print(`}`);
    }
    static get isReferenceRelativeToNamespaces() { return this._isReferenceRelativeToNamespaces; }
    static relativeReferences(isRelative, op) {
        const prevIsRelative = this.isReferenceRelativeToNamespaces;
        this._isReferenceRelativeToNamespaces = isRelative;
        const result = op();
        this._isReferenceRelativeToNamespaces = prevIsRelative;
        return result;
    }
}
LanguageWriter._isReferenceRelativeToNamespaces = false;

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
class PrimitiveType {
    constructor(name, isPointer = false) {
        this.name = name;
        this.isPointer = isPointer;
    }
    getText() {
        return generatorConfiguration().TypePrefix + this.name;
    }
    getInterop() {
        return 'Interop' + this.name;
    }
    toString() {
        return this.getText();
    }
}
class PrimitiveTypeList {
    constructor() {
        this.Int32 = new PrimitiveType(`Int32`);
        this.Int64 = new PrimitiveType(`Int64`);
        this.Number = new PrimitiveType(`Number`);
        this.Boolean = new PrimitiveType(`Boolean`);
        this.Function = new PrimitiveType(`Function`);
        this.Undefined = new PrimitiveType(`Undefined`);
        this.Void = new PrimitiveType(`Void`);
        this.NativePointer = new PrimitiveType(`NativePointer`);
        this.Tag = new PrimitiveType(`Tag`);
        this.Materialized = new PrimitiveType(`Materialized`, true);
        this.CustomObject = new PrimitiveType(`CustomObject`, true);
        this.String = new PrimitiveType(`String`);
    }
    static get UndefinedTag() {
        return "INTEROP_TAG_UNDEFINED";
    }
    static get UndefinedRuntime() {
        return "INTEROP_RUNTIME_UNDEFINED";
    }
    static get ObjectTag() {
        return "INTEROP_TAG_OBJECT";
    }
}
const PrimitiveTypesInstance = new PrimitiveTypeList();

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
function createEmptyReferenceResolver() {
    return {
        resolveTypeReference() {
            return undefined;
        },
        toDeclaration(type) {
            return type;
        }
    };
}

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
function convertType(convertor, type) {
    if (isOptionalType(type))
        return convertor.convertOptional(type);
    if (isUnionType(type))
        return convertor.convertUnion(type);
    if (isContainerType(type))
        return convertor.convertContainer(type);
    if (isImport(type))
        return convertor.convertImport(type);
    if (isReferenceType(type)) {
        const importAttr = getExtAttribute(type, IDLExtendedAttributes.Import);
        return importAttr
            ? convertor.convertTypeReferenceAsImport(type, importAttr)
            : convertor.convertTypeReference(type);
    }
    if (isTypeParameterType(type))
        return convertor.convertTypeParameter(type);
    if (isPrimitiveType(type))
        return convertor.convertPrimitiveType(type);
    throw new Error(`Unknown type ${IDLKind[type.kind]}`);
}
function convertDeclaration(convertor, decl) {
    if (isImport(decl))
        return convertor.convertImport(decl);
    if (isNamespace(decl))
        return convertor.convertNamespace(decl);
    if (isInterface$1(decl))
        return convertor.convertInterface(decl);
    if (isEnum$1(decl))
        return convertor.convertEnum(decl);
    if (isEnumMember(decl))
        return convertor.convertEnum(decl.parent);
    if (isTypedef$1(decl))
        return convertor.convertTypedef(decl);
    if (isCallback$1(decl))
        return convertor.convertCallback(decl);
    if (isMethod(decl))
        return convertor.convertMethod(decl);
    if (isConstant$1(decl))
        return convertor.convertConstant(decl);
    throw new Error(`Unknown declaration type ${decl.kind ? IDLKind[decl.kind] : "(undefined kind)"}`);
}
function convertNode(convertor, node) {
    if (isEntry(node))
        return convertDeclaration(convertor, node);
    if (isType(node))
        return convertType(convertor, node);
    throw new Error(`Unknown node type ${IDLKind[node.kind]}`);
}

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
/**
 * Builder classes are classes with methods which have only one parameter and return only itself
 */
function isBuilderClass(declaration) {
    const className = declaration.name;
    if (generatorConfiguration().builderClasses.includes(className)) {
        return true;
    }
    // TBD: update builder class check condition.
    // Only SubTabBarStyle, BottomTabBarStyle, DotIndicator, and DigitIndicator classes
    // are used for now.
    return false;
    /*
    if (peerGeneratorConfiguration().isStandardNameIgnored(className)) {
        return false
    }

    const methods: (ts.MethodSignature | ts.MethodDeclaration)[] = [
        ...ts.isClassDeclaration(declaration) ? declaration.members.filter(ts.isMethodDeclaration) : [],
    ]

    if (methods.length === 0) {
        return false
    }

    return methods.every(it => it.type && className == it.type.getText() && it.parameters.length === 1)
    */
}

function isExternalType(declaration, resolver) {
    // declarations outside of the generator input dirs
    if (generatorConfiguration().externalTypes.get(declaration.name) != undefined)
        return true;
    // treat as external types only declarations with methods
    if (declaration.methods.length == 0)
        return false;
    const pack = getPackageName(declaration);
    if (generatorConfiguration().externalPackages.includes(pack))
        return true;
    return false;
}

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
function getSuperCandidates(declaration, resolver) {
    return declaration.inheritance
        .map(it => [resolver.resolveTypeReference(it), it])
        .filter(([it,]) => it && isInterface$1(it) && isClassSubkind(it))
        .map(it => it);
}
function getSuperTuple(declaration, resolver) {
    if (isClassSubkind(declaration)) {
        const found = declaration.inheritance.find(it => hasExtAttribute(it, IDLExtendedAttributes.Extends));
        if (found) {
            const resolved = resolver.resolveTypeReference(found);
            if (resolved && isInterface$1(resolved)) {
                return [resolved, found];
            }
        }
        const candidates = getSuperCandidates(declaration, resolver);
        if (candidates.length > 0) {
            return candidates[0];
        }
        return undefined;
    }
    const fst = declaration.inheritance[0];
    if (!fst) {
        return undefined;
    }
    const resolved = resolver.resolveTypeReference(fst);
    if (!resolved || !isInterface$1(resolved)) {
        return undefined;
    }
    return [resolved, fst];
}
function getSuper(declaration, resolver) {
    var _a;
    return (_a = getSuperTuple(declaration, resolver)) === null || _a === void 0 ? void 0 : _a[0];
}

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
function isMaterialized(declaration, resolver) {
    var _a;
    if (!isInterfaceSubkind(declaration) && !isClassSubkind(declaration))
        return false;
    if (isHandwritten(declaration) || isBuilderClass(declaration))
        return false;
    if (generatorConfiguration().forceResource.includes(declaration.name)) {
        return false;
    }
    if (generatorConfiguration().forceMaterialized.includes(declaration.name)) {
        return true;
    }
    // TODO: rework this
    // TODO: CustomComponent from components.custom config file
    if (["BaseSpan", "CustomComponent"].includes(declaration.name)) {
        return false;
    }
    for (const ignore of ["Attribute", "Method", "Interface"]) {
        if (declaration.name.endsWith(ignore)) {
            return false;
        }
    }
    if (((_a = generatorConfiguration().forceCallback.get(declaration.name)) === null || _a === void 0 ? void 0 : _a.length) === 0) {
        return false;
    }
    if (generatorConfiguration().ignoreMaterialized.includes(declaration.name)) {
        return false;
    }
    if (isExternalType(declaration)) {
        return false;
    }
    // A materialized class is a class or an interface with methods
    // excluding components and related classes
    if (declaration.methods.length > 0 || declaration.constructors.length > 0)
        return true;
    // Or a class or an interface derived from materialized class
    const superClass = getSuper(declaration, resolver);
    if (superClass) {
        const superType = superClass;
        if (!superType || !isInterface$1(superType)) {
            console.log(`Unable to resolve ${superClass.name} type, consider ${declaration.name} to be not materialized`);
            return false;
        }
        return isMaterialized(superType, resolver);
    }
    return false;
}

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
class CJTypeNameConvertor {
    constructor(resolver) {
        this.resolver = resolver;
    }
    convert(node) {
        if (isType(node) && isReferenceType(node)) {
            if (node.name.startsWith('%TEXT%:')) {
                return node.name.substring(7);
            }
        }
        return convertNode(this, node);
    }
    /***** TypeConvertor<string> **********************************/
    convertOptional(type) {
        return `Option<${this.convert(type.type)}>`;
    }
    convertUnion(type) {
        return type.name;
    }
    convertContainer(type) {
        if (IDLContainerUtils.isSequence(type)) {
            return `ArrayList<${convertType(this, type.elementType[0])}>`;
        }
        if (IDLContainerUtils.isRecord(type)) {
            const stringes = type.elementType.slice(0, 2).map(it => convertType(this, it));
            if (isReferenceType(type.elementType[0])) {
                const keyValueType = this.resolver.resolveTypeReference(type.elementType[0]);
                if (isInterface$1(keyValueType) || isEnum$1(keyValueType)) {
                    return `HashMap<Int64, ${stringes[1]}>`;
                }
            }
            return `HashMap<${stringes[0]}, ${stringes[1]}>`;
        }
        if (IDLContainerUtils.isPromise(type)) {
            return `Any`;
        }
        throw new Error(`IDL type ${DebugUtils.debugPrintType(type)} not supported`);
    }
    convertNamespace(node) {
        return node.name;
    }
    convertInterface(node) {
        return removePoints(getNamespaceName(node).concat(node.name));
    }
    convertEnum(node) {
        return removePoints(getNamespaceName(node).concat(node.name));
    }
    convertTypedef(node) {
        return node.name;
    }
    convertCallback(type) {
        const params = type.parameters.map(it => `${CJKeywords.has(it.name) ? it.name.concat("_") : it.name}: ${it.isOptional ? "?" : ""}${this.convert(it.type)}`);
        return `(${params.join(", ")}) -> ${this.convert(type.returnType)}`;
    }
    convertMethod(node) {
        throw new Error('Method not implemented.');
    }
    convertConstant(node) {
        throw new Error('Method not implemented.');
    }
    convertImport(type) {
        console.warn("Imports are not implemented yet");
        return type.name;
    }
    convertTypeReferenceAsImport(type, importClause) {
        var _a;
        const maybeTypeArguments = ((_a = type.typeArguments) === null || _a === void 0 ? void 0 : _a.length) ? `<${type.typeArguments.join(', ')}>` : "";
        let decl = this.resolver.resolveTypeReference(type);
        if (decl)
            return `${decl.name}${maybeTypeArguments}`;
        return this.convert(IDLCustomObjectType);
    }
    convertTypeReference(type) {
        var _a, _b;
        if (type.name === IDLObjectType.name)
            return "KPointer";
        // resolve synthetic types
        const decl = this.resolver.resolveTypeReference(type);
        if (decl && isSyntheticEntry(decl)) {
            if (isCallback$1(decl)) {
                return this.callbackType(decl);
            }
            const entity = getExtAttribute(decl, IDLExtendedAttributes.Entity);
            if (entity) {
                const isTuple = entity === IDLEntity.Tuple;
                return this.productType(decl, isTuple, !isTuple);
            }
        }
        let name = type.name.split('.');
        let typeArgs = (_b = (_a = type.typeArguments) === null || _a === void 0 ? void 0 : _a.map(it => this.convert(it))) !== null && _b !== void 0 ? _b : [];
        const maybeTypeArguments = !(typeArgs === null || typeArgs === void 0 ? void 0 : typeArgs.length) ? '' : `<${typeArgs.join(', ')}>`;
        if (decl) {
            return getNamespacesPathFor(decl).map(ns => ns.name).join().concat(name[name.length - 1].concat(maybeTypeArguments));
        }
        return this.convert(IDLCustomObjectType);
    }
    convertTypeParameter(type) {
        return type.name;
    }
    convertPrimitiveType(type) {
        switch (type) {
            case IDLThisType: return 'this';
            case IDLStringType: return 'String';
            case IDLBooleanType: return 'Bool';
            case IDLNumberType: return 'Float64';
            case IDLUndefinedType: return 'Unit'; // might be wrong
            case IDLI8Type: return 'Int8';
            case IDLU8Type: return 'UInt8';
            case IDLI16Type: return 'Int16';
            case IDLU16Type: return 'UInt16';
            case IDLI32Type: return 'Int32';
            case IDLU32Type: return 'UInt32';
            case IDLI64Type: return 'Int64';
            case IDLU64Type: return 'UInt64';
            case IDLF32Type: return 'Float32';
            case IDLF64Type: return 'Float64';
            case IDLPointerType: return 'UInt64';
            case IDLVoidType: return 'Unit';
            case IDLBufferType: return 'Array<UInt8>';
            case IDLInteropReturnBufferType: return 'Array<UInt8>';
            case IDLBigintType: return 'Int64';
            case IDLSerializerBuffer: return 'KSerializerBuffer';
            case IDLAnyType: return 'Any';
            case IDLDate: return 'DateTime';
            case IDLObjectType: return 'Any';
            case IDLUnknownType:
            case IDLFunctionType:
            case IDLCustomObjectType: return 'Any';
        }
        throw new Error(`Unsupported IDL primitive ${DebugUtils.debugPrintType(type)}`);
    }
    callbackType(decl) {
        const params = decl.parameters.map(it => `${CJKeywords.has(it.name) ? it.name.concat("_") : it.name}: ${this.convert(it.type)}`);
        return `((${params.join(", ")}) -> ${this.convert(decl.returnType)})`;
    }
    productType(decl, isTuple, includeFieldNames) {
        return decl.name;
    }
}
class CJIDLTypeToForeignStringConvertor extends CJTypeNameConvertor {
    convert(type) {
        if (isPrimitiveType(type)) {
            switch (type) {
                case IDLStringType: return 'CString';
                case IDLInteropReturnBufferType: return 'KInteropReturnBuffer';
                case IDLSerializerBuffer: return 'KSerializerBuffer';
                case IDLObjectType: return 'Unit';
            }
        }
        if (isContainerType(type)) {
            if (IDLContainerUtils.isSequence(type)) {
                return `CPointer<${this.convert(type.elementType[0])}>`;
            }
        }
        if (isReferenceType(type)) {
            // Fix, actual mapping has to be due to IDLType
            if (super.convert(type).startsWith('Array'))
                return `CPointer<UInt8>`;
            if (super.convert(type) == 'String' || super.convert(type) == 'KStringPtr') {
                return `CString`;
            }
            if (super.convert(type) == 'Object') {
                return `KPointer`;
            }
        }
        return super.convert(type);
    }
    convertPrimitiveType(type) {
        switch (type) {
            case IDLBufferType: return 'CPointer<UInt8>';
        }
        return super.convertPrimitiveType(type);
    }
}
function removePoints(s) {
    return s.split(/[\.\-]/g).join('_');
}

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
class GenericCppConvertor {
    constructor(resolver) {
        this.resolver = resolver;
    }
    make(text, resolvedType, noPrefix = false) {
        return { text, noPrefix, resolvedType };
    }
    convertNode(node) {
        return convertNode(this, node);
    }
    convertNamespace(node) {
        throw new Error("Internal error: namespaces are not allowed on the interop layer");
    }
    convertInterface(node) {
        switch (node.subkind) {
            case IDLInterfaceSubkind.AnonymousInterface:
                return node.name
                    ? this.make(this.qualifiedName(node), createReferenceType(node))
                    : this.make(this.computeTargetTypeLiteralName(node), createReferenceType(node), true);
            case IDLInterfaceSubkind.Interface:
            case IDLInterfaceSubkind.Class:
                if (isInIdlizeInternal(node)) {
                    return this.make(this.qualifiedName(node), createReferenceType(node), true);
                }
                return this.make(this.qualifiedName(node), createReferenceType(node));
            case IDLInterfaceSubkind.Tuple:
                return node.name
                    ? this.make(this.qualifiedName(node), createReferenceType(node))
                    : this.make(`Tuple_${node.properties.map(it => this.convertNode(maybeOptional(it.type, it.isOptional)).text).join("_")}`, createReferenceType(node), true);
        }
    }
    convertEnum(node) {
        return this.make(this.qualifiedName(node), createReferenceType(node));
    }
    convertTypedef(node) {
        return this.make(this.qualifiedName(node), createReferenceType(node));
    }
    convertCallback(node) {
        return this.make(generatorConfiguration().LibraryPrefix + this.qualifiedName(node), createReferenceType(node), true);
    }
    convertMethod(node) {
        return this.make(node.name, createReferenceType(node));
    }
    convertConstant(node) {
        return this.make(this.qualifiedName(node), createReferenceType(node));
    }
    /////////////////////////////////////////////////////////////////////////////////////////
    convertOptional(type) {
        const converted = this.convertNode(type.type);
        const prefix = generatorConfiguration().OptionalPrefix;
        if (isOptionalType(converted.resolvedType)) {
            return converted;
        }
        return this.make(prefix + converted.text, type, true);
    }
    convertUnion(type) {
        return this.make(type.name, type, false);
    }
    convertContainer(type) {
        if (IDLContainerUtils.isPromise(type)) {
            return this.make(`Promise_${this.convertNode(type.elementType[0]).text}`, type);
        }
        if (IDLContainerUtils.isSequence(type)) {
            if (type.elementType[0] === IDLU8Type) {
                return this.make(`uint8_t*`, type, true);
            }
            return this.make(`Array_${this.convertNode(type.elementType[0]).text}`, type, true);
        }
        if (IDLContainerUtils.isRecord(type)) {
            return this.make(`Map_${this.convertNode(type.elementType[0]).text}_${this.convertNode(type.elementType[1]).text}`, type, true);
        }
        throw new Error(`Unmapped container type ${DebugUtils.debugPrintType(type)}`);
    }
    convertImport(type) {
        console.warn("Imports are not implemented yet");
        return this.make(IDLCustomObjectType.name, IDLCustomObjectType);
    }
    convertTypeReferenceAsImport(type, _) {
        return this.convertTypeReference(type);
    }
    convertTypeReference(type) {
        var _a;
        const refName = type.name;
        if (generatorConfiguration().parameterized.includes(refName)) {
            return this.make('CustomObject', IDLCustomObjectType);
        }
        let decl = this.resolver.toDeclaration(type);
        if (isCallback$1(decl)) {
            decl = (_a = maybeTransformManagedCallback(decl, this.resolver)) !== null && _a !== void 0 ? _a : decl;
        }
        if (isType(decl)) {
            if (isReferenceType(decl)) {
                return this.make(`${capitalize(decl.name)}`, decl);
            }
            return this.convertNode(decl);
        }
        let res = this.convertNode(decl);
        if (type.name === "Optional")
            res = this.make("Opt_" + res.text, createOptionalType(type.typeArguments[0]), true);
        return res;
    }
    convertTypeParameter(type) {
        return this.make('CustomObject', IDLCustomObjectType);
    }
    convertPrimitiveType(type) {
        switch (type) {
            case IDLThisType: // maybe fix it in another level?
            case IDLVoidType: return this.make('void', type, true);
            case IDLI8Type: return this.make(`Int8`, type);
            case IDLU8Type: return this.make(`UInt8`, type);
            case IDLI16Type: return this.make(`Int16`, type);
            case IDLU16Type: return this.make(`UInt16`, type);
            case IDLI32Type: return this.make(`Int32`, type);
            case IDLU32Type: return this.make(`UInt32`, type);
            case IDLI64Type: return this.make(`Int64`, type);
            case IDLU64Type: return this.make(`UInt64`, type);
            case IDLF32Type: return this.make(`Float32`, type);
            case IDLF64Type: return this.make(`Float64`, type);
            case IDLNumberType: return this.make(`Number`, type);
            case IDLStringType: return this.make(`String`, type);
            case IDLBooleanType: return this.make(`Boolean`, type);
            case IDLBigintType: return this.make(`Int64`, type); // TODO add arbitrary precision numeric type
            case IDLPointerType: return this.make('NativePointer', type);
            case IDLCustomObjectType: return this.make('CustomObject', type);
            case IDLUnknownType:
            case IDLObjectType:
            case IDLAnyType: return this.make(`Object`, type);
            case IDLUndefinedType: return this.make(`Undefined`, type);
            case IDLFunctionType: return this.make(`Function`, type);
            case IDLDate: return this.make(`Date`, type);
            case IDLBufferType: return this.make('Buffer', type);
            case IDLPointerType: return this.make('Pointer', type);
            case IDLSerializerBuffer: return this.make('KSerializerBuffer', type, true);
        }
        throw new Error(`Unmapped primitive type ${DebugUtils.debugPrintType(type)}`);
    }
    qualifiedName(target) {
        return qualifiedName(target, "_", "namespace.name");
    }
    computeTargetTypeLiteralName(decl) {
        const map = new Map();
        for (const prop of decl.properties) {
            const type = this.convertNode(prop.type);
            const values = map.has(type.text) ? map.get(type.text) : [];
            values.push(prop.name);
            map.set(type.text, values);
        }
        const names = Array.from(map.keys()).map(key => `${key}_${map.get(key).join('_')}`);
        return `Literal_${names.join('_')}`;
    }
}
class CppConvertor extends GenericCppConvertor {
    unwrap(type, result) {
        const conf = generatorConfiguration();
        if (result.noPrefix) {
            return result.text;
        }
        const typePrefix = conf.TypePrefix;
        // TODO remove this ugly hack for CustomObject's
        const convertedToCustomObject = result.text === IDLCustomObjectType.name;
        const libPrefix = this.isPrimitiveOrPrimitiveAlias(type) || convertedToCustomObject ? "" : conf.LibraryPrefix;
        return `${typePrefix}${libPrefix}${result.text}`;
    }
    isPrimitiveOrPrimitiveAlias(type) {
        if (!isType(type))
            return false;
        const { resolver } = this;
        const seen = new Set;
        while (type && isReferenceType(type)) {
            const resolved = resolver.resolveTypeReference(type);
            if (!resolved)
                return false;
            if (!isTypedef$1(resolved))
                break;
            if (seen.has(resolved))
                return false;
            seen.add(resolved);
            type = resolved.type;
        }
        return isPrimitiveType(type);
    }
    convert(node) {
        return this.unwrap(node, this.convertNode(node));
    }
}
class CppNameConvertor {
    constructor(resolver) {
        this.resolver = resolver;
        this.cppConvertor = new GenericCppConvertor(resolver);
    }
    convert(node) {
        return this.cppConvertor.convertNode(node).text;
    }
}

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
class TSTypeNameConvertor {
    constructor(resolver) {
        this.resolver = resolver;
    }
    convert(node) {
        return convertNode(this, node);
    }
    convertNamespace(node) {
        return node.name;
    }
    convertInterface(node) {
        return getQualifiedName(node, "namespace.name");
    }
    convertEnum(node) {
        return getQualifiedName(node, "namespace.name");
    }
    convertTypedef(node) {
        return node.name;
    }
    convertCallback(node) {
        return isSyntheticEntry(node)
            ? this.mapCallback(node)
            : node.name;
    }
    convertMethod(node) {
        return node.name;
    }
    convertConstant(node) {
        return node.name;
    }
    convertOptional(type) {
        return `${this.convert(type.type)} | undefined`;
    }
    convertUnion(type) {
        return type.types.
            map(it => {
            return this.convert(it);
        })
            .join(' | ');
    }
    convertContainer(type) {
        if (IDLContainerUtils.isSequence(type)) {
            switch (type.elementType[0]) {
                case IDLU8Type: return 'Uint8Array'; // should be changed to Array
                case IDLI32Type: return 'Int32Array'; // should be changed to Array
                case IDLF32Type: return 'KFloat32ArrayPtr'; // should be changed to Array
                default: return `Array<${this.convert(type.elementType[0])}>`;
            }
        }
        if (IDLContainerUtils.isRecord(type)) {
            return `Map<${this.convert(type.elementType[0])}, ${this.convert(type.elementType[1])}>`;
        }
        if (IDLContainerUtils.isPromise(type)) {
            return `Promise<${this.convert(type.elementType[0])}>`;
        }
        throw new Error(`Unmapped container type ${DebugUtils.debugPrintType(type)}`);
    }
    convertImport(type) {
        console.warn("Imports are not implemented yet");
        return type.name;
    }
    convertTypeReferenceAsImport(type, importClause) {
        var _a;
        const maybeTypeArguments = ((_a = type.typeArguments) === null || _a === void 0 ? void 0 : _a.length) ? `<${type.typeArguments.join(', ')}>` : "";
        let decl = this.resolver.resolveTypeReference(type);
        if (decl)
            return `${decl.name}${maybeTypeArguments}`;
        return `${type.name}${maybeTypeArguments}`;
    }
    convertTypeReference(type) {
        var _a, _b;
        let decl = this.resolver.resolveTypeReference(type);
        if (decl) {
            if (isSyntheticEntry(decl)) {
                if (isCallback$1(decl)) {
                    return this.mapCallback(decl, type.typeArguments);
                }
                const entity = getExtAttribute(decl, IDLExtendedAttributes.Entity);
                if (entity) {
                    const isTuple = entity === IDLEntity.Tuple;
                    return this.productType(decl, type.typeArguments, isTuple, !isTuple);
                }
            }
            // FIXME: isEnumMember is not TYPE!
            if (decl && isEnumMember(decl) && decl.parent) {
                // when `interface A { field?: MyEnum.Value1 }` is generated, it is not possible
                // to deserialize A, because there is no such type information in declaration target
                // (can not cast MyEnum to exact MyEnum.Value1)
                decl = decl.parent;
            }
            let typeSpec = type.name;
            let typeArgs = (_b = (_a = type.typeArguments) === null || _a === void 0 ? void 0 : _a.map(it => this.convert(it))) !== null && _b !== void 0 ? _b : [];
            if (typeSpec === `Optional`)
                return `${typeArgs} | undefined`;
            if (typeSpec === `Function`)
                return this.mapFunctionType(typeArgs);
            const maybeTypeArguments = !(typeArgs === null || typeArgs === void 0 ? void 0 : typeArgs.length) ? '' : `<${typeArgs.join(', ')}>`;
            if (decl) {
                const path = getNamespacesPathFor(decl).map(it => it.name);
                path.push(decl.name);
                return `${path.join(".")}${maybeTypeArguments}`;
            }
            return `${type.name}${maybeTypeArguments}`;
        }
        return this.convert(IDLCustomObjectType);
    }
    convertTypeParameter(type) {
        return type.name;
    }
    convertPrimitiveType(type) {
        switch (type) {
            case IDLFunctionType: return 'Function';
            case IDLUnknownType:
            case IDLCustomObjectType: return 'any';
            case IDLThisType: return 'this';
            case IDLObjectType: return 'Object';
            case IDLAnyType: return 'any';
            case IDLUndefinedType: return 'undefined';
            case IDLPointerType: return 'KPointer';
            case IDLSerializerBuffer: return 'KSerializerBuffer';
            case IDLVoidType: return 'void';
            case IDLBooleanType: return 'boolean';
            case IDLI32Type:
                return 'int32';
            case IDLF32Type:
                return 'float32';
            case IDLI8Type:
            case IDLU8Type:
            case IDLI16Type:
            case IDLU16Type:
            case IDLU32Type:
            case IDLI64Type:
            case IDLU64Type:
            case IDLF64Type:
            case IDLNumberType:
                return 'number';
            case IDLBigintType:
                return 'bigint';
            case IDLStringType:
                return 'string';
            case IDLDate:
                return 'Date';
            case IDLBufferType:
                return 'NativeBuffer';
            case IDLInteropReturnBufferType:
                return `KInteropReturnBuffer`;
        }
        throw new Error(`Unmapped primitive type ${DebugUtils.debugPrintType(type)}`);
    }
    processTupleType(idlProperty) {
        return idlProperty;
    }
    createTypeSubstitution(parameters, args) {
        const subst = new Map();
        if (args && parameters) {
            for (let i = 0; i < args.length && i < parameters.length; ++i) {
                subst.set(parameters[i], args[i]);
            }
        }
        return subst;
    }
    applySubstitution(subst, type) {
        var _a;
        if (isContainerType(type)) {
            return createContainerType(type.containerKind, type.elementType.map(it => this.applySubstitution(subst, it)));
        }
        if (isReferenceType(type)) {
            return createReferenceType(type.name, (_a = type.typeArguments) === null || _a === void 0 ? void 0 : _a.map(it => this.applySubstitution(subst, it)));
        }
        if (isTypeParameterType(type)) {
            const record = subst.get(type.name);
            if (record) {
                return record;
            }
        }
        return type;
    }
    mapCallback(decl, args) {
        const subst = this.createTypeSubstitution(decl.typeParameters, args);
        const parameters = decl.parameters.map(it => {
            const param = clone(it);
            param.type = this.applySubstitution(subst, param.type);
            return param;
        });
        const params = parameters.map(it => `${it.isVariadic ? "..." : ""}${it.name}${it.isOptional ? "?" : ""}: ${this.convert(it.type)}${it.isVariadic ? "[]" : ""}`);
        return `((${params.join(", ")}) => ${this.convert(decl.returnType)})`;
    }
    productType(decl, args, isTuple, includeFieldNames) {
        const subst = this.createTypeSubstitution(decl.typeParameters, args);
        const name = `${isTuple ? "[" : "{"} ${decl.properties
            .map(it => isTuple ? this.processTupleType(it) : it)
            .map(it => {
            const prop = clone(it);
            prop.type = this.applySubstitution(subst, prop.type);
            return prop;
        })
            .map(it => {
            const type = this.convert(it.type);
            return it.isOptional
                ? includeFieldNames ? `${it.name}?: ${type}` : `(${type})?`
                : includeFieldNames ? `${it.name}: ${type}` : `${type}`;
        }).join(", ")} ${isTuple ? "]" : "}"}`;
        return name;
    }
    mapFunctionType(typeArgs) {
        return `Function${typeArgs.length ? `<${typeArgs.join(",")}>` : ''}`;
    }
}

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
class ETSTypeNameConvertor extends TSTypeNameConvertor {
    convertTypeReference(type) {
        let typeName = super.convertTypeReference(type);
        if (LanguageWriter.isReferenceRelativeToNamespaces && isReferenceType(type)) {
            const namespacesPath = getNamespacesPathFor(type).map(it => `${it.name}.`).join("");
            if (typeName.startsWith(namespacesPath))
                typeName = typeName.substring(namespacesPath.length);
        }
        // TODO: Fix for 'TypeError: Type 'Function<R>' is generic but type argument were not provided.'
        if (typeName === "Function") {
            return "Function<void>";
        }
        return typeName;
    }
    convertContainer(type) {
        if (IDLContainerUtils.isSequence(type)) {
            switch (type.elementType[0]) {
                case IDLU8Type: return 'KUint8ArrayPtr';
                case IDLI32Type: return 'KInt32ArrayPtr';
                case IDLF32Type: return 'KFloat32ArrayPtr';
            }
            return `Array<${this.convert(type.elementType[0])}>`;
        }
        return super.convertContainer(type);
    }
    convertPrimitiveType(type) {
        switch (type) {
            case IDLAnyType: return "object";
            case IDLUnknownType: return "object";
            case IDLPointerType: return 'KPointer';
            case IDLVoidType: return 'void';
            case IDLBooleanType: return 'boolean';
            case IDLU8Type:
            case IDLI8Type:
            case IDLI16Type:
            case IDLU16Type:
            case IDLI32Type:
            case IDLU32Type:
                return 'int32';
            case IDLI64Type:
            case IDLU64Type:
                return 'int64';
            case IDLF32Type:
                return 'float';
            case IDLF64Type:
                return 'double';
            case IDLNumberType:
                return 'number';
            case IDLStringType: return 'string';
            case IDLFunctionType: return 'Object';
            case IDLBigintType: return 'long';
            case IDLCustomObjectType: return 'object';
        }
        return super.convertPrimitiveType(type);
    }
    productType(decl, args, isTuple, includeFieldNames) {
        if (decl.subkind === IDLInterfaceSubkind.AnonymousInterface) {
            return decl.name;
        }
        return super.productType(decl, args, isTuple, includeFieldNames);
    }
    processTupleType(idlProperty) {
        if (idlProperty.isOptional) {
            return Object.assign(Object.assign({}, idlProperty), { isOptional: false, type: createUnionType([idlProperty.type, IDLUndefinedType]) });
        }
        return idlProperty;
    }
    mapCallback(decl) {
        const params = decl.parameters.map(it => {
            return `${it.name}${it.isOptional ? "?" : ""}: ${this.convert(it.type)}`;
        });
        return `((${params.join(",")}) => ${this.convert(decl.returnType)})`;
    }
    mapFunctionType(typeArgs) {
        // Fix for "TypeError: Type 'Function<R>' is generic but type argument were not provided."
        // Replace "Function" to "Function<void>"
        // Use "FunctionN" for ts compatibility
        if (typeArgs.length === 0) {
            typeArgs = [this.convert(IDLVoidType)];
        }
        return `Function${typeArgs.length - 1}<${typeArgs.join(",")}>`;
    }
}

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
function convertJavaOptional(type) {
    switch (type) {
        case 'boolean': return 'Opt_Boolean';
        case 'double': return 'Opt_Number';
    }
    return type;
}
class JavaTypeNameConvertor {
    constructor(resolver) {
        this.resolver = resolver;
        this.solidConvertor = lazy(() => new JavaIdlNodeToSolidStringConvertor(this.resolver));
        this.javaPrimitiveToReferenceTypeMap = new Map([
            ['byte', 'Byte'],
            ['short', 'Short'],
            ['int', 'Integer'],
            ['float', 'Float'],
            ['double', 'Double'],
            ['boolean', 'Boolean'],
            ['char', 'Character'],
        ]);
    }
    convert(node) {
        const typeString = convertNode(this, node);
        return this.mapTypeName(typeString);
    }
    convertNamespace(node) {
        throw new Error('Method not implemented.'); // TODO: namespace-related-to-rework
    }
    convertInterface(node) {
        if (node.subkind === IDLInterfaceSubkind.Tuple) {
            const javaTypeAliases = node.properties.map(it => convertType(this, maybeOptional(it.type, it.isOptional)));
            return `Tuple_${javaTypeAliases.join('_')}`;
        }
        return node.name;
    }
    convertEnum(node) {
        return node.name;
    }
    convertTypedef(node) {
        return node.name;
    }
    convertOptional(type) {
        return convertJavaOptional(this.convert(type.type));
    }
    convertUnion(type) {
        const aliases = type.types.map(it => convertType(this.solidConvertor.value, it));
        return `Union_${aliases.join('_')}`;
    }
    convertContainer(type) {
        if (IDLContainerUtils.isSequence(type)) {
            const javaType = convertType(this, type.elementType[0]);
            return `${javaType}[]`;
        }
        if (IDLContainerUtils.isRecord(type)) {
            const javaTypes = type.elementType.slice(0, 2).map(it => convertType(this, it)).map(this.maybeConvertPrimitiveType, this);
            return `Map<${javaTypes[0]}, ${javaTypes[1]}>`;
        }
        throw new Error(`IDL type ${DebugUtils.debugPrintType(type)} not supported`);
    }
    convertCallback(type) {
        return `Callback`;
    }
    convertMethod(type) {
        throw new Error('Method not implemented.'); // TODO: namespace-related-to-rework
    }
    convertConstant(type) {
        throw new Error('Method not implemented.'); // TODO: namespace-related-to-rework
    }
    convertImport(type) {
        console.warn("Imports are not implemented yet");
        return type.name;
    }
    convertTypeReferenceAsImport(type, importClause) {
        return type.name;
    }
    convertTypeReference(type) {
        const importAttr = getExtAttribute(type, IDLExtendedAttributes.Import);
        if (importAttr) {
            return this.convertTypeReferenceAsImport(type, importAttr);
        }
        const decl = this.resolver.resolveTypeReference(type);
        if (decl) {
            const declName = this.convert(decl);
            return declName;
        }
        if (type.name === `Optional`) {
            return convertJavaOptional(printType(type.typeArguments[0]));
        }
        return type.name;
    }
    convertTypeParameter(type) {
        // TODO
        return type.name;
    }
    convertPrimitiveType(type) {
        switch (type) {
            case IDLStringType: return 'String';
            case IDLNumberType: return 'double';
            case IDLBooleanType: return 'boolean';
            case IDLUndefinedType: return 'Ark_Undefined';
            case IDLI8Type: return 'byte';
            case IDLU8Type: return 'byte';
            case IDLI16Type: return 'short';
            case IDLU16Type: return 'short';
            case IDLI32Type: return 'int';
            case IDLU32Type: return 'int';
            case IDLI64Type: return 'long';
            case IDLU64Type: return 'long';
            case IDLF32Type: return 'float';
            case IDLF64Type: return 'double';
            case IDLPointerType: return 'long';
            case IDLVoidType: return 'void';
            case IDLDate: return 'Date';
            case IDLBufferType: return 'byte[]';
            case IDLInteropReturnBufferType: return 'byte[]';
            case IDLSerializerBuffer: return 'long';
            case IDLAnyType: return 'Ark_Object';
            case IDLUnknownType: return 'Ark_Object';
        }
        throw new Error(`Unsupported IDL primitive ${DebugUtils.debugPrintType(type)}`);
    }
    maybeConvertPrimitiveType(javaType) {
        if (this.javaPrimitiveToReferenceTypeMap.has(javaType)) {
            return this.javaPrimitiveToReferenceTypeMap.get(javaType);
        }
        return javaType;
    }
    mapTypeName(name) {
        switch (name) {
            case 'KPointer': return 'long';
            case 'KBoolean': return 'boolean';
            case 'KUInt': return 'int';
            case 'int32':
            case 'KInt': return 'int';
            case 'int64':
            case 'KLong': return 'long';
            case 'float32':
            case 'KFloat': return 'float';
            case 'KUint8ArrayPtr': return 'byte[]';
            case 'KInt32ArrayPtr': return 'int[]';
            case 'KFloat32ArrayPtr': return 'float[]';
            // case 'ArrayBuffer': return 'byte[]'
            case 'KStringPtr': return 'String';
            case 'string': return 'String';
        }
        return name.split(".").at(-1);
    }
}
class JavaIdlNodeToSolidStringConvertor extends JavaTypeNameConvertor {
    constructor() {
        super(...arguments);
        this.solidConvertor = lazy(() => this);
    }
    convertContainer(type) {
        if (IDLContainerUtils.isSequence(type)) {
            const javaTypeSolid = convertType(this, type.elementType[0]);
            return `Array_${javaTypeSolid}`;
        }
        if (IDLContainerUtils.isRecord(type)) {
            const javaTypeSolids = type.elementType.slice(0, 2).map(it => convertType(this, it)).map(this.maybeConvertPrimitiveType, this);
            return `Map_${javaTypeSolids[0]}_${javaTypeSolids[1]}`;
        }
        throw new Error(`IDL type ${DebugUtils.debugPrintType(type)} not supported`);
    }
}

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
class KotlinTypeNameConvertor {
    constructor(resolver) {
        this.resolver = resolver;
    }
    convert(node) {
        return convertNode(this, node);
    }
    convertNamespace(node) {
        return node.name;
    }
    convertInterface(node) {
        return node.name;
    }
    convertEnum(node) {
        return node.name;
    }
    convertTypedef(node) {
        return node.name;
    }
    convertCallback(node) {
        const params = node.parameters.map(it => `${it.name}: ${this.convert(it.type)}${it.isOptional ? "?" : ""}`);
        return `(${params.join(", ")}) -> ${this.convert(node.returnType)}`;
    }
    convertMethod(node) {
        return node.name;
    }
    convertConstant(node) {
        return node.name;
    }
    convertOptional(type) {
        return `${this.convert(type.type)}?`;
    }
    convertUnion(type) {
        return "Union_" + type.types.map(it => generateSyntheticIdlNodeName(it)).join("_");
    }
    convertContainer(type) {
        if (IDLContainerUtils.isSequence(type)) {
            return `ArrayList<${convertType(this, type.elementType[0])}>`;
        }
        if (IDLContainerUtils.isRecord(type)) {
            const stringes = type.elementType.slice(0, 2).map(it => convertType(this, it));
            return `MutableMap<${stringes[0]}, ${stringes[1]}>`;
        }
        if (IDLContainerUtils.isPromise(type)) {
            return `Any`;
        }
        throw new Error(`IDL type ${DebugUtils.debugPrintType(type)} not supported`);
    }
    convertImport(type) {
        throw new Error("Not implemented");
    }
    convertTypeReferenceAsImport(type, importClause) {
        throw new Error("Not implemented");
    }
    convertTypeReference(type) {
        const decl = this.resolver.resolveTypeReference(type);
        if (decl && isSyntheticEntry(decl)) {
            if (isCallback$1(decl)) {
                return this.callbackType(decl);
            }
        }
        if (decl) {
            return decl.name;
        }
        return this.convert(IDLCustomObjectType);
    }
    convertTypeParameter(type) {
        return type.name;
    }
    convertPrimitiveType(type) {
        switch (type) {
            case IDLFunctionType: return 'Function';
            case IDLUnknownType:
            case IDLCustomObjectType: return 'Any';
            case IDLThisType: return 'this';
            case IDLObjectType: return 'Object';
            case IDLAnyType: return 'Any';
            case IDLUndefinedType: return 'Nothing?';
            case IDLPointerType: return 'KPointer';
            case IDLSerializerBuffer: return 'KSerializerBuffer';
            case IDLVoidType: return 'Unit';
            case IDLBooleanType: return 'Boolean';
            case IDLI8Type: return 'Byte';
            case IDLU8Type: return 'UByte';
            case IDLI16Type: return 'Short';
            case IDLU16Type: return 'UShort';
            case IDLI32Type: return 'Int';
            case IDLU32Type: return 'UInt';
            case IDLI64Type: return 'Long';
            case IDLU64Type: return 'ULong';
            case IDLF32Type: return 'Float';
            case IDLF64Type: return 'Double';
            case IDLNumberType: return 'Double';
            case IDLBigintType:
                return 'BigInteger'; // relies on import java.math.BigInteger
            case IDLStringType:
                return 'String';
            case IDLDate:
                return 'Date';
            case IDLBufferType:
                return 'NativeBuffer';
            case IDLInteropReturnBufferType:
                return `KInteropReturnBuffer`;
        }
        throw new Error(`Unmapped primitive type ${DebugUtils.debugPrintType(type)}`);
    }
    callbackType(decl) {
        const params = decl.parameters.map(it => `${it.name}: ${this.convert(it.type)}`);
        return `((${params.join(", ")}) -> ${this.convert(decl.returnType)})`;
    }
}

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
////////////////////////////////////////////////////////////////
//                        EXPRESSIONS                         //
////////////////////////////////////////////////////////////////
class CJLambdaExpression extends LambdaExpression {
    constructor(writer, signature, resolver, body) {
        super(writer, signature, resolver, body);
        this.writer = writer;
    }
    get statementHasSemicolon() {
        return false;
    }
    asString() {
        const params = this.signature.args.map((it, i) => `${this.writer.escapeKeyword(this.signature.argName(i))}: ${this.writer.getNodeName(it)}`);
        return `{${params.join(", ")} => ${this.bodyAsString()} }`;
    }
}
class CJCheckDefinedExpression {
    constructor(value) {
        this.value = value;
    }
    asString() {
        return `${this.value}.isSome()`;
    }
}
class CJCastExpression {
    constructor(value, type, unsafe = false) {
        this.value = value;
        this.type = type;
        this.unsafe = unsafe;
    }
    asString() {
        return `match (${this.value.asString()} as ${this.type}) { case Some(x) => x; case None => throw Exception("Cast is not succeeded")}`;
    }
}
class CJMatchExpression {
    constructor(matchValue, matchCases, caseBlocks, indentDepth) {
        this.matchValue = matchValue;
        this.matchCases = matchCases;
        this.caseBlocks = caseBlocks;
        this.indentDepth = indentDepth;
    }
    asString() {
        var _a, _b, _c;
        let output = [];
        output.push(`match (${this.matchValue}) {`);
        for (let index in this.matchCases) {
            output.push(indentedBy(`case ${this.matchCases[index].asString()} => ${this.caseBlocks[index].asString()}`, ((_a = this.indentDepth) !== null && _a !== void 0 ? _a : 0) + 1));
        }
        output.push(indentedBy(`case _ => throw Exception(\"Unmatched pattern ${this.matchValue}\")`, ((_b = this.indentDepth) !== null && _b !== void 0 ? _b : 1) + 1));
        output.push(indentedBy(`}`, ((_c = this.indentDepth) !== null && _c !== void 0 ? _c : 1)));
        return output.join('\n');
    }
}
class CJTernaryExpression {
    constructor(condition, trueExpression, falseExpression) {
        this.condition = condition;
        this.trueExpression = trueExpression;
        this.falseExpression = falseExpression;
    }
    asString() {
        return `if (${this.condition.asString()}) { ${this.trueExpression.asString()} } else { ${this.falseExpression.asString()} }`;
    }
}
class CJNewObjectExpression {
    constructor(objectName, params) {
        this.objectName = objectName;
        this.params = params;
    }
    asString() {
        return `${this.objectName}(${this.params.map(it => it.asString()).join(", ")})`;
    }
}
////////////////////////////////////////////////////////////////
//                         STATEMENTS                         //
////////////////////////////////////////////////////////////////
class CJAssignStatement extends AssignStatement {
    constructor(variableName, type, expression, isDeclared = true, isConst = true) {
        super(variableName, type, expression, isDeclared, isConst);
        this.variableName = variableName;
        this.type = type;
        this.expression = expression;
        this.isDeclared = isDeclared;
        this.isConst = isConst;
    }
    write(writer) {
        var _a;
        if (this.isDeclared) {
            const typeSpec = ((_a = this.options) === null || _a === void 0 ? void 0 : _a.overrideTypeName)
                ? `: ${this.options.overrideTypeName}`
                : this.type ? `: ${writer.getNodeName(this.type)}` : "";
            const constSpec = this.isConst ? "let" : "var";
            const initValue = this.expression ? `= ${this.expression.asString()}` : "";
            writer.print(`${constSpec} ${this.variableName}${typeSpec} ${initValue}`);
        }
        else {
            writer.print(`${this.variableName} = ${this.expression.asString()}`);
        }
    }
}
class CJLoopStatement {
    constructor(counter, limit, statement) {
        this.counter = counter;
        this.limit = limit;
        this.statement = statement;
    }
    write(writer) {
        writer.print(`for (${this.counter} in 0..${this.limit}) {`);
        if (this.statement) {
            writer.pushIndent();
            this.statement.write(writer);
            writer.popIndent();
            writer.print("}");
        }
    }
}
class CJMapForEachStatement {
    constructor(map, key, value, op) {
        this.map = map;
        this.key = key;
        this.value = value;
        this.op = op;
    }
    write(writer) {
        writer.print(`for ((${this.key}, ${this.value}) in ${this.map}) {`);
        writer.pushIndent();
        this.op();
        writer.popIndent();
        writer.print(`}`);
    }
}
class CJEnumWithGetter {
    constructor(enumEntity, isExport) {
        this.enumEntity = enumEntity;
        this.isExport = isExport;
    }
    write(writer) {
        const initializers = this.enumEntity.elements.map(it => {
            return { name: it.name, id: it.initializer };
        });
        initializers.every(it => typeof it.id == 'string');
        let memberValue = 0;
        const members = [];
        for (const initializer of initializers) {
            if (typeof initializer.id == 'string') {
                members.push({ name: initializer.name, stringId: initializer.id, numberId: memberValue });
            }
            else if (typeof initializer.id == 'number') {
                memberValue = initializer.id;
                members.push({ name: initializer.name, stringId: undefined, numberId: memberValue });
            }
            else {
                members.push({ name: initializer.name, stringId: undefined, numberId: memberValue });
            }
            memberValue += 1;
        }
        let enumName = getNamespaceName(this.enumEntity).concat(this.enumEntity.name);
        writer.writeClass(enumName, () => {
            const enumType = createReferenceType(this.enumEntity);
            members.forEach(it => {
                writer.writeFieldDeclaration(it.name, enumType, [FieldModifier.PUBLIC, FieldModifier.STATIC, FieldModifier.FINAL], false, writer.makeString(`${enumName}(${it.numberId})`));
            });
            const value = 'value';
            const intType = IDLI32Type;
            writer.writeFieldDeclaration(value, intType, [FieldModifier.PUBLIC, FieldModifier.FINAL], false);
            const signature = new MethodSignature(IDLVoidType, [intType]);
            writer.writeConstructorImplementation(enumName, signature, () => {
                writer.writeStatement(writer.makeAssign(value, undefined, writer.makeString(signature.argName(0)), false));
            });
        });
    }
}
class CJThrowErrorStatement {
    constructor(message) {
        this.message = message;
    }
    write(writer) {
        writer.print(`throw Exception("${this.message}")`);
    }
}
class CJCheckOptionalStatement {
    constructor(undefinedValue, optionalExpression, doStatement) {
        this.undefinedValue = undefinedValue;
        this.optionalExpression = optionalExpression;
        this.doStatement = doStatement;
    }
    write(writer) {
        writer.print(`if (let Some(${this.optionalExpression.asString()}) <- ${this.optionalExpression.asString()}) {`);
        writer.pushIndent();
        this.doStatement.write(writer);
        writer.popIndent();
        writer.print('}');
    }
}
class CJArrayResizeStatement {
    constructor(array, arrayType, length, deserializer) {
        this.array = array;
        this.arrayType = arrayType;
        this.length = length;
        this.deserializer = deserializer;
    }
    write(writer) {
        writer.print(`${this.array} = ${this.arrayType}(Int64(${this.length}))`);
    }
}
////////////////////////////////////////////////////////////////
//                           WRITER                           //
////////////////////////////////////////////////////////////////
class CJLanguageWriter extends LanguageWriter {
    constructor(printer, resolver, typeConvertor, typeForeignConvertor, language = Language.CJ) {
        super(printer, resolver, language);
        this.typeConvertor = typeConvertor;
        this.typeForeignConvertor = typeForeignConvertor;
    }
    fork(options) {
        var _a;
        return new CJLanguageWriter(new IndentedPrinter(), (_a = options === null || options === void 0 ? void 0 : options.resolver) !== null && _a !== void 0 ? _a : this.resolver, this.typeConvertor, this.typeForeignConvertor);
    }
    getNodeName(type) {
        // rework for proper namespace logic
        return this.typeConvertor.convert(type);
    }
    writeClass(name, op, superClass, interfaces, generics) {
        let extendsClause = superClass ? `${superClass}` : undefined;
        let implementsClause = interfaces ? `${interfaces.join(' & ')}` : undefined;
        let inheritancePart = [extendsClause, implementsClause]
            .filter(isDefined)
            .join(' & ');
        inheritancePart = inheritancePart.length != 0 ? ' <: '.concat(inheritancePart) : '';
        this.printer.print(`public open class ${name}${inheritancePart} {`);
        this.pushIndent();
        op(this);
        this.popIndent();
        this.printer.print(`}`);
    }
    writeEnum(name, members, options, op) {
        this.printer.print(`public enum ${name}{`);
        this.pushIndent();
        for (const member of members) {
            this.print('|'.concat(member.name));
        }
        op(this);
        this.popIndent();
        this.printer.print(`}`);
    }
    writeInterface(name, op, superInterfaces, generics) {
        let extendsClause = superInterfaces ? ` <: ${superInterfaces.join(" & ")}` : '';
        this.printer.print(`public interface ${name}${extendsClause} {`);
        this.pushIndent();
        op(this);
        this.popIndent();
        this.printer.print(`}`);
    }
    writeFunctionDeclaration(name, signature) {
        this.printer.print(this.generateFunctionDeclaration(name, signature));
    }
    writeFunctionImplementation(name, signature, op) {
        this.printer.print(`${this.generateFunctionDeclaration(name, signature)} {`);
        this.printer.pushIndent();
        op(this);
        this.printer.popIndent();
        this.printer.print('}');
    }
    generateFunctionDeclaration(name, signature) {
        const args = signature.args.map((it, index) => `${this.escapeKeyword(signature.argName(index))}: ${this.getNodeName(it)}`);
        return `public func ${name}(${args.join(", ")}): ${this.getNodeName(signature.returnType)}`;
    }
    writeMethodCall(receiver, method, params, nullable = false) {
        params = params.map(argName => this.escapeKeyword(argName));
        if (nullable) {
            if (receiver == 'this') {
                this.printer.print('let thisObj = this');
                super.writeMethodCall('thisObj', this.escapeKeyword(method), params, false);
                return;
            }
            this.printer.print(`if (let Some(${receiver}) <- ${receiver}) { ${receiver}.${this.escapeKeyword(method)}(${params.join(", ")}) }`);
        }
        else {
            super.writeMethodCall(receiver, this.escapeKeyword(method), params, nullable);
        }
    }
    writeFieldDeclaration(name, type, modifiers, optional, initExpr) {
        const init = initExpr != undefined ? ` = ${initExpr.asString()}` : ``;
        name = this.escapeKeyword(name);
        let prefix = this.makeFieldModifiersList(modifiers);
        this.printer.print(`${prefix ? prefix.concat(" ") : ""}var ${name}: ${this.getNodeName(maybeOptional(type, optional))}${init}`);
    }
    writeMethodDeclaration(name, signature, modifiers) {
        this.writeDeclaration(name, signature, modifiers);
    }
    writeConstructorImplementation(className, signature, op, delegationCall, modifiers) {
        var _a;
        let i = 1;
        while (signature.isArgOptional(signature.args.length - i)) {
            let smallerSignature = signature.args.slice(0, -i);
            this.printer.print(`${modifiers ? modifiers.map((it) => MethodModifier[it].toLowerCase()).join(' ') + ' ' : ''}init (${smallerSignature.map((it, index) => `${this.escapeKeyword(signature.argName(index))}: ${this.getNodeName(it)}`).join(", ")}) {`);
            this.pushIndent();
            let lessArgs = (_a = signature.args) === null || _a === void 0 ? void 0 : _a.slice(0, -i).map((_, i) => this.escapeKeyword(signature.argName(i))).join(', ');
            for (let idx = 0; idx < i; idx++) {
                lessArgs = lessArgs.concat(`${i == signature.args.length && idx == 0 ? '' : ', '}Option.None`);
            }
            this.print(`${className}(${lessArgs})`);
            this.popIndent();
            this.printer.print(`}`);
            i += 1;
        }
        this.printer.print(`${modifiers ? modifiers.map((it) => MethodModifier[it].toLowerCase()).join(' ') + ' ' : ''}${className}(${signature.args.map((it, index) => `${this.escapeKeyword(signature.argName(index))}: ${this.getNodeName(maybeOptional(it, signature.isArgOptional(index)))}`).join(", ")}) {`);
        this.pushIndent();
        if (delegationCall) {
            // TBD: check delegationType to write "this" or "super"
            this.print(`super(${delegationCall.delegationArgs.map(it => it.asString()).join(", ")})`);
        }
        op(this);
        this.popIndent();
        this.printer.print(`}`);
    }
    writeTypeDeclaration(decl) {
        throw new Error(`writeTypeDeclaration not implemented`);
    }
    writeConstant(constName, constType, constVal) {
        const namespacePrefix = this.namespaceStack.join('_');
        this.print(`const ${namespacePrefix}${constName}: ${this.getNodeName(constType)} = ${constVal !== null && constVal !== void 0 ? constVal : ''}`);
    }
    writeMethodImplementation(method, op) {
        this.writeDeclaration(method.name, method.signature, method.modifiers, " {");
        this.pushIndent();
        op(this);
        this.popIndent();
        this.printer.print(`}`);
    }
    writeProperty(propName, propType, modifiers, getter, setter, initExpr) {
        let containerName = propName.concat("_container");
        let truePropName = this.escapeKeyword(propName);
        if (getter) {
            if (!getter.op) {
                this.print(`private var ${containerName}: ${this.getNodeName(propType)}`);
            }
        }
        let isStatic = modifiers.includes(FieldModifier.STATIC);
        let isMutable = !modifiers.includes(FieldModifier.READONLY);
        let initializer = initExpr ? ` = ${initExpr.asString()}` : "";
        this.print(`public ${isMutable ? "mut " : ""}${isStatic ? "static " : "open "}prop ${truePropName}: ${this.getNodeName(propType)}${initializer}`);
        if (getter) {
            this.print('{');
            this.pushIndent();
            this.writeGetterImplementation(getter.method, getter.op);
            if (isMutable) {
                if (setter) {
                    this.writeSetterImplementation(setter.method, setter ? setter.op : (writer) => { this.print(`${containerName} = ${truePropName}`); });
                }
                else {
                    this.print(`set(${truePropName}) {`);
                    this.pushIndent();
                    this.print(`${containerName} = ${truePropName}`);
                    this.popIndent();
                    this.print(`}`);
                }
            }
            this.popIndent();
            this.print('}');
        }
    }
    writeGetterImplementation(method, op) {
        this.print(`get() {`);
        this.pushIndent();
        op ? op(this) : this.print(`return ${method.signature.argsNames.map(arg => `${arg}_container`).join(', ')}`);
        this.popIndent();
        this.print('}');
    }
    writeSetterImplementation(method, op) {
        this.print(`set(${method.signature.argsNames.map(arg => this.escapeKeyword(arg)).join(', ')}) {`);
        this.pushIndent();
        op(this);
        this.popIndent();
        this.print('}');
    }
    writeCJForeign(op) {
        this.print(`foreign {`);
        this.pushIndent();
        op(this);
        this.popIndent();
        this.print('}');
    }
    writeDeclaration(name, signature, modifiers, postfix, generics) {
        let prefix = modifiers === null || modifiers === void 0 ? void 0 : modifiers.filter(it => this.supportedModifiers.includes(it)).map(it => this.mapMethodModifier(it)).join(" ");
        prefix = prefix ? prefix + " " : "public ";
        const typeParams = (generics === null || generics === void 0 ? void 0 : generics.length) ? `<${generics.join(", ")}>` : "";
        this.print(`${prefix}${((modifiers === null || modifiers === void 0 ? void 0 : modifiers.includes(MethodModifier.SETTER)) || (modifiers === null || modifiers === void 0 ? void 0 : modifiers.includes(MethodModifier.GETTER))) ? '' : `${((modifiers === null || modifiers === void 0 ? void 0 : modifiers.includes(MethodModifier.STATIC)) || (modifiers === null || modifiers === void 0 ? void 0 : modifiers.includes(MethodModifier.PRIVATE))) ? '' : 'open '}func `}${this.escapeKeyword(name)}${typeParams}(${signature.args.map((it, index) => `${this.escapeKeyword(signature.argName(index))}: ${this.getNodeName(maybeOptional(it, signature.isArgOptional(index)))}`).join(", ")})${this.getNodeName(signature.returnType) == 'this' ? '' : `: ${this.getNodeName(signature.returnType)}`}${postfix !== null && postfix !== void 0 ? postfix : ""}`);
    }
    writeNativeFunctionCall(printer, name, signature) {
        printer.print(`return unsafe { ${name}(${signature.args.map((it, index) => `${this.escapeKeyword(signature.argName(index))}`).join(", ")}) }`);
    }
    writeNativeMethodDeclaration(method) {
        let name = method.name;
        let signture = `${method.signature.args.map((it, index) => `${this.escapeKeyword(method.signature.argName(index))}: ${this.typeForeignConvertor.convert(it)}`).join(", ")}`;
        name = name.startsWith('_') ? name.slice(1) : name;
        this.print(`func ${name}(${signture}): ${this.typeForeignConvertor.convert(method.signature.returnType)}`);
    }
    i32FromEnum(value, _enumEntry) {
        return this.makeString(`${value.asString()}.value`);
    }
    makeAssign(variableName, type, expr, isDeclared = true, isConst = true) {
        return new CJAssignStatement(this.escapeKeyword(variableName), type, expr, isDeclared, isConst);
    }
    makeClassInit(type, parameters) {
        throw new Error(`makeClassInit`);
    }
    makeArrayInit(type, size) {
        return this.makeString(`ArrayList<${this.getNodeName(type.elementType[0])}>(Int64(${size !== null && size !== void 0 ? size : ''}))`);
    }
    makeMapInit(type) {
        return this.makeString(`${this.getNodeName(type)}()`);
    }
    makeArrayLength(array, length) {
        return this.makeString(`${array}.size`);
    }
    makeArrayResize(array, arrayType, length, deserializer) {
        return new CJArrayResizeStatement(array, arrayType, length, deserializer);
    }
    makeArrayAccess(value, indexVar) {
        return this.makeString(`${value}[Int64(${indexVar})]`);
    }
    makeRuntimeTypeCondition(typeVarName, equals, type, varName) {
        if (varName) {
            varName = this.escapeKeyword(varName);
            return this.makeString(`let Some(${varName}) <- ${varName}`);
        }
        else {
            const op = equals ? "==" : "!=";
            return this.makeNaryOp(op, [this.makeRuntimeType(type), this.makeString(`Int32(${typeVarName})`)]);
        }
    }
    makeLambda(signature, body) {
        return new CJLambdaExpression(this, signature, this.resolver, body);
    }
    makeThrowError(message) {
        return new CJThrowErrorStatement(message);
    }
    makeTernary(condition, trueExpression, falseExpression) {
        return new CJTernaryExpression(condition, trueExpression, falseExpression);
    }
    makeReturn(expr) {
        return new ReturnStatement(expr);
    }
    makeCheckOptional(optional, doStatement) {
        return new CJCheckOptionalStatement("undefined", optional, doStatement);
    }
    makeStatement(expr) {
        return new ExpressionStatement(expr);
    }
    makeLoop(counter, limit, statement) {
        return new CJLoopStatement(counter, limit, statement);
    }
    makeMapForEach(map, key, value, op) {
        return new CJMapForEachStatement(map, key, value, op);
    }
    makeDefinedCheck(value) {
        return new CJCheckDefinedExpression(this.escapeKeyword(value));
    }
    makeNewObject(objectName, params = []) {
        return new CJNewObjectExpression(objectName, params);
    }
    writePrintLog(message) {
        this.print(`println(\"${message}\")`);
    }
    makeCast(value, node, options) {
        var _a;
        return new CJCastExpression(value, this.getNodeName(node), (_a = options === null || options === void 0 ? void 0 : options.unsafe) !== null && _a !== void 0 ? _a : false);
    }
    typeInstanceOf(type, value, members) {
        if (isInterface$1(type)) {
            return this.makeString(`${value} is ${this.getNodeName(type)}`);
        }
        throw new Error(`typeInstanceOf fails: not class or interface: ${this.getNodeName(type)}`);
    }
    getObjectAccessor(convertor, value, args) {
        return `${value}`;
    }
    makeUndefined() {
        return this.makeString("Option.None");
    }
    makeUnwrapOptional(expression) {
        return new CJMatchExpression(this.escapeKeyword(expression.asString()), [this.makeString(`Some(unwrap_value)`)], [this.makeString(`unwrap_value`)], this.indentDepth());
    }
    makeValueFromOption(value, destinationConvertor) {
        return this.makeString(this.escapeKeyword(value));
    }
    makeRuntimeType(rt) {
        return this.makeString(`RuntimeType.${RuntimeType[rt]}.ordinal`);
    }
    makeRuntimeTypeGetterCall(value) {
        let methodCall = this.makeMethodCall("Ark_Object", "getRuntimeType", [this.makeString(value)]);
        return this.makeString(methodCall.asString() + '.ordinal');
    }
    makeMapInsert(keyAccessor, key, valueAccessor, value) {
        return this.makeStatement(this.makeMethodCall(keyAccessor, "add", [this.makeString(key), this.makeString(value)]));
    }
    makeNull(value) {
        return new StringExpression(`Option.None`);
    }
    getTagType() {
        return createReferenceType("Tags");
    }
    getRuntimeType() {
        return IDLNumberType;
    }
    makeTupleAssign(receiver, fields) {
        return this.makeAssign(receiver, undefined, this.makeString(`[${fields.map(it => `${it}!`).join(",")}]`), false);
    }
    get supportedModifiers() {
        return [MethodModifier.PUBLIC, MethodModifier.PRIVATE, MethodModifier.STATIC];
    }
    get supportedFieldModifiers() {
        return [FieldModifier.PUBLIC, FieldModifier.PRIVATE, FieldModifier.PROTECTED, FieldModifier.READONLY, FieldModifier.STATIC];
    }
    makeUnionSelector(value, valueType) {
        return this.makeAssign(valueType, undefined, this.makeMethodCall(value, "getSelector", []), false);
    }
    makeUnionVariantCondition(_convertor, _valueName, valueType, type, convertorIndex) {
        return this.makeString(`${valueType} == ${convertorIndex}`);
    }
    makeUnionVariantCast(value, type, convertor, index) {
        return this.makeMethodCall(value, `getValue${index}`, []);
    }
    makeTupleAccess(value, index) {
        return this.makeString(`${value}.value${index}`);
    }
    enumFromI32(value, enumEntry) {
        return this.makeString(`${this.getNodeName(enumEntry)}(${value.asString()})`);
    }
    makeEnumEntity(enumEntity, options) {
        return new CJEnumWithGetter(enumEntity, options.isExport);
    }
    makeEquals(args) {
        return this.makeString(`refEq(${args.map(arg => `${arg.asString()}`).join(`, `)})`);
    }
    runtimeType(param, valueType, value) {
        this.writeStatement(this.makeAssign(valueType, undefined, this.makeRuntimeTypeGetterCall(value), false));
    }
    escapeKeyword(word) {
        return CJKeywords.has(word) ? word.concat("_") : word;
    }
    pushNamespace(namespace, options) { }
    popNamespace(options) { }
    castToInt(value, bitness) {
        return `Int${bitness}(${this.escapeKeyword(value)})`;
    }
    castToBoolean(value) {
        return `if (${value}) { Int32(1) } else { Int32(0) }`;
    }
}

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
////////////////////////////////////////////////////////////////
//                         STATEMENTS                         //
////////////////////////////////////////////////////////////////
class CLikeReturnStatement extends ReturnStatement {
    constructor(expression) {
        super(expression);
        this.expression = expression;
    }
    write(writer) {
        writer.print(this.expression ? `return ${this.expression.asString()};` : "return;");
    }
}
class CDefinedExpression {
    constructor(value) {
        this.value = value;
    }
    asString() {
        return `${this.value} != ${PrimitiveTypeList.UndefinedTag}`;
    }
}
class CLikeLoopStatement {
    constructor(counter, limit, statement) {
        this.counter = counter;
        this.limit = limit;
        this.statement = statement;
    }
    write(writer) {
        writer.print(`for (int ${this.counter} = 0; ${this.counter} < ${this.limit}; ${this.counter}++) {`);
        if (this.statement) {
            writer.pushIndent();
            this.statement.write(writer);
            writer.popIndent();
            writer.print("}");
        }
    }
}
class CLikeExpressionStatement extends ExpressionStatement {
    constructor(expression) {
        super(expression);
        this.expression = expression;
    }
    write(writer) {
        const text = this.expression.asString();
        if (text.length > 0) {
            writer.print(`${this.expression.asString()};`);
        }
    }
}
class CLikeThrowErrorStatement {
    constructor(message) {
        this.message = message;
    }
    write(writer) {
        writer.print(`throw new Error("${this.message}");`);
    }
}
////////////////////////////////////////////////////////////////
//                           WRITER                           //
////////////////////////////////////////////////////////////////
class CLikeLanguageWriter extends LanguageWriter {
    constructor(printer, resolver, language) {
        super(printer, resolver, language);
    }
    writeFunctionDeclaration(name, signature) {
        this.writeMethodDeclaration(name, signature);
    }
    writeFunctionImplementation(name, signature, op) {
        this.writeMethodImplementation(new Method(name, signature), op);
    }
    makeThrowError(message) {
        return new CLikeThrowErrorStatement(message);
    }
    makeEquals(args) {
        return this.makeNaryOp("==", args);
    }
    writeMethodCall(receiver, method, params, nullable = false) {
        this.printer.print(`${receiver}.${method}(${params.join(", ")});`);
    }
    writeMethodDeclaration(name, signature, modifiers) {
        this.writeDeclaration(name, signature, modifiers, ";");
    }
    writeEnum(name, members, options, op) {
        throw new Error("WriteEnum for C-family languages is not implemented");
    }
    writeMethodImplementation(method, op) {
        this.writeDeclaration(method.name, method.signature, method.modifiers);
        this.printer.print(`{`);
        this.pushIndent();
        op(this);
        this.popIndent();
        this.printer.print(`}`);
    }
    writeDeclaration(name, signature, modifiers, postfix) {
        let prefix = modifiers === null || modifiers === void 0 ? void 0 : modifiers.filter(it => this.supportedModifiers.includes(it)).map(it => this.mapMethodModifier(it)).join(" ");
        prefix = prefix ? prefix + " " : "";
        this.print(`${prefix}${this.stringifyMethodReturnType(signature.returnType, signature.retHint())} ${name}(${signature.args.map((it, index) => `${this.stringifyMethodArgType(it, signature.argHint(index))} ${signature.argName(index)}`).join(", ")})${postfix !== null && postfix !== void 0 ? postfix : ""}`);
    }
    stringifyMethodReturnType(type, _) {
        return this.getNodeName(type);
    }
    stringifyMethodArgType(type, _) {
        return this.getNodeName(type);
    }
}

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
////////////////////////////////////////////////////////////////
//                        EXPRESSIONS                         //
////////////////////////////////////////////////////////////////
class CppCastExpression {
    constructor(convertor, value, node, options) {
        this.convertor = convertor;
        this.value = value;
        this.node = node;
        this.options = options;
    }
    asString() {
        var _a, _b, _c, _d;
        if (forceAsNamedNode(this.node).name === "Tag") {
            return `${this.value.asString()} == ${PrimitiveTypeList.UndefinedRuntime} ? ${PrimitiveTypeList.UndefinedTag} : ${PrimitiveTypeList.ObjectTag}`;
        }
        let resultName = '';
        if ((_a = this.options) === null || _a === void 0 ? void 0 : _a.overrideTypeName) {
            resultName = this.options.overrideTypeName;
        }
        else {
            const pureName = this.mapTypeWithReceiver((_b = this.options) === null || _b === void 0 ? void 0 : _b.receiver);
            const qualifiedName = ((_c = this.options) === null || _c === void 0 ? void 0 : _c.toRef) ? `${pureName}&` : pureName;
            resultName = qualifiedName;
        }
        return ((_d = this.options) === null || _d === void 0 ? void 0 : _d.unsafe)
            ? `reinterpret_cast<${resultName}>(${this.value.asString()})`
            : `static_cast<${resultName}>(${this.value.asString()})`;
    }
    mapTypeWithReceiver(receiver) {
        // make deducing type from receiver
        if (receiver !== undefined) {
            return `std::decay<decltype(${receiver})>::type`;
        }
        return this.convertor.convert(this.node);
    }
}
class CppPointerPropertyAccessExpression {
    constructor(expression, name) {
        this.expression = expression;
        this.name = name;
    }
    asString() {
        return `${this.expression}->${this.name}`;
    }
}
class CPPMethodStaticCallExpression extends MethodStaticCallExpression {
    asString() {
        return `${this.receiver}::${this.name}(${this.params.map(it => it.asString()).join(', ')})`;
    }
}
////////////////////////////////////////////////////////////////
//                         STATEMENTS                         //
////////////////////////////////////////////////////////////////
class CppAssignStatement extends AssignStatement {
    constructor(variableName, type, expression, isDeclared = true, isConst = true, options) {
        super(variableName, type, expression, isDeclared, isConst, options);
        this.variableName = variableName;
        this.type = type;
        this.expression = expression;
        this.isDeclared = isDeclared;
        this.isConst = isConst;
        this.options = options;
    }
    write(writer) {
        var _a, _b;
        if (this.isDeclared) {
            const typeName = this.type ? writer.stringifyTypeWithReceiver(this.type, (_a = this.options) === null || _a === void 0 ? void 0 : _a.receiver) : "auto";
            const typeSpec = ((_b = this.options) === null || _b === void 0 ? void 0 : _b.assignRef) ? `${typeName}&` : typeName;
            const initValue = this.expression ? this.expression.asString() : "{}";
            const constSpec = this.isConst ? "const " : "";
            writer.print(`${constSpec}${typeSpec} ${this.variableName} = ${initValue};`);
        }
        else {
            writer.print(`${this.variableName} = ${this.expression.asString()};`);
        }
    }
}
class CppArrayResizeStatement {
    constructor(array, length, deserializer) {
        this.array = array;
        this.length = length;
        this.deserializer = deserializer;
    }
    write(writer) {
        writer.print(`${this.deserializer}.resizeArray<std::decay<decltype(${this.array})>::type,
        std::decay<decltype(*${this.array}.array)>::type>(&${this.array}, ${this.length});`);
    }
}
class CppMapResizeStatement {
    constructor(mapTypeName, keyType, valueType, map, size, deserializer) {
        this.mapTypeName = mapTypeName;
        this.keyType = keyType;
        this.valueType = valueType;
        this.map = map;
        this.size = size;
        this.deserializer = deserializer;
    }
    write(writer) {
        writer.print(`${this.deserializer}.resizeMap<${this.mapTypeName}, ${writer.getNodeName(this.keyType)}, ${writer.getNodeName(this.valueType)}>(&${this.map}, ${this.size});`);
    }
}
class CppMapForEachStatement {
    constructor(map, key, value, op) {
        this.map = map;
        this.key = key;
        this.value = value;
        this.op = op;
    }
    write(writer) {
        writer.print(`for (int32_t i = 0; i < ${this.map}.size; i++) {`);
        writer.pushIndent();
        writer.print(`auto ${this.key} = ${this.map}.keys[i];`);
        writer.print(`auto ${this.value} = ${this.map}.values[i];`);
        this.op();
        writer.popIndent();
        writer.print(`}`);
    }
}
// todo:
class CppEnumEntityStatement {
    constructor(_enum) {
        this._enum = _enum;
    }
    write(writer) {
        writer.print(`typedef enum ${this._enum.name} {`);
        writer.pushIndent();
        this._enum.elements.forEach((member, index) => { var _a; return writer.print(`${member.name} = ${(_a = member.initializer) !== null && _a !== void 0 ? _a : index},`); });
        writer.popIndent();
        writer.print(`} ${this._enum.name};`);
    }
}
class CPPThrowErrorStatement {
    constructor(message) {
        this.message = message;
    }
    write(writer) {
        writer.print(`INTEROP_FATAL("${this.message}");`);
    }
}
////////////////////////////////////////////////////////////////
//                           WRITER                           //
////////////////////////////////////////////////////////////////
class CppLanguageWriter extends CLikeLanguageWriter {
    constructor(printer, resolver, typeConvertor, primitivesTypes) {
        super(printer, resolver, Language.CPP);
        this.primitivesTypes = primitivesTypes;
        this.classMode = 'normal';
        this.currentClass = [];
        this.typeConvertor = typeConvertor;
    }
    changeModeTo(mode) {
        this.classMode = mode;
    }
    getNodeName(type) {
        return this.typeConvertor.convert(type);
    }
    fork(options) {
        var _a;
        return new CppLanguageWriter(new IndentedPrinter(), (_a = options === null || options === void 0 ? void 0 : options.resolver) !== null && _a !== void 0 ? _a : this.resolver, this.typeConvertor, this.primitivesTypes);
    }
    writeDeclaration(name, signature, modifiers, postfix) {
        const realName = this.classMode === 'normal' ? name : `${this.currentClass.at(0)}::${name}`;
        const newModifiers = this.classMode === 'normal'
            ? modifiers
            : (modifiers !== null && modifiers !== void 0 ? modifiers : []).filter(it => it !== MethodModifier.STATIC).concat(MethodModifier.INLINE);
        super.writeDeclaration(realName, signature, newModifiers, postfix);
    }
    writeClass(name, op, superClass, interfaces) {
        if (this.classMode === 'normal') {
            const superClasses = (superClass ? [superClass] : []).concat(interfaces !== null && interfaces !== void 0 ? interfaces : []);
            const extendsClause = superClasses.length > 0 ? ` : ${superClasses.map(c => `public ${c}`).join(", ")}` : '';
            this.printer.print(`class ${name}${extendsClause} {`);
            this.pushIndent();
        }
        if (this.classMode === 'detached') {
            this.currentClass.push(name);
        }
        op(this);
        if (this.classMode === 'normal') {
            this.popIndent();
            this.printer.print(`};`);
        }
    }
    writeInterface(name, op, superInterfaces, generics) {
        throw new Error("Method not implemented.");
    }
    writeMethodCall(receiver, method, params, nullable = false) {
        if (nullable) {
            this.printer.print(`if (${receiver}) ${receiver}.${method}(${params.join(", ")});`);
        }
        else {
            super.writeMethodCall(receiver, method, params, nullable);
        }
    }
    writeStaticMethodCall(receiver, method, params, nullable) {
        this.printer.print(`${receiver}::${method}(${params.join(', ')});`);
    }
    writeFieldDeclaration(name, type, modifiers, optional, initExpr) {
        let filter = function (modifier_name) {
            return modifier_name !== FieldModifier.STATIC;
        };
        let prefix = this.makeFieldModifiersList(modifiers, filter);
        this.printer.print(`${prefix}:`);
        this.printer.pushIndent();
        this.printer.print(`${forceAsNamedNode(type).name} ${name};`);
        this.printer.popIndent();
    }
    writeConstructorImplementation(className, signature, op, delegationCall, modifiers) {
        const superInvocation = delegationCall
            ? ` : ${delegationCall.delegationName}(${delegationCall.delegationArgs.map(it => it.asString()).join(", ")})`
            : "";
        const argList = signature.args.map((it, index) => {
            var _a;
            const maybeDefault = ((_a = signature.defaults) === null || _a === void 0 ? void 0 : _a[index]) ? ` = ${signature.defaults[index]}` : "";
            return `${this.stringifyMethodArgType(it, signature.argHint(index))} ${signature.argName(index)}${maybeDefault}`;
        }).join(", ");
        this.print("public:");
        this.print(`${className}(${argList})${superInvocation} {`);
        this.pushIndent();
        op(this);
        this.popIndent();
        this.print(`}`);
    }
    writeProperty(propName, propType, modifiers, getter, setter) {
        throw new Error("writeProperty for c++ is not implemented yet.");
    }
    writeTypeDeclaration(decl) {
        throw new Error(`writeTypeDeclaration not implemented`);
    }
    writeConstant(constName, constType, constVal) {
        this.print(`${this.getNodeName(constType)} ${constName}${constVal ? ' = ' + constVal : ''};`);
    }
    /**
     * Writes multiline comments decorated with stars
     */
    writeMultilineCommentBlock(lines) {
        this.print('/*');
        lines.split("\n").forEach(it => this.print(' * ' + it));
        this.print(' */');
    }
    /**
     * Writes `#include "path"`
     * @param path File path to be included
     */
    writeInclude(path) {
        this.print(`#include "${path}"`);
    }
    /**
     * Writes `#include <path>`
     * @param path File path to be included
     */
    writeGlobalInclude(path) {
        this.print(`#include <${path}>`);
    }
    makeRef(type, options) {
        return createReferenceType(`${this.stringifyTypeWithReceiver(type, options === null || options === void 0 ? void 0 : options.receiver)}&`);
    }
    makeThis() {
        return new StringExpression("*this");
    }
    makeNull() {
        return new StringExpression("nullptr");
    }
    makeValueFromOption(value) {
        return this.makeString(`${value}.value`);
    }
    makeThrowError(message) {
        return new CPPThrowErrorStatement(message);
    }
    makeAssign(variableName, type, expr, isDeclared = true, isConst = true, options) {
        return new CppAssignStatement(variableName, type, expr, isDeclared, isConst, options);
    }
    makeLambda(signature, body) {
        throw new Error(`TBD`);
    }
    makeReturn(expr) {
        return new CLikeReturnStatement(expr);
    }
    makeCheckOptional(optional, doStatement) {
        throw new Error(`TBD`);
    }
    makeStatement(expr) {
        return new CLikeExpressionStatement(expr);
    }
    makeArrayAccess(value, indexVar) {
        return this.makeString(`${value}.array[${indexVar}]`);
    }
    makeTupleAccess(value, index) {
        return this.makeString(`${value}.value${index}`);
    }
    makeUnionSelector(value, valueType) {
        return this.makeAssign(valueType, undefined, this.makeString(`${value}.selector`), false);
    }
    makeUnionVariantCondition(_convertor, _valueName, valueType, type, convertorIndex) {
        return this.makeString(`${valueType} == ${convertorIndex}`);
    }
    makeUnionVariantCast(value, type, convertor, index) {
        return this.makeString(`${value}.value${index}`);
    }
    makeStaticMethodCall(receiver, method, params, nullable) {
        return new CPPMethodStaticCallExpression(receiver, method, params, nullable);
    }
    makeLoop(counter, limit, statement) {
        return new CLikeLoopStatement(counter, limit, statement);
    }
    makeMapForEach(map, key, value, op) {
        return new CppMapForEachStatement(map, key, value, op);
    }
    makeArrayInit(type) {
        return this.makeString(`{}`);
    }
    makeClassInit(type, paramenters) {
        return this.makeString(`${this.getNodeName(type)}(${paramenters.map(it => it.asString()).join(", ")})`);
    }
    makeMapInit(type) {
        return this.makeString(`{}`);
    }
    makeArrayResize(array, arrayType, length, deserializer) {
        return new CppArrayResizeStatement(array, length, deserializer);
    }
    makeMapResize(mapTypeName, keyType, valueType, map, size, deserializer) {
        return new CppMapResizeStatement(mapTypeName, keyType, valueType, map, size, deserializer);
    }
    makeCast(expr, node, options) {
        return new CppCastExpression(this.typeConvertor, expr, node, options);
    }
    makePointerPropertyAccessExpression(expression, name) {
        return new CppPointerPropertyAccessExpression(expression, name);
    }
    writePrintLog(message) {
        this.print(`printf("${message}\\n");`);
    }
    makeDefinedCheck(value) {
        return new CDefinedExpression(value);
    }
    makeSetUnionSelector(value, index) {
        return this.makeAssign(`${value}.selector`, undefined, this.makeString(index), false);
    }
    makeSetOptionTag(value, tag) {
        return this.makeAssign(`${value}.tag`, undefined, tag, false);
    }
    getObjectAccessor(convertor, value, args) {
        return value;
    }
    makeUndefined() {
        return this.makeString(`${this.primitivesTypes.Undefined.getText()}()`);
    }
    makeVoid() {
        return this.makeString(`${this.primitivesTypes.Void.getText()}()`);
    }
    makeRuntimeType(rt) {
        return this.makeString(`INTEROP_RUNTIME_${RuntimeType[rt]}`);
    }
    makeMapInsert(keyAccessor, key, valueAccessor, value) {
        // TODO: maybe use std::move?
        return new BlockStatement([
            this.makeAssign(keyAccessor, undefined, this.makeString(key), false),
            this.makeAssign(valueAccessor, undefined, this.makeString(value), false)
        ], false);
    }
    getTagType() {
        return createReferenceType('Tag');
    }
    getRuntimeType() {
        return createReferenceType(`RuntimeType`);
    }
    makeTupleAssign(receiver, tupleFields) {
        const statements = tupleFields.map((field, index) => {
            //TODO: maybe use std::move?
            return this.makeAssign(`${receiver}.value${index}`, undefined, this.makeString(field), false);
        });
        return new BlockStatement(statements, false);
    }
    get supportedModifiers() {
        return [MethodModifier.INLINE, MethodModifier.STATIC];
    }
    get supportedFieldModifiers() {
        return [];
    }
    enumFromI32(value, enumEntry) {
        return this.makeString(`static_cast<${this.typeConvertor.convert(enumEntry)}>(` + value.asString() + `)`);
    }
    makeUnsafeCast(param) {
        return param;
    }
    makeUnsafeCast_(value, type, typeOptions) {
        let typeName = this.getNodeName(type);
        switch (typeOptions) {
            case PrintHint.AsPointer:
                typeName = `${typeName}*`;
                break;
            case PrintHint.AsConstPointer:
                typeName = `const ${typeName}*`;
                break;
            case PrintHint.AsConstReference:
                typeName = `const ${typeName}&`;
                break;
        }
        return `(${typeName}) (${value.asString()})`;
    }
    i32FromEnum(value, enumEntry) {
        return this.makeString(`static_cast<${this.typeConvertor.convert(createReferenceType(enumEntry))}>(${value.asString()})`);
    }
    escapeKeyword(name) {
        return cppKeywords.has(name) ? name + "_" : name;
    }
    makeEnumEntity(enumEntity, options) {
        return new CppEnumEntityStatement(enumEntity);
    }
    decayTypeName(typeName) {
        if (typeName.endsWith('*') || typeName.endsWith('&')) {
            typeName = typeName.substring(0, typeName.length - 1);
        }
        if (typeName.startsWith('const ')) {
            typeName = typeName.substring(6);
        }
        return typeName;
    }
    stringifyMethodReturnType(type, hint) {
        const name = this.getNodeName(type);
        let postfix = '';
        if (hint === PrintHint.AsPointer || hint === PrintHint.AsConstPointer) {
            postfix = '*';
        }
        let constModifier = '';
        if (hint === PrintHint.AsConstPointer) {
            constModifier = 'const ';
        }
        return `${constModifier}${name}${postfix}`;
    }
    stringifyMethodArgType(type, hint) {
        // we should decide pass by value or by reference here
        const name = this.getNodeName(type);
        let constModifier = '';
        let postfix = '';
        switch (hint) {
            case undefined:
            case PrintHint.AsValue:
                break;
            case PrintHint.AsPointer:
                postfix = '*';
                break;
            case PrintHint.AsReference:
                postfix = '&';
                break;
            case PrintHint.AsConstPointer:
                constModifier = 'const ';
                postfix = '*';
                break;
            case PrintHint.AsConstReference:
                constModifier = 'const ';
                postfix = '&';
                break;
            default:
                throw new Error(`Unknown hint ${hint}`);
        }
        return `${constModifier}${name}${postfix}`;
    }
    stringifyTypeWithReceiver(type, receiver) {
        // make deducing type from receiver
        if (receiver !== undefined) {
            return `std::decay<decltype(${receiver})>::type`;
        }
        return this.getNodeName(type);
    }
    makeSerializerConstructorSignatures() {
        const fromBufferCtor = new NamedMethodSignature(IDLVoidType, [
            IDLSerializerBuffer,
            IDLU32Type,
            createReferenceType("CallbackResourceHolder")
        ], ["data", "dataLength", "resourceHolder"], [undefined, `0`, `nullptr`], undefined, [undefined, undefined, undefined, PrintHint.AsPointer]);
        const ownedDataCtor = new NamedMethodSignature(IDLVoidType, [
            createReferenceType("CallbackResourceHolder")
        ], ["resourceHolder"], [`nullptr`], undefined, [undefined, PrintHint.AsPointer]);
        return [ownedDataCtor, fromBufferCtor];
    }
}

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
////////////////////////////////////////////////////////////////
//                        EXPRESSIONS                         //
////////////////////////////////////////////////////////////////
class TSLambdaExpression extends LambdaExpression {
    constructor(writer, convertor, signature, resolver, body) {
        super(writer, signature, resolver, body);
        this.convertor = convertor;
    }
    get statementHasSemicolon() {
        return false;
    }
    asString() {
        const params = this.signature.args.map((it, i) => {
            const maybeOptional = isOptionalType(it) ? "?" : "";
            return `${this.signature.argName(i)}${maybeOptional}: ${this.convertor.convert(it)}`;
        });
        return `(${params.join(", ")}): ${this.convertor.convert(this.signature.returnType)} => { ${this.bodyAsString()} }`;
    }
}
class TSCastExpression {
    constructor(value, type, unsafe = false) {
        this.value = value;
        this.type = type;
        this.unsafe = unsafe;
    }
    asString() {
        return this.unsafe
            ? `unsafeCast<${this.type}>(${this.value.asString()})`
            : `(${this.value.asString()} as ${this.type})`;
    }
}
class TSUnwrapOptionalExpression {
    constructor(value) {
        this.value = value;
    }
    asString() {
        return `(${this.value.asString()})!`;
    }
}
////////////////////////////////////////////////////////////////
//                         STATEMENTS                         //
////////////////////////////////////////////////////////////////
class TSThrowErrorStatement {
    constructor(message) {
        this.message = message;
    }
    write(writer) {
        writer.print(`throw new Error("${this.message}")`);
    }
}
class TSReturnStatement extends ReturnStatement {
    constructor(expression) {
        super(expression);
        this.expression = expression;
    }
}
class TSLoopStatement {
    constructor(counter, limit, statement) {
        this.counter = counter;
        this.limit = limit;
        this.statement = statement;
    }
    write(writer) {
        writer.print(`for (let ${this.counter} = 0; ${this.counter} < ${this.limit}; ${this.counter}++) {`);
        if (this.statement) {
            writer.pushIndent();
            this.statement.write(writer);
            writer.popIndent();
            writer.print("}");
        }
    }
}
class TSMapForEachStatement {
    constructor(map, key, value, op) {
        this.map = map;
        this.key = key;
        this.value = value;
        this.op = op;
    }
    write(writer) {
        writer.print(`for (const [${this.key}, ${this.value}] of ${this.map}) {`);
        writer.pushIndent();
        this.op();
        writer.popIndent();
        writer.print(`}`);
    }
}
class TsTupleAllocStatement {
    constructor(tuple) {
        this.tuple = tuple;
    }
    write(writer) {
        writer.writeStatement(writer.makeAssign(this.tuple, undefined, writer.makeString("[]"), false, false));
    }
}
////////////////////////////////////////////////////////////////
//                           WRITER                           //
////////////////////////////////////////////////////////////////
class TSLanguageWriter extends LanguageWriter {
    constructor(printer, resolver, typeConvertor, language = Language.TS) {
        super(printer, resolver, language);
        this.typeConvertor = typeConvertor;
    }
    maybeSemicolon() { return ""; }
    pushNamespace(namespace, options) {
        this.namespaceStack.push(namespace);
        const declaredPrefix = options.isDeclared ? "declare " : "";
        this.print(`export ${declaredPrefix}namespace ${namespace} {`);
        if (options.ident)
            this.pushIndent();
    }
    fork(options) {
        var _a;
        return new TSLanguageWriter(new IndentedPrinter(), (_a = options === null || options === void 0 ? void 0 : options.resolver) !== null && _a !== void 0 ? _a : this.resolver, this.typeConvertor, this.language);
    }
    getNodeName(type) {
        // another stub. Bad one.
        // I hope that I will rewrite LWs soon
        if (isType(type) && isReferenceType(type)) {
            if (type.name.startsWith('%TEXT%:')) {
                return type.name.substring(7);
            }
        }
        return this.typeConvertor.convert(type);
    }
    writeClass(name, op, superClass, interfaces, generics, isDeclared, isAbstract) {
        let extendsClause = superClass ? ` extends ${superClass}` : '';
        let implementsClause = interfaces ? ` implements ${interfaces.join(",")}` : '';
        let genericsClause = (generics === null || generics === void 0 ? void 0 : generics.length) ? `<${generics.join(", ")}>` : '';
        let declaredClause = isDeclared ? ` declare` : '';
        let abstractClause = isAbstract ? ` abstract` : '';
        this.printer.print(`export${declaredClause}${abstractClause} class ${name}${genericsClause}${extendsClause}${implementsClause} {`);
        this.pushIndent();
        op(this);
        this.popIndent();
        this.printer.print(`}`);
    }
    writeInterface(name, op, superInterfaces, generics, isDeclared) {
        const genericsClause = (generics === null || generics === void 0 ? void 0 : generics.length) ? `<${generics.join(", ")}>` : '';
        let extendsClause = superInterfaces ? ` extends ${superInterfaces.join(",")}` : '';
        this.printer.print(`export ${isDeclared ? "declare " : ""}interface ${name}${genericsClause}${extendsClause} {`);
        this.pushIndent();
        op(this);
        this.popIndent();
        this.printer.print(`}`);
    }
    writeFunctionDeclaration(name, signature, generics) {
        this.printer.print(this.generateFunctionDeclaration(name, signature, generics));
    }
    writeFunctionImplementation(name, signature, op, generics) {
        this.printer.print(`${this.generateFunctionDeclaration(name, signature, generics)} {`);
        this.printer.pushIndent();
        op(this);
        this.printer.popIndent();
        this.printer.print('}');
    }
    generateFunctionDeclaration(name, signature, generics) {
        const rightmostRegularParameterIndex = rightmostIndexOf(signature.args, it => !isOptionalType(it));
        const args = signature.args.map((it, index) => {
            const optionalToken = isOptionalType(it) && index > rightmostRegularParameterIndex ? '?' : '';
            return `${signature.argName(index)}${optionalToken}: ${this.getNodeName(it)}`;
        });
        const returnType = this.getNodeName(signature.returnType);
        const typeParams = generics && generics.length ? '<' + (generics === null || generics === void 0 ? void 0 : generics.join(', ')) + '>' : '';
        return `export function ${name}${typeParams}(${args.join(", ")}): ${returnType}`;
    }
    writeEnum(name, members, options) {
        this.printer.print(`${options.isExport ? "export " : ""}${options.isDeclare ? "declare " : ""}enum ${name} {`);
        this.printer.pushIndent();
        for (const [index, member] of members.entries()) {
            let value;
            if (member.alias !== undefined) {
                value = member.alias;
            }
            else {
                value = `${member.stringId != undefined ? `"${member.stringId}"` : `${member.numberId}`}`;
            }
            const maybeComma = index < members.length - 1 ? "," : "";
            this.printer.print(`${member.name} = ${value}${maybeComma}`);
        }
        this.printer.popIndent();
        this.printer.print("}");
    }
    writeFieldDeclaration(name, type, modifiers, optional, initExpr) {
        const init = initExpr != undefined ? ` = ${initExpr.asString()}` : ``;
        let prefix = this.makeFieldModifiersList(modifiers);
        if (prefix)
            prefix += " ";
        this.printer.print(`${prefix}${name}${optional ? "?" : ""}: ${this.getNodeName(type)}${init}`);
    }
    writeNativeMethodDeclaration(method) {
        let name = method.name;
        let signature = method.signature;
        this.writeMethodImplementation(new Method(name, signature, [MethodModifier.STATIC]), writer => {
            const selfCallExpression = writer.makeFunctionCall(`this.${name}`, signature.args.map((_, i) => writer.makeString(this.escapeKeyword(signature.argName(i)))));
            writer.writeStatement(new IfStatement(new NaryOpExpression("==", [writer.makeFunctionCall("this._LoadOnce", []), writer.makeString("true")]), new BlockStatement([
                writer.makeReturn(selfCallExpression)
            ]), undefined, undefined, undefined));
            writer.writeStatement(writer.makeThrowError("Not implemented"));
        });
    }
    writeMethodDeclaration(name, signature, modifiers) {
        this.writeDeclaration(name, signature, true, false, modifiers);
    }
    writeConstructorImplementation(className, signature, op, delegationCall, modifiers) {
        var _a;
        this.writeDeclaration(`${modifiers ? modifiers.map((it) => MethodModifier[it].toLowerCase()).join(' ') + ' ' : ''}constructor`, signature, false, true);
        this.pushIndent();
        if (delegationCall) {
            const delegationType = ((delegationCall === null || delegationCall === void 0 ? void 0 : delegationCall.delegationType) == DelegationType.THIS) ? "this" : "super";
            this.print(`${delegationType}(${(_a = delegationCall.delegationArgs) === null || _a === void 0 ? void 0 : _a.map(it => it.asString()).join(", ")})`);
        }
        op(this);
        this.popIndent();
        this.printer.print(`}`);
    }
    writeMethodImplementation(method, op) {
        this.writeDeclaration(method.name, method.signature, true, true, method.modifiers, method.generics);
        this.pushIndent();
        op(this);
        this.popIndent();
        this.printer.print(`}`);
    }
    writeProperty(propName, propType, modifiers, getter, setter, initExpr) {
        let isStatic = modifiers.includes(FieldModifier.STATIC);
        let isMutable = !modifiers.includes(FieldModifier.READONLY);
        let containerName = propName.concat("_container");
        if (getter) {
            if (!getter.op) {
                this.print(`private var ${this.getNodeName(propType)} ${containerName}`);
            }
            this.writeGetterImplementation(new Method(propName, new MethodSignature(propType, []), isStatic ? [MethodModifier.STATIC] : []), getter ? getter.op :
                (writer) => {
                    writer.print(`return ${containerName}`);
                });
            if (isMutable) {
                const setSignature = new NamedMethodSignature(IDLVoidType, [propType], [propName]);
                this.writeSetterImplementation(new Method(propName, setSignature, isStatic ? [MethodModifier.STATIC] : []), setter ? setter.op :
                    (writer) => {
                        writer.print(`${containerName} = ${propName}`);
                    });
            }
        }
        else {
            this.writeFieldDeclaration(propName, propType, modifiers, isOptionalType(propType), initExpr);
        }
    }
    writeTypeDeclaration(decl) {
        var _a;
        const type = this.getNodeName(decl.type);
        const typeParams = ((_a = decl.typeParameters) === null || _a === void 0 ? void 0 : _a.length) ? `<${decl.typeParameters.join(",").replace("[]", "")}>` : "";
        this.print(`export type ${decl.name}${typeParams} = ${type};`);
    }
    writeConstant(constName, constType, constVal) {
        this.print(`export const ${constName}: ${this.getNodeName(constType)}${constVal ? ' = ' + constVal : ''}`);
    }
    writeDeclaration(name, signature, needReturn, needBracket, modifiers, generics) {
        let prefix = !modifiers ? undefined : this.supportedModifiers
            .filter(it => modifiers.includes(it))
            .map(it => this.mapMethodModifier(it)).join(" ");
        if (modifiers === null || modifiers === void 0 ? void 0 : modifiers.includes(MethodModifier.GETTER)) {
            prefix = `${prefix} get`;
        }
        else if (modifiers === null || modifiers === void 0 ? void 0 : modifiers.includes(MethodModifier.SETTER)) {
            prefix = `${prefix} set`;
            needReturn = false;
        }
        else if (modifiers === null || modifiers === void 0 ? void 0 : modifiers.includes(MethodModifier.FREE)) {
            prefix = `${needBracket ? "" : "declare "}function ${prefix}`;
        }
        prefix = prefix ? prefix.trim() + " " : "";
        const typeParams = (generics === null || generics === void 0 ? void 0 : generics.length) ? `<${generics.join(", ")}>` : "";
        const normalizedArgs = signature.args.map((it, i) => isOptionalType(it) && signature.isArgOptional(i) ? maybeUnwrapOptionalType(it) : it);
        this.printer.print(`${prefix}${name}${typeParams}(${normalizedArgs.map((it, index) => `${this.escapeKeyword(signature.argName(index))}${signature.isArgOptional(index) ? "?" : ``}: ${this.getNodeName(it)}${signature.argDefault(index) ? ' = ' + signature.argDefault(index) : ""}`).join(", ")})${needReturn ? ": " + this.getNodeName(signature.returnType) : ""}${needBracket ? " {" : ""}`);
    }
    makeNull() {
        return new StringExpression("undefined");
    }
    makeAssign(variableName, type, expr, isDeclared = true, isConst = true, options) {
        return new AssignStatement(variableName, type, expr, isDeclared, isConst, options);
    }
    makeLambda(signature, body) {
        return new TSLambdaExpression(this, this.typeConvertor, signature, this.resolver, body);
    }
    makeThrowError(message) {
        return new TSThrowErrorStatement(message);
    }
    makeReturn(expr) {
        return new TSReturnStatement(expr);
    }
    makeCheckOptional(optional, doStatement) {
        return new CheckOptionalStatement("undefined", optional, doStatement);
    }
    makeStatement(expr) {
        return new ExpressionStatement(expr);
    }
    makeLoop(counter, limit, statement) {
        return new TSLoopStatement(counter, limit, statement);
    }
    makeMapForEach(map, key, value, op) {
        return new TSMapForEachStatement(map, key, value, op);
    }
    writePrintLog(message) {
        this.print(`console.log("${message}")`);
    }
    makeCast(value, node, options) {
        var _a;
        return new TSCastExpression(value, this.getNodeName(node), (_a = options === null || options === void 0 ? void 0 : options.unsafe) !== null && _a !== void 0 ? _a : false);
    }
    typeInstanceOf(type, value, members) {
        if (isInterface$1(type)) {
            if (isInterfaceSubkind(type)) {
                if (!members) {
                    throw new Error("Members must be defined for interface type recognition!");
                }
                return this.makeString(members.map(it => `${value}.hasOwnProperty("${it}")`).join("&&"));
            }
            if (isClassSubkind(type)) {
                return super.typeInstanceOf(type, value, members);
            }
        }
        throw new Error(`typeInstanceOf fails: not class or interface: ${this.getNodeName(type)}`);
    }
    getObjectAccessor(convertor, value, args) {
        if (convertor.useArray && (args === null || args === void 0 ? void 0 : args.index) != undefined) {
            return `${value}[${args.index}]`;
        }
        return `${value}`;
    }
    makeUndefined() {
        return this.makeString("undefined");
    }
    makeRuntimeType(rt) {
        return this.makeString(`RuntimeType.${RuntimeType[rt]}`);
    }
    makeTupleAlloc(option) {
        return new TsTupleAllocStatement(option);
    }
    makeArrayInit(type, size) {
        var _a;
        return this.makeString(`new Array<${this.getNodeName(type.elementType[0])}>(${(_a = size === null || size === void 0 ? void 0 : size.toString()) !== null && _a !== void 0 ? _a : ''})`);
    }
    makeClassInit(type, paramenters) {
        return this.makeString(`new ${this.getNodeName(type)}(${paramenters.map(it => it.asString()).join(", ")})`);
    }
    makeMapInit(type) {
        return this.makeString(`new ${this.getNodeName(type)}()`);
    }
    makeMapInsert(keyAccessor, key, valueAccessor, value) {
        // keyAccessor and valueAccessor are equal in TS
        return this.makeStatement(this.makeMethodCall(keyAccessor, "set", [this.makeString(key), this.makeString(value)]));
    }
    makeUnwrapOptional(expression) {
        return new TSUnwrapOptionalExpression(expression);
    }
    getTagType() {
        return createReferenceType("Tags");
    }
    getRuntimeType() {
        return IDLI32Type;
    }
    makeTupleAssign(receiver, fields) {
        return this.makeAssign(receiver, undefined, this.makeString(`[${fields.map(it => `${it}!`).join(",")}]`), false);
    }
    get supportedModifiers() {
        return [MethodModifier.PUBLIC, MethodModifier.PRIVATE, MethodModifier.PROTECTED, MethodModifier.STATIC];
    }
    get supportedFieldModifiers() {
        return [FieldModifier.PUBLIC, FieldModifier.PRIVATE, FieldModifier.PROTECTED, FieldModifier.READONLY, FieldModifier.STATIC];
    }
    enumFromI32(value, enumEntry) {
        const enumName = enumEntry.name;
        const ordinal = value.asString();
        return isStringEnum(enumEntry)
            ? this.makeString(`Object.values(${enumName})[${ordinal}]`)
            : this.makeString(ordinal);
    }
    i32FromEnum(value, enumEntry) {
        const enumName = this.getNodeName(enumEntry);
        if (isEnum$1(enumEntry) && isStringEnum(enumEntry)) {
            return this.makeString(`Object.values(${enumName}).indexOf(${value.asString()})`);
        }
        return this.makeString(`${value.asString()}.valueOf()`);
    }
    castToBoolean(value) { return `+${value}`; }
    makeCallIsObject(value) {
        return this.makeString(`${value} instanceof Object`);
    }
    escapeKeyword(keyword) {
        return TSKeywords.has(keyword) ? keyword + "_" : keyword;
    }
    makeDiscriminatorConvertor(convertor, value, index) {
        const convertorNativeType = convertor.nativeType();
        const decl = this.resolver.resolveTypeReference(isReferenceType(convertorNativeType)
            ? convertorNativeType
            : createReferenceType(this.getNodeName(convertorNativeType)));
        if (decl === undefined || !isEnum$1(decl)) {
            throwException(`The type reference ${decl === null || decl === void 0 ? void 0 : decl.name} must be Enum`);
        }
        const ordinal = isStringEnum(decl)
            ? this.i32FromEnum(this.makeCast(this.makeString(this.getObjectAccessor(convertor, value)), convertor.idlType), decl)
            : this.makeUnionVariantCast(this.getObjectAccessor(convertor, value), this.getNodeName(IDLI32Type), convertor, index);
        const { low, high } = extremumOfOrdinals(decl);
        return this.discriminatorFromExpressions(value, convertor.runtimeTypes[0], [
            this.makeNaryOp(">=", [ordinal, this.makeString(low.toString())]),
            this.makeNaryOp("<=", [ordinal, this.makeString(high.toString())])
        ]);
    }
    makeSerializerConstructorSignatures() {
        return [new NamedMethodSignature(IDLVoidType, [], [])];
    }
}

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
class DeclarationNameConvertor {
    convertImport(decl) {
        console.warn("Imports are not implemented yet");
        return decl.name;
    }
    convertInterface(decl) {
        return decl.name;
    }
    convertEnum(decl) {
        return `${getNamespacesPathFor(decl).join('')}${decl.name}`;
    }
    convertTypedef(decl) {
        return decl.name;
    }
    convertCallback(decl) {
        var _a;
        return (_a = decl.name) !== null && _a !== void 0 ? _a : "MISSING CALLBACK NAME";
    }
    convertNamespace(node) {
        return node.name;
    }
    convertMethod(node) {
        return node.name;
    }
    convertConstant(node) {
        return node.name;
    }
}
DeclarationNameConvertor.I = new DeclarationNameConvertor();
class TSFeatureNameConvertor extends DeclarationNameConvertor {
    convertEnum(decl) {
        const namespace = getNamespacesPathFor(decl).map(it => it.name);
        if (namespace.length > 0)
            return namespace[0];
        return decl.name;
    }
}
TSFeatureNameConvertor.I = new TSFeatureNameConvertor();
class ETSDeclarationNameConvertor extends DeclarationNameConvertor {
    convertInterface(decl) {
        return getQualifiedName(decl, "namespace.name");
    }
    convertEnum(decl) {
        return getQualifiedName(decl, "namespace.name");
    }
}
ETSDeclarationNameConvertor.I = new ETSDeclarationNameConvertor();
class CJDeclarationNameConvertor extends DeclarationNameConvertor {
    convertInterface(decl) {
        return decl.name;
    }
    convertEnum(decl) {
        return decl.name;
    }
}
CJDeclarationNameConvertor.I = new CJDeclarationNameConvertor();
class ETSFeatureNameConvertor extends DeclarationNameConvertor {
    convertEnum(decl) {
        const namespace = getNamespacesPathFor(decl).map(it => it.name);
        if (namespace.length > 0)
            return namespace[0];
        return decl.name;
    }
}
ETSFeatureNameConvertor.I = new ETSFeatureNameConvertor();
class CJFeatureNameConvertor extends DeclarationNameConvertor {
    convertEnum(decl) {
        return decl.name;
    }
}
CJFeatureNameConvertor.I = new CJFeatureNameConvertor();
class KotlinFeatureNameConvertor extends DeclarationNameConvertor {
    convertEnum(decl) {
        return decl.name;
    }
}
KotlinFeatureNameConvertor.I = new KotlinFeatureNameConvertor();
function createDeclarationNameConvertor(language) {
    switch (language) {
        case Language.ARKTS: return ETSDeclarationNameConvertor.I;
        case Language.JAVA:
        case Language.CPP:
        case Language.TS: return DeclarationNameConvertor.I;
        case Language.CJ:        default: throw new Error(`Language ${language.toString()} is not supported`);
    }
}

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
////////////////////////////////////////////////////////////////
//                         STATEMENTS                         //
////////////////////////////////////////////////////////////////
class EtsAssignStatement {
    constructor(variableName, type, expression, isDeclared = true, isConst = true, options) {
        this.variableName = variableName;
        this.type = type;
        this.expression = expression;
        this.isDeclared = isDeclared;
        this.isConst = isConst;
        this.options = options;
    }
    write(writer) {
        var _a;
        if (this.isDeclared) {
            const typeClause = this.type !== undefined ? `: ${writer.getNodeName(this.type)}` : '';
            const maybeAssign = this.expression !== undefined ? " = " : "";
            const initValue = this.expression !== undefined ? this.expression : writer.makeString("");
            writer.print(`${this.isConst ? "const" : "let"} ${this.variableName} ${typeClause}${maybeAssign}${initValue.asString()}`);
        }
        else {
            const receiver = (_a = this.options) === null || _a === void 0 ? void 0 : _a.receiver;
            const withReceiver = receiver ? `${receiver}.` : "";
            writer.print(`${withReceiver}${this.variableName} = ${this.expression.asString()}`);
        }
    }
}
class ArkTSMapForEachStatement {
    constructor(map, key, value, op) {
        this.map = map;
        this.key = key;
        this.value = value;
        this.op = op;
    }
    write(writer) {
        writer.print(`for (const pair of ${this.map}) {`);
        writer.pushIndent();
        writer.print(`const ${this.key} = pair[0]`);
        writer.print(`const ${this.value} = pair[1]`);
        this.op();
        writer.popIndent();
        writer.print(`}`);
    }
}
class ArkTSEnumEntityStatement {
    constructor(enumEntity, options) {
        this.enumEntity = enumEntity;
        this.options = options;
    }
    write(writer) {
        let enumName = convertDeclaration(createDeclarationNameConvertor(Language.ARKTS), this.enumEntity);
        enumName = enumName.split('.').at(-1);
        const members = this.enumEntity.elements
            .flatMap((member, index) => {
            var _a;
            const initText = (_a = member.initializer) !== null && _a !== void 0 ? _a : index;
            const isTypeString = typeof initText !== "number";
            const originalName = getExtAttribute(member, IDLExtendedAttributes.OriginalEnumMemberName);
            const res = [{
                    name: member.name,
                    alias: undefined,
                    stringId: isTypeString ? initText : undefined,
                    numberId: initText
                }];
            if (originalName !== undefined) {
                res.push({
                    name: originalName,
                    alias: undefined,
                    stringId: isTypeString ? initText : undefined,
                    numberId: initText
                });
                //TODO: enums do not support member aliases
                // res.push({
                //     name: originalName,
                //     alias: member.name,
                //     stringId: undefined,
                //     numberId: initText as number
                // })
            }
            return res;
        });
        writer.writeEnum(enumName, members, { isExport: this.options.isExport, isDeclare: this.options.isDeclare });
    }
}
class ETSLambdaExpression extends LambdaExpression {
    constructor(writer, convertor, signature, resolver, body) {
        super(writer, signature, resolver, body);
        this.convertor = convertor;
    }
    get statementHasSemicolon() {
        return false;
    }
    asString() {
        const params = this.signature.args.map((it, i) => {
            const maybeOptional = isOptionalType(it) ? "?" : "";
            return `${this.signature.argName(i)}${maybeOptional}: ${this.convertor.convert(it)}`;
        });
        // Workaround to fix ArkTS error: SyntaxError: Unexpected token, arrow (=>)
        // Issue: https://rnd-gitlab-msc.huawei.com/rus-os-team/virtual-machines-and-tools/panda/-/issues/21333
        let isRetTypeCallback = isCallback$1(this.signature.returnType);
        if (isReferenceType(this.signature.returnType)) {
            const resolved = this.resolver.resolveTypeReference(this.signature.returnType);
            isRetTypeCallback = resolved !== undefined && isCallback$1(resolved);
        }
        return `(${params.join(", ")})${isRetTypeCallback
            ? "" : `:${this.convertor.convert(this.signature.returnType)}`} => { ${this.bodyAsString()} }`;
    }
}
////////////////////////////////////////////////////////////////
//                           UTILS                            //
////////////////////////////////////////////////////////////////
function generateTypeCheckerName(typeName) {
    typeName = typeName
        .replaceAll('[]', 'BracketsArray')
        .split('.').join('_');
    return `is${typeName.replaceAll('[]', 'Brackets')}`;
}
function generateEnumToNumericName(entry) {
    const typeName = getQualifiedName(entry, "namespace.name").split('.').join('_');
    return `${typeName}_ToNumeric`;
}
function generateEnumFromNumericName(entry) {
    const typeName = getQualifiedName(entry, "namespace.name").split('.').join('_');
    return `${typeName}_FromNumeric`;
}
function makeArrayTypeCheckCall(valueAccessor, typeName, writer) {
    return writer.makeMethodCall("TypeChecker", generateTypeCheckerName(typeName), [writer.makeString(valueAccessor)
    ]);
}
////////////////////////////////////////////////////////////////
//                           WRITER                           //
////////////////////////////////////////////////////////////////
class ETSLanguageWriter extends TSLanguageWriter {
    constructor(printer, resolver, typeConvertor, arrayConvertor) {
        super(printer, resolver, typeConvertor, Language.ARKTS);
        this.arrayConvertor = arrayConvertor;
    }
    fork(options) {
        var _a;
        return new ETSLanguageWriter(new IndentedPrinter(), (_a = options === null || options === void 0 ? void 0 : options.resolver) !== null && _a !== void 0 ? _a : this.resolver, this.typeConvertor, this.arrayConvertor);
    }
    makeAssign(variableName, type, expr, isDeclared = true, isConst = true, options) {
        return new EtsAssignStatement(variableName, type, expr, isDeclared, isConst, options);
    }
    makeLambda(signature, body) {
        return new ETSLambdaExpression(this, this.typeConvertor, signature, this.resolver, body);
    }
    makeMapForEach(map, key, value, op) {
        return new ArkTSMapForEachStatement(map, key, value, op);
    }
    makeMapSize(map) {
        return this.makeString(`${super.makeMapSize(map).asString()}`); // TODO: cast really needed?
    }
    get supportedModifiers() {
        return [MethodModifier.PUBLIC, MethodModifier.PRIVATE, MethodModifier.NATIVE, MethodModifier.STATIC];
    }
    runtimeType(param, valueType, value) {
        super.runtimeType(param, valueType, value);
    }
    makeUnionVariantCast(value, type, convertor, index) {
        return this.makeString(`${value} as ${type}`);
    }
    i32FromEnum(value, enumEntry) {
        if (ETSLanguageWriter.isUseTypeChecker) {
            return this.makeMethodCall('TypeChecker', generateEnumToNumericName(enumEntry), [value]);
        }
        return isStringEnum(enumEntry)
            ? this.makeMethodCall(value.asString(), 'getOrdinal', [])
            : this.makeMethodCall(value.asString(), 'valueOf', []);
    }
    enumFromI32(value, enumEntry) {
        const enumName = this.getNodeName(enumEntry);
        if (ETSLanguageWriter.isUseTypeChecker) {
            return this.makeMethodCall('TypeChecker', generateEnumFromNumericName(enumEntry), [value]);
        }
        return isStringEnum(enumEntry)
            ? this.makeString(`${enumName}.values()[${value.asString()}]`)
            : this.makeMethodCall(enumName, 'fromValue', [value]);
    }
    makeDiscriminatorFromFields(convertor, value, accessors, duplicates) {
        if (convertor instanceof AggregateConvertor
            || convertor instanceof InterfaceConvertor
            || convertor instanceof MaterializedClassConvertor
            || convertor instanceof CustomTypeConvertor) {
            return this.instanceOf(convertor, value, duplicates);
        }
        return this.makeString(`${value} instanceof ${convertor.targetType(this)}`);
    }
    makeValueFromOption(value, destinationConvertor) {
        if (isEnum$1(this.resolver.toDeclaration(destinationConvertor.nativeType()))) {
            return this.makeCast(this.makeString(value), destinationConvertor.idlType);
        }
        return super.makeValueFromOption(value, destinationConvertor);
    }
    makeIsTypeCall(value, decl) {
        return makeInterfaceTypeCheckerCall(value, decl.name, decl.properties.map(it => it.name), new Set(), this);
    }
    makeEnumEntity(enumEntity, options) {
        return new ArkTSEnumEntityStatement(enumEntity, {
            isExport: options === null || options === void 0 ? void 0 : options.isExport,
            isDeclare: !!(options === null || options === void 0 ? void 0 : options.isDeclare),
        });
    }
    getObjectAccessor(convertor, value, args) {
        return super.getObjectAccessor(convertor, value, args);
    }
    writeMethodCall(receiver, method, params, nullable = false) {
        // ArkTS does not support - 'this.?'
        super.writeMethodCall(receiver, method, params, nullable && receiver !== "this");
    }
    isQuickType(type) {
        return asPromise(type) == undefined;
    }
    writeNativeMethodDeclaration(method) {
        if (method.signature.returnType === IDLThisType) {
            throw new Error('static method can not return this!');
        }
        this.writeMethodDeclaration(method.name, method.signature, [MethodModifier.STATIC, MethodModifier.NATIVE]);
    }
    makeUnionVariantCondition(convertor, valueName, valueType, type, convertorIndex, runtimeTypeIndex) {
        if (isEnum$1(this.resolver.toDeclaration(convertor.nativeType()))) {
            return this.instanceOf(convertor, valueName);
        }
        // TODO: in ArkTS SerializerBase.runtimeType returns RuntimeType.OBJECT for enum type and not RuntimeType.NUMBER as in TS
        if (convertor instanceof UnionConvertor || convertor instanceof OptionConvertor) {
            // Unwrapping of type
            const idlType = convertor instanceof UnionConvertor
                ? convertor.nativeType().types[runtimeTypeIndex]
                : maybeUnwrapOptionalType(convertor.nativeType());
            if (idlType !== undefined && isReferenceType(idlType)) {
                const resolved = this.resolver.resolveTypeReference(idlType);
                type = resolved != undefined && isEnum$1(resolved) ? RuntimeType[RuntimeType.OBJECT] : type;
            }
        }
        return super.makeUnionVariantCondition(convertor, valueName, valueType, type, convertorIndex);
    }
    makeCastCustomObject(customName, isGenericType) {
        if (isGenericType) {
            return this.makeCast(this.makeString(customName), IDLObjectType);
        }
        return super.makeCastCustomObject(customName, isGenericType);
    }
    makeHasOwnProperty(value, valueTypeName, property, propertyTypeName) {
        return this.makeNaryOp("&&", [
            this.makeString(`${value} instanceof ${valueTypeName}`),
            this.makeString(`isInstanceOf("${propertyTypeName}", ${value}.${property})`)
        ]);
    }
    makeEquals(args) {
        // TODO: Error elimination: 'TypeError: Both operands have to be reference types'
        // the '==' operator must be used when one of the operands is a reference
        return super.makeNaryOp('==', args);
    }
    makeDiscriminatorConvertor(convertor, value, index) {
        return this.instanceOf(convertor, value);
        // Or this ????????
        // return this.discriminatorFromExpressions(value, RuntimeType.OBJECT, [
        //     makeEnumTypeCheckerCall(value, this.getNodeName(convertor.idlType), this)
        // ])
    }
    castToInt(value, bitness) {
        // This fix is used to avoid unnecessary writeInt8(value as int32) call, which is generated if value is already an int32
        // The explicit cast forces ui2abc to call valueOf on an int, which fails the compilation
        // TODO Fix this cast
        if (bitness === 8)
            return `(${value}).toChar()`;
        return `(${value}).toInt()`; // FIXME: is there int8 in ARKTS?
    }
    castToBoolean(value) { return `${value} ? 1 : 0`; }
    instanceOf(convertor, value, duplicateMembers) {
        if (convertor instanceof CustomTypeConvertor) {
            return makeInterfaceTypeCheckerCall(value, this.getNodeName(convertor.idlType), [], duplicateMembers, this);
        }
        if (convertor instanceof InterfaceConvertor || convertor instanceof MaterializedClassConvertor) {
            return makeInterfaceTypeCheckerCall(value, this.getNodeName(convertor.idlType), convertor.declaration.properties.filter(it => !it.isStatic).map(it => it.name), duplicateMembers, this);
        }
        if (convertor instanceof BufferConvertor) {
            return makeInterfaceTypeCheckerCall(value, this.getNodeName(convertor.idlType), [], new Set(), this);
        }
        if (convertor instanceof AggregateConvertor) {
            return makeInterfaceTypeCheckerCall(value, convertor.aliasName !== undefined ? convertor.aliasName : this.getNodeName(convertor.idlType), convertor.members.map(it => it[0]), duplicateMembers, this);
        }
        if (convertor instanceof ArrayConvertor) {
            return makeArrayTypeCheckCall(value, this.arrayConvertor.convert(convertor.idlType), this);
        }
        if (isEnum$1(this.resolver.toDeclaration(convertor.nativeType()))) {
            return makeEnumTypeCheckerCall(value, this.getNodeName(convertor.idlType), this);
        }
        return super.instanceOf(convertor, value, duplicateMembers);
    }
    typeInstanceOf(type, value, members) {
        if (!members || members.length === 0) {
            throw new Error("At least one member needs to provided to pass it to TypeChecker!");
        }
        const prop = members[0];
        // Use the same typeInstanceOf<T>(...) method to compile the ETS code by two compilers ArkTS and TS
        return this.makeString(`TypeChecker.typeInstanceOf<${this.getNodeName(type)}>(value, "${prop}")`);
    }
    makeTypeCast(value, type, options) {
        return this.makeString(`TypeChecker.typeCast<${this.getNodeName(type)}>(value)`);
    }
    makeCast(value, node, options) {
        var _a;
        if (node === IDLI64Type)
            return this.makeMethodCall(value.asString(), `toLong`, []);
        if (node === IDLI32Type)
            return this.makeMethodCall(value.asString(), `toInt`, []);
        if (node === IDLI8Type)
            return this.makeMethodCall(value.asString(), `toByte`, []);
        if (node === IDLF64Type)
            return this.makeMethodCall(value.asString(), `toDouble`, []);
        if (node === IDLF32Type)
            return this.makeMethodCall(value.asString(), `toFloat`, []);
        return new TSCastExpression(value, `${this.getNodeName(node)}`, (_a = options === null || options === void 0 ? void 0 : options.unsafe) !== null && _a !== void 0 ? _a : false);
    }
    static get isUseTypeChecker() { return this._isUseTypeChecker; }
    static useTypeChecker(isUseTypeChecker, op) {
        const prevIsUse = this.isReferenceRelativeToNamespaces;
        this._isUseTypeChecker = isUseTypeChecker;
        const result = op();
        this._isUseTypeChecker = prevIsUse;
        return result;
    }
}
ETSLanguageWriter._isUseTypeChecker = true;
function makeInterfaceTypeCheckerCall(valueAccessor, interfaceName, allFields, duplicates, writer) {
    return writer.makeMethodCall("TypeChecker", generateTypeCheckerName(interfaceName), [writer.makeString(valueAccessor),
        ...allFields.map(it => {
            return writer.makeString(duplicates.has(it) ? "true" : "false");
        })
    ]);
}
function makeEnumTypeCheckerCall(valueAccessor, enumName, writer) {
    return writer.makeMethodCall("TypeChecker", generateTypeCheckerName(enumName), [writer.makeString(valueAccessor)]);
}

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
////////////////////////////////////////////////////////////////
//                        EXPRESSIONS                         //
////////////////////////////////////////////////////////////////
class JavaLambdaExpression extends LambdaExpression {
    constructor(writer, signature, resolver, body) {
        super(writer, signature, resolver, body);
    }
    get statementHasSemicolon() {
        return true;
    }
    asString() {
        const params = this.signature.args.map((it, i) => `${forceAsNamedNode(it).name} ${this.signature.argName(i)}`);
        return `(${params.join(", ")}) -> { ${this.bodyAsString()} }`;
    }
}
class JavaCheckDefinedExpression {
    constructor(value) {
        this.value = value;
    }
    asString() {
        return `${this.value} != null`;
    }
}
class JavaCastExpression {
    constructor(value, type, unsafe = false) {
        this.value = value;
        this.type = type;
        this.unsafe = unsafe;
    }
    asString() {
        return `(${this.type})(${this.value.asString()})`;
    }
}
////////////////////////////////////////////////////////////////
//                         STATEMENTS                         //
////////////////////////////////////////////////////////////////
class JavaAssignStatement extends AssignStatement {
    constructor(variableName, type, expression, isDeclared = true, isConst = true) {
        super(variableName, type, expression, isDeclared, isConst);
        this.variableName = variableName;
        this.type = type;
        this.expression = expression;
        this.isDeclared = isDeclared;
        this.isConst = isConst;
    }
    write(writer) {
        if (this.isDeclared) {
            const typeSpec = this.type ? writer.getNodeName(this.type) : "var";
            writer.print(`${typeSpec} ${this.variableName} = ${this.expression.asString()};`);
        }
        else {
            writer.print(`${this.variableName} = ${this.expression.asString()};`);
        }
    }
}
class JavaMapForEachStatement {
    constructor(map, key, value, op) {
        this.map = map;
        this.key = key;
        this.value = value;
        this.op = op;
    }
    write(writer) {
        const entryVar = `${this.map}Entry`;
        writer.print(`for (var ${entryVar}: ${this.map}.entrySet()) {`);
        writer.pushIndent();
        writer.print(`var ${this.key} = ${entryVar}.getKey();`);
        writer.print(`var ${this.value} = ${entryVar}.getValue();`);
        this.op();
        writer.popIndent();
        writer.print(`}`);
    }
}
////////////////////////////////////////////////////////////////
//                           WRITER                           //
////////////////////////////////////////////////////////////////
class JavaLanguageWriter extends CLikeLanguageWriter {
    constructor(printer, resolver, typeConvertor) {
        super(printer, resolver, Language.JAVA);
        this.typeConvertor = typeConvertor;
    }
    getNodeName(type) {
        // another stub. Bad one.
        // I hope that I will rewrite LWs soon
        if (isType(type) && isReferenceType(type)) {
            if (type.name.startsWith('%TEXT%:')) {
                return type.name.substring(7);
            }
        }
        return this.typeConvertor.convert(type);
    }
    fork(options) {
        var _a;
        return new JavaLanguageWriter(new IndentedPrinter(), (_a = options === null || options === void 0 ? void 0 : options.resolver) !== null && _a !== void 0 ? _a : this.resolver, this.typeConvertor);
    }
    writeClass(name, op, superClass, interfaces, generics, isDeclared, isExport = true) {
        let genericsClause = (generics === null || generics === void 0 ? void 0 : generics.length) ? `<${generics.join(', ')}> ` : ``;
        let extendsClause = superClass ? ` extends ${superClass}` : '';
        let implementsClause = interfaces ? ` implements ${interfaces.join(",")}` : '';
        this.printer.print(`${isExport ? 'public ' : ''}class ${name}${genericsClause}${extendsClause}${implementsClause} {`); // TODO check for multiple classes in file
        this.pushIndent();
        op(this);
        this.popIndent();
        this.printer.print(`}`);
    }
    writeInterface(name, op, superInterfaces, generics) {
        let extendsClause = superInterfaces ? ` extends ${superInterfaces.join(",")}` : '';
        this.printer.print(`interface ${name}${extendsClause} {`);
        this.pushIndent();
        op(this);
        this.popIndent();
        this.printer.print(`}`);
    }
    writeMethodCall(receiver, method, params, nullable = false) {
        if (nullable) {
            this.printer.print(`if (${receiver} != null) ${receiver}.${method}(${params.join(", ")});`);
        }
        else {
            super.writeMethodCall(receiver, method, params, nullable);
        }
    }
    writeFieldDeclaration(name, type, modifiers, optional, initExpr) {
        let prefix = this.makeFieldModifiersList(modifiers);
        this.printer.print(`${prefix} ${(this.getNodeName(type))} ${name}${initExpr ? ` = ${initExpr.asString()}` : ""};`);
    }
    writeNativeMethodDeclaration(method) {
        this.writeMethodDeclaration(method.name, method.signature, [MethodModifier.STATIC, MethodModifier.NATIVE]);
    }
    writeConstructorImplementation(className, signature, op, delegationCall, modifiers) {
        this.printer.print(`${modifiers ? modifiers.map((it) => MethodModifier[it].toLowerCase()).join(' ') : ''} ${className}(${signature.args.map((it, index) => `${this.getNodeName(it)} ${signature.argName(index)}`).join(", ")}) {`);
        this.pushIndent();
        if (delegationCall) {
            this.print(`super(${delegationCall.delegationArgs.map(it => it.asString()).join(", ")});`);
        }
        op(this);
        this.popIndent();
        this.printer.print(`}`);
    }
    writeProperty(propName, propType, modifiers, getter, setter, initExpr) {
        let isStatic = modifiers.includes(FieldModifier.STATIC);
        let isMutable = !modifiers.includes(FieldModifier.READONLY);
        let containerName = propName.concat("_container");
        if (getter) {
            if (!getter.op) {
                this.print(`private var ${this.getNodeName(propType)} ${containerName};`);
            }
            this.writeGetterImplementation(new Method(propName, new MethodSignature(propType, []), isStatic ? [MethodModifier.STATIC, MethodModifier.PUBLIC] : [MethodModifier.PUBLIC]), getter ? getter.op :
                (writer) => {
                    writer.print(`return ${containerName}`);
                });
            if (isMutable) {
                const setSignature = new NamedMethodSignature(IDLVoidType, [propType], [propName]);
                this.writeSetterImplementation(new Method(propName, setSignature, isStatic ? [MethodModifier.STATIC, MethodModifier.PUBLIC] : [MethodModifier.PUBLIC]), setter ? setter.op :
                    (writer) => {
                        writer.print(`${containerName} = ${propName};`);
                    });
            }
        }
        else {
            // TBD: use initExpr
            this.writeMethodDeclaration(propName, new MethodSignature(propType, []));
        }
    }
    writeTypeDeclaration(decl) {
        throw new Error(`Type declarations do not exist in Java, use something else`);
    }
    writeConstant(constName, constType, constVal) {
        throw new Error("writeConstant for Java is not implemented yet.");
    }
    makeAssign(variableName, type, expr, isDeclared = true, isConst = true) {
        return new JavaAssignStatement(variableName, type, expr, isDeclared, isConst);
    }
    makeLambda(signature, body) {
        return new JavaLambdaExpression(this, signature, this.resolver, body);
    }
    makeReturn(expr) {
        return new CLikeReturnStatement(expr);
    }
    makeCheckOptional(optional, doStatement) {
        return new CheckOptionalStatement("null", optional, doStatement);
    }
    makeDefinedCheck(value) {
        return new JavaCheckDefinedExpression(value);
    }
    makeLoop(counter, limit, statement) {
        return new CLikeLoopStatement(counter, limit, statement);
    }
    makeMapForEach(map, key, value, op) {
        return new JavaMapForEachStatement(map, key, value, op);
    }
    makeMapSize(map) {
        return this.makeString(`${map}.size()`);
    }
    makeCast(value, node, options) {
        var _a;
        return new JavaCastExpression(value, this.getNodeName(node), (_a = options === null || options === void 0 ? void 0 : options.unsafe) !== null && _a !== void 0 ? _a : false);
    }
    makeStatement(expr) {
        return new CLikeExpressionStatement(expr);
    }
    makeUnionSelector(value, valueType) {
        return this.makeAssign(valueType, undefined, this.makeMethodCall(value, "getSelector", []), false);
    }
    makeUnionVariantCondition(_convertor, _valueName, valueType, _type, convertorIndex) {
        return this.makeString(`${valueType} == ${convertorIndex}`);
    }
    makeUnionVariantCast(value, type, convertor, index) {
        return this.makeMethodCall(value, `getValue${index}`, []);
    }
    makeUnionTypeDefaultInitializer() {
        return this.makeString("-1");
    }
    writePrintLog(message) {
        this.print(`System.out.println("${message}")`);
    }
    mapIDLContainerType(type) {
        switch (type.containerKind) {
            case "sequence": return `${this.getNodeName(type.elementType[0])}[]`;
        }
        throw new Error(`Unmapped container type ${DebugUtils.debugPrintType(type)}`);
    }
    applyToObject(p, param, value, args) {
        throw new Error("Method not implemented.");
    }
    getObjectAccessor(convertor, value, args) {
        return value;
    }
    makeUndefined() {
        return this.makeString("null");
    }
    makeRuntimeType(rt) {
        return this.makeString(`RuntimeType.${RuntimeType[rt]}`);
    }
    makeRuntimeTypeGetterCall(value) {
        return this.makeMethodCall("Ark_Object", "getRuntimeType", [this.makeString(value)]);
    }
    makeMapInsert(keyAccessor, key, valueAccessor, value) {
        throw new Error("Method not implemented.");
    }
    getTagType() {
        throw new Error("Method not implemented.");
    }
    getRuntimeType() {
        throw new Error("Method not implemented.");
    }
    makeTupleAssign(receiver, tupleFields) {
        throw new Error("Method not implemented.");
    }
    get supportedModifiers() {
        return [MethodModifier.PUBLIC, MethodModifier.PRIVATE, MethodModifier.STATIC, MethodModifier.NATIVE];
    }
    get supportedFieldModifiers() {
        return [FieldModifier.PUBLIC, FieldModifier.PRIVATE, FieldModifier.PROTECTED, FieldModifier.STATIC, FieldModifier.FINAL];
    }
    makeArrayInit(type, size) {
        return this.makeString(`new ${this.getNodeName(type.elementType[0])}[${size !== null && size !== void 0 ? size : 0}]`);
    }
    makeClassInit(type, paramenters) {
        throw new Error("Method not implemented.");
    }
    makeMapInit(type) {
        throw new Error("Method not implemented.");
    }
    makeTupleAccess(value, index) {
        return this.makeString(`${value}.value${index}`);
    }
    enumFromI32(value, enumEntry) {
        const enumName = forceAsNamedNode(enumEntry).name;
        const ordinal = value.asString();
        return this.makeString(`${enumName}.values()[${ordinal}]`);
    }
    makeValueFromOption(value) {
        return this.makeString(`${value}`);
    }
    runtimeType(param, valueType, value) {
        this.writeStatement(this.makeAssign(valueType, undefined, this.makeRuntimeTypeGetterCall(value), false));
    }
    i32FromEnum(value, enumEntry) {
        const i32Value = isStringEnum(enumEntry)
            ? `${value.asString()}.ordinal`
            : `${value.asString()}.value`;
        return this.makeString(i32Value);
    }
    castToBoolean(value) { return value; }
}

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
class KotlinLambdaReturnStatement {
    constructor(expression) {
        this.expression = expression;
    }
    write(writer) {
        if (this.expression)
            writer.print(`${this.expression.asString()}`);
    }
}
class KotlinEnumWithGetter {
    constructor(enumEntity, isExport) {
        this.enumEntity = enumEntity;
        this.isExport = isExport;
    }
    write(writer) {
        const initializers = this.enumEntity.elements.map(it => {
            return { name: it.name, id: it.initializer };
        });
        const isStringEnum = initializers.every(it => typeof it.id == 'string');
        let memberValue = 0;
        const members = [];
        for (const initializer of initializers) {
            if (typeof initializer.id == 'string') {
                members.push({ name: initializer.name, stringId: initializer.id, numberId: memberValue });
            }
            else if (typeof initializer.id == 'number') {
                memberValue = initializer.id;
                members.push({ name: initializer.name, stringId: undefined, numberId: memberValue });
            }
            else {
                members.push({ name: initializer.name, stringId: undefined, numberId: memberValue });
            }
            memberValue += 1;
        }
        let mangledName = removePoints(getQualifiedName(this.enumEntity, 'namespace.name'));
        writer.writeClass(mangledName, () => {
            createReferenceType(this.enumEntity);
            writer.makeStaticBlock(() => {
                members.forEach(it => {
                    writer.writeFieldDeclaration(it.name, IDLAnyType, [FieldModifier.PUBLIC, FieldModifier.STATIC, FieldModifier.FINAL], false, writer.makeString(`${mangledName}(${it.stringId ? `\"${it.stringId}\"` : it.numberId})`));
                });
            });
            const value = 'value';
            writer.writeFieldDeclaration(value, IDLI32Type, [FieldModifier.PUBLIC], true, writer.makeNull());
            const signature = new MethodSignature(IDLVoidType, [IDLI32Type]);
            writer.writeConstructorImplementation('constructor', signature, () => {
                writer.writeStatement(writer.makeAssign(`this.${value}`, undefined, writer.makeString(signature.argName(0)), false));
            });
            if (isStringEnum) {
                const stringValue = 'stringValue';
                writer.writeFieldDeclaration(stringValue, IDLStringType, [FieldModifier.PUBLIC], true, writer.makeNull());
                const signature = new MethodSignature(IDLVoidType, [IDLStringType]);
                writer.writeConstructorImplementation('constructor', signature, () => {
                    writer.writeStatement(writer.makeAssign(`this.${stringValue}`, undefined, writer.makeString(signature.argName(0)), false));
                });
            }
        });
    }
}
class KotlinMapForEachStatement {
    constructor(map, key, value, op) {
        this.map = map;
        this.key = key;
        this.value = value;
        this.op = op;
    }
    write(writer) {
        writer.print(`for ((${this.key}, ${this.value}) in ${this.map}) {`);
        writer.pushIndent();
        this.op();
        writer.popIndent();
        writer.print(`}`);
    }
}
class KotlinThrowErrorStatement {
    constructor(message) {
        this.message = message;
    }
    write(writer) {
        writer.print(`throw Error("${this.message}")`);
    }
}
class KotlinArrayResizeStatement {
    constructor(array, arrayType, length, deserializer) {
        this.array = array;
        this.arrayType = arrayType;
        this.length = length;
        this.deserializer = deserializer;
    }
    write(writer) {
        writer.print(`${this.array} = ${this.arrayType}(${this.length})`);
    }
}
class KotlinLoopStatement {
    constructor(counter, limit, statement) {
        this.counter = counter;
        this.limit = limit;
        this.statement = statement;
    }
    write(writer) {
        writer.print(`for (${this.counter} in 0..${this.limit}) {`);
        if (this.statement) {
            writer.pushIndent();
            this.statement.write(writer);
            writer.popIndent();
            writer.print("}");
        }
    }
}
class KotlinAssignStatement extends AssignStatement {
    constructor(variableName, type, expression, isDeclared = true, isConst = true) {
        super(variableName, type, expression, isDeclared, isConst);
        this.variableName = variableName;
        this.type = type;
        this.expression = expression;
        this.isDeclared = isDeclared;
        this.isConst = isConst;
    }
    write(writer) {
        var _a;
        if (this.isDeclared) {
            const typeSpec = ((_a = this.options) === null || _a === void 0 ? void 0 : _a.overrideTypeName)
                ? `: ${this.options.overrideTypeName}`
                : this.type ? `: ${writer.getNodeName(this.type)}` : "";
            const constSpec = this.isConst ? "val" : "var";
            const initValue = this.expression ? `= ${this.expression.asString()}` : "";
            writer.print(`${constSpec} ${this.variableName}${typeSpec} ${initValue}`);
        }
        else {
            writer.print(`${this.variableName} = ${this.expression.asString()}`);
        }
    }
}
class KotlinNewObjectExpression {
    constructor(objectName, params) {
        this.objectName = objectName;
        this.params = params;
    }
    asString() {
        return `${this.objectName}(${this.params.map(it => it.asString()).join(", ")})`;
    }
}
class KotlinCheckDefinedExpression {
    constructor(value) {
        this.value = value;
    }
    asString() {
        return `${this.value} != null`;
    }
}
class KotlinUnwrapOptionalExpression {
    constructor(value) {
        this.value = value;
    }
    asString() {
        return `requireNotNull(${this.value.asString()})`;
    }
}
class KotlinLambdaExpression extends LambdaExpression {
    constructor(writer, signature, resolver, body) {
        super(writer, signature, resolver, body);
        this.writer = writer;
    }
    get statementHasSemicolon() {
        return false;
    }
    asString() {
        const params = this.signature.args.map((it, i) => `${this.writer.escapeKeyword(this.signature.argName(i))}: ${this.writer.getNodeName(it)}`);
        return `{${params.join(", ")} -> ${this.bodyAsString()} }`;
    }
}
class KotlinLanguageWriter extends LanguageWriter {
    constructor(printer, resolver, typeConvertor, language = Language.KOTLIN) {
        super(printer, resolver, language);
        this.typeConvertor = typeConvertor;
    }
    fork(options) {
        var _a;
        return new KotlinLanguageWriter(new IndentedPrinter(), (_a = options === null || options === void 0 ? void 0 : options.resolver) !== null && _a !== void 0 ? _a : this.resolver, this.typeConvertor, this.language);
    }
    getNodeName(type) {
        return this.typeConvertor.convert(type);
    }
    writeClass(name, op, superClass, interfaces, generics, isDeclared, isAbstract) {
        let extendsClause = superClass ? `${superClass}` : undefined;
        let implementsClause = interfaces ? `${interfaces.join(' , ')}` : undefined;
        let inheritancePart = [extendsClause, implementsClause]
            .filter(isDefined)
            .join(' , ');
        inheritancePart = inheritancePart.length != 0 ? ' : '.concat(inheritancePart) : '';
        this.printer.print(`public open class ${name}${inheritancePart} {`);
        this.pushIndent();
        op(this);
        this.popIndent();
        this.printer.print(`}`);
    }
    writeInterface(name, op, superInterfaces, generics, isDeclared) {
        const inheritance = superInterfaces ? (superInterfaces.length > 0 ? `: ${superInterfaces.join(', ')}` : '') : '';
        this.printer.print(`public interface ${name}${inheritance} {`);
        this.pushIndent();
        op(this);
        this.popIndent();
        this.printer.print(`}`);
    }
    writeFunctionDeclaration(name, signature, generics) {
        this.printer.print(this.generateFunctionDeclaration(name, signature));
    }
    writeFunctionImplementation(name, signature, op, generics) {
        this.printer.print(`${this.generateFunctionDeclaration(name, signature)} {`);
        this.printer.pushIndent();
        op(this);
        this.printer.popIndent();
        this.printer.print('}');
    }
    generateFunctionDeclaration(name, signature) {
        const args = signature.args.map((it, index) => `${signature.argName(index)}: ${this.getNodeName(it)}`);
        return `public fun ${name}(${args.join(", ")}): ${this.getNodeName(signature.returnType)}`;
    }
    writeEnum(name, members, options) {
        throw new Error("Try to avoid writeEnum");
    }
    writeDeclaration(name, signature, needReturn, needBracket, modifiers, generics) {
        let prefix = !modifiers ? undefined : this.supportedModifiers
            .filter(it => modifiers.includes(it))
            .map(it => this.mapMethodModifier(it)).join(" ");
        if (modifiers === null || modifiers === void 0 ? void 0 : modifiers.includes(MethodModifier.GETTER)) {
            prefix = `${prefix} get`;
        }
        else if (modifiers === null || modifiers === void 0 ? void 0 : modifiers.includes(MethodModifier.SETTER)) {
            prefix = `${prefix} set`;
            needReturn = false;
        }
        prefix = prefix ? prefix.trim() + " " : "";
        const typeParams = (generics === null || generics === void 0 ? void 0 : generics.length) ? `<${generics.join(", ")}>` : "";
        const normalizedArgs = signature.args.map((it, i) => isOptionalType(it) && signature.isArgOptional(i) ? maybeUnwrapOptionalType(it) : it);
        this.printer.print(`${prefix}fun ${name}${typeParams}(${normalizedArgs.map((it, index) => `${signature.argName(index)}: ${this.getNodeName(it)}${signature.isArgOptional(index) ? "?" : ``}${signature.argDefault(index) ? ' = ' + signature.argDefault(index) : ""}`).join(", ")})${needReturn ? ": " + this.getNodeName(signature.returnType) : ""}${needBracket ? " {" : ""}`);
    }
    writeFieldDeclaration(name, type, modifiers, optional, initExpr) {
        const init = initExpr != undefined ? ` = ${initExpr.asString()}` : ``;
        let prefix = this.makeFieldModifiersList(modifiers === null || modifiers === void 0 ? void 0 : modifiers.filter(m => m != FieldModifier.READONLY && m != FieldModifier.STATIC));
        this.printer.print(`${prefix ? prefix.concat(" ") : ""}${(modifiers === null || modifiers === void 0 ? void 0 : modifiers.includes(FieldModifier.READONLY)) ? 'val' : 'var'} ${name}: ${this.getNodeName(maybeOptional(type, optional))}${init}`);
    }
    writeNativeMethodDeclaration(method) {
        let name = method.name;
        let signature = method.signature;
        this.writeMethodImplementation(new Method(name, signature, [MethodModifier.STATIC]), writer => { });
    }
    writeMethodDeclaration(name, signature, modifiers) {
        this.writeDeclaration(name, signature, true, false, modifiers);
    }
    writeConstructorImplementation(className, signature, op, delegationCall, modifiers) {
        const delegationType = ((delegationCall === null || delegationCall === void 0 ? void 0 : delegationCall.delegationType) == DelegationType.THIS) ? "this" : "super";
        const superInvocation = delegationCall
            ? ` : ${delegationType}(${delegationCall.delegationArgs.map(it => it.asString()).join(", ")})`
            : "";
        const argList = signature.args.map((it, index) => {
            var _a;
            const maybeDefault = ((_a = signature.defaults) === null || _a === void 0 ? void 0 : _a[index]) ? ` = ${signature.defaults[index]}` : "";
            return `${signature.argName(index)}: ${this.getNodeName(it)}${maybeDefault}`;
        }).join(", ");
        this.print(`constructor(${argList})${superInvocation} {`);
        this.pushIndent();
        op(this);
        this.popIndent();
        this.printer.print(`}`);
    }
    writeMethodImplementation(method, op) {
        this.writeDeclaration(method.name, method.signature, true, true, method.modifiers, method.generics);
        this.pushIndent();
        op(this);
        this.popIndent();
        this.printer.print(`}`);
    }
    writeProperty(propName, propType, modifiers, getter, setter, initExpr) {
        let containerName = propName.concat("_container");
        let truePropName = this.escapeKeyword(propName);
        if (getter) {
            if (!getter.op) {
                this.print(`private var ${containerName}: ${this.getNodeName(propType)}`);
            }
        }
        let isMutable = !modifiers.includes(FieldModifier.READONLY);
        let isOverride = modifiers.includes(FieldModifier.OVERRIDE);
        let initializer = initExpr ? ` = ${initExpr.asString()}` : "";
        this.print(`${isOverride ? 'override ' : ''}public ${isMutable ? "var " : "val "}${truePropName}: ${this.getNodeName(propType)}${initializer}`);
        if (getter) {
            this.pushIndent();
            this.writeGetterImplementation(getter.method, getter.op);
            if (isMutable) {
                if (setter) {
                    this.writeSetterImplementation(setter.method, setter ? setter.op : (writer) => { this.print(`${containerName} = ${truePropName}`); });
                }
                else {
                    this.print(`set(${truePropName}) {`);
                    this.pushIndent();
                    this.print(`${containerName} = ${truePropName}`);
                    this.popIndent();
                    this.print(`}`);
                }
            }
            this.popIndent();
        }
    }
    writeGetterImplementation(method, op) {
        this.print(`get() {`);
        this.pushIndent();
        op ? op(this) : this.print(`return ${method.signature.argsNames.map(arg => `${arg}_container`).join(', ')}`);
        this.popIndent();
        this.print('}');
    }
    writeSetterImplementation(method, op) {
        this.print(`set(${method.signature.argsNames.map(arg => this.escapeKeyword(arg)).join(', ')}) {`);
        this.pushIndent();
        op(this);
        this.popIndent();
        this.print('}');
    }
    writeTypeDeclaration(decl) {
        throw new Error("Not implemented");
    }
    writeConstant(constName, constType, constVal) {
        throw new Error("Not implemented");
    }
    makeNull() {
        return this.makeString('null');
    }
    makeAssign(variableName, type, expr, isDeclared = true, isConst = true, options) {
        return new KotlinAssignStatement(variableName, type, expr, isDeclared, isConst);
    }
    makeLambda(signature, body) {
        return new KotlinLambdaExpression(this, signature, this.resolver, body);
    }
    makeThrowError(message) {
        return new KotlinThrowErrorStatement(message);
    }
    makeReturn(expr) {
        return new ReturnStatement(expr);
    }
    makeLambdaReturn(expr) {
        return new KotlinLambdaReturnStatement(expr);
    }
    makeCheckOptional(optional, doStatement) {
        throw new Error("Not implemented");
    }
    makeStatement(expr) {
        return new ExpressionStatement(expr);
    }
    makeLoop(counter, limit, statement) {
        return new KotlinLoopStatement(counter, limit, statement);
    }
    makeMapForEach(map, key, value, op) {
        return new KotlinMapForEachStatement(map, key, value, op);
    }
    writePrintLog(message) {
        this.print(`println(\"${message}\")`);
    }
    makeCast(value, node, options) {
        return this.makeString(`${value.asString()} as ${this.getNodeName(node)}`);
    }
    typeInstanceOf(type, value, members) {
        throw new Error("Not implemented");
    }
    getObjectAccessor(convertor, value, args) {
        throw new Error("Not implemented");
    }
    makeUndefined() {
        return this.makeNull();
    }
    makeRuntimeType(rt) {
        return this.makeString(`RuntimeType.${RuntimeType[rt]}.value`);
    }
    makeTupleAlloc(option) {
        throw new Error("Not implemented");
    }
    makeTupleAccess(value, index) {
        return this.makeString(`${value}.component${index + 1}()`);
    }
    makeArrayInit(type, size) {
        return this.makeString(`ArrayList<${this.getNodeName(type.elementType[0])}>(${size !== null && size !== void 0 ? size : ''})`);
    }
    makeArrayLength(array, length) {
        return this.makeString(`${array}.size`);
    }
    makeArrayResize(array, arrayType, length, deserializer) {
        return new KotlinArrayResizeStatement(array, arrayType, length, deserializer);
    }
    makeClassInit(type, paramenters) {
        throw new Error("Not implemented");
    }
    makeMapInit(type) {
        return this.makeString(`${this.getNodeName(type)}()`);
    }
    makeMapInsert(keyAccessor, key, valueAccessor, value) {
        return this.makeStatement(this.makeMethodCall(keyAccessor, "put", [this.makeString(key), this.makeString(value)]));
    }
    makeUnwrapOptional(expression) {
        return new KotlinUnwrapOptionalExpression(expression);
    }
    makeDefinedCheck(value) {
        return new KotlinCheckDefinedExpression(value);
    }
    makeUnionSelector(value, valueType) {
        return this.makeAssign(valueType, undefined, this.makeMethodCall(value, "getSelector", []), false);
    }
    makeUnionVariantCast(value, type, convertor, index) {
        return this.makeMethodCall(value, `getValue${index}`, []);
    }
    makeValueFromOption(value, destinationConvertor) {
        return this.makeString(`${value}!!`);
    }
    makeUnionVariantCondition(_convertor, _valueName, valueType, type, _convertorIndex, _runtimeTypeIndex) {
        return this.makeString(`RuntimeType.${type.toUpperCase()}.value == ${valueType}`);
    }
    makeRuntimeTypeCondition(typeVarName, equals, type, varName) {
        if (varName) {
            return this.makeDefinedCheck(varName);
        }
        else {
            const op = equals ? "==" : "!=";
            return this.makeNaryOp(op, [this.makeRuntimeType(type), this.makeString(`${typeVarName}.toInt()`)]);
        }
    }
    getTagType() {
        return createReferenceType("Tag");
    }
    getRuntimeType() {
        return IDLNumberType;
    }
    makeTupleAssign(receiver, fields) {
        throw new Error("Not implemented");
    }
    get supportedModifiers() {
        return [MethodModifier.PUBLIC, MethodModifier.PRIVATE, MethodModifier.OVERRIDE];
    }
    get supportedFieldModifiers() {
        return [FieldModifier.PUBLIC, FieldModifier.PRIVATE, FieldModifier.PROTECTED, FieldModifier.READONLY, FieldModifier.OVERRIDE];
    }
    enumFromI32(value, enumEntry) {
        return this.makeString(`${this.getNodeName(enumEntry)}(${value.asString()})`);
    }
    i32FromEnum(value, enumEntry) {
        return this.makeString(`${value.asString()}.value!!`);
    }
    makeEnumEntity(enumEntity, options) {
        return new KotlinEnumWithGetter(enumEntity, options.isExport);
    }
    castToBoolean(value) {
        return `if (${value}) { 1 } else { 0 }`;
    }
    castToInt(value, bitness) {
        return `${this.escapeKeyword(value)}.${bitness == 8 ? 'toByte()' : 'toInt()'}`;
    }
    makeCallIsObject(value) {
        throw new Error("Not implemented");
    }
    makeNewObject(objectName, params = []) {
        return new KotlinNewObjectExpression(objectName, params);
    }
    escapeKeyword(keyword) {
        return keyword;
    }
    makeDiscriminatorConvertor(convertor, value, index) {
        throw new Error("Not implemented");
    }
    makeStaticBlock(op) {
        this.printer.print('companion object {');
        this.printer.pushIndent();
        op(this);
        this.popIndent();
        this.printer.print('}');
    }
    pushNamespace(namespace, options) { }
    popNamespace(options) { }
}

function createLanguageWriter(language, resolver) {
    resolver !== null && resolver !== void 0 ? resolver : (resolver = EmptyReferenceResolver);
    const printer = new IndentedPrinter();
    switch (language) {
        case Language.TS: return new TSLanguageWriter(printer, resolver, new TSTypeNameConvertor(resolver));
        case Language.ARKTS: return new ETSLanguageWriter(printer, resolver, new ETSTypeNameConvertor(resolver), new CppConvertor(resolver));
        case Language.JAVA: return new JavaLanguageWriter(printer, resolver, new JavaTypeNameConvertor(resolver));
        case Language.CPP: return new CppLanguageWriter(printer, resolver, new CppConvertor(resolver), PrimitiveTypesInstance);
        case Language.CJ: return new CJLanguageWriter(printer, resolver, new CJTypeNameConvertor(resolver), new CJIDLTypeToForeignStringConvertor(resolver));
        case Language.KOTLIN: return new KotlinLanguageWriter(printer, resolver, new KotlinTypeNameConvertor(resolver));
        default: throw new Error(`Language ${language.toString()} is not supported`);
    }
}
const EmptyReferenceResolver = createEmptyReferenceResolver();

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
class UnionRuntimeTypeChecker {
    constructor(convertors) {
        this.convertors = convertors;
        this.conflictingConvertors = new Set();
        this.duplicateMembers = new Set();
        this.discriminators = [];
        this.checkConflicts();
    }
    checkConflicts() {
        const runtimeTypeConflicts = new Map();
        this.convertors.forEach(conv => {
            conv.runtimeTypes.forEach(rtType => {
                const convertors = runtimeTypeConflicts.get(rtType);
                if (convertors)
                    convertors.push(conv);
                else
                    runtimeTypeConflicts.set(rtType, [conv]);
            });
        });
        runtimeTypeConflicts.forEach((convertors, rtType) => {
            if (convertors.length > 1) {
                const allMembers = new Set();
                if (rtType === RuntimeType.OBJECT) {
                    convertors.forEach(convertor => {
                        convertor.getMembers().forEach(member => {
                            if (allMembers.has(member))
                                this.duplicateMembers.add(member);
                            allMembers.add(member);
                        });
                    });
                }
                convertors.forEach(convertor => {
                    this.conflictingConvertors.add(convertor);
                });
            }
        });
    }
    makeDiscriminator(value, convertorIndex, writer) {
        const convertor = this.convertors[convertorIndex];
        if (this.conflictingConvertors.has(convertor) && writer.language.needsUnionDiscrimination) {
            const discriminator = convertor.unionDiscriminator(value, convertorIndex, writer, this.duplicateMembers);
            this.discriminators.push([discriminator, convertor, convertorIndex]);
            if (discriminator)
                return discriminator;
        }
        return writer.makeNaryOp("||", convertor.runtimeTypes.map((it, runtimeTypeIndex) => writer.makeNaryOp("==", [
            writer.makeUnionVariantCondition(convertor, value, `${value}_type`, RuntimeType[it], convertorIndex, runtimeTypeIndex)
        ])));
    }
    reportConflicts(context, writer) {
        if (this.discriminators.filter(([discriminator, _, __]) => discriminator === undefined).length > 1) {
            Array.from(this.duplicateMembers).join(",").padEnd(30);
            this.discriminators.forEach(([discr, conv, n]) => {
                n.toString().padEnd(3);
                conv.targetType(writer).padEnd(30);
                discr ? discr.asString() : "<undefined>";
            });
            // throw new Error(report)
        }
    }
}

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
var LayoutNodeRole;
(function (LayoutNodeRole) {
    LayoutNodeRole[LayoutNodeRole["PEER"] = 0] = "PEER";
    LayoutNodeRole[LayoutNodeRole["INTERFACE"] = 1] = "INTERFACE";
    LayoutNodeRole[LayoutNodeRole["GLOBAL"] = 2] = "GLOBAL";
    LayoutNodeRole[LayoutNodeRole["COMPONENT"] = 3] = "COMPONENT";
    LayoutNodeRole[LayoutNodeRole["SERIALIZER"] = 4] = "SERIALIZER";
})(LayoutNodeRole || (LayoutNodeRole = {}));
class LayoutManager {
    constructor(strategy) {
        this.strategy = strategy;
    }
    resolve(target) {
        return this.strategy.resolve(target);
    }
    handwrittenPackage() {
        return this.strategy.handwrittenPackage();
    }
    ////////////////////////////////////////////////////////////////////
    static Empty() {
        return new LayoutManager({ resolve: () => '', handwrittenPackage: () => '' });
    }
}

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
function getSerializerName(declaration) {
    return `${getQualifiedName(declaration, "namespace.name").split('.').join('_')}_serializer`;
}
class BaseArgConvertor {
    constructor(idlType, runtimeTypes, isScoped, useArray, param) {
        this.idlType = idlType;
        this.runtimeTypes = runtimeTypes;
        this.isScoped = isScoped;
        this.useArray = useArray;
        this.param = param;
    }
    holdResource(_resourceName, _holder, _writer) { }
    nativeType() {
        throw new Error("Define");
    }
    isPointerType() {
        throw new Error("Define");
    }
    interopType() {
        throw new Error("Define");
    }
    targetType(writer) {
        return writer.getNodeName(this.idlType);
    }
    unionDiscriminator(value, index, writer, duplicates) {
        return undefined;
    }
    getMembers() { return []; }
    getObjectAccessor(language, value, args, writer) {
        if (writer)
            return writer.getObjectAccessor(this, value, args);
        return this.useArray && (args === null || args === void 0 ? void 0 : args.index) ? `${value}[${args.index}]` : value;
    }
    discriminatorFromFields(value, writer, uniqueFields, nameAccessor, optionalAccessor, duplicates) {
        if (!uniqueFields || uniqueFields.length === 0)
            return undefined;
        const firstNonOptional = uniqueFields.find(it => !optionalAccessor(it));
        return writer.discriminatorFromExpressions(value, RuntimeType.OBJECT, [
            writer.makeDiscriminatorFromFields(this, value, firstNonOptional ? [nameAccessor(firstNonOptional)] : uniqueFields.map(it => nameAccessor(it)), duplicates)
        ]);
    }
}
class BooleanConvertor extends BaseArgConvertor {
    constructor(param) {
        super(IDLBooleanType, [RuntimeType.BOOLEAN], false, false, param);
    }
    convertorArg(param, writer) {
        return writer.castToBoolean(param);
    }
    convertorSerialize(param, value, printer) {
        printer.writeMethodCall(`${param}Serializer`, "writeBoolean", [value]);
    }
    convertorDeserialize(bufferName, deserializerName, assigneer, writer) {
        return assigneer(writer.makeString(`${deserializerName}.readBoolean()`));
    }
    nativeType() {
        return IDLBooleanType;
    }
    interopType() {
        return IDLBooleanType;
    }
    isPointerType() {
        return false;
    }
}
class UndefinedConvertor extends BaseArgConvertor {
    constructor(param) {
        super(IDLUndefinedType, [RuntimeType.UNDEFINED], false, false, param);
    }
    convertorArg(param, writer) {
        return writer.makeUndefined().asString();
    }
    convertorSerialize(param, value, printer) { }
    convertorDeserialize(bufferName, deserializerName, assigneer, writer) {
        return assigneer(writer.makeUndefined());
    }
    nativeType() {
        return IDLUndefinedType;
    }
    interopType() {
        return IDLUndefinedType;
    }
    isPointerType() {
        return false;
    }
}
class VoidConvertor extends UndefinedConvertor {
    convertorArg(param, writer) {
        return writer.makeVoid().asString();
    }
    convertorDeserialize(bufferName, deserializerName, assigneer, writer) {
        return assigneer(writer.makeVoid());
    }
    nativeType() {
        return IDLVoidType;
    }
}
class StringConvertor extends BaseArgConvertor {
    constructor(param) {
        super(IDLStringType, [RuntimeType.STRING], false, false, param);
    }
    convertorArg(param, writer) {
        return writer.language == Language.CPP
            ? writer.makeUnsafeCast_(writer.makeString(`&${param}`), this.idlType, PrintHint.AsConstPointer)
            : writer.escapeKeyword(param);
    }
    convertorSerialize(param, value, writer) {
        writer.writeMethodCall(`${param}Serializer`, `writeString`, [value]);
    }
    convertorDeserialize(bufferName, deserializerName, assigneer, writer) {
        return assigneer(writer.makeCast(writer.makeString(`${deserializerName}.readString()`), this.idlType, { optional: false }));
    }
    nativeType() {
        return IDLStringType;
    }
    interopType() {
        return IDLStringType;
    }
    isPointerType() {
        return true;
    }
    unionDiscriminator(value, index, writer, duplicates) {
        return this.literalValue
            ? writer.makeString(`${value} === "${this.literalValue}"`)
            : undefined;
    }
    targetType(writer) {
        if (this.literalValue) {
            return writer.getNodeName(IDLStringType);
        }
        return super.targetType(writer);
    }
}
class EnumConvertor extends BaseArgConvertor {
    constructor(param, enumEntry) {
        super(createReferenceType(enumEntry), [isStringEnum(enumEntry) ? RuntimeType.STRING : RuntimeType.NUMBER], false, false, param);
        this.enumEntry = enumEntry;
    }
    convertorArg(param, writer) {
        return writer.i32FromEnum(writer.makeString(writer.escapeKeyword(param)), this.enumEntry).asString();
    }
    convertorSerialize(param, value, writer) {
        writer.writeMethodCall(`${param}Serializer`, "writeInt32", [writer.i32FromEnum(writer.makeString(value), this.enumEntry).asString()]);
    }
    convertorDeserialize(bufferName, deserializerName, assigneer, writer) {
        const readExpr = writer.makeMethodCall(`${deserializerName}`, "readInt32", []);
        const enumExpr = writer.enumFromI32(readExpr, this.enumEntry);
        return assigneer(enumExpr);
    }
    nativeType() {
        return this.idlType;
    }
    interopType() {
        return IDLI32Type;
    }
    isPointerType() {
        return false;
    }
    targetType(writer) {
        return writer.getNodeName(this.idlType); // this.enumTypeName(writer.language)
    }
    unionDiscriminator(value, index, writer, duplicates) {
        return writer.makeDiscriminatorConvertor(this, value, index);
    }
}
class NumberConvertor extends BaseArgConvertor {
    constructor(param) {
        // TODO: as we pass tagged values - request serialization to array for now.
        // Optimize me later!
        super(IDLNumberType, [RuntimeType.NUMBER], false, false, param);
    }
    convertorArg(param, writer) {
        return writer.language == Language.CPP
            ? writer.makeUnsafeCast_(writer.makeString(`&${param}`), this.idlType, PrintHint.AsConstPointer)
            : writer.escapeKeyword(param);
    }
    convertorSerialize(param, value, printer) {
        printer.writeMethodCall(`${param}Serializer`, "writeNumber", [value]);
    }
    convertorDeserialize(bufferName, deserializerName, assigneer, writer) {
        return assigneer(writer.makeCast(writer.makeString(`${deserializerName}.readNumber()`), this.idlType, { optional: false }));
    }
    nativeType() {
        return IDLNumberType;
    }
    interopType() {
        return IDLNumberType;
    }
    isPointerType() {
        return true;
    }
}
class NumericConvertor extends BaseArgConvertor {
    constructor(param, type) {
        // check numericPrimitiveTypes.include(type)
        super(type, [RuntimeType.NUMBER], false, false, param);
        this.interopNameConvertor = new CppNameConvertor(createEmptyReferenceResolver());
    }
    convertorArg(param, writer) {
        return param;
    }
    convertorSerialize(param, value, printer) {
        printer.writeMethodCall(`${param}Serializer`, `write${this.interopNameConvertor.convert(this.idlType)}`, [value]);
    }
    convertorDeserialize(bufferName, deserializerName, assigneer, writer) {
        return assigneer(writer.makeString(`${deserializerName}.read${this.interopNameConvertor.convert(this.idlType)}()`));
    }
    nativeType() {
        return this.idlType;
    }
    interopType() {
        return this.idlType;
    }
    isPointerType() {
        return false;
    }
}
class BigIntToU64Convertor extends BaseArgConvertor {
    constructor(param) {
        super(IDLBigintType, [RuntimeType.BIGINT], false, false, param);
    }
    convertorArg(param, writer) {
        return writer.escapeKeyword(param);
    }
    convertorSerialize(param, value, printer) {
        printer.writeMethodCall(`${param}Serializer`, "writeInt64", [value]);
    }
    convertorDeserialize(bufferName, deserializerName, assigneer, writer) {
        return assigneer(writer.makeCast(writer.makeString(`${deserializerName}.readInt64()`), this.idlType, { optional: false }));
    }
    nativeType() {
        return IDLI64Type;
    }
    interopType() {
        return IDLI64Type;
    }
    isPointerType() {
        return false;
    }
}
class ObjectConvertor extends BaseArgConvertor {
    constructor(param, type) {
        super(type, [
            RuntimeType.BIGINT,
            RuntimeType.BOOLEAN,
            RuntimeType.FUNCTION,
            RuntimeType.MATERIALIZED,
            RuntimeType.NUMBER,
            RuntimeType.OBJECT,
            RuntimeType.STRING,
            RuntimeType.SYMBOL,
        ], false, true, param);
    }
    convertorArg(param, writer) {
        return writer.escapeKeyword(param);
    }
    convertorSerialize(param, value, printer) {
        if (printer.language === Language.CPP) {
            printer.writeMethodCall(`${param}Serializer`, "writeObject", [value]);
        }
        else {
            printer.writeMethodCall(`${param}Serializer`, "holdAndWriteObject", [value]);
        }
    }
    convertorDeserialize(bufferName, deserializerName, assigneer, writer) {
        return assigneer(writer.makeCast(writer.makeMethodCall(deserializerName, 'readObject', []), this.idlType, { optional: false }));
    }
    holdResource(name, holder, writer) {
        writer.writeStatement(writer.makeAssign(name, createReferenceType(`CallbackResource`), writer.makeString(`{${this.param}.resource.resourceId, holdManagedCallbackResource, releaseManagedCallbackResource}`), true));
        writer.writeExpressionStatement(writer.makeMethodCall(holder, 'holdCallbackResource', [
            writer.makeString('&' + name)
        ]));
    }
    nativeType() {
        return IDLAnyType;
    }
    interopType() {
        return IDLAnyType;
    }
    isPointerType() {
        return true;
    }
}
class PointerConvertor extends BaseArgConvertor {
    constructor(param) {
        // check numericPrimitiveTypes.include(type)
        super(IDLPointerType, [RuntimeType.NUMBER, RuntimeType.OBJECT], false, false, param);
    }
    convertorArg(param, writer) {
        return param;
    }
    convertorSerialize(param, value, printer) {
        printer.writeMethodCall(`${param}Serializer`, `writePointer`, [value]);
    }
    convertorDeserialize(bufferName, deserializerName, assigneer, writer) {
        return assigneer(writer.makeString(`${deserializerName}.readPointer()`));
    }
    nativeType() {
        return this.idlType;
    }
    interopType() {
        return this.idlType;
    }
    isPointerType() {
        return false;
    }
}
class BufferConvertor extends BaseArgConvertor {
    constructor(param) {
        super(IDLBufferType, [RuntimeType.OBJECT], false, true, param);
    }
    convertorArg(param, _) {
        return param;
    }
    convertorSerialize(param, value, printer) {
        printer.writeMethodCall(`${param}Serializer`, "writeBuffer", [value]);
    }
    convertorDeserialize(_, deserializerName, assigneer, writer) {
        return assigneer(writer.makeCast(writer.makeString(`${deserializerName}.readBuffer()`), this.idlType, { optional: false }));
    }
    nativeType() {
        return IDLBufferType;
    }
    interopType() {
        return IDLBufferType;
    }
    isPointerType() {
        return true;
    }
    unionDiscriminator(value, index, writer, duplicates) {
        return writer.instanceOf(this, value);
    }
}
class AggregateConvertor extends BaseArgConvertor {
    constructor(library, param, type, decl) {
        super(type, [RuntimeType.OBJECT], false, true, param);
        this.library = library;
        this.decl = decl;
        this.members = [];
        // this.aliasName = ts.isTypeAliasDeclaration(this.type.parent) ? identName(this.type.parent.name) : undefined
        this.memberConvertors = decl
            .properties
            // .filter(ts.isPropertySignature)
            .map((member, index) => {
            this.members[index] = [member.name, member.isOptional];
            return library.typeConvertor(param, member.type, member.isOptional);
        });
    }
    convertorArg(param, writer) {
        throw new Error("Do not use for aggregates");
    }
    convertorSerialize(param, value, printer) {
        this.memberConvertors.forEach((it, index) => {
            let memberName = this.members[index][0];
            let memberAccess = `${value}.${printer.escapeKeyword(memberName)}`;
            printer.writeStatement(printer.makeAssign(`${value}_${memberName}`, undefined, printer.makeString(memberAccess), true));
            it.convertorSerialize(param, `${value}_${memberName}`, printer);
        });
    }
    convertorDeserialize(bufferName, deserializerName, assigneer, writer) {
        const statements = [];
        if (writer.language === Language.CPP) {
            statements.push(writer.makeAssign(bufferName, this.idlType, undefined, true, false));
        }
        // TODO: Needs to be reworked DeserializerBase.readFunction properly
        if (writer.language === Language.ARKTS
            && this.memberConvertors.find(it => it instanceof FunctionConvertor)) {
            return new BlockStatement([writer.makeThrowError("Not implemented yet")], false);
        }
        for (let i = 0; i < this.decl.properties.length; i++) {
            const prop = this.decl.properties[i];
            const propConvertor = this.memberConvertors[i];
            statements.push(propConvertor.convertorDeserialize(`${bufferName}_${prop.name}_buf`, deserializerName, (expr) => {
                if (writer.language === Language.CPP) {
                    // prefix initialization for CPP, just easier. Waiting for easy work with nullables
                    return writer.makeAssign(`${bufferName}.${writer.escapeKeyword(prop.name)}`, undefined, expr, false);
                }
                /**
                 * todo: check UnionType name creation for union of unnamed nodes (isNamedNode() == false)
                 */
                const memberType = maybeOptional(prop.type, prop.isOptional);
                return writer.makeAssign(`${bufferName}_${prop.name}`, memberType, expr, true, true);
            }, writer));
        }
        if (writer.language === Language.CPP) {
            statements.push(assigneer(writer.makeString(bufferName)));
        }
        else if (writer.language == Language.CJ) {
            const resultExpression = writer.makeString(`${writer.getNodeName(this.idlType)}(${this.decl.properties.map(prop => `${bufferName}_${prop.name}`).join(", ")})`);
            statements.push(assigneer(resultExpression));
        }
        else if (writer.language == Language.KOTLIN) {
            const resultExpression = this.decl.subkind === IDLInterfaceSubkind.Tuple ?
                writer.makeString(`${writer.getNodeName(this.idlType)}(${this.decl.properties.map(prop => `${bufferName}_${prop.name}`).join(', ')})`) :
                writer.makeString(`object: ${writer.getNodeName(this.idlType)} { ${this.decl.properties.map(prop => `override var ${prop.name} = ${bufferName}_${prop.name}`).join("; ")} }`);
            statements.push(assigneer(resultExpression));
        }
        else {
            const resultExpression = this.makeAssigneeExpression(this.decl.properties.map(prop => {
                return [prop.name, writer.makeString(`${bufferName}_${prop.name}`)];
            }), writer);
            statements.push(assigneer(resultExpression));
        }
        return new BlockStatement(statements, false);
    }
    makeAssigneeExpression(fields, writer) {
        const content = fields.map(it => `${it[0]}: ${it[1].asString()}`).join(', ');
        return writer.makeCast(writer.makeString(`{${content}}`), this.idlType);
    }
    nativeType() {
        return createReferenceType(this.decl);
    }
    interopType() {
        throw new Error("Must never be used");
    }
    isPointerType() {
        return true;
    }
    getMembers() {
        return this.members.map(it => it[0]);
    }
    unionDiscriminator(value, index, writer, duplicates) {
        const uniqueFields = this.members.filter(it => !duplicates.has(it[0]));
        return this.discriminatorFromFields(value, writer, uniqueFields, it => it[0], it => it[1], duplicates);
    }
}
class TupleConvertor extends AggregateConvertor {
    constructor(library, param, type, decl) {
        super(library, param, type, decl);
    }
    convertorArg(param, writer) {
        throw new Error("Must never be used");
    }
    convertorSerialize(param, value, printer) {
        this.memberConvertors.forEach((it, index) => {
            printer.writeStatement(printer.makeAssign(`${value}_${index}`, undefined, printer.makeTupleAccess(value, index), true));
            it.convertorSerialize(param, `${value}_${index}`, printer);
        });
    }
    makeAssigneeExpression(fields, writer) {
        return writer.makeCast(writer.makeString(`[${fields.map(it => it[1].asString()).join(', ')}]`), this.idlType);
    }
    nativeType() {
        return createReferenceType(this.decl);
    }
    interopType() {
        throw new Error("Must never be used");
    }
    isPointerType() {
        return true;
    }
    getObjectAccessor(language, value, args) {
        return (args === null || args === void 0 ? void 0 : args.index)
            ? language === Language.CPP
                ? `${value}.value${args.index}`
                : `${value}[${args.index}]`
            : value;
    }
}
class InterfaceConvertor extends BaseArgConvertor {
    constructor(library, name /* change to IDLReferenceType */, param, declaration) {
        super(createReferenceType(declaration), [RuntimeType.OBJECT], false, true, param);
        this.library = library;
        this.declaration = declaration;
    }
    convertorArg(param, writer) {
        throw new Error("Must never be used");
    }
    convertorSerialize(param, value, printer) {
        const accessor = getSerializerName(this.declaration);
        printer.addFeature(accessor, this.library.layout.resolve({ node: this.declaration, role: LayoutNodeRole.SERIALIZER }));
        printer.writeStaticMethodCall(accessor, 'write', [`${param}Serializer`, value]);
    }
    convertorDeserialize(bufferName, deserializerName, assigneer, writer) {
        const accessor = getSerializerName(this.declaration);
        writer.addFeature(accessor, this.library.layout.resolve({ node: this.declaration, role: LayoutNodeRole.SERIALIZER }));
        return assigneer(writer.makeStaticMethodCall(accessor, 'read', [writer.makeString(deserializerName)]));
    }
    nativeType() {
        return this.idlType;
    }
    interopType() {
        // Actually shouldn't be used!
        // throw new Error("Must never be used")
        return IDLSerializerBuffer;
    }
    isPointerType() {
        return true;
    }
    getMembers() {
        var _a, _b;
        return (_b = (_a = this.declaration) === null || _a === void 0 ? void 0 : _a.properties.map(it => it.name)) !== null && _b !== void 0 ? _b : [];
    }
    unionDiscriminator(value, index, writer, duplicates) {
        var _a;
        // Try to figure out interface by examining field sets
        const uniqueFields = (_a = this.declaration) === null || _a === void 0 ? void 0 : _a.properties.filter(it => !duplicates.has(it.name));
        return this.discriminatorFromFields(value, writer, uniqueFields, it => it.name, it => it.isOptional, duplicates);
    }
}
class ClassConvertor extends InterfaceConvertor {
    constructor(library, name, param, declaration) {
        super(library, name, param, declaration);
    }
    unionDiscriminator(value, index, writer, duplicateMembers) {
        return writer.discriminatorFromExpressions(value, RuntimeType.OBJECT, [writer.instanceOf(this, value, duplicateMembers)]);
    }
}
class ArrayConvertor extends BaseArgConvertor {
    constructor(library, param, type, elementType) {
        super(createContainerType('sequence', [elementType]), [RuntimeType.OBJECT], false, true, param);
        this.library = library;
        this.type = type;
        this.elementType = elementType;
        this.elementConvertor = library.typeConvertor(param, elementType);
    }
    convertorArg(param, writer) {
        throw new Error("Must never be used");
    }
    convertorSerialize(param, value, printer) {
        // Array length.
        const valueLength = printer.makeArrayLength(value).asString();
        const loopCounter = "i";
        printer.writeMethodCall(`${param}Serializer`, "writeInt32", [printer.castToInt(valueLength, 32)]);
        printer.writeStatement(printer.makeLoop(loopCounter, valueLength));
        printer.pushIndent();
        printer.writeStatement(printer.makeAssign(`${value}_element`, this.elementType, printer.makeArrayAccess(value, loopCounter), true));
        this.elementConvertor.convertorSerialize(param, `${value}_element`, printer);
        printer.popIndent();
        printer.print(`}`);
    }
    convertorDeserialize(bufferName, deserializerName, assigneer, writer) {
        const lengthBuffer = `${bufferName}_length`;
        const counterBuffer = `${bufferName}_i`;
        const statements = [];
        const arrayType = this.idlType;
        statements.push(writer.makeAssign(lengthBuffer, IDLI32Type, writer.makeString(`${deserializerName}.readInt32()`), true));
        statements.push(writer.makeAssign(bufferName, arrayType, writer.makeArrayInit(this.type, lengthBuffer), true, false));
        statements.push(writer.makeArrayResize(bufferName, writer.getNodeName(arrayType), lengthBuffer, deserializerName));
        statements.push(writer.makeLoop(counterBuffer, lengthBuffer, this.elementConvertor.convertorDeserialize(`${bufferName}_buf`, deserializerName, (expr) => {
            return writer.makeAssign(writer.makeArrayAccess(bufferName, counterBuffer).asString(), undefined, expr, false);
        }, writer)));
        statements.push(assigneer(writer.makeString(bufferName)));
        return new BlockStatement(statements, false);
    }
    nativeType() {
        return createContainerType('sequence', [this.elementType]);
    }
    interopType() {
        throw new Error("Must never be used");
    }
    isPointerType() {
        return true;
    }
    unionDiscriminator(value, index, writer, duplicates) {
        return writer.discriminatorFromExpressions(value, RuntimeType.OBJECT, [writer.instanceOf(this, value, duplicates)]);
    }
    getObjectAccessor(language, value, args) {
        const array = language === Language.CPP ? ".array" : "";
        return (args === null || args === void 0 ? void 0 : args.index) ? `${value}${array}${args.index}` : value;
    }
}
class MapConvertor extends BaseArgConvertor {
    constructor(library, param, type, keyType, valueType) {
        super(createContainerType('record', [keyType, valueType]), [RuntimeType.OBJECT], false, true, param);
        this.library = library;
        this.keyType = keyType;
        this.valueType = valueType;
        this.keyConvertor = library.typeConvertor(param, keyType);
        this.valueConvertor = library.typeConvertor(param, valueType);
    }
    convertorArg(param, writer) {
        throw new Error("Must never be used");
    }
    convertorSerialize(param, value, printer) {
        // Map size.
        const mapSize = printer.makeMapSize(value);
        printer.writeMethodCall(`${param}Serializer`, "writeInt32", [printer.castToInt(mapSize.asString(), 32)]);
        printer.writeStatement(printer.makeMapForEach(value, `${value}_key`, `${value}_value`, () => {
            this.keyConvertor.convertorSerialize(param, `${value}_key`, printer);
            this.valueConvertor.convertorSerialize(param, `${value}_value`, printer);
        }));
    }
    convertorDeserialize(bufferName, deserializerName, assigneer, writer) {
        const mapTypeName = writer.getNodeName(this.idlType);
        const keyType = this.keyType;
        const valueType = this.valueType;
        const sizeBuffer = `${bufferName}_size`;
        const keyBuffer = `${bufferName}_key`;
        const valueBuffer = `${bufferName}_value`;
        const counterBuffer = `${bufferName}_i`;
        const keyAccessor = this.getObjectAccessor(writer.language, bufferName, { index: counterBuffer, field: "keys" });
        const valueAccessor = this.getObjectAccessor(writer.language, bufferName, { index: counterBuffer, field: "values" });
        return new BlockStatement([
            writer.makeAssign(sizeBuffer, IDLI32Type, writer.makeString(`${deserializerName}.readInt32()`), true, true),
            writer.makeAssign(bufferName, this.idlType, writer.makeMapInit(this.idlType), true, false),
            writer.makeMapResize(mapTypeName, keyType, valueType, bufferName, sizeBuffer, deserializerName),
            writer.makeLoop(counterBuffer, sizeBuffer, new BlockStatement([
                this.keyConvertor.convertorDeserialize(`${keyBuffer}_buf`, deserializerName, (expr) => {
                    return writer.makeAssign(keyBuffer, keyType, expr, true, true);
                }, writer),
                this.valueConvertor.convertorDeserialize(`${valueBuffer}_buf`, deserializerName, (expr) => {
                    return writer.makeAssign(valueBuffer, valueType, expr, true, true);
                }, writer),
                writer.makeMapInsert(keyAccessor, keyBuffer, valueAccessor, valueBuffer),
            ], false)),
            assigneer(writer.makeString(bufferName))
        ], false);
    }
    nativeType() {
        return createContainerType('record', [this.keyType, this.valueType]);
    }
    interopType() {
        throw new Error("Must never be used");
    }
    isPointerType() {
        return true;
    }
    unionDiscriminator(value, index, writer, duplicates) {
        return writer.discriminatorFromExpressions(value, RuntimeType.OBJECT, [writer.makeString(`${value} instanceof Map`)]);
    }
    getObjectAccessor(language, value, args) {
        return language === Language.CPP && (args === null || args === void 0 ? void 0 : args.index) && (args === null || args === void 0 ? void 0 : args.field)
            ? `${value}.${args.field}[${args.index}]`
            : value;
    }
}
class DateConvertor extends BaseArgConvertor {
    constructor(param) {
        super(IDLBigintType, [RuntimeType.NUMBER], false, false, param);
    }
    convertorArg(param, writer) {
        if (writer.language === Language.CPP) {
            return param;
        }
        return `${param}.getTime()`;
    }
    convertorSerialize(param, value, writer) {
        if (writer.language === Language.CPP) {
            writer.writeMethodCall(`${param}Serializer`, "writeInt64", [value]);
        }
        else if (writer.language === Language.CJ) {
            writer.writeMethodCall(`${param}Serializer`, "writeInt64", [
                writer.makeCast(writer.makeString(`${value}`), IDLI64Type).asString()
            ]);
        }
        else {
            writer.writeMethodCall(`${param}Serializer`, "writeInt64", [
                writer.makeCast(writer.makeString(`${value}.getTime()`), IDLI64Type).asString()
            ]);
        }
    }
    convertorDeserialize(bufferName, deserializerName, assigneer, writer) {
        const deserializeTime = writer.makeMethodCall(`${deserializerName}`, "readInt64", []);
        if (writer.language === Language.CPP) {
            return assigneer(deserializeTime);
        }
        if (writer.language === Language.CJ) {
            return assigneer(writer.makeString(`DateTime.now()`));
        }
        return assigneer(writer.makeString(`new Date(${deserializeTime.asString()})`));
    }
    nativeType() {
        return IDLDate;
    }
    interopType() {
        return IDLDate;
    }
    isPointerType() {
        return false;
    }
}
class ProxyConvertor extends BaseArgConvertor {
    constructor(convertor, suggestedReference) {
        super(suggestedReference ? suggestedReference : convertor.idlType, convertor.runtimeTypes, convertor.isScoped, convertor.useArray, convertor.param);
        this.convertor = convertor;
    }
    convertorArg(param, writer) {
        return this.convertor.convertorArg(param, writer);
    }
    convertorDeserialize(bufferName, deserializerName, assigneer, writer) {
        return this.convertor.convertorDeserialize(bufferName, deserializerName, assigneer, writer);
    }
    convertorSerialize(param, value, printer) {
        this.convertor.convertorSerialize(param, value, printer);
    }
    nativeType() {
        return this.convertor.nativeType();
    }
    interopType() {
        return this.convertor.interopType();
    }
    isPointerType() {
        return this.convertor.isPointerType();
    }
    unionDiscriminator(value, index, writer, duplicates) {
        return this.convertor.unionDiscriminator(value, index, writer, duplicates);
    }
    getMembers() {
        return this.convertor.getMembers();
    }
}
class TypeAliasConvertor extends ProxyConvertor {
    constructor(library, param, typedef) {
        super(library.typeConvertor(param, typedef.type), createReferenceType(typedef));
    }
}
class CustomTypeConvertor extends BaseArgConvertor {
    constructor(param, customTypeName, isGenericType, tsType) {
        super(createReferenceType(tsType !== null && tsType !== void 0 ? tsType : "Object"), [RuntimeType.OBJECT], false, true, param);
        this.customTypeName = customTypeName;
        this.isGenericType = isGenericType;
        warnCustomObject(`${customTypeName}: ${tsType}`);
    }
    convertorArg(param, writer) {
        throw new Error("Must never be used");
    }
    /** todo: check */
    convertorSerialize(param, value, printer) {
        printer.writeMethodCall(`${param}Serializer`, `writeCustomObject`, [`"${this.customTypeName}"`, printer.makeCastCustomObject(value, this.isGenericType).asString()]);
    }
    convertorDeserialize(bufferName, deserializerName, assigneer, writer) {
        const type = writer.language === Language.CPP
            ? this.nativeType()
            : this.idlType;
        return assigneer(writer.makeCast(writer.makeMethodCall(`${deserializerName}`, "readCustomObject", [writer.makeString(`"${this.customTypeName}"`)]), type, { optional: false }));
    }
    nativeType() {
        return IDLCustomObjectType;
    }
    interopType() {
        throw new Error("Must never be used");
    }
    isPointerType() {
        return true;
    }
}
class OptionConvertor extends BaseArgConvertor {
    // TODO: be smarter here, and for smth like Length|undefined or number|undefined pass without serializer.
    constructor(library, param, type) {
        let conv = library.typeConvertor(param, type);
        let currentConv = conv;
        while (currentConv instanceof ProxyConvertor) {
            currentConv = currentConv.convertor;
        }
        if (currentConv instanceof OptionConvertor) {
            conv = currentConv.typeConvertor;
        }
        let runtimeTypes = conv.runtimeTypes;
        if (!runtimeTypes.includes(RuntimeType.UNDEFINED)) {
            runtimeTypes.push(RuntimeType.UNDEFINED);
        }
        super(createOptionalType(conv.idlType), runtimeTypes, conv.isScoped, true, param);
        this.type = type;
        this.typeConvertor = conv;
    }
    convertorArg(param, writer) {
        throw new Error("Must never be used");
    }
    convertorSerialize(param, value, printer) {
        const valueType = `${value}_type`.replaceAll('.', '_');
        const serializedType = (printer.language == Language.JAVA ? undefined : IDLI32Type);
        printer.writeStatement(printer.makeAssign(valueType, serializedType, printer.makeRuntimeType(RuntimeType.UNDEFINED), true, false));
        if (printer.language != Language.CJ && printer.language != Language.KOTLIN) {
            printer.runtimeType(this, valueType, value);
            printer.writeMethodCall(`${param}Serializer`, "writeInt8", [printer.castToInt(valueType, 8)]);
        }
        printer.print(`if (${printer.makeRuntimeTypeCondition(valueType, false, RuntimeType.UNDEFINED, value).asString()}) {`);
        printer.pushIndent();
        if (printer.language == Language.CJ || printer.language == Language.KOTLIN) {
            printer.writeMethodCall(`${param}Serializer`, "writeInt8", ["RuntimeType.OBJECT.ordinal"]); // everything is object, except None<T>
        }
        const valueValue = `${value}_value`.replaceAll('.', '_');
        printer.writeStatement(printer.makeAssign(valueValue, undefined, printer.makeValueFromOption(value, this.typeConvertor), true));
        this.typeConvertor.convertorSerialize(param, this.typeConvertor.getObjectAccessor(printer.language, valueValue), printer);
        printer.popIndent();
        printer.print(`}`);
        if (printer.language == Language.CJ || printer.language == Language.KOTLIN) {
            printer.print('else {');
            printer.pushIndent();
            printer.writeMethodCall(`${param}Serializer`, "writeInt8", ["RuntimeType.UNDEFINED.ordinal"]); // undefined
            printer.popIndent();
            printer.print('}');
        }
    }
    convertorCArg(param) {
        throw new Error("Must never be used");
    }
    convertorDeserialize(bufferName, deserializerName, assigneer, writer) {
        const runtimeBufferName = `${bufferName}_runtimeType`;
        const statements = [];
        statements.push(writer.makeAssign(runtimeBufferName, undefined, writer.makeCast(writer.makeString(`${deserializerName}.readInt8()`), writer.getRuntimeType()), true));
        const bufferType = this.nativeType();
        statements.push(writer.makeAssign(bufferName, bufferType, (writer.language == Language.CJ || writer.language == Language.KOTLIN) ? writer.makeNull() : undefined, true, false));
        const thenStatement = new BlockStatement([
            this.typeConvertor.convertorDeserialize(`${bufferName}_`, deserializerName, (expr) => {
                const receiver = writer.language === Language.CPP
                    ? `${bufferName}.value` : bufferName;
                return writer.makeAssign(receiver, undefined, expr, false);
            }, writer)
        ]);
        statements.push(writer.makeSetOptionTag(bufferName, writer.makeCast(writer.makeString(runtimeBufferName), writer.getTagType())));
        statements.push(writer.makeCondition(writer.makeRuntimeTypeDefinedCheck(runtimeBufferName), thenStatement));
        statements.push(assigneer(writer.makeString(bufferName)));
        return writer.makeBlock(statements, false);
    }
    nativeType() {
        return createOptionalType(this.type);
    }
    interopType() {
        return createOptionalType(this.type);
    }
    isPointerType() {
        return true;
    }
    getObjectAccessor(language, value, args) {
        return language === Language.CPP ? `${value}.value` : value;
    }
}
class UnionConvertor extends BaseArgConvertor {
    constructor(library, param, type) {
        super(IDLObjectType, [], false, true, param);
        this.library = library;
        this.type = type;
        this.memberConvertors = type.types.map(member => library.typeConvertor(param, member));
        this.unionChecker = new UnionRuntimeTypeChecker(this.memberConvertors);
        this.runtimeTypes = this.memberConvertors.flatMap(it => it.runtimeTypes);
        this.idlType = type;
    }
    convertorArg(param, writer) {
        throw new Error("Do not use for union");
    }
    convertorSerialize(param, value, printer) {
        var _a;
        printer.writeStatement(printer.makeAssign(`${value}_type`, IDLI32Type, printer.makeUnionTypeDefaultInitializer(), true, false));
        printer.writeStatement(printer.makeUnionSelector(value, `${value}_type`));
        this.memberConvertors.forEach((it, index) => {
            const maybeElse = (index > 0 && this.memberConvertors[index - 1].runtimeTypes.length > 0) ? "else " : "";
            const conditions = this.unionChecker.makeDiscriminator(value, index, printer);
            printer.print(`${maybeElse}if (${conditions.asString()}) {`);
            printer.pushIndent();
            printer.writeMethodCall(`${param}Serializer`, "writeInt8", [printer.castToInt(index.toString(), 8)]);
            if (!(it instanceof UndefinedConvertor)) {
                printer.writeStatement(printer.makeAssign(`${value}_${index}`, undefined, printer.makeUnionVariantCast(it.getObjectAccessor(printer.language, value), printer.getNodeName(it.idlType), it, index), true));
                it.convertorSerialize(param, `${value}_${index}`, printer);
            }
            printer.popIndent();
            printer.print(`}`);
        });
        this.unionChecker.reportConflicts((_a = this.library.getCurrentContext()) !== null && _a !== void 0 ? _a : "<unknown context>", printer);
    }
    convertorDeserialize(bufferName, deserializerName, assigneer, writer) {
        const statements = [];
        let selectorBuffer = `${bufferName}_selector`;
        const maybeOptionalUnion = writer.language === Language.CPP || writer.language == Language.CJ
            ? this.type
            : createOptionalType(this.type);
        statements.push(writer.makeAssign(selectorBuffer, IDLI8Type, writer.makeString(`${deserializerName}.readInt8()`), true));
        statements.push(writer.makeAssign(bufferName, maybeOptionalUnion, undefined, true, false));
        if (writer.language === Language.CPP)
            statements.push(writer.makeAssign(`${bufferName}.selector`, undefined, writer.makeString(selectorBuffer), false));
        const branches = this.memberConvertors.map((it, index) => {
            const receiver = this.getObjectAccessor(writer.language, bufferName, { index: `${index}` });
            const expr = writer.makeString(`${selectorBuffer} == ${writer.castToInt(index.toString(), 8)}`);
            const stmt = new BlockStatement([
                writer.makeSetUnionSelector(bufferName, `${index}`),
                it.convertorDeserialize(`${bufferName}_u`, deserializerName, (expr) => {
                    if (writer.language == Language.CJ || writer.language == Language.KOTLIN) {
                        return writer.makeAssign(receiver, undefined, writer.makeFunctionCall(writer.getNodeName(this.type), [expr]), false);
                    }
                    else {
                        return writer.makeAssign(receiver, undefined, expr, false);
                    }
                }, writer),
            ], false);
            return { expr, stmt };
        });
        statements.push(writer.makeMultiBranchCondition(branches, writer.makeThrowError(`One of the branches for ${bufferName} has to be chosen through deserialisation.`)));
        statements.push(assigneer(writer.makeCast(writer.makeString(bufferName), this.nativeType())));
        return new BlockStatement(statements, false);
    }
    nativeType() {
        return this.type;
    }
    interopType() {
        throw new Error("Union");
    }
    isPointerType() {
        return true;
    }
    getObjectAccessor(language, value, args) {
        return language === Language.CPP && (args === null || args === void 0 ? void 0 : args.index) ? `${value}.value${args.index}` : value;
    }
    unionDiscriminator(value, index, writer, duplicates) {
        const checker = new UnionRuntimeTypeChecker(this.memberConvertors);
        return writer.makeNaryOp("||", this.memberConvertors.map((_, n) => checker.makeDiscriminator(value, n, writer)));
    }
}
class FunctionConvertor extends BaseArgConvertor {
    constructor(library, param) {
        // TODO: pass functions as integers to native side.
        super(IDLFunctionType, [RuntimeType.FUNCTION], false, false, param);
        this.library = library;
    }
    convertorArg(param, writer) {
        return writer.language == Language.CPP ? `makeArkFunctionFromId(${param})` : `registerCallback(${param})`;
    }
    convertorSerialize(param, value, writer) {
        writer.writeMethodCall(`${param}Serializer`, "writeFunction", [value]);
    }
    convertorDeserialize(bufferName, deserializerName, assigneer, writer) {
        return assigneer(writer.makeCast(writer.makeString(`${deserializerName}.readFunction()`), IDLFunctionType, { optional: true }));
    }
    nativeType() {
        return IDLFunctionType;
    }
    interopType() {
        return IDLFunctionType;
    }
    isPointerType() {
        return false;
    }
}
class MaterializedClassConvertor extends BaseArgConvertor {
    constructor(library, param, declaration) {
        super(createReferenceType(declaration), [RuntimeType.OBJECT], false, false, param);
        this.library = library;
        this.declaration = declaration;
    }
    convertorArg(param, writer) {
        switch (writer.language) {
            case Language.CPP:
                return `static_cast<${generatorTypePrefix()}${qualifiedName(this.declaration, "_", "namespace.name")}>(${param})`;
            case Language.JAVA:
            case Language.KOTLIN:
            case Language.CJ:
                return `MaterializedBase.toPeerPtr(${writer.escapeKeyword(param)})`;
            default:
                return `toPeerPtr(${param})`;
        }
    }
    convertorSerialize(param, value, printer) {
        const accessorRoot = getSerializerName(this.declaration);
        printer.addFeature(accessorRoot, this.library.layout.resolve({ node: this.declaration, role: LayoutNodeRole.SERIALIZER }));
        printer.writeStaticMethodCall(accessorRoot, 'write', [`${param}Serializer`, value]);
    }
    convertorDeserialize(bufferName, deserializerName, assigneer, writer) {
        const accessorRoot = getSerializerName(this.declaration);
        writer.addFeature(accessorRoot, this.library.layout.resolve({ node: this.declaration, role: LayoutNodeRole.SERIALIZER }));
        const readStatement = writer.makeCast(writer.makeStaticMethodCall(accessorRoot, "read", [writer.makeString(deserializerName)]), this.declaration);
        return assigneer(readStatement);
    }
    nativeType() {
        return createReferenceType(this.declaration);
    }
    interopType() {
        return IDLPointerType;
    }
    isPointerType() {
        return false;
    }
    unionDiscriminator(value, index, writer, duplicates) {
        if (isInterface$1(this.declaration)) {
            if (this.declaration.subkind === IDLInterfaceSubkind.Class) {
                return writer.discriminatorFromExpressions(value, RuntimeType.OBJECT, [writer.instanceOf(this, value, duplicates)]);
            }
            if (this.declaration.subkind === IDLInterfaceSubkind.Interface) {
                const uniqueFields = this.declaration.properties.filter(it => !duplicates.has(it.name));
                return this.discriminatorFromFields(value, writer, uniqueFields, it => it.name, it => it.isOptional, duplicates);
            }
        }
    }
}
class ExternalTypeConvertor extends BaseArgConvertor {
    constructor(library, param, declaration) {
        super(createReferenceType(declaration), [RuntimeType.OBJECT], false, false, param);
        this.library = library;
        this.declaration = declaration;
        console.log(`ExternalType convertor for type: ${declaration.name}`);
    }
    convertorArg(param, writer) {
        const lang = writer.language;
        switch (lang) {
            case Language.CPP:
                return `static_cast<${generatorTypePrefix()}${qualifiedName(this.declaration, "_", "namespace.name")}>(${param})`;
            default:
                return `extractors.${getExtractorName(this.declaration, lang, true)}(${param})`;
        }
    }
    convertorSerialize(param, value, printer) {
        const accessor = getSerializerName(this.declaration);
        printer.addFeature(accessor, this.library.layout.resolve({ node: this.declaration, role: LayoutNodeRole.SERIALIZER }));
        printer.writeStatement(printer.makeStatement(printer.makeStaticMethodCall(accessor, 'write', [
            printer.makeString(`${param}Serializer`),
            printer.makeString(value)
        ])));
    }
    convertorDeserialize(bufferName, deserializerName, assigneer, writer) {
        const accessor = getSerializerName(this.declaration);
        writer.addFeature(accessor, this.library.layout.resolve({ node: this.declaration, role: LayoutNodeRole.SERIALIZER }));
        const readStatement = writer.makeCast(writer.makeStaticMethodCall(accessor, 'read', [writer.makeString(deserializerName)]), this.declaration);
        return assigneer(readStatement);
    }
    nativeType() {
        return createReferenceType(this.declaration);
    }
    interopType() {
        return IDLPointerType;
    }
    isPointerType() {
        return false;
    }
    unionDiscriminator(value, index, writer, duplicates) {
        if (isInterface$1(this.declaration)) {
            if (this.declaration.subkind === IDLInterfaceSubkind.Class) {
                return writer.discriminatorFromExpressions(value, RuntimeType.OBJECT, [writer.instanceOf(this, value, duplicates)]);
            }
            if (this.declaration.subkind === IDLInterfaceSubkind.Interface) {
                const uniqueFields = this.declaration.properties.filter(it => !duplicates.has(it.name));
                return this.discriminatorFromFields(value, writer, uniqueFields, it => it.name, it => it.isOptional, duplicates);
            }
        }
    }
}
class ImportTypeConvertor extends BaseArgConvertor {
    constructor(param, importedName) {
        super(IDLObjectType, [RuntimeType.OBJECT], false, true, param);
        this.importedName = importedName;
        warnCustomObject(importedName, `imported`);
    }
    convertorArg(param, writer) {
        throw new Error("Must never be used");
    }
    convertorSerialize(param, value, printer) {
        printer.writeMethodCall(`${param}Serializer`, "writeCustomObject", [`"${this.importedName}"`, value]);
    }
    convertorDeserialize(bufferName, deserializerName, assigneer, writer) {
        return assigneer(writer.makeString(`${deserializerName}.readCustomObject("${this.importedName}")`));
    }
    nativeType() {
        // treat ImportType as CustomObject
        return IDLCustomObjectType;
    }
    interopType() {
        throw new Error("Must never be used");
    }
    isPointerType() {
        return true;
    }
}
class CallbackConvertor extends BaseArgConvertor {
    constructor(library, param, decl, interopModuleName) {
        super(createReferenceType(decl), [RuntimeType.FUNCTION], false, true, param);
        this.library = library;
        this.decl = decl;
        this.interopModuleName = interopModuleName;
    }
    get isTransformed() {
        return this.decl !== this.transformedDecl;
    }
    get transformedDecl() {
        var _a;
        return (_a = maybeTransformManagedCallback(this.decl, this.library)) !== null && _a !== void 0 ? _a : this.decl;
    }
    convertorArg(param, writer) {
        throw new Error("Must never be used");
    }
    convertorSerialize(param, value, writer) {
        if (writer.language == Language.CPP) {
            writer.writeMethodCall(`${param}Serializer`, "writeCallbackResource", [`${value}.resource`]);
            writer.writeMethodCall(`${param}Serializer`, "writePointer", [writer.makeCast(new StringExpression(`${value}.call`), IDLPointerType, { unsafe: true }).asString()]);
            writer.writeMethodCall(`${param}Serializer`, "writePointer", [writer.makeCast(new StringExpression(`${value}.callSync`), IDLPointerType, { unsafe: true }).asString()]);
            return;
        }
        if (this.isTransformed)
            value = `CallbackTransformer.transformFrom${this.library.getInteropName(this.decl)}(${value})`;
        writer.writeMethodCall(`${param}Serializer`, `holdAndWriteCallback`, [`${value}`]);
    }
    convertorDeserialize(bufferName, deserializerName, assigneer, writer, useSyncVersion = false) {
        if (writer.language == Language.CPP) {
            const callerInvocation = writer.makeString(`getManagedCallbackCaller(${generateCallbackKindAccess(this.transformedDecl, writer.language)})`);
            const callerSyncInvocation = writer.makeString(`getManagedCallbackCallerSync(${generateCallbackKindAccess(this.transformedDecl, writer.language)})`);
            const resourceReadExpr = writer.makeMethodCall(`${deserializerName}`, `readCallbackResource`, []);
            const callReadExpr = writer.makeCast(writer.makeMethodCall(`${deserializerName}`, `readPointerOrDefault`, [writer.makeCast(callerInvocation, IDLPointerType, { unsafe: true })]), IDLUndefinedType /* not used */, {
                unsafe: true,
                overrideTypeName: `void(*)(${generateCallbackAPIArguments(this.library, this.transformedDecl).join(", ")})`
            });
            const callSyncReadExpr = writer.makeCast(writer.makeMethodCall(`${deserializerName}`, `readPointerOrDefault`, [writer.makeCast(callerSyncInvocation, IDLPointerType, { unsafe: true })]), IDLUndefinedType /* not used */, {
                unsafe: true,
                overrideTypeName: `void(*)(${[`${generatorTypePrefix()}VMContext vmContext`].concat(generateCallbackAPIArguments(this.library, this.transformedDecl)).join(", ")})`
            });
            return assigneer(writer.makeString(`{${resourceReadExpr.asString()}, ${callReadExpr.asString()}, ${callSyncReadExpr.asString()}}`));
        }
        const resourceName = bufferName + "_resource";
        const callName = bufferName + "_call";
        const callSyncName = bufferName + '_callSync';
        const argsSerializer = bufferName + "_args";
        const continuationValueName = bufferName + "_continuationValue";
        const continuationCallbackName = bufferName + "_continuationCallback";
        const statements = [];
        statements.push(writer.makeAssign(resourceName, createReferenceType("CallbackResource"), writer.makeMethodCall(deserializerName, 'readCallbackResource', []), true));
        statements.push(writer.makeAssign(callName, IDLPointerType, writer.makeMethodCall(deserializerName, `readPointer`, []), true));
        statements.push(writer.makeAssign(callSyncName, IDLPointerType, writer.makeMethodCall(deserializerName, 'readPointer', []), true));
        const callbackSignature = new NamedMethodSignature(this.decl.returnType, this.decl.parameters.map(it => maybeOptional(it.type, it.isOptional)), this.decl.parameters.map(it => it.name));
        const hasContinuation = !isVoidType(this.decl.returnType);
        let continuation = [];
        if (hasContinuation) {
            const continuationReference = this.library.createContinuationCallbackReference(this.decl.returnType);
            const continuationConvertor = this.library.typeConvertor(continuationCallbackName, continuationReference);
            const returnType = this.decl.returnType;
            const optionalReturnType = createOptionalType(this.decl.returnType);
            continuation = [
                writer.language == Language.CJ ?
                    writer.makeAssign(continuationValueName, undefined, writer.makeString(`${writer.getNodeName(this.decl.returnType).replace(/[\<\>]/g, '')}Holder(None<${writer.getNodeName(this.decl.returnType)}>)`), true, true) :
                    writer.makeAssign(continuationValueName, optionalReturnType, undefined, true, false),
                writer.makeAssign(continuationCallbackName, continuationReference, writer.makeLambda(new NamedMethodSignature(IDLVoidType, [returnType], [`value`]), [
                    writer.language == Language.CJ ?
                        writer.makeAssign(`${continuationValueName}.value`, undefined, writer.makeString(`value`), false) :
                        writer.makeAssign(continuationValueName, undefined, writer.makeString(`value`), false)
                ]), true),
                new ProxyStatement(writer => {
                    continuationConvertor.convertorSerialize(argsSerializer, continuationCallbackName, writer);
                }),
            ];
        }
        const result = writer.makeLambda(callbackSignature, [
            writer.makeAssign(`${argsSerializer}Serializer`, createReferenceType('SerializerBase'), writer.makeMethodCall('SerializerBase', 'hold', []), true),
            new ExpressionStatement(writer.makeMethodCall(`${argsSerializer}Serializer`, `writeInt32`, [writer.makeString(`${resourceName}.resourceId`)])),
            new ExpressionStatement(writer.makeMethodCall(`${argsSerializer}Serializer`, `writePointer`, [writer.makeString(callName)])),
            new ExpressionStatement(writer.makeMethodCall(`${argsSerializer}Serializer`, `writePointer`, [writer.makeString(callSyncName)])),
            ...this.decl.parameters.map(it => {
                const convertor = this.library.typeConvertor(it.name, it.type, it.isOptional);
                return new ProxyStatement((writer) => {
                    convertor.convertorSerialize(argsSerializer, writer.escapeKeyword(it.name), writer);
                });
            }),
            ...continuation,
            new ExpressionStatement(useSyncVersion
                ? writer.makeNativeCall(this.interopModuleName, `_CallCallbackSync`, [
                    writer.makeString(generateCallbackKindValue(this.decl).toString()),
                    writer.makeSerializedBufferGetter(`${argsSerializer}Serializer`),
                    writer.makeString(`${argsSerializer}Serializer.length()`),
                ])
                : writer.makeNativeCall(this.interopModuleName, `_CallCallback`, [
                    writer.makeString(generateCallbackKindValue(this.decl).toString()),
                    writer.makeSerializedBufferGetter(`${argsSerializer}Serializer`),
                    writer.makeString(`${argsSerializer}Serializer.length()`),
                ])),
            new ExpressionStatement(writer.makeMethodCall(`${argsSerializer}Serializer`, `release`, [])),
            writer.makeLambdaReturn(hasContinuation
                ? writer.makeCast(writer.language == Language.CJ ?
                    writer.makeString(`${continuationValueName}.value`) :
                    writer.makeString(continuationValueName), this.decl.returnType)
                : undefined),
        ]);
        return writer.makeBlock([
            ...statements,
            assigneer(result)
        ], false);
    }
    nativeType() {
        return createReferenceType(this.decl);
    }
    isPointerType() {
        return true;
    }
    unionDiscriminator(value, index, writer, duplicates) {
        // We serialize callbacks as table offsets, so don't need to discriminate them. Runtime type check is enough
        return writer.makeUnionVariantCondition(this, value, `${value}_type`, RuntimeType[RuntimeType.FUNCTION]);
    }
}
////////////////////////////////////////////////////////////////////////////////
// UTILS
const customObjects = new Set();
function warnCustomObject(type, msg) {
    if (!customObjects.has(type)) {
        warn(`Use CustomObject for ${msg ? `${msg} ` : ``}type ${type}`);
        customObjects.add(type);
    }
}
const CallbackKind = "CallbackKind";
function generateCallbackKindName(callback) {
    return `Kind_${callback.name}`;
}
function generateCallbackKindAccess(callback, language) {
    const name = generateCallbackKindName(callback);
    if (language == Language.CPP)
        return name;
    return `${CallbackKind}.${name}`;
}
function generateCallbackKindValue(callback) {
    const name = generateCallbackKindName(callback);
    return hashCodeFromString(name);
}
function generateCallbackAPIArguments(library, callback) {
    const nameConvertor = new CppConvertor(library);
    const args = [`const ${PrimitiveTypesInstance.Int32.getText()} resourceId`];
    args.push(...callback.parameters.map(it => {
        const target = library.toDeclaration(it.type);
        const type = library.typeConvertor(it.name, it.type, it.isOptional);
        const constPrefix = !isEnum$1(target) ? "const " : "";
        return `${constPrefix}${nameConvertor.convert(type.nativeType())} ${type.param}`;
    }));
    if (!isVoidType(callback.returnType)) {
        const type = library.typeConvertor(`continuation`, library.createContinuationCallbackReference(callback.returnType), false);
        args.push(`const ${nameConvertor.convert(type.nativeType())} ${type.param}`);
    }
    return args;
}
function maybeTransformManagedCallback(callback, library) {
    if (callback.name === "CustomBuilder")
        return library.resolveTypeReference(createReferenceType("CustomNodeBuilder"));
    return undefined;
}

function isInModule(nodeOrPackage, module) {
    if (typeof nodeOrPackage === 'object')
        return isInModule(getPackageName(nodeOrPackage), module);
    return module.packages.some(modulePackage => nodeOrPackage.startsWith(modulePackage));
}
function currentModule() {
    const conf = generatorConfiguration();
    const result = conf.modules.get(conf.moduleName);
    if (!result)
        throw new Error(`Can not determine current module configuration ${conf.moduleName}`);
    return result;
}
function isInCurrentModule(nodeOrPackage) {
    if (typeof nodeOrPackage === 'string')
        return isInModule(nodeOrPackage, currentModule());
    else
        return isInModule(nodeOrPackage, currentModule());
}

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
class IDLIdentityTransformer {
    cloneNodeInitializer(node) {
        var _a;
        return {
            documentation: node.documentation,
            extendedAttributes: (_a = node.extendedAttributes) === null || _a === void 0 ? void 0 : _a.map(e => ({ name: e.name, value: e.value })),
            fileName: node.fileName,
        };
    }
    visitInterface(node) {
        return createInterface(node.name, node.subkind, node.inheritance.map(x => this.visitReferenceType(x)), node.constructors.map(x => this.visitConstructor(x)), node.constants.map(x => this.visitConstant(x)), node.properties.map(x => this.visitProperty(x)), node.methods.map(x => this.visitMethod(x)), node.callables.map(x => this.visitCallable(x)), node.typeParameters, this.cloneNodeInitializer(node));
    }
    visitImport(node) {
        return createImport(node.clause, node.name, this.cloneNodeInitializer(node));
    }
    visitCallback(node) {
        return createCallback(node.name, node.parameters.map(x => this.visitParameter(x)), this.visitType(node.returnType), this.cloneNodeInitializer(node), node.typeParameters);
    }
    visitConstant(node) {
        return createConstant(node.name, this.visitType(node.type), node.value, this.cloneNodeInitializer(node));
    }
    visitProperty(node) {
        return createProperty(node.name, this.visitType(node.type), node.isReadonly, node.isStatic, node.isOptional, this.cloneNodeInitializer(node));
    }
    visitParameter(node) {
        return createParameter(node.name, this.visitType(node.type), node.isOptional, node.isVariadic, this.cloneNodeInitializer(node));
    }
    visitMethod(node) {
        return createMethod(node.name, node.parameters.map(x => this.visitParameter(x)), this.visitType(node.returnType), {
            isAsync: node.isAsync,
            isFree: node.isFree,
            isOptional: node.isOptional,
            isStatic: node.isStatic
        }, this.cloneNodeInitializer(node), node.typeParameters);
    }
    visitCallable(node) {
        return createCallable(node.name, node.parameters.map(x => this.visitParameter(x)), this.visitType(node.returnType), {
            isAsync: node.isAsync,
            isStatic: node.isStatic
        }, this.cloneNodeInitializer(node), node.typeParameters);
    }
    visitConstructor(node) {
        var _a;
        return createConstructor(node.parameters.map(x => this.visitParameter(x)), this.visitType((_a = node.returnType) !== null && _a !== void 0 ? _a : IDLVoidType), this.cloneNodeInitializer(node));
    }
    visitEnum(node) {
        var _a;
        return createEnum(node.name, node.elements.map(x => this.visitEnumMember(x)), (_a = this.cloneNodeInitializer(node)) !== null && _a !== void 0 ? _a : {});
    }
    visitEnumMember(node) {
        return createEnumMember(node.name, createEnum('$FAKE$', [], {}), this.visitPrimitiveType(node.type), node.initializer);
    }
    visitTypedef(node) {
        return createTypedef(node.name, this.visitType(node.type), node.typeParameters, this.cloneNodeInitializer(node));
    }
    visitPrimitiveType(node) {
        return node;
    }
    visitContainerType(node) {
        return createContainerType(node.containerKind, node.elementType.map(x => this.visitType(x)), this.cloneNodeInitializer(node));
    }
    visitUnspecifiedGenericType(node) {
        return createUnspecifiedGenericType(node.name, node.typeArguments.map(x => this.visitType(x)), this.cloneNodeInitializer(node));
    }
    visitReferenceType(node) {
        var _a;
        return createReferenceType(node.name, (_a = node.typeArguments) === null || _a === void 0 ? void 0 : _a.map(x => this.visitType(x)), this.cloneNodeInitializer(node));
    }
    visitUnionType(node) {
        return createUnionType(node.types.map(x => this.visitType(x)), node.name, this.cloneNodeInitializer(node));
    }
    visitTypeParameterType(node) {
        return createTypeParameterReference(node.name, this.cloneNodeInitializer(node));
    }
    visitOptionalType(node) {
        return createOptionalType(this.visitType(node.type), this.cloneNodeInitializer(node));
    }
    visitVersion(node) {
        return createVersion(node.value, this.cloneNodeInitializer(node));
    }
    visitNamespace(node) {
        return createNamespace(node.name, node.members.map(x => this.visitEntry(x)), this.cloneNodeInitializer(node));
    }
    visitFile(node) {
        return createFile(node.entries.map(x => this.visitEntry(x)), node.fileName, node.packageClause, this.cloneNodeInitializer(node));
    }
    ////
    visitEntry(node) {
        if (isInterface$1(node)) {
            return this.visitInterface(node);
        }
        if (isImport(node)) {
            return this.visitImport(node);
        }
        if (isCallback$1(node)) {
            return this.visitCallback(node);
        }
        if (isConstant$1(node)) {
            return this.visitConstant(node);
        }
        if (isProperty(node)) {
            return this.visitProperty(node);
        }
        if (isParameter(node)) {
            return this.visitParameter(node);
        }
        if (isMethod(node)) {
            return this.visitMethod(node);
        }
        if (isCallable(node)) {
            return this.visitCallable(node);
        }
        if (isConstructor$1(node)) {
            return this.visitConstructor(node);
        }
        if (isEnum$1(node)) {
            return this.visitEnum(node);
        }
        if (isEnumMember(node)) {
            return this.visitEnumMember(node);
        }
        if (isTypedef$1(node)) {
            return this.visitTypedef(node);
        }
        if (isVersion(node)) {
            return this.visitVersion(node);
        }
        if (isNamespace(node)) {
            return this.visitNamespace(node);
        }
        throw new Error(`Not exhaustive "${IDLKind[node.kind]}"`);
    }
    visitType(node) {
        if (isPrimitiveType(node)) {
            return this.visitPrimitiveType(node);
        }
        if (isContainerType(node)) {
            return this.visitContainerType(node);
        }
        if (isUnspecifiedGenericType(node)) {
            return this.visitUnspecifiedGenericType(node);
        }
        if (isReferenceType(node)) {
            return this.visitReferenceType(node);
        }
        if (isUnionType(node)) {
            return this.visitUnionType(node);
        }
        if (isTypeParameterType(node)) {
            return this.visitTypeParameterType(node);
        }
        if (isOptionalType(node)) {
            return this.visitOptionalType(node);
        }
        throw new Error(`Not exhaustive "${IDLKind[node.kind]}"`);
    }
}
function applyTransformer(transformer, files) {
    return files.map(file => linkParentBack(transformer.visitFile(file)));
}

class FQReferenceMaker extends IDLIdentityTransformer {
    constructor(resolver) {
        super();
        this.resolver = resolver;
    }
    visitReferenceType(node) {
        const transformed = super.visitReferenceType(node);
        const declaration = this.resolver.resolveTypeReference(node);
        if (!declaration) {
            const names = [];
            let current = node;
            while (current) {
                if (isNamedNode(current)) {
                    names.push(current.name);
                }
                else {
                    names.push('()');
                }
                current = current.parent;
            }
            console.error(`NOT FOUND REFERENCE "${node.name}" (${names.join(' => ')})`);
            return createReferenceType('CustomObject');
        }
        transformed.name = getFQName(declaration);
        return transformed;
    }
}

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
const lenses = {
    globals: lib.lens(lib.select.files())
        .pipe(lib.select.nodes())
        .pipe(lib.req('globals', (nodes) => {
        const result = [];
        const queue = [nodes];
        while (queue.length) {
            const line = {
                constants: [],
                methods: []
            };
            const next = queue.pop();
            next.forEach(node => {
                if (!isInCurrentModule(node))
                    return;
                if (isNamespace(node)) {
                    queue.push(node.members);
                }
                if (isConstant$1(node)) {
                    line.constants.push(node);
                }
                if (isMethod(node)) {
                    line.methods.push(node);
                }
            });
            if (line.constants.length || line.methods.length) {
                result.push(line);
            }
        }
        return result;
    }))
};
class PeerLibrary {
    asIDLLibrary() {
        if (this._cachedIdlLibrary) {
            return this._cachedIdlLibrary;
        }
        this._cachedIdlLibrary = {
            files: this.files.map(file => file)
        };
        return this._cachedIdlLibrary;
    }
    get globals() {
        return query(this.asIDLLibrary(), lenses.globals);
    }
    initSyntheticEntries(file) {
        this._syntheticFile = file;
    }
    getSyntheticData() {
        return this._syntheticFile.entries.filter(it => isInterface$1(it));
    }
    get buildersToGenerate() {
        return Array.from(this.builderClasses.values()).filter(it => it.needBeGenerated);
    }
    get orderedMaterialized() {
        function accessorName(decl) {
            return getQualifiedName(decl, "namespace.name");
        }
        return Array.from(this.materializedClasses.values()).filter(it => it.needBeGenerated)
            .sort((a, b) => accessorName(a.decl).localeCompare(accessorName(b.decl)));
    }
    constructor(language, interopNativeModule, useMemoM3 = false) {
        this.language = language;
        this.interopNativeModule = interopNativeModule;
        this.useMemoM3 = useMemoM3;
        this.layout = LayoutManager.Empty();
        this._syntheticFile = createFile([]);
        this.files = [];
        this.auxFiles = [];
        this.builderClasses = new Map();
        this.materializedClasses = new Map();
        this.name = "";
        this.customComponentMethods = [];
        this.targetNameConvertorInstance = this.createTypeNameConvertor(this.language);
        this.interopNameConvertorInstance = new CppNameConvertor(this);
    }
    createLanguageWriter(language) {
        return createLanguageWriter(language !== null && language !== void 0 ? language : this.language, this);
    }
    createTypeNameConvertor(language) {
        switch (language) {
            case Language.TS: return new TSTypeNameConvertor(this);
            case Language.ARKTS: return new ETSTypeNameConvertor(this);
            case Language.JAVA: return new JavaTypeNameConvertor(this);
            case Language.CJ: return new CJTypeNameConvertor(this);
            case Language.CPP: return new CppConvertor(this);
            case Language.KOTLIN: return new KotlinTypeNameConvertor(this);
        }
        throw new Error(`IdlNameConvertor for ${language} is not implemented`);
    }
    get libraryPrefix() {
        return this.name ? this.name + "_" : "";
    }
    createContinuationParameters(continuationType) {
        const continuationParameters = [];
        if (isContainerType(continuationType) && IDLContainerUtils.isPromise(continuationType)) {
            const errorType = createOptionalType(createContainerType("sequence", [IDLStringType]));
            continuationParameters.push(createParameter("error", errorType, true));
            const promise = continuationType;
            if (!isVoidType(promise.elementType[0])) {
                const valueType = createOptionalType(promise.elementType[0]);
                continuationParameters.unshift(createParameter("value", valueType, true));
            }
        }
        else if (!isVoidType(continuationType))
            continuationParameters.push(createParameter('value', continuationType));
        return continuationParameters;
    }
    createContinuationCallbackReference(continuationType) {
        const continuationParameters = this.createContinuationParameters(continuationType);
        const syntheticName = generateSyntheticFunctionName(continuationParameters, IDLVoidType);
        return createReferenceType(syntheticName);
    }
    getCurrentContext() {
        return this.context;
    }
    setCurrentContext(context) {
        this.context = context;
    }
    findFileByOriginalFilename(filename) {
        return this.files.find(it => it.fileName === filename);
    }
    mapType(type) {
        return this.targetNameConvertorInstance.convert(type);
    }
    enableCache() {
        this.referenceCache = new Map();
    }
    makeRefsFQ() {
        this.files = applyTransformer(new FQReferenceMaker(this), this.files);
    }
    resolveTypeReference(type, singleStep) {
        var _a, _b;
        const key = type.parent ? type : type.name; // does entry have resolve context or just FQN
        let result = ((_a = this.referenceCache) === null || _a === void 0 ? void 0 : _a.has(key))
            ? this.referenceCache.get(key)
            : this.resolveTypeReferenceUncached(type, singleStep);
        (_b = this.referenceCache) === null || _b === void 0 ? void 0 : _b.set(key, result);
        return result;
    }
    resolveTypeReferenceUncached(type, singleStep) {
        var _a, _b;
        if ((_a = this.referenceCache) === null || _a === void 0 ? void 0 : _a.has(type))
            return this.referenceCache.get(type);
        let result = this.resolveNamedNode(type.name.split("."), type.parent);
        if (!singleStep) {
            const seen = new Set;
            while (result) {
                let nextResult = undefined;
                if (isImport(result))
                    nextResult = this.resolveImport(result);
                else if (isReferenceType(result))
                    nextResult = this.resolveNamedNode(result.name.split("."));
                else if (isTypedef$1(result) && isReferenceType(result.type))
                    nextResult = this.resolveNamedNode(result.type.name.split("."));
                if (!nextResult)
                    break;
                if (seen.has(nextResult)) {
                    console.warn(`Cyclic referenceType: ${type.name}, seen: [${[...seen.values()].map(getFQName).join(", ")}]`);
                    break;
                }
                seen.add(nextResult);
                result = nextResult;
            }
        }
        if (result && (isImport(result) || isNamespace(result)))
            result = undefined;
        (_b = this.referenceCache) === null || _b === void 0 ? void 0 : _b.set(type, result);
        return result;
    }
    resolveNamedNode(target, pov = undefined) {
        const qualifiedName = target.join(".");
        const entry = this._syntheticFile.entries.find(it => it.name === qualifiedName);
        if (entry)
            return entry;
        if (1 === target.length) {
            const predefined = this.files.flatMap(it => it.entries).filter(isInIdlizeInternal);
            const found = predefined.find(it => it.name === target.at(-1));
            if (found)
                return found;
        }
        const corpus = this.files.concat(this.auxFiles);
        let result = resolveNamedNode(target, pov, corpus);
        if (result && isEntry(result))
            return result;
        if (1 == target.length) {
            const stdScopes = generatorConfiguration().globalPackages.map(it => it.split('.'));
            for (const stdScope of stdScopes) {
                result = resolveNamedNode([...stdScope, ...target], undefined, corpus);
                if (result && isEntry(result))
                    return result;
            }
        }
        return undefined;
    }
    resolveImport(target) {
        let result = this.resolveNamedNode(target.clause);
        if (result) {
            if (isReferenceType(result))
                return this.resolveTypeReference(result);
            if (isImport(result)) {
                if (result == target) {
                    console.log("Self-targeted Import?");
                    return undefined;
                }
                return this.resolveImport(result);
            }
            if (isEntry(result))
                return result;
        }
        return undefined;
    }
    typeConvertor(param, type, isOptionalParam = false) {
        if (isOptionalParam) {
            return new OptionConvertor(this, param, maybeUnwrapOptionalType(type));
        }
        if (isOptionalType(type)) {
            return new OptionConvertor(this, param, type.type);
        }
        if (isPrimitiveType(type)) {
            switch (type) {
                case IDLI8Type: return new NumericConvertor(param, type);
                case IDLU8Type: return new NumericConvertor(param, type);
                case IDLI16Type: return new NumericConvertor(param, type);
                case IDLU16Type: return new NumericConvertor(param, type);
                case IDLI32Type: return new NumericConvertor(param, type);
                case IDLU32Type: return new NumericConvertor(param, type);
                case IDLI64Type: return new NumericConvertor(param, type);
                case IDLU64Type: return new NumericConvertor(param, type);
                case IDLF16Type: return new NumericConvertor(param, type);
                case IDLF32Type: return new NumericConvertor(param, type);
                case IDLF64Type: return new NumericConvertor(param, type);
                case IDLBigintType: return new BigIntToU64Convertor(param);
                case IDLSerializerBuffer: new PointerConvertor(param);
                case IDLPointerType: return new PointerConvertor(param);
                case IDLBufferType: return new BufferConvertor(param);
                case IDLBooleanType: return new BooleanConvertor(param);
                case IDLStringType: return new StringConvertor(param);
                case IDLNumberType: return new NumberConvertor(param);
                case IDLUndefinedType: return new UndefinedConvertor(param);
                case IDLVoidType: return new VoidConvertor(param);
                case IDLUnknownType:
                case IDLObjectType:
                case IDLAnyType: return new ObjectConvertor(param, IDLAnyType);
                case IDLDate: return new DateConvertor(param);
                case IDLFunctionType: return new FunctionConvertor(this, param);
                default: throw new Error(`Unconverted primitive ${DebugUtils.debugPrintType(type)}`);
            }
        }
        if (isReferenceType(type)) {
            // TODO: special cases for interop types.
            // TODO: this types are not references! NativeModulePrinter must be fixed
            switch (type.name.replaceAll('%TEXT%:', '')) { // this is really bad stub, to fix legacy references
                case 'KBoolean': return new BooleanConvertor(param);
                case 'KInt': return new NumericConvertor(param, IDLI32Type);
                case 'KFloat': return new NumericConvertor(param, IDLF32Type);
                case 'KLong': return new NumericConvertor(param, IDLI64Type);
                case 'KDouble': return new NumericConvertor(param, IDLF64Type);
                case 'KStringPtr': return new StringConvertor(param);
                case 'number': return new NumberConvertor(param);
                case 'KPointer': return new PointerConvertor(param);
            }
            if (generatorConfiguration().forceResource.includes(type.name)) {
                return new ObjectConvertor(param, type);
            }
            const decl = this.resolveTypeReference(type);
            if (decl && isImportAttr(decl) || !decl && isImportAttr(type))
                return new ImportTypeConvertor(param, this.targetNameConvertorInstance.convert(type));
            return this.declarationConvertor(param, type, decl);
        }
        if (isUnionType(type)) {
            return new UnionConvertor(this, param, type);
        }
        if (isContainerType(type)) {
            if (IDLContainerUtils.isSequence(type))
                return new ArrayConvertor(this, param, type, type.elementType[0]);
            if (IDLContainerUtils.isRecord(type))
                return new MapConvertor(this, param, type, type.elementType[0], type.elementType[1]);
        }
        if (isTypeParameterType(type)) {
            // TODO: unlikely correct.
            return new CustomTypeConvertor(param, this.targetNameConvertorInstance.convert(type), true, `<${type.name}>`);
        }
        throw new Error(`Cannot convert: ${type.kind}`);
    }
    declarationConvertor(param, type, declaration) {
        if (generatorConfiguration().forceResource.includes(type.name)) {
            return new ObjectConvertor(param, type);
        }
        let customConv = this.customConvertor(param, type.name, type);
        if (customConv)
            return customConv;
        if (!declaration) {
            return new CustomTypeConvertor(param, this.targetNameConvertorInstance.convert(type), false, this.targetNameConvertorInstance.convert(type)); // assume some predefined type
        }
        const declarationName = declaration.name;
        if (isImportAttr(declaration)) {
            return new ImportTypeConvertor(param, this.targetNameConvertorInstance.convert(type));
        }
        if (isImport(declaration)) {
            const target = this.resolveImport(declaration);
            if (target && isEntry(target))
                return this.declarationConvertor(param, type, target);
            else {
                console$1.warn(`Unable to resolve Import ${declaration.clause.join(".")} as ${declaration.name}`);
                return new CustomTypeConvertor(param, declaration.name, false, declaration.name);
            }
        }
        if (isEnum$1(declaration)) {
            return new EnumConvertor(param, declaration);
        }
        if (isEnumMember(declaration)) {
            return new EnumConvertor(param, declaration.parent);
        }
        if (isCallback$1(declaration)) {
            return new CallbackConvertor(this, param, declaration, this.interopNativeModule);
        }
        if (isTypedef$1(declaration)) {
            if (isCyclicTypeDef(declaration)) {
                console$1.warn(`Cyclic typedef: ${DebugUtils.debugPrintType(type)}`);
                return new CustomTypeConvertor(param, declaration.name, false, declaration.name);
            }
            return new TypeAliasConvertor(this, param, declaration);
        }
        if (isInterface$1(declaration)) {
            if (isExternalType(declaration)) {
                return new ExternalTypeConvertor(this, param, declaration);
            }
            if (isMaterialized(declaration, this)) {
                return new MaterializedClassConvertor(this, param, declaration);
            }
            if (isBuilderClass(declaration)) {
                return new ClassConvertor(this, declarationName, param, declaration);
            }
            switch (declaration.subkind) {
                case IDLInterfaceSubkind.Interface:
                case IDLInterfaceSubkind.Class:
                    return new InterfaceConvertor(this, declarationName, param, declaration);
                case IDLInterfaceSubkind.AnonymousInterface:
                    return new AggregateConvertor(this, param, type, declaration);
                case IDLInterfaceSubkind.Tuple:
                    return new TupleConvertor(this, param, type, declaration);
            }
        }
        throw new Error(`Unknown decl ${declarationName} of kind ${declaration.kind}`);
    }
    customConvertor(param, typeName, type) {
        switch (typeName) {
            case `Object`:
                return new ObjectConvertor(param, IDLObjectType);
            case `Date`:
                return new DateConvertor(param);
            case `Function`:
                return new FunctionConvertor(this, param);
            case `Record`:
                return new CustomTypeConvertor(param, "Record", false, "Record<string, string>");
            case `Optional`:
                return new OptionConvertor(this, param, type.typeArguments[0]);
        }
        return undefined;
    }
    getInteropName(node) {
        return this.interopNameConvertorInstance.convert(node);
    }
    toDeclaration(type) {
        switch (type) {
            case IDLAnyType: return ArkCustomObject;
            case IDLVoidType: return IDLVoidType;
            case IDLUndefinedType: return IDLUndefinedType;
            case IDLUnknownType: return ArkCustomObject;
            // case idl.IDLObjectType: return ArkCustomObject
        }
        const typeName = isNamedNode(type) ? type.name : undefined;
        switch (typeName) {
            case "object":
            case "Object": return IDLObjectType;
        }
        if (isReferenceType(type)) {
            // TODO: remove all this!
            if (type.name === 'Date') {
                return ArkDate;
            }
            if (type.name === 'AnimationRange') {
                return ArkCustomObject;
            }
            if (type.name === 'Function') {
                return ArkFunction;
            }
            if (type.name === 'Optional') {
                return this.toDeclaration(type.typeArguments[0]);
            }
            const decl = this.resolveTypeReference(type);
            if (!decl) {
                console$1.warn(`undeclared type ${DebugUtils.debugPrintType(type)}`);
            }
            if (decl && isTypedef$1(decl) && isCyclicTypeDef(decl)) {
                console$1.warn(`Cyclic typedef: ${DebugUtils.debugPrintType(type)}`);
                return ArkCustomObject;
            }
            return !decl ? ArkCustomObject // assume some builtin type
                : isTypedef$1(decl) ? this.toDeclaration(decl.type)
                    : decl;
        }
        if (isImportAttr(type)) {
            return ArkCustomObject;
        }
        return type;
    }
    setFileLayout(strategy) {
        this.layout = new LayoutManager(strategy);
    }
}
const ArkFunction = IDLFunctionType;
const ArkDate = IDLDate;
const ArkCustomObject = IDLCustomObjectType;
function isCyclicTypeDef(decl) {
    return isReferenceType(decl.type) && isNamedNode(decl.type) && decl.type.name == decl.name;
}

var IDLValidationDiagnosticsCode;
(function (IDLValidationDiagnosticsCode) {
    IDLValidationDiagnosticsCode[IDLValidationDiagnosticsCode["INVALID_EXTENDED_ATTRIBUTE"] = 1000] = "INVALID_EXTENDED_ATTRIBUTE";
    IDLValidationDiagnosticsCode[IDLValidationDiagnosticsCode["ENUM_IS_NOT_CONSISTENT"] = 1001] = "ENUM_IS_NOT_CONSISTENT";
    IDLValidationDiagnosticsCode[IDLValidationDiagnosticsCode["REFERENCE_IS_NOT_RESOLVED"] = 1002] = "REFERENCE_IS_NOT_RESOLVED";
})(IDLValidationDiagnosticsCode || (IDLValidationDiagnosticsCode = {}));
({
    [IDLValidationDiagnosticsCode.INVALID_EXTENDED_ATTRIBUTE]: "Invalid extended attribute",
    [IDLValidationDiagnosticsCode.ENUM_IS_NOT_CONSISTENT]: "Enum includes both string and number values",
    [IDLValidationDiagnosticsCode.REFERENCE_IS_NOT_RESOLVED]: "Can not resolve reference",
});

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
function isEnum(node) {
    return node.type === "enum";
}
function isInterface(node) {
    return node.type === "interface";
}
function isClass(node) {
    var _a, _b;
    return isInterface(node)
        && ((_b = (_a = node.extAttrs.find(it => it.name === "Entity")) === null || _a === void 0 ? void 0 : _a.rhs) === null || _b === void 0 ? void 0 : _b.value) === IDLEntity.Class;
}
function isCallback(node) {
    return node.type === "callback";
}
function isTypedef(node) {
    return node.type === "typedef";
}
function isDictionary(node) {
    return node.type === "dictionary";
}
function isAttribute(node) {
    return node.type === "attribute";
}
function isOperation(node) {
    return node.type === "operation";
}
function isConstructor(node) {
    return node.type === "constructor";
}
function isUnionTypeDescription(node) {
    return node.union;
}
function isSingleTypeDescription(node) {
    return (typeof node.idlType === "string");
}
function isSequenceTypeDescription(node) {
    return node.generic === "sequence";
}
function isPromiseTypeDescription(node) {
    return node.generic === "Promise";
}
function isRecordTypeDescription(node) {
    return node.generic === "record";
}
function isConstant(node) {
    return node.type === "const";
}
function isUnspecifiedGenericTypeDescription(node) {
    switch (node.generic) {
        case "FrozenArray":
        case "ObservableArray":
        case "Promise":
        case "record":
        case "sequence":
        case "":
            return false;
    }
    return true;
}
function isOptional(node) {
    return node.extAttrs
        .map((it) => it.name)
        .map((it) => it.toLowerCase())
        .includes("optional");
}

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
function toString(node) {
    return JSON.stringify(node, undefined, 4);
}

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
function getTokens(node) {
    return node.tokens;
}
const syntheticTypes = new Map();
function addSyntheticType(name, type) {
    if (syntheticTypes.has(name)) {
        warn(`duplicate synthetic type name "${name}"`);
    }
    syntheticTypes.set(name, type);
} // check
class IDLDeserializer {
    enterGenericScope(generics) {
        this.genericsScopes.push(new Set(generics !== null && generics !== void 0 ? generics : []));
    }
    constructor(info, inheritanceMode = 'multiple') {
        this.info = info;
        this.inheritanceMode = inheritanceMode;
        this.namespacePathNames = [];
        this.currentPackage = [];
        this.genericsScopes = [];
    }
    ///
    withInfo(from, result) {
        this.info.set(result, getTokens(from));
        return result;
    }
    setPackage(pkg) {
        this.currentPackage = pkg;
    }
    ///
    sanitizeTypeParameter(param) {
        const extendsIdx = param.indexOf('extends');
        if (extendsIdx !== -1) {
            return param.substring(0, extendsIdx).trim();
        }
        const eqIdx = param.indexOf('=');
        if (eqIdx !== -1) {
            return param.substring(0, eqIdx).trim();
        }
        return param;
    }
    extractGenerics(extAttrs) {
        var _a, _b;
        return (_b = (_a = this.findExtendedAttribute(extAttrs, IDLExtendedAttributes.TypeParameters)) === null || _a === void 0 ? void 0 : _a.split(",")) === null || _b === void 0 ? void 0 : _b.map(it => this.sanitizeTypeParameter(it));
    }
    ///
    toIDLNode(file, node) {
        return this.toIDLNodeForward(file, node);
    }
    toIDLNodeForward(file, node) {
        if (isEnum(node)) {
            return this.toIDLEnum(file, node);
        }
        if (this.isImport(node)) {
            return this.toIDLImport(node);
        }
        if (isClass(node)) {
            return this.toIDLInterface(file, node);
        }
        if (isInterface(node)) {
            return this.toIDLInterface(file, node);
        }
        if (isCallback(node)) {
            return this.toIDLCallback(file, node);
        }
        if (isTypedef(node)) {
            return this.toIDLTypedef(file, node);
        }
        if (isDictionary(node)) {
            return this.toIDLDictionary(file, node);
        }
        if (this.isNamespace(node)) {
            return this.toIDLNamespace(file, node);
        }
        if (this.isVersion(node)) {
            return this.toIDLVersion(file, node);
        }
        if (isAttribute(node)) {
            return this.toIDLProperty(file, node);
        }
        if (isOperation(node)) {
            return this.toIDLMethod(file, node, true);
        }
        if (isConstant(node)) {
            return this.toIDLConstant(file, node);
        }
        throw new Error(`unexpected node type: ${toString(node)}`);
    }
    toIDLImport(node) {
        return this.withInfo(node, createImport(node.clause.split("."), node.alias || undefined));
    }
    interfaceSubkind(node) {
        var _a, _b;
        const nodeIDLEntity = (_b = (_a = node.extAttrs.find(it => it.name === "Entity")) === null || _a === void 0 ? void 0 : _a.rhs) === null || _b === void 0 ? void 0 : _b.value;
        switch (nodeIDLEntity) {
            case IDLEntity.Class: return IDLInterfaceSubkind.Class;
            case IDLEntity.Literal: return IDLInterfaceSubkind.AnonymousInterface;
            case IDLEntity.Tuple: return IDLInterfaceSubkind.Tuple;
            default: return IDLInterfaceSubkind.Interface;
        }
    }
    toIDLInterface(file, node) {
        const generics = this.extractGenerics(node.extAttrs);
        this.enterGenericScope(generics);
        const subkind = this.interfaceSubkind(node);
        const result = createInterface(node.name, subkind, (() => {
            if (!node.inheritance) {
                return [];
            }
            const implementations = [];
            node.inheritance.forEach(it => {
                var _a;
                const attributes = it.extAttrs;
                const parentTypeArgs = this.extractTypeArguments(file, attributes !== null && attributes !== void 0 ? attributes : [], IDLExtendedAttributes.TypeArguments);
                const attrs = (_a = this.toExtendedAttributes(attributes !== null && attributes !== void 0 ? attributes : [])) === null || _a === void 0 ? void 0 : _a.filter(it => it.name !== IDLExtendedAttributes.TypeArguments);
                const ref = createReferenceType(it.inheritance, parentTypeArgs, {
                    extendedAttributes: attrs
                });
                implementations.push(ref);
            });
            return implementations;
        })(), node.members
            .filter(isConstructor)
            .map(it => this.toIDLConstructor(file, it)), [], node.members
            .filter(isAttribute)
            .map(it => this.toIDLProperty(file, it)), node.members
            .filter(isOperation)
            .filter(it => !this.isCallable(it))
            .map(it => this.toIDLMethod(file, it, false)), node.members
            .filter(isOperation)
            .filter(it => this.isCallable(it))
            .map(it => this.toIDLCallable(file, it)), generics, {
            fileName: file,
            documentation: this.makeDocs(node),
            extendedAttributes: this.toExtendedAttributes(node.extAttrs),
        });
        this.genericsScopes.pop();
        this.info.set(result, getTokens(node));
        if (node.extAttrs.find(it => it.name === "Synthetic")) {
            const fqName = this.currentPackage.concat(this.namespacePathNames).concat([node.name]).join('.');
            addSyntheticType(fqName, result);
        }
        return result;
    }
    toIDLType(file, type, extAttrs, suggestedName) {
        var _a;
        if (typeof type === "string") {
            // is it IDLStringType?
            const refType = createReferenceType(type);
            refType.fileName = file;
            refType.typeArguments = this.extractTypeArguments(file, extAttrs, IDLExtendedAttributes.TypeArguments);
            return refType;
        }
        if (type.nullable) {
            return this.withInfo(type, createOptionalType(this.toIDLType(file, Object.assign(Object.assign({}, type), { nullable: false }), extAttrs)));
        }
        if (isUnionTypeDescription(type)) {
            let types = type.idlType
                .map(it => this.toIDLType(file, it, undefined))
                .filter(isDefined);
            if (types.includes(IDLUndefinedType)) {
                types = types.filter(it => it !== IDLUndefinedType);
                return this.withInfo(type, createOptionalType(collapseTypes(types)));
            }
            const name = suggestedName !== null && suggestedName !== void 0 ? suggestedName : generateSyntheticUnionName(types);
            return this.withInfo(type, createUnionType(types, name));
        }
        if (isSingleTypeDescription(type)) {
            // must match with primitive types in idl.ts
            switch (type.idlType) {
                case IDLPointerType.name: return IDLPointerType;
                case IDLVoidType.name: return IDLVoidType;
                case IDLBooleanType.name: return IDLBooleanType;
                case IDLObjectType.name: return IDLObjectType;
                case IDLI8Type.name: return IDLI8Type;
                case IDLU8Type.name: return IDLU8Type;
                case IDLI16Type.name: return IDLI16Type;
                case IDLU16Type.name: return IDLU16Type;
                case IDLI32Type.name: return IDLI32Type;
                case IDLU32Type.name: return IDLU32Type;
                case IDLI64Type.name: return IDLI64Type;
                case IDLU64Type.name: return IDLU64Type;
                case IDLF32Type.name: return IDLF32Type;
                case IDLF64Type.name: return IDLF64Type;
                case IDLBigintType.name: return IDLBigintType;
                case IDLNumberType.name: return IDLNumberType;
                case IDLStringType.name: return IDLStringType;
                case IDLAnyType.name: return IDLAnyType;
                case IDLUndefinedType.name: return IDLUndefinedType;
                case IDLUnknownType.name: return IDLUnknownType;
                case IDLObjectType.name: return IDLObjectType;
                case IDLThisType.name: return IDLThisType;
                case IDLDate.name: return IDLDate;
                case IDLBufferType.name: return IDLBufferType;
                case IDLSerializerBuffer.name: return IDLSerializerBuffer;
            }
            const combinedExtAttrs = ((_a = type.extAttrs) !== null && _a !== void 0 ? _a : []).concat(extAttrs !== null && extAttrs !== void 0 ? extAttrs : []);
            let idlRefType;
            if (this.genericsScopes.some(it => it.has(type.idlType))) {
                idlRefType = createTypeParameterReference(type.idlType);
            }
            else {
                const ref = createReferenceType(type.idlType);
                ref.typeArguments = this.extractTypeArguments(file, combinedExtAttrs, IDLExtendedAttributes.TypeArguments);
                idlRefType = ref;
            }
            idlRefType.fileName = file;
            idlRefType.extendedAttributes = this.toExtendedAttributes(combinedExtAttrs);
            return this.withInfo(type, idlRefType);
        }
        if (isSequenceTypeDescription(type) || isPromiseTypeDescription(type) || isRecordTypeDescription(type)) {
            return this.withInfo(type, createContainerType(type.generic, type.idlType.map(it => this.toIDLType(file, it, undefined))));
        }
        if (isUnspecifiedGenericTypeDescription(type)) {
            return this.withInfo(type, createUnspecifiedGenericType(type.generic, type.idlType.map(it => this.toIDLType(file, it, undefined))));
        }
        throw new Error(`unexpected type: ${toString(type)}`);
    }
    toIDLCallable(file, node) {
        var _a;
        if (!node.idlType) {
            throw new Error(`method with no type ${toString(node)}`);
        }
        const generics = this.extractGenerics(node.extAttrs);
        this.enterGenericScope(generics);
        const returnType = this.toIDLType(file, node.idlType, node.extAttrs);
        if (isReferenceType(returnType)) {
            const returnTypeArgs = this.extractTypeArguments(file, node.extAttrs, IDLExtendedAttributes.TypeArguments);
            returnType.typeArguments = returnTypeArgs;
        }
        const result = this.withInfo(node, createCallable((_a = node.name) !== null && _a !== void 0 ? _a : "", node.arguments.map(it => this.toIDLParameter(file, it)), returnType, {
            isStatic: node.special === "static",
            isAsync: node.async,
        }, {
            documentation: this.makeDocs(node),
            extendedAttributes: this.toExtendedAttributes(node.extAttrs),
        }, generics));
        this.genericsScopes.pop();
        return result;
    }
    toIDLMethod(file, node, isFree = false) {
        var _a;
        if (!node.idlType) {
            throw new Error(`method with no type ${toString(node)}`);
        }
        const generics = this.extractGenerics(node.extAttrs);
        this.enterGenericScope(generics);
        const returnType = this.toIDLType(file, node.idlType, node.extAttrs);
        if (isReferenceType(returnType))
            returnType.typeArguments = this.extractTypeArguments(file, node.extAttrs, IDLExtendedAttributes.TypeArguments);
        const result = this.withInfo(node, createMethod((_a = node.name) !== null && _a !== void 0 ? _a : "", node.arguments.map(it => this.toIDLParameter(file, it !== null && it !== void 0 ? it : new Map())), returnType, {
            isStatic: node.special === "static",
            isAsync: node.async,
            isOptional: isOptional(node),
            isFree
        }, {
            documentation: this.makeDocs(node),
            extendedAttributes: this.toExtendedAttributes(node.extAttrs),
        }, generics));
        this.genericsScopes.pop();
        return result;
    }
    toIDLConstructor(file, node) {
        return this.withInfo(node, createConstructor(node.arguments.map(it => this.toIDLParameter(file, it)), undefined, {
            documentation: this.makeDocs(node),
        }));
    }
    toIDLParameter(file, node) {
        return this.withInfo(node, createParameter(node.name, this.toIDLType(file, node.idlType, node.extAttrs), node.optional, node.variadic, {
            fileName: file,
        }));
    }
    toIDLCallback(file, node) {
        const generics = this.extractGenerics(node.extAttrs);
        this.enterGenericScope(generics);
        const result = createCallback(node.name, node.arguments.map(it => this.toIDLParameter(file, it)), this.toIDLType(file, node.idlType, undefined), {
            fileName: file,
            extendedAttributes: this.toExtendedAttributes(node.extAttrs),
            documentation: this.makeDocs(node),
        }, generics);
        if (node.extAttrs.find(it => it.name === "Synthetic")) {
            const fqName = this.currentPackage.concat(this.namespacePathNames).concat([node.name]).join('.');
            addSyntheticType(fqName, result);
        }
        this.genericsScopes.pop();
        return this.withInfo(node, result);
    }
    toIDLTypedef(file, node) {
        const generics = this.extractGenerics(node.extAttrs);
        this.enterGenericScope(generics);
        const result = this.withInfo(node, createTypedef(node.name, this.toIDLType(file, node.idlType, undefined, node.name), generics, {
            extendedAttributes: this.toExtendedAttributes(node.extAttrs),
            documentation: this.makeDocs(node),
            fileName: file,
        }));
        this.genericsScopes.pop();
        return result;
    }
    toIDLConstant(file, node) {
        return this.withInfo(node, createConstant(node.name, this.toIDLType(file, node.idlType, undefined), this.constantValue(node)));
    }
    toIDLDictionary(file, node) {
        const result = createEnum(node.name, [], {
            documentation: this.makeDocs(node),
            extendedAttributes: this.toExtendedAttributes(node.extAttrs),
            fileName: file,
        });
        result.elements = node.members.map(it => this.toIDLEnumMember(file, it, result));
        return this.withInfo(node, result);
    }
    toIDLNamespace(file, node) {
        const namespace = createNamespace(node.name, [], {
            extendedAttributes: this.toExtendedAttributes(node.extAttrs),
            fileName: file
        });
        this.namespacePathNames.push(node.name);
        namespace.members = node.members.map(it => this.toIDLNodeForward(file, it));
        this.namespacePathNames.pop();
        return this.withInfo(node, namespace);
    }
    toIDLVersion(file, node) {
        return this.withInfo(node, createVersion(node.value, {
            extendedAttributes: this.toExtendedAttributes(node.extAttrs),
            fileName: file
        }));
    }
    toIDLProperty(file, node) {
        return this.withInfo(node, createProperty(node.name, this.toIDLType(file, node.idlType, undefined), node.readonly, node.special === "static", isOptional(node), {
            documentation: this.makeDocs(node),
            fileName: file,
            extendedAttributes: this.toExtendedAttributes(node.extAttrs)
        }));
    }
    toIDLEnumMember(file, node, parent) {
        var _a, _b, _c;
        let initializer = undefined;
        if (((_a = node.default) === null || _a === void 0 ? void 0 : _a.type) == "string") {
            initializer = this.unescapeString(node.default.value);
        }
        else if (((_b = node.default) === null || _b === void 0 ? void 0 : _b.type) == "number") {
            initializer = +((_c = node.default) === null || _c === void 0 ? void 0 : _c.value);
        }
        else if (node.default == null) {
            initializer = undefined;
        }
        else {
            throw new Error(`Not representable enum initializer: ${JSON.stringify(node.default)}. Found in ${file}`);
        }
        return this.withInfo(node, createEnumMember(node.name, parent, this.toIDLType(file, node.idlType, undefined), initializer, {
            extendedAttributes: this.toExtendedAttributes(node.extAttrs),
        }));
    }
    toExtendedAttributes(extAttrs) {
        return extAttrs.map(it => {
            return this.withInfo(it, { name: it.name, value: this.toExtendedAttributeValue(it) });
        });
    }
    toExtendedAttributeValue(attr) {
        var _a, _b;
        // TODO: be smarter about RHS.
        if (((_a = attr.rhs) === null || _a === void 0 ? void 0 : _a.value) instanceof Array)
            return attr.rhs.value.map(v => v.value).join(",");
        if (typeof ((_b = attr.rhs) === null || _b === void 0 ? void 0 : _b.value) === 'string')
            return this.unescapeString(attr.rhs.value);
        return;
    }
    toIDLEnum(file, node) {
        const result = createEnum(node.name, [], {
            fileName: file,
            documentation: this.makeDocs(node),
            extendedAttributes: this.toExtendedAttributes(node.extAttrs),
        });
        result.elements = node.values.map((it) => createEnumMember(it.value, result, IDLNumberType, undefined));
        return this.withInfo(node, result);
    }
    ///
    isNamespace(node) {
        return node.type === 'namespace';
    }
    isVersion(node) {
        return node.type === 'version';
    }
    isPackage(node) {
        return node.type === 'package';
    }
    isImport(node) {
        return node.type === 'import';
    }
    isCallable(node) {
        return node.extAttrs.some(it => it.name == IDLExtendedAttributes.CallSignature);
    }
    ///
    splitTypeArguments(line) {
        let buffer = "";
        let brackets = 0;
        const result = [];
        for (const letter of line) {
            if (letter === ',' && brackets === 0) {
                result.push(buffer);
                buffer = '';
                continue;
            }
            if (letter === '<') {
                brackets += 1;
            }
            if (letter === '>') {
                brackets -= 1;
            }
            buffer += letter;
        }
        if (buffer.length) {
            result.push(buffer);
        }
        return result;
    }
    extractTypeArguments(file, extAttrs, attribute) {
        var _a;
        const attr = extAttrs === null || extAttrs === void 0 ? void 0 : extAttrs.find(it => it.name === attribute);
        if (!attr)
            return undefined;
        let value = this.toExtendedAttributeValue(attr);
        return (_a = this.splitTypeArguments(value)) === null || _a === void 0 ? void 0 : _a.map(it => { var _a; return this.toIDLType(file, (_a = parseType(it.replaceAll('\'', '"'), file)) !== null && _a !== void 0 ? _a : it); });
    }
    constantValue(node) {
        switch (node.value.type) {
            case "string":
                return `"${node.value.value}"`;
            case "number":
                return node.value.value;
            case "boolean":
                return node.value.value.toString();
            case "null":
                return "null";
            case "Infinity":
                return "Infinity";
            case "NaN":
                return "NaN";
            case "sequence":
                return `[${node.value.value.join(',')}]`;
            case "dictionary":
                return `new Map()`;
            default:
                return "undefined";
        }
    }
    unescapeString(value) {
        if (!value.length || value[0] !== '"')
            return value;
        value = value.slice(1, -1);
        value = value.replace(/\\((['"\\bfnrtv])|([0-7]{1-3})|x([0-9a-fA-F]{2})|u([0-9a-fA-F]{4}))/g, (_, all, c, oct, h2, u4) => {
            if (c !== undefined) {
                switch (c) {
                    case "'": return "'";
                    case '"': return '"';
                    case "\\": return "\\";
                    case "b": return "\b";
                    case "f": return "\f";
                    case "n": return "\n";
                    case "r": return "\r";
                    case "t": return "\t";
                    case "v": return "\v";
                }
            }
            else if (oct !== undefined) {
                return String.fromCharCode(parseInt(oct, 8));
            }
            else if (h2 !== undefined) {
                return String.fromCharCode(parseInt(h2, 16));
            }
            else if (u4 !== undefined) {
                return String.fromCharCode(parseInt(u4, 16));
            }
            throw new Error(`unknown escape sequence: ${_}`);
        });
        return value;
    }
    makeDocs(node) {
        let docs = undefined;
        node.extAttrs.forEach(it => {
            var _a;
            if (it.name == "Documentation")
                docs = (_a = it.rhs) === null || _a === void 0 ? void 0 : _a.value;
        });
        return docs;
    }
    findExtendedAttribute(extAttrs, name) {
        const attr = extAttrs.find(it => it.name === name);
        return attr ? this.toExtendedAttributeValue(attr) : undefined;
    }
}
function toIDLFile(fileName, { content, inheritanceMode = 'multiple' } = {}) {
    const lexicalInfo = new Map();
    const deserializer = new IDLDeserializer(lexicalInfo, inheritanceMode);
    if (undefined === content)
        content = fs__namespace.readFileSync(fileName).toString();
    let packageClause = [];
    const entries = parse(content)
        .filter(it => {
        if (!it.type)
            return false;
        if (deserializer.isPackage(it)) {
            packageClause = it.clause.split(".");
            deserializer.setPackage(packageClause);
            return false;
        }
        return true;
    })
        .map(it => deserializer.toIDLNode(fileName, it));
    const file = createFile(entries, fileName, packageClause);
    file.text = content;
    return [linkParentBack(file), lexicalInfo];
}

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
/**
 * Collection of diagnostic messages.
 */
class DiagnosticResults {
    constructor() {
        this.entries = [];
        this.totals = { "fatal": 0, "error": 0, "warning": 0, "information": 0, "hint": 0 };
    }
    push(message) {
        this.entries.push(message);
        this.totals[message.severity] += 1;
    }
    get hasErrors() {
        return this.totals.fatal != 0 || this.totals.error != 0;
    }
}
/**
 * Diagnostic message severity values.
 */
let MessageSeverityList = ["fatal", "error", "warning", "information", "hint"];
function commonRange(range1, range2) {
    let start = minPosition(range1.start, range2.start);
    let end = maxPosition(range1.end, range2.end);
    return { start, end };
}
function comparePositions(a, b) {
    if (a.line < b.line) {
        return -1;
    }
    if (a.line > b.line) {
        return 1;
    }
    if (a.character < b.character) {
        return -1;
    }
    if (a.character > b.character) {
        return 1;
    }
    return 0;
}
function minPosition(a, b) {
    return comparePositions(a, b) == -1 ? a : b;
}
function maxPosition(a, b) {
    return comparePositions(a, b) == 1 ? a : b;
}
/**
 * Exception for delivering prepared DiagnosticMessage through processing
 */
class DiagnosticException extends Error {
    constructor(diagnosticMessage, cause) {
        super();
        this.diagnosticMessage = diagnosticMessage;
        this.cause = cause;
    }
}

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
/**
 * Index for DiagnosticMessageKind by code
 */
let messageByCode = new Map();
/**
 * Template for registering different kinds of messages
 */
class DiagnosticMessageKind {
    constructor(severity, code, codeDescription, mainMessageTemplate, additionalMessageTemplate) {
        this.severity = severity;
        this.code = code;
        this.codeDescription = codeDescription;
        // No cases of codeUri for now, can be embedded into codeDescription later if needed
        this.mainMessageTemplate = mainMessageTemplate !== null && mainMessageTemplate !== void 0 ? mainMessageTemplate : codeDescription;
        this.additionalMessageTemplate = additionalMessageTemplate !== null && additionalMessageTemplate !== void 0 ? additionalMessageTemplate : "See";
        if (messageByCode.has(code)) {
            throw new Error(`Duplicate message code ${code}`);
        }
        messageByCode.set(code, this);
    }
    generateDiagnosticMessage(locations, mainMessage, additionalMessage) {
        let msg = {
            severity: this.severity,
            code: this.code,
            codeDescription: this.codeDescription,
            codeURI: this.codeURI,
            parts: []
        };
        let first = true;
        for (let l of locationsFromAuto(locations)) {
            msg.parts.push({ location: l, message: first ? (mainMessage !== null && mainMessage !== void 0 ? mainMessage : this.mainMessageTemplate) : (additionalMessage !== null && additionalMessage !== void 0 ? additionalMessage : this.additionalMessageTemplate) });
            first = false;
        }
        return msg;
    }
    reportDiagnosticMessage(locations, mainMessage, additionalMessage) {
        idlManager.results.push(this.generateDiagnosticMessage(locations, mainMessage, additionalMessage));
    }
    throwDiagnosticMessage(locations, mainMessage, additionalMessage) {
        throw new DiagnosticException(this.generateDiagnosticMessage(locations, mainMessage, additionalMessage));
    }
}
let UnknownError = new DiagnosticMessageKind("fatal", 0, "Unknown error");
let LoadingError = new DiagnosticMessageKind("fatal", 100, "Loading error");
let ParsingError = new DiagnosticMessageKind("fatal", 101, "Parsing error");
let ProcessingError = new DiagnosticMessageKind("fatal", 102, "Processing error");
let UnresolvedReference = new DiagnosticMessageKind("error", 200, "Unresolved reference");
new DiagnosticMessageKind("error", 201, "Duplicate identifier", undefined, "Duplicate of");
let InconsistentEnum = new DiagnosticMessageKind("error", 202, "Enum includes both string and number values", undefined, "Conflicting value");
let WrongAttributeName = new DiagnosticMessageKind("error", 301, "Wrong attribute name");
let WrongAttributePlacement = new DiagnosticMessageKind("error", 302, "Wrong attribute placement");
// export let PackageNotFound = new DiagnosticMessageKind("error", 105, "Package not found")
// export let IdentifierNotFound = new DiagnosticMessageKind("error", 106, "Identifier not found")

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
class Parsed {
    constructor(fileName) {
        this.content = "";
        this.lines = [];
        this.offsets = [];
        this.fileName = fileName;
        this.idlFile = createFile([], this.fileName);
        this.lexicalInfo = new Map();
    }
    load() {
        var _a, _b, _c;
        try {
            this.content = fs__namespace.readFileSync(this.fileName).toString();
            let lines = (_a = this.content.match(/[^\r\n]*(\n|\r\n)?/g)) !== null && _a !== void 0 ? _a : [];
            this.offsets = prepareOffsets(lines);
            this.lines = lines.map((s) => s.replace(/(\n|\r\n)$/, ""));
        }
        catch (e) {
            LoadingError.throwDiagnosticMessage([{ documentPath: this.fileName }], (_b = e.message) !== null && _b !== void 0 ? _b : "");
        }
        try {
            ;
            [this.idlFile, this.lexicalInfo] = toIDLFile(this.fileName, { content: this.content });
            //;[this.idlFile, this.lexicalInfo] = idl.toIDLFile(this.fileName, {content: this.content, inheritanceMode: "single"})
        }
        catch (e) {
            if (e.name == "WebIDLParseError") {
                let tokens = e.tokens;
                let range = tokens.length > 0 ? rangeForToken(this.offsets, tokens[0]) : undefined;
                ParsingError.throwDiagnosticMessage([{ documentPath: this.fileName, range: range }], e.bareMessage);
            }
            UnknownError.throwDiagnosticMessage([{ documentPath: this.fileName }], (_c = e.message) !== null && _c !== void 0 ? _c : "");
        }
        // Provide full location tracking
        forEachChild(this.idlFile, (n) => {
            n._parsed = this;
        });
    }
}
function rangeForToken(offsets, token) {
    let dif = token.value.length - 1;
    if (dif < 0) {
        dif = 0;
    }
    let endline = token.line + (token.value.match(/\n/g) || []).length;
    let character = token.position - offsets[token.line - 1] + 1;
    let endcharacter = token.position + dif - offsets[endline - 1] + 1;
    return { start: { line: token.line, character: character }, end: { line: endline, character: endcharacter } };
}
function rangeForNode(parsed, node, component) {
    var _a;
    let info = parsed.lexicalInfo.get(node);
    if (info == null) {
        // console.log("node:")
        // console.log(node.kind)
        // console.log(JSON.stringify(Object.keys(node), null, 2))
        // console.log("parent:")
        // console.log(node.parent!.kind)
        // console.log(JSON.stringify(Object.keys(node.parent!), null, 2))
        // let info2 = parsed.lexicalInfo.get(node.parent!)
        // console.log(JSON.stringify(info2, null, 2))
        // Proper solution will require fixes with inheritance tokens in Idlize/core and custom webidl2.js
        // So now we are extracting from what we have
        if (node.parent) {
            return (_a = rangeForNode(parsed, node.parent, "inheritance")) !== null && _a !== void 0 ? _a : rangeForNode(parsed, node.parent);
        }
        return;
    }
    let range;
    for (let k of Object.keys(info)) {
        if (component && k != component) {
            continue;
        }
        let named = info[k];
        if (named == null) {
            continue;
        }
        if (named.value == null) {
            if (k == "inheritance" && Array.isArray(named)) {
                for (let inh of named) {
                    if (inh.inheritance == null) {
                        continue;
                    }
                    let newRange = rangeForToken(parsed.offsets, inh.inheritance);
                    range = range ? commonRange(range, newRange) : newRange;
                }
            }
            continue;
        }
        let newRange = rangeForToken(parsed.offsets, named);
        range = range ? commonRange(range, newRange) : newRange;
    }
    return range;
}
function locationForNode(node, component) {
    let parsed = node._parsed;
    if (parsed == null) {
        throw new Error("IDLNode without _parsed field!");
    }
    return { documentPath: parsed.fileName, range: rangeForNode(parsed, node, component) };
}
function locationsFromAuto(autolocations) {
    if (autolocations == null) {
        return [];
    }
    if (Array.isArray(autolocations)) {
        let res = [];
        for (let l of autolocations) {
            res.push(l.kind ? locationForNode(l) : l);
        }
        return res;
    }
    return (autolocations.kind ? [locationForNode(autolocations)] : [autolocations]);
}
function prepareOffsets(lines) {
    let offsets = [];
    let offset = 0;
    for (let line of lines) {
        let plus = line.length;
        offsets.push(offset);
        offset += plus;
    }
    return offsets;
}

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
/**
 * Checks that object is provided.
 */
function isObj(value) {
    return value !== null && typeof value === 'object' && !Array.isArray(value);
}
/**
 * Checks that pattern matches value.
 */
function checkPartial(value, pattern) {
    if (value == null) {
        return false;
    }
    for (let k of Object.keys(pattern)) {
        if (isObj(pattern[k])) {
            if (value[k] == null || !checkPartial(value[k], pattern[k])) {
                return false;
            }
        }
        else {
            if (pattern[k] != value[k]) {
                return false;
            }
        }
    }
    return true;
}
class IdlProcessignProxy {
    constructor(reg, pattern) {
        this.pass = reg;
        this.pattern = pattern;
    }
    set before(func) {
        this.pass.add(func, this.pattern, true);
    }
    set after(func) {
        this.pass.add(func, this.pattern);
    }
}
class IdlProcessingPass {
    constructor(name, dependencies, stateMaker) {
        this.rulesBefore = [];
        this.rulesAfter = [];
        this.rulesBeforeByKind = new Map();
        this.rulesAfterByKind = new Map();
        this.name = name;
        this.dependencies = dependencies;
        this.order = Math.max(0, ...dependencies.map(x => x.order)) + 1;
        this.stateMaker = stateMaker;
    }
    on(pattern) {
        return new IdlProcessignProxy(this, pattern);
    }
    set final(func) {
        this.afterAll = func;
    }
    add(func, pattern, before) {
        if (pattern.kind) {
            appendTo(before ? this.rulesBeforeByKind : this.rulesAfterByKind, pattern.kind, { pattern, func });
        }
        else {
            // For patterns without `kind` that are still possible
            (before ? this.rulesBefore : this.rulesAfter).push({ pattern, func });
        }
    }
    begin() {
        this.innerState = this.stateMaker();
    }
    dispatch(value, before) {
        let byKind = before ? this.rulesBeforeByKind : this.rulesAfterByKind;
        if (byKind.has(value.kind)) {
            for (let entry of byKind.get(value.kind)) {
                if (checkPartial(value, entry.pattern)) {
                    entry.func(value, this.innerState);
                }
            }
        }
        // And for patterns without `kind`
        for (let entry of (before ? this.rulesBefore : this.rulesAfter)) {
            if (checkPartial(value, entry.pattern)) {
                entry.func(value, this.innerState);
            }
        }
    }
    end() {
        var _a;
        (_a = this.afterAll) === null || _a === void 0 ? void 0 : _a.call(this, this.innerState);
    }
    get state() {
        return this.innerState;
    }
}
function appendTo(map, key, value) {
    if (map.has(key)) {
        map.get(key).push(value);
    }
    else {
        map.set(key, [value]);
    }
}
class IdlProcessingManager {
    constructor() {
        this.entries = [];
        this.entriesByPath = new Map();
        this.entriesToValidate = [];
        this.results = new DiagnosticResults();
        this.featuresByName = new Map();
        this._activeFeatures = [];
        this.passes = [];
        this.passesByName = new Map();
        this.activePasses = new Set();
        this.orderedPasses = [];
        // Only resolution is used for now, so choosing idl.Language.TS does not have language-specific effects
        this.peerlibrary = new PeerLibrary(Language.TS, new NativeModuleType("_UNUSED__"));
    }
    addFile(fileName, parseOnly) {
        var _a;
        try {
            let parsed = new Parsed(fileName);
            this.entries.push(parsed);
            this.entriesByPath.set(fileName, parsed);
            parsed.load();
            if (parseOnly) {
                this.peerlibrary.auxFiles.push(parsed.idlFile);
            }
            else {
                this.entriesToValidate.push(parsed);
                this.peerlibrary.files.push(parsed.idlFile);
            }
        }
        catch (e) {
            if (e.diagnosticMessage != null) {
                this.results.push(e.diagnosticMessage);
            }
            else {
                UnknownError.reportDiagnosticMessage([{ documentPath: fileName }], (_a = e.message) !== null && _a !== void 0 ? _a : "");
            }
        }
    }
    _markActive(pass) {
        if (this.activePasses.has(pass)) {
            return;
        }
        this.activePasses.add(pass);
        for (const dep of pass.dependencies) {
            this._markActive(dep);
        }
    }
    runPasses() {
        for (const pass of this.passes) {
            if (pass.name.indexOf(".") == -1) {
                this._markActive(pass);
                continue;
            }
            for (const feature of this._activeFeatures) {
                if (pass.name.startsWith(feature + ".")) {
                    this._markActive(pass);
                }
            }
        }
        let maxOrder = Math.max(0, ...this.passes.map(x => x.order));
        for (let i = 0; i < maxOrder; ++i) {
            this.orderedPasses.push(this.passes.filter(x => (this.activePasses.has(x)) && x.order == i + 1));
        }
        for (let passes of this.orderedPasses) {
            for (let pass of passes) {
                pass.begin();
            }
            for (let entry of this.entries) {
                forEachChild(entry.idlFile, n => passes.forEach(p => {
                    try {
                        p.dispatch(n, true);
                    }
                    catch (e) {
                        ProcessingError.reportDiagnosticMessage([{ documentPath: entry.fileName }], `Pass "${p.name}": ${e.message}`);
                    }
                }), n => passes.forEach(p => {
                    try {
                        p.dispatch(n);
                    }
                    catch (e) {
                        ProcessingError.reportDiagnosticMessage([{ documentPath: entry.fileName }], `Pass "${p.name}": ${e.message}`);
                    }
                }));
            }
            for (let pass of passes) {
                pass.end();
            }
        }
    }
    newFeature(name, description) {
        if (this.featuresByName.has(name)) {
            throw new Error(`Feature "${name}" uses duplicate feature name`);
        }
        let dot = name.lastIndexOf(".");
        if (dot != -1 && !this.featuresByName.has(name.substring(0, dot))) {
            throw new Error(`Feature "${name}" references unexisting parent feature`);
        }
        if (this.passesByName.has(name)) {
            throw new Error(`Feature "${name}" uses duplicate pass name`);
        }
        this.featuresByName.set(name, description);
    }
    newPass(name, dependencies, stateMaker) {
        let pass = new IdlProcessingPass(name, [], stateMaker);
        if (this.passesByName.has(pass.name)) {
            throw new Error(`Pass "${pass.name}" uses duplicate pass name`);
        }
        if (this.featuresByName.has(pass.name)) {
            throw new Error(`Pass "${pass.name}" uses duplicate feature name`);
        }
        let dot = pass.name.lastIndexOf(".");
        if (dot != -1 && pass.name[0] != "." && !this.featuresByName.has(pass.name.substring(0, dot))) {
            throw new Error(`Pass "${pass.name}" references unexisting parent feature`);
        }
        this.passes.push(pass);
        return pass;
    }
    set activeFeatures(value) {
        for (const feature of value) {
            if (!this.featuresByName.has(feature)) {
                throw new Error(`Feature "${feature}" does not exist`);
            }
        }
        this._activeFeatures = value;
    }
    get activeFeatures() {
        return this._activeFeatures;
    }
    get featuresHelp() {
        const lines = [];
        for (const [k, v] of this.featuresByName) {
            lines.push(`${k}  ${v}`);
        }
        return lines.join("\n");
    }
}
let idlManager = new IdlProcessingManager();

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
const enumPass = idlManager.newPass("enumPass", [], () => ({ enums: new Map() }));
enumPass.on({ kind: IDLKind.Enum }).before = (node, st) => st.enums.set(node, []);
enumPass.on({ kind: IDLKind.EnumMember }).after = (node, st) => {
    let nodes = st.enums.get(node.parent);
    if (nodes.length == 0 || nodes.length == 1 && typeof nodes[0].initializer != typeof node.initializer) {
        nodes.push(node);
    }
};
enumPass.on({ kind: IDLKind.Enum }).after = (node, st) => {
    let nodes = st.enums.get(node);
    if (nodes.length == 2) {
        InconsistentEnum.reportDiagnosticMessage([locationForNode(node, "name"), nodes[0], nodes[1]]);
    }
};
// let namedDecls = [idl.IDLKind.Namespace, idl.IDLKind.Const, idl.IDLKind.Property, idl.IDLKind.Interface, idl.IDLKind.Method, idl.IDLKind.Callable, idl.IDLKind.Typedef, idl.IDLKind.Enum]
const resolvePass = idlManager.newPass("resolvePass", [], () => ({ typeParameters: new Set() }));
function extParam(param) {
    const extendsIdx = param.indexOf('extends');
    if (extendsIdx !== -1) {
        return param.substring(0, extendsIdx).trim();
    }
    const eqIdx = param.indexOf('=');
    if (eqIdx !== -1) {
        return param.substring(0, eqIdx).trim();
    }
    return param;
}
resolvePass.on({}).before = (node, st) => {
    if (!node.typeParameters) {
        return;
    }
    for (let tp of node.typeParameters) {
        st.typeParameters.add(extParam(tp));
    }
};
resolvePass.on({ kind: IDLKind.ReferenceType }).before = (node, st) => {
    if (!node.name || node.name == "Object" || node.name == "__TOP__" || st.typeParameters.has(node.name)) {
        return;
    }
    if (!idlManager.peerlibrary.resolveTypeReference(node)) {
        UnresolvedReference.reportDiagnosticMessage(node);
    }
};
resolvePass.on({}).after = (node, st) => {
    if (!node.typeParameters) {
        return;
    }
    for (let tp of node.typeParameters) {
        st.typeParameters.delete(extParam(tp));
    }
};
idlManager.newFeature("ohos", "OHOS-specific checks");
const ohosValidAttributes = new Map([
    [IDLKind.Import, ["Deprecated", "Documentation"]],
    [IDLKind.Namespace, ["DefaultExport", "Deprecated", "Documentation", "VerbatimDts"]],
    [IDLKind.Const, ["DefaultExport", "Deprecated", "Documentation"]],
    [IDLKind.Property, ["DefaultExport", "Optional", "Accessor", "Deprecated", "CommonMethod", "Protected", "DtsName", "Documentation"]],
    [IDLKind.Interface, ["DefaultExport", "Predefined", "TSType", "CPPType", "Entity", "Interfaces", "ParentTypeArguments", "Component", "Synthetic", "Deprecated", "HandWrittenImplementation", "Documentation", "TypeParameters", "ComponentInterface"]],
    [IDLKind.Callback, ["DefaultExport", "Deprecated", "Async", "Synthetic", "Documentation", "TypeParameters"]],
    [IDLKind.Method, ["DefaultExport", "Optional", "DtsTag", "DtsName", "Throws", "Deprecated", "IndexSignature", "Protected", "Documentation", "CallSignature", "TypeParameters"]],
    [IDLKind.Callable, ["DefaultExport", "CallSignature", "Deprecated", "Documentation", "CallSignature"]],
    [IDLKind.Typedef, ["DefaultExport", "Deprecated", "Import", "Documentation", "TypeParameters"]],
    [IDLKind.Enum, ["DefaultExport", "Deprecated", "Documentation"]],
    [IDLKind.EnumMember, ["OriginalEnumMemberName", "Deprecated", "Documentation"]],
    [IDLKind.Constructor, ["Deprecated", "Documentation"]]
]);
const attrPass = idlManager.newPass("ohos.attrPass", [], () => { });
attrPass.on({}).before = (node, st) => {
    if (!node.extendedAttributes || node.extendedAttributes.length == 0) {
        return;
    }
    let valids = ohosValidAttributes.get(node.kind);
    if (!valids) {
        WrongAttributePlacement.reportDiagnosticMessage(node, `Attributes not allowed on ${node.kind}`);
        return;
    }
    for (let attr of node.extendedAttributes) {
        if (!valids.includes(attr.name)) {
            WrongAttributeName.reportDiagnosticMessage(locationForNode(node, "name"), `Attribute "${attr.name}" not allowed on ${node.kind}`);
        }
    }
};
const genPass = idlManager.newPass(".genPass", [enumPass], () => ({ lines: [] }));
genPass.on({ kind: IDLKind.File }).before = (node, st) => { st.lines = []; };
genPass.on({ kind: IDLKind.Enum }).before = (node, st) => st.lines.push(`enum ${node.name} {`);
genPass.on({ kind: IDLKind.EnumMember }).after = (node, st) => st.lines.push(`    ${node.name} = ${typeof node.initializer == "string" ? '"' + node.initializer + '"' : node.initializer},`);
genPass.on({ kind: IDLKind.Enum }).after = (node, st) => st.lines.push("}");
genPass.on({ kind: IDLKind.File }).after = (node, st) => {
    fs__namespace.writeFileSync(node.fileName.replace(".idl", ".ts"), st.lines.join("\n"));
};
const locationCheckPass = idlManager.newPass(".locationCheckPass", [], () => [0, 0]);
locationCheckPass.on({}).after = (node, st) => {
    let t = node;
    let l = locationForNode(node);
    t.wholeLocation = l;
    t.nameLocation = locationForNode(node, "name");
    st[0] += 1;
    if (l.range) {
        st[1] += 1;
    }
};
locationCheckPass.afterAll = (st) => {
    console.log(`Stats: ${st[1]}/${st[0]} nodes have locations`);
};

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
function outputReadableResult(result) {
    for (let message of result.entries) {
        outputReadableMessage(message);
    }
    outputReadableTotals(result);
}
function outputReadableTotals(result) {
    let totals = [];
    for (let k of MessageSeverityList) {
        totals.push(`${k}: ${result.totals[k]}`);
    }
    console.log(totals.join(", "));
}
function lineDigitCount(message) {
    let count = 0;
    for (let part of message.parts) {
        let range = part.location.range;
        if (range == null) {
            continue;
        }
        count = Math.max(count, range.start.line.toString().length, range.end.line.toString().length);
    }
    return count;
}
function paddedLineNo(digits, line) {
    let s = line.toString();
    if (s.length < digits) {
        return " ".repeat(digits - s.length) + s;
    }
    return s;
}
function formatLine(digits, lines, lineNo) {
    return `${paddedLineNo(digits, lineNo)} | ${lines[lineNo - 1]}`;
}
function formatUnderline(indent, lines, lineNo, range, edgeChar, midChar, message) {
    if (lineNo == range.start.line && lineNo == range.end.line) {
        let len = range.end.character - range.start.character + 1;
        return `${indent} | ${" ".repeat(range.start.character - 1)}${edgeChar}${len > 2 ? midChar.repeat(len - 2) : ""}${len > 1 ? edgeChar : ""} ${message}`;
    }
    if (lineNo == range.start.line) {
        let len = lines[lineNo - 1].length - range.start.character;
        return `${indent} | ${" ".repeat(range.start.character - 1)}${edgeChar}${len > 1 ? midChar.repeat(len - 1) : ""}`;
    }
    if (lineNo == range.end.line) {
        let len = range.end.character;
        return `${indent} | ${len > 1 ? midChar.repeat(len - 1) : ""}${edgeChar} ${message}`;
    }
    return `${indent} | ${midChar.repeat(lines[lineNo - 1].length)}`;
}
function outputReadableMessage(message) {
    var _a;
    console.log(`${message.severity}[E${message.code}]: ${message.codeDescription}`);
    let digits = lineDigitCount(message);
    let indent = " ".repeat(digits);
    let first = true;
    for (let part of message.parts) {
        if (part.location.range != null) {
            let range = part.location.range;
            let lines = (_a = idlManager.entriesByPath.get(part.location.documentPath)) === null || _a === void 0 ? void 0 : _a.lines;
            console.log(`${indent}--> ${part.location.documentPath}:${range.start.line}:${range.start.character}`);
            console.log(`${indent} |`);
            for (let i = range.start.line; i <= range.end.line; ++i) {
                console.log(formatLine(digits, lines, i));
                console.log(formatUnderline(indent, lines, i, range, "^", first ? "-" : "~", part.message));
            }
            console.log(`${indent} = ${part.message}`);
            console.log();
        }
        else {
            console.log(`${indent}--> ${part.location.documentPath}`);
            console.log(`${indent} |`);
            console.log(`${indent} = ${part.message}`);
            console.log();
        }
        first = false;
    }
}

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
function processIdl(checkFiles, loadFiles) {
    performance.mark("procStart");
    for (let ent of checkFiles) {
        idlManager.addFile(ent);
    }
    for (let ent of loadFiles) {
        idlManager.addFile(ent, true);
    }
    idlManager.runPasses();
    performance.mark("procEnd");
    performance.measure("proc", "procStart", "procEnd");
    performance.getEntriesByName("proc")[0];
    //console.log(`Processing duration: ${measure.duration} milliseconds`);
    outputReadableResult(idlManager.results);
}
function listIdl(listPath, what, excluding) {
    try {
        if (Array.isArray(listPath)) {
            const files = new Set();
            for (const path of listPath) {
                const pathFiles = listIdl(path, what, excluding);
                for (const file of pathFiles) {
                    files.add(file);
                }
            }
            return files;
        }
        let stat = fs__namespace.lstatSync(listPath);
        if (stat.isFile() && listPath.endsWith(".idl")) {
            return new Set([path__namespace.normalize(listPath)].filter((n) => !excluding || !excluding.has(n)));
        }
        if (stat.isDirectory()) {
            let files = fs__namespace.readdirSync(listPath, { recursive: true, withFileTypes: true }).map((n) => path__namespace.join(n.parentPath, n.name)).filter((n) => n.endsWith(".idl")).map(path__namespace.normalize).filter((n) => !excluding || !excluding.has(n));
            return new Set(files);
        }
    }
    catch (e) {
    }
    console.error(`Invalid path ${listPath} in ${what}`);
    process.exit(1);
}
function idlinterMain() {
    var _a;
    const cmd = commander.program
        .version("0.0.7")
        .option("--check <paths...>", "Paths to individual .idl files (or directories recursively containing them) for validation")
        .option("--load <paths...>", "Paths to individual .idl files (or directories recursively containing them) for loading and symbol search\n(only those also mentioned in --check will be checked)")
        .option("--features <features...>", "Enable additional validation features,\nincluding:\n" + idlManager.featuresHelp)
        .addHelpText("after", "\nExit codes are (1) for invalid arguments and (2) in case of errors/fatals found in .idl files.");
    const options = cmd.parse().opts();
    try {
        idlManager.activeFeatures = (_a = options.features) !== null && _a !== void 0 ? _a : [];
    }
    catch (e) {
        console.error(e.message);
        process.exit(1);
    }
    let checkFiles = new Set();
    let loadFiles = new Set();
    if (options.check == null && options.load == null) {
        commander.program.help();
    }
    if (options.check != null) {
        checkFiles = listIdl(options.check, "--check");
    }
    if (options.load != null) {
        loadFiles = listIdl(options.load, "--load", checkFiles);
    }
    processIdl(checkFiles, loadFiles);
    if (idlManager.results.hasErrors) {
        process.exit(2);
    }
}
if (require.main === module) {
    idlinterMain();
}
//# sourceMappingURL=index.js.map
