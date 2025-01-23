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
      if (tokeniser.probe("["))
        tokeniser.error("Promise type cannot have extended attribute");
      const subtype =
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
function inheritance(tokeniser) {
  const colon = tokeniser.consume(":");
  if (!colon) {
    return {};
  }
  const extAttrs = ExtendedAttributes.parse(tokeniser);
  const inheritance =
    tokeniser.consumeKind("identifier") ||
    tokeniser.error("Inheritance lacks a type");
  return {
    colon,
    extAttrs: extAttrs && extAttrs.length ? extAttrs : undefined,
    inheritance,
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
  static parse(tokeniser, instance, { inheritable, allowedMembers }) {
    const { tokens, type } = instance;
    tokens.name =
      tokeniser.consumeKind("identifier") ||
      tokeniser.error(`Missing name in ${type}`);
    tokeniser.current = instance;
    instance = autoParenter(instance);
    if (inheritable) {
      const inheritanceParsed = inheritance(tokeniser);
      tokens.colon = inheritanceParsed.colon;
      tokens.inheritance = inheritanceParsed.inheritance;
      instance.inheritanceExtAttrs = inheritanceParsed.extAttrs;
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
  return identifier.startsWith("_") ? identifier.slice(1) : identifier;
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
  identifier: /[_-]?[A-Za-z](\.?[0-9A-Z_a-z-])*/y,
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
  "toString",
  "_toString",
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
    } else if (/[-0-9.A-Z_a-z]/.test(nextChar)) {
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
            const message = `${unescape(
              token.value,
            )} is a reserved identifier and must not be used.`;
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
      tokens.push({ type, value: result[0], trivia, line, index });
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
    tokens.name =
      tokeniser.consumeKind("string") || tokeniser.error("No name for package");
    tokens.termination =
      tokeniser.consume(";") || tokeniser.error("No semicolon after package");
    const ret = autoParenter(new Package({ source: tokeniser.source, tokens }));
    ret.nameValue = tokens.name.value;
    return ret.this;
  }

  get type() {
    return "package";
  }
  get name() {
    return unescape(this.tokens.name.value);
  }

  write(w) {
    return w.ts.definition(
      w.ts.wrap([
        w.token(this.tokens.base),
        w.reference_token(this.tokens.name, this),
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
    tokens.name =
      tokeniser.consumeKind("string") ||
      tokeniser.error("Incomplete import statement");
    tokens.termination =
      tokeniser.consume(";") ||
      tokeniser.error("No terminating ; for import statement");
    const ret = autoParenter(new Import({ source: tokeniser.source, tokens }));
    ret.nameValue = tokens.name.value;
    return ret.this;
  }

  get type() {
    return "import";
  }
  get target() {
    return unescape(this.tokens.target.value);
  }
  get import() {
    return unescape(this.tokens.importName.value);
  }

  write(w) {
    return w.ts.definition(
      w.ts.wrap([
        w.token(this.tokens.import),
        w.reference_token(this.tokens.name, this),
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
({
    target: ts__namespace.ScriptTarget.ES5,
    module: ts__namespace.ModuleKind.CommonJS,
    noLib: true,
    types: []
});
function warn(message) {
    console.log(`WARNING: ${message}`);
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
function generateSyntheticIdlNodeName(type) {
    if (isPrimitiveType(type))
        return capitalize(type.name);
    if (isContainerType(type)) {
        const typeArgs = type.elementType.map(it => generateSyntheticIdlNodeName(it)).join("_");
        switch (type.containerKind) {
            case "sequence": return "Array_" + typeArgs;
            case "record": return "Map_" + typeArgs;
            case "Promise": return "Promise_" + typeArgs;
            default: throw new Error(`Unknown container type ${DebugUtils.debugPrintType(type)}`);
        }
    }
    if (isNamedNode(type))
        return type.name;
    if (isOptionalType(type))
        return `Opt_${generateSyntheticIdlNodeName(type.type)}`;
    throw `Can not compute type name of ${IDLKind[type.kind]}`;
}
function generateSyntheticUnionName(types) {
    return `Union_${types.map(it => generateSyntheticIdlNodeName(it)).join("_")}`;
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
var IDLKind;
(function (IDLKind) {
    IDLKind[IDLKind["Interface"] = 0] = "Interface";
    IDLKind[IDLKind["Package"] = 1] = "Package";
    IDLKind[IDLKind["Import"] = 2] = "Import";
    IDLKind[IDLKind["Callback"] = 3] = "Callback";
    IDLKind[IDLKind["Const"] = 4] = "Const";
    IDLKind[IDLKind["Property"] = 5] = "Property";
    IDLKind[IDLKind["Parameter"] = 6] = "Parameter";
    IDLKind[IDLKind["Method"] = 7] = "Method";
    IDLKind[IDLKind["Callable"] = 8] = "Callable";
    IDLKind[IDLKind["Constructor"] = 9] = "Constructor";
    IDLKind[IDLKind["Enum"] = 10] = "Enum";
    IDLKind[IDLKind["EnumMember"] = 11] = "EnumMember";
    IDLKind[IDLKind["Typedef"] = 12] = "Typedef";
    IDLKind[IDLKind["PrimitiveType"] = 13] = "PrimitiveType";
    IDLKind[IDLKind["ContainerType"] = 14] = "ContainerType";
    IDLKind[IDLKind["UnspecifiedGenericType"] = 15] = "UnspecifiedGenericType";
    IDLKind[IDLKind["ReferenceType"] = 16] = "ReferenceType";
    IDLKind[IDLKind["EnumType"] = 17] = "EnumType";
    IDLKind[IDLKind["UnionType"] = 18] = "UnionType";
    IDLKind[IDLKind["TypeParameterType"] = 19] = "TypeParameterType";
    IDLKind[IDLKind["ModuleType"] = 20] = "ModuleType";
    IDLKind[IDLKind["OptionalType"] = 21] = "OptionalType";
    IDLKind[IDLKind["Version"] = 22] = "Version";
})(IDLKind || (IDLKind = {}));
var IDLEntity;
(function (IDLEntity) {
    IDLEntity["Class"] = "Class";
    IDLEntity["Interface"] = "Interface";
    IDLEntity["Package"] = "Package";
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
    IDLExtendedAttributes["CJType"] = "CJType";
    IDLExtendedAttributes["CommonMethod"] = "CommonMethod";
    IDLExtendedAttributes["Component"] = "Component";
    IDLExtendedAttributes["ComponentInterface"] = "ComponentInterface";
    IDLExtendedAttributes["CPPType"] = "CPPType";
    IDLExtendedAttributes["Deprecated"] = "Deprecated";
    IDLExtendedAttributes["Documentation"] = "Documentation";
    IDLExtendedAttributes["DtsName"] = "DtsName";
    IDLExtendedAttributes["DtsTag"] = "DtsTag";
    IDLExtendedAttributes["Entity"] = "Entity";
    IDLExtendedAttributes["GlobalScope"] = "GlobalScope";
    IDLExtendedAttributes["Import"] = "Import";
    IDLExtendedAttributes["IndexSignature"] = "IndexSignature";
    IDLExtendedAttributes["Interfaces"] = "Interfaces";
    IDLExtendedAttributes["Namespace"] = "Namespace";
    IDLExtendedAttributes["NativeModule"] = "NativeModule";
    IDLExtendedAttributes["Optional"] = "Optional";
    IDLExtendedAttributes["OriginalEnumMemberName"] = "OriginalEnumMemberName";
    IDLExtendedAttributes["Protected"] = "Protected";
    IDLExtendedAttributes["Synthetic"] = "Synthetic";
    IDLExtendedAttributes["TSType"] = "TSType";
    IDLExtendedAttributes["TypeArguments"] = "TypeArguments";
    IDLExtendedAttributes["TypeParameters"] = "TypeParameters";
    IDLExtendedAttributes["VerbatimDts"] = "VerbatimDts";
    IDLExtendedAttributes["HandWrittenImplementation"] = "HandWrittenImplementation";
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
function isNamedNode(type) {
    return "_idlNamedNodeBrand" in type;
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
function isUnionType(type) {
    return type.kind == IDLKind.UnionType;
}
function isTypeParameterType(type) {
    return type.kind == IDLKind.TypeParameterType;
}
function isInterface$1(node) {
    return node.kind === IDLKind.Interface;
}
function isOptionalType(type) {
    return type.kind === IDLKind.OptionalType;
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
function createOptionalType(element) {
    if (isOptionalType(element)) {
        return element;
    }
    return {
        kind: IDLKind.OptionalType,
        type: element,
        _idlNodeBrand: innerIdlSymbol,
        _idlTypeBrand: innerIdlSymbol,
    };
}
/**
 * This placeholder is used when a class has no superclass.
 * Examples:
 *  class definition:               inheritance:
 * `C extends T`                  :  [T]
 * `C implements T`               :  [Top, T]
 * `C extends T implements I, J`  :  [T, I, J]
 */
createReferenceType("__TOP__");
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
createPrimitiveType('f16');
const IDLF32Type = createPrimitiveType('f32');
const IDLF64Type = createPrimitiveType('f64');
createPrimitiveType("bigint");
const IDLNumberType = createPrimitiveType('number');
const IDLStringType = createPrimitiveType('String');
const IDLAnyType = createPrimitiveType('any');
const IDLUndefinedType = createPrimitiveType('undefined');
const IDLUnknownType = createPrimitiveType('unknown');
const IDLObjectType = createReferenceType('Object');
createPrimitiveType('this');
createPrimitiveType('date');
const IDLBufferType = createPrimitiveType('buffer');
createContainerType('sequence', [IDLU8Type]);
// Stub for IdlPeerLibrary
createPrimitiveType('Function');
createPrimitiveType('Length');
createPrimitiveType('CustomObject');
function createModuleType(name, extendedAttributes, fileName) {
    return {
        kind: IDLKind.ModuleType,
        name: name,
        extendedAttributes,
        fileName,
        _idlNodeBrand: innerIdlSymbol,
        _idlEntryBrand: innerIdlSymbol,
        _idlNamedNodeBrand: innerIdlSymbol,
    };
}
function createVersion(value, extendedAttributes, fileName) {
    return {
        kind: IDLKind.Version,
        value,
        name: "version",
        extendedAttributes,
        fileName,
        _idlNodeBrand: innerIdlSymbol,
        _idlEntryBrand: innerIdlSymbol,
        _idlNamedNodeBrand: innerIdlSymbol,
    };
}
function createReferenceType(name, typeArguments) {
    return {
        kind: IDLKind.ReferenceType,
        name,
        typeArguments,
        _idlNodeBrand: innerIdlSymbol,
        _idlTypeBrand: innerIdlSymbol,
        _idlNamedNodeBrand: innerIdlSymbol,
    };
}
function createUnspecifiedGenericType(name, typeArguments) {
    return {
        kind: IDLKind.UnspecifiedGenericType,
        name,
        typeArguments,
        _idlNodeBrand: innerIdlSymbol,
        _idlTypeBrand: innerIdlSymbol,
        _idlNamedNodeBrand: innerIdlSymbol,
    };
}
function createContainerType(container, element) {
    if (container == "Promise") {
        // A bit ugly, but we cannot do that.
        element.forEach(it => { it.extendedAttributes = []; });
    }
    // TODO not used?
    // if (element[0][idlTypeName] == "PropertyKey") {
    //     element[0] = { ...element[0], [idlTypeName]: IDLStringType[idlTypeName] }
    // }
    return {
        kind: IDLKind.ContainerType,
        containerKind: container,
        elementType: element,
        _idlNodeBrand: innerIdlSymbol,
        _idlTypeBrand: innerIdlSymbol,
    };
}
function createUnionType(types, name) {
    if (types.length < 2)
        throw new Error("IDLUnionType should contain at least 2 types");
    return {
        kind: IDLKind.UnionType,
        name: name !== null && name !== void 0 ? name : "Union_" + types.map(it => generateSyntheticIdlNodeName(it)).join("_"),
        types: types,
        _idlNodeBrand: innerIdlSymbol,
        _idlTypeBrand: innerIdlSymbol,
        _idlNamedNodeBrand: innerIdlSymbol,
    };
}
function createPackage(name) {
    return {
        kind: IDLKind.Package,
        name,
        _idlNodeBrand: innerIdlSymbol,
        _idlEntryBrand: innerIdlSymbol,
        _idlNamedNodeBrand: innerIdlSymbol,
    };
}
function createImport(name, importClause) {
    return {
        kind: IDLKind.Import,
        name,
        importClause: importClause,
        _idlNodeBrand: innerIdlSymbol,
        _idlEntryBrand: innerIdlSymbol,
        _idlNamedNodeBrand: innerIdlSymbol,
    };
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
    if (isNamedNode(returnType) && returnType.name === "this")
        returnType = IDLAnyType;
    parameters = parameters.map(it => {
        if (it.type && isNamedNode(it.type) && (it.type.name === "T" || it.type.name === "this"))
            return createParameter(it.name, IDLAnyType, it.isOptional, it.isVariadic, { fileName: it.fileName });
        return it;
    });
    return Object.assign(Object.assign({ kind: IDLKind.Callback, name, parameters, returnType, typeParameters }, nodeInitializer), { _idlNodeBrand: innerIdlSymbol, _idlEntryBrand: innerIdlSymbol, _idlNamedNodeBrand: innerIdlSymbol });
}
function createTypedef(name, type, typeParameters = [], nodeInitializer = {}) {
    return Object.assign(Object.assign({ name, type, typeParameters, kind: IDLKind.Typedef }, nodeInitializer), { _idlNodeBrand: innerIdlSymbol, _idlEntryBrand: innerIdlSymbol, _idlNamedNodeBrand: innerIdlSymbol });
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
const DebugUtils = {
    debugPrintType: (type) => {
        if (isContainerType(type)) {
            return `[IDLType, name: '${printType(type)}', kind: '${IDLKind[type.kind]}', elements: [${type.elementType.map(DebugUtils.debugPrintType).join(', ')}]]`;
        }
        return `[IDLType, name: '${printType(type)}', kind: '${IDLKind[type.kind]}']`;
    },
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
//                         SIGNATURES                         //
////////////////////////////////////////////////////////////////
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
})(FieldModifier || (FieldModifier = {}));
var MethodModifier;
(function (MethodModifier) {
    MethodModifier[MethodModifier["PUBLIC"] = 0] = "PUBLIC";
    MethodModifier[MethodModifier["PRIVATE"] = 1] = "PRIVATE";
    MethodModifier[MethodModifier["STATIC"] = 2] = "STATIC";
    MethodModifier[MethodModifier["NATIVE"] = 3] = "NATIVE";
    MethodModifier[MethodModifier["INLINE"] = 4] = "INLINE";
    MethodModifier[MethodModifier["GETTER"] = 5] = "GETTER";
    MethodModifier[MethodModifier["SETTER"] = 6] = "SETTER";
    MethodModifier[MethodModifier["PROTECTED"] = 7] = "PROTECTED";
})(MethodModifier || (MethodModifier = {}));
var ClassModifier;
(function (ClassModifier) {
    ClassModifier[ClassModifier["PUBLIC"] = 0] = "PUBLIC";
    ClassModifier[ClassModifier["PRIVATE"] = 1] = "PRIVATE";
    ClassModifier[ClassModifier["PROTECTED"] = 2] = "PROTECTED";
})(ClassModifier || (ClassModifier = {}));

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
const syntheticTypes = new Map();
function addSyntheticType(name, type) {
    if (syntheticTypes.has(name))
        warn(`duplicate synthetic type name "${name}"`); ///throw?
    syntheticTypes.set(name, type);
} // check
function toIDLNode(file, node) {
    if (isEnum(node)) {
        return toIDLEnum(file, node);
    }
    if (isPackage(node)) {
        return toIDLPackage(node);
    }
    if (isImport(node)) {
        return toIDLImport(node);
    }
    if (isClass(node)) {
        return toIDLInterface(file, node);
    }
    if (isInterface(node)) {
        return toIDLInterface(file, node);
    }
    if (isCallback(node)) {
        return toIDLCallback(file, node);
    }
    if (isTypedef(node)) {
        return toIDLTypedef(file, node);
    }
    if (isDictionary(node)) {
        return toIDLDictionary(file, node);
    }
    if (isNamespace(node)) {
        return toIDLNamespace(file, node);
    }
    if (isVersion(node)) {
        return toIDLVersion(file, node);
    }
    throw new Error(`unexpected node type: ${toString(node)}`);
}
function isNamespace(node) {
    return node.type === 'namespace';
}
function isVersion(node) {
    return node.type === 'version';
}
function isPackage(node) {
    return node.type === 'package';
}
function isImport(node) {
    return node.type === 'import';
}
function isCallable(node) {
    return node.extAttrs.some(it => it.name == "Invoke");
}
function toIDLPackage(node) {
    return createPackage(node.nameValue);
}
function toIDLImport(node) {
    // console.log(node)
    return createImport(node.nameValue);
}
function toIDLInterface(file, node) {
    var _a;
    const result = createInterface(node.name, isClass(node) ? IDLInterfaceSubkind.Class : IDLInterfaceSubkind.Interface, (() => {
        var _a, _b;
        if (!node.inheritance)
            return [];
        const parentTypeArgs = extractTypeArguments(file, (_a = node.inheritanceExtAttrs) !== null && _a !== void 0 ? _a : [], IDLExtendedAttributes.TypeArguments);
        const parentType = createReferenceType(node.inheritance, parentTypeArgs);
        parentType.fileName = file;
        if (node.inheritanceExtAttrs)
            parentType.extendedAttributes = (_b = toExtendedAttributes(node.inheritanceExtAttrs)) === null || _b === void 0 ? void 0 : _b.filter(it => it.name !== IDLExtendedAttributes.TypeArguments);
        return [parentType];
    })(), node.members
        .filter(isConstructor)
        .map(it => toIDLConstructor(file, it)), [], node.members
        .filter(isAttribute)
        .map(it => toIDLProperty(file, it)), node.members
        .filter(isOperation)
        .filter(it => !isCallable(it))
        .map(it => toIDLMethod(file, it)), node.members
        .filter(isOperation)
        .filter(it => isCallable(it))
        .map(it => toIDLCallable(file, it)), (_a = findExtendedAttribute(node.extAttrs, IDLExtendedAttributes.TypeParameters)) === null || _a === void 0 ? void 0 : _a.split(","), {
        fileName: file,
        documentation: makeDocs(node),
        extendedAttributes: toExtendedAttributes(node.extAttrs),
    });
    if (result.inheritance.length && isReferenceType(result.inheritance[0]))
        result.inheritance[0].typeArguments = extractTypeArguments(file, node.extAttrs, IDLExtendedAttributes.TypeArguments);
    if (node.extAttrs.find(it => it.name === "Synthetic"))
        addSyntheticType(node.name, result);
    return result;
}
function extractTypeArguments(file, extAttrs, attribute) {
    var _a;
    const attr = extAttrs === null || extAttrs === void 0 ? void 0 : extAttrs.find(it => it.name === attribute);
    if (!attr)
        return undefined;
    let value = toExtendedAttributeValue(attr);
    return (_a = value === null || value === void 0 ? void 0 : value.split(",") // TODO need real parsing here. What about "<T, Map<K, Callback<K,R>>, U>"
    ) === null || _a === void 0 ? void 0 : _a.map(it => toIDLType(file, it));
}
function toIDLType(file, type, extAttrs) {
    var _a;
    if (typeof type === "string") {
        // is it IDLStringType?
        const refType = createReferenceType(type);
        refType.fileName = file;
        refType.typeArguments = extractTypeArguments(file, extAttrs, IDLExtendedAttributes.TypeArguments);
        return refType;
    }
    if (type.nullable) {
        return createOptionalType(toIDLType(file, Object.assign(Object.assign({}, type), { nullable: false }), extAttrs));
    }
    if (isUnionTypeDescription(type)) {
        const types = type.idlType
            .map(it => toIDLType(file, it))
            .filter(isDefined);
        const name = generateSyntheticUnionName(types);
        return createUnionType(types, name);
    }
    if (isSingleTypeDescription(type)) {
        switch (type.idlType) {
            case IDLUnknownType.name: return IDLUnknownType;
            case IDLObjectType.name: return IDLObjectType;
            case IDLAnyType.name: return IDLAnyType;
            case IDLBooleanType.name: return IDLBooleanType;
            case IDLNumberType.name: return IDLNumberType;
            case IDLStringType.name: return IDLStringType;
            case IDLUndefinedType.name: return IDLUndefinedType;
            case IDLVoidType.name: return IDLVoidType;
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
            case IDLPointerType.name: return IDLPointerType;
            case IDLBufferType.name: return IDLBufferType;
        }
        const combinedExtAttrs = ((_a = type.extAttrs) !== null && _a !== void 0 ? _a : []).concat(extAttrs !== null && extAttrs !== void 0 ? extAttrs : []);
        const idlRefType = createReferenceType(type.idlType);
        idlRefType.fileName = file;
        idlRefType.typeArguments = extractTypeArguments(file, combinedExtAttrs, IDLExtendedAttributes.TypeArguments);
        idlRefType.extendedAttributes = toExtendedAttributes(combinedExtAttrs);
        return idlRefType;
    }
    if (isSequenceTypeDescription(type) || isPromiseTypeDescription(type) || isRecordTypeDescription(type)) {
        return createContainerType(type.generic, type.idlType.map(it => toIDLType(file, it)));
    }
    if (isUnspecifiedGenericTypeDescription(type)) {
        return createUnspecifiedGenericType(type.generic, type.idlType.map(it => toIDLType(file, it)));
    }
    throw new Error(`unexpected type: ${toString(type)}`);
}
function toIDLCallable(file, node) {
    var _a, _b;
    if (!node.idlType) {
        throw new Error(`method with no type ${toString(node)}`);
    }
    const returnType = toIDLType(file, node.idlType, node.extAttrs);
    if (isReferenceType(returnType)) {
        const returnTypeArgs = extractTypeArguments(file, node.extAttrs, IDLExtendedAttributes.TypeArguments);
        returnType.typeArguments = returnTypeArgs;
    }
    return createCallable((_a = node.name) !== null && _a !== void 0 ? _a : "", node.arguments.map(it => toIDLParameter(file, it)), returnType, {
        isStatic: node.special === "static",
        isAsync: node.async,
    }, {
        documentation: makeDocs(node),
        extendedAttributes: toExtendedAttributes(node.extAttrs),
    }, (_b = findExtendedAttribute(node.extAttrs, IDLExtendedAttributes.TypeParameters)) === null || _b === void 0 ? void 0 : _b.split(","));
}
function toIDLMethod(file, node) {
    var _a, _b;
    if (!node.idlType) {
        throw new Error(`method with no type ${toString(node)}`);
    }
    const returnType = toIDLType(file, node.idlType, node.extAttrs);
    if (isReferenceType(returnType))
        returnType.typeArguments = extractTypeArguments(file, node.extAttrs, IDLExtendedAttributes.TypeArguments);
    return createMethod((_a = node.name) !== null && _a !== void 0 ? _a : "", node.arguments.map(it => toIDLParameter(file, it)), returnType, {
        isStatic: node.special === "static",
        isAsync: node.async,
        isOptional: isOptional(node),
    }, {
        documentation: makeDocs(node),
        extendedAttributes: toExtendedAttributes(node.extAttrs),
    }, (_b = findExtendedAttribute(node.extAttrs, IDLExtendedAttributes.TypeParameters)) === null || _b === void 0 ? void 0 : _b.split(","));
}
function toIDLConstructor(file, node) {
    return createConstructor(node.arguments.map(it => toIDLParameter(file, it)), undefined, {
        documentation: makeDocs(node),
    });
}
function toIDLParameter(file, node) {
    return createParameter(node.name, toIDLType(file, node.idlType, node.extAttrs), node.optional, node.variadic, {
        fileName: file,
    });
}
function toIDLCallback(file, node) {
    const result = createCallback(node.name, node.arguments.map(it => toIDLParameter(file, it)), toIDLType(file, node.idlType), {
        fileName: file,
        extendedAttributes: toExtendedAttributes(node.extAttrs),
        documentation: makeDocs(node),
    });
    if (node.extAttrs.find(it => it.name === "Synthetic"))
        addSyntheticType(node.name, result);
    return result;
}
function toIDLTypedef(file, node) {
    var _a;
    return createTypedef(node.name, toIDLType(file, node.idlType), (_a = findExtendedAttribute(node.extAttrs, IDLExtendedAttributes.TypeParameters)) === null || _a === void 0 ? void 0 : _a.split(","), {
        extendedAttributes: toExtendedAttributes(node.extAttrs),
        documentation: makeDocs(node),
        fileName: file,
    });
}
function toIDLDictionary(file, node) {
    const result = createEnum(node.name, [], {
        documentation: makeDocs(node),
        extendedAttributes: toExtendedAttributes(node.extAttrs),
        fileName: file,
    });
    result.elements = node.members.map(it => toIDLEnumMember(file, it, result));
    return result;
}
function toIDLNamespace(file, node) {
    return createModuleType(node.name, toExtendedAttributes(node.extAttrs), file);
}
function toIDLVersion(file, node) {
    return createVersion(node.value, toExtendedAttributes(node.extAttrs), file);
}
function toIDLProperty(file, node) {
    return createProperty(node.name, toIDLType(file, node.idlType), node.readonly, node.special === "static", isOptional(node), {
        documentation: makeDocs(node),
        fileName: file,
        extendedAttributes: toExtendedAttributes(node.extAttrs)
    });
}
function unescapeString(value) {
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
function toIDLEnumMember(file, node, parent) {
    var _a, _b, _c;
    let initializer = undefined;
    if (((_a = node.default) === null || _a === void 0 ? void 0 : _a.type) == "string") {
        initializer = unescapeString(node.default.value);
    }
    else if (((_b = node.default) === null || _b === void 0 ? void 0 : _b.type) == "number") {
        initializer = +((_c = node.default) === null || _c === void 0 ? void 0 : _c.value);
    }
    else if (node.default == null) {
        initializer = undefined;
    }
    else {
        throw new Error(`Not representable enum initializer: ${node.default}`);
    }
    return createEnumMember(node.name, parent, toIDLType(file, node.idlType), initializer, {
        extendedAttributes: toExtendedAttributes(node.extAttrs),
    });
}
function toExtendedAttributes(extAttrs) {
    return extAttrs.map(it => {
        return { name: it.name, value: toExtendedAttributeValue(it) };
    });
}
function toExtendedAttributeValue(attr) {
    var _a, _b;
    // TODO: be smarter about RHS.
    if (((_a = attr.rhs) === null || _a === void 0 ? void 0 : _a.value) instanceof Array)
        return attr.rhs.value.map(v => v.value).join(",");
    if (typeof ((_b = attr.rhs) === null || _b === void 0 ? void 0 : _b.value) === 'string')
        return unescapeString(attr.rhs.value);
    return;
}
function makeDocs(node) {
    let docs = undefined;
    node.extAttrs.forEach(it => {
        var _a;
        if (it.name == "Documentation")
            docs = (_a = it.rhs) === null || _a === void 0 ? void 0 : _a.value;
    });
    return docs;
}
function toIDLEnum(file, node) {
    const result = createEnum(node.name, [], {
        fileName: file,
        documentation: makeDocs(node),
        extendedAttributes: toExtendedAttributes(node.extAttrs),
    });
    result.elements = node.values.map((it) => createEnumMember(it.value, result, IDLNumberType, undefined));
    return result;
}
function findExtendedAttribute(extAttrs, name) {
    const attr = extAttrs.find(it => it.name === name);
    return attr ? toExtendedAttributeValue(attr) : undefined;
}
function toIDL(file) {
    const content = fs__namespace.readFileSync(file).toString();
    return parse(content).map(it => toIDLNode(file, it));
}

var IDLFile = /** @class */ (function () {
    function IDLFile(entries) {
        this.entries = entries;
    }
    return IDLFile;
}());
var OHOSVisitor = /** @class */ (function () {
    function OHOSVisitor(files) {
        this.files = files;
        this.idls = files.map(function (it) { return new IDLFile(toIDL(it)); });
    }
    OHOSVisitor.prototype.execute = function (outDir) {
        this.idls.forEach(function (idl) {
            console.log("first ".concat(idl.entries[0].name));
        });
    };
    return OHOSVisitor;
}());
function generateOhos(outDir, inputFiles) {
    var generatedSubDir = path__namespace.join(outDir, 'generated');
    if (!fs__namespace.existsSync(generatedSubDir))
        fs__namespace.mkdirSync(outDir, { recursive: true });
    var visitor = new OHOSVisitor(inputFiles);
    visitor.execute(generatedSubDir);
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
var options = commander.program
    .option('--output-dir <path>', 'Path to output dir')
    .option('--input-files <path>', 'Path to file(s) to generate from')
    .option('--idl2bridges', 'Convert IDL files to bridges')
    .parse()
    .opts();
function main() {
    var _a;
    var outDir = (_a = options.outputDir) !== null && _a !== void 0 ? _a : "./out";
    var inputFiles = options.inputFiles.split(",");
    if (options.idl2bridges)
        generateOhos(outDir, inputFiles);
}
main();
//# sourceMappingURL=index.js.map
