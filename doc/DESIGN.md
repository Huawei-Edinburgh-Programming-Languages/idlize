# IDLize API compiler toolchain

## Purpose and goals

Large APIs needs special treatment to provide multiple languages and execution environment bindings.
We believe that universal mechanism to support such mapping is needed, and not yet exists in industry.
Thus we've created toolchain and accompanying runtime interop mechanisms to solve cross-language API
mapping problem both in compile and execution phases of application lifecycle.

## Approach

  To provide ability to support multiple target languages and interop scenarios we take an approach similar to what LLVM
does to compiler development. We implement general purpose compiler toolchain with IDL-like IR and flexible backend system
build around notions of LanguageWriter and TypeConvertor. LanguageWriter implements language agnostic emitter interface,
which can be implemented for particular target language to emit particular programming language constructions when needed.
TypeConvertor defines the policy of conversion for abstract IDL-based type system for a particular programming language.

 Per-project generator is provided by a framework developer to produce specific integration code emit library-bridging code.
Additionally, build system integration code is frequently emitted.

 Initially interfaces can be either described in the IDL language, or be converted by a language-specific frontend from
some other interface definition language, for example .d.ts TypeScript interface definitions or .h C header file.
Then IDLize compiler analyses whole API surface as consistent system of interfaces, their typing information and on demand emits
project and language-specific glue code to allow invocation of APIs across languages and runtimes.

 Important part of interop problem is mapping of data types between languages and runtimes. To solve that universal
type system based serialization/deserialization mechanism is designed. It works by analyzing types aggregation and inheritance
and created automated serializers and deserializers for data transfer. This way every API call and callback can be


## Challenges

  * Different languages and execution environments frequently use quite different notions and concepts, and IDL language
  must balance to expose enough expressive features to represent practically usable APIs, while have sensible and performant
  mapping to all relevant target languages and their execution environment.
  * Some notions, like asynchronous operations and callbacks may not have standardized mapping in target languages,
  so implementor may be required to provide somewhat biased mapping approach.
  * IR to keep language-specific information inevitably have to have some annotation-like mechanism, i.e. extended attributes,
  which are not formally validated or processed by the toolchain

## Implementation

 Current implementation is written in TypeScript and uses universal IDL IR as input for language-specific emitters and type mappers.

