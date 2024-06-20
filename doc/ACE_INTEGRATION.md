# Peer Generator and IDL: Proposed Integration Sequence

## Integration Step 0: generator technical readiness

Taking sdk *.d.ts files as input PG tool produces :
    * TS PeerClasses code,
    * C++ bridge code,
    * C API header,
    * Modifier signatures
    * Test functions
All compilable and linkable together.

Benefit: allows to check architecture and estimate call overhead performance

## Integration Step 1: hello world

The produced C API headers and Modifier signatures are compilable within libace build.
The generator source code is NOT in the ace_engine workspace.
The generator tool can be run from the workspace.
The generator tool allows to regenerate the interface when needed.
The first demonstratory components are checked into workspace and working from DevEco with Arkoala enabled SDK.
Allowing to establish a process of updating components one by one to work through generated interface.

Code produced by the generator will be integrated to ACE engine according to the following scheme.
![integration](./integration1.png "Integration into the ACE engine")

Benefit: End-to-end performance can be measured and optimized.

## Integration Step 2: TS and C++ bridges have some BZ workspace

The generated TS code and C++ bridge code are generated to some Blue zone workspace.
Something like SIG.

Benefit: Allows Blue zone Arkoala/TS to be tested with 

## Integration Step 3: generated modifiers cover more than manual

There are more API cases working through generated C API than through manual C API.

Benefit: the manual C API can be dropped.

It needs to be decided, when to regenerate the bindings:
   * Automatically on every update of the interfaces
   * Manually on regular basis
   * Msanually on minor SDK releases
   etc

## Integration Step 4: reversible *d.ts -> IDL -> *.dts

The ohos component *.d.ts files are not wel lfit for ArkTS interface generations.
So before we have ArkTS we'd need IDL integrated.
It is more convenient not to force complete switch to IDL,
so we integrate the tool invocation infrastructure with two reversible operations:
    * d.ts -> idl
    * idl -> d.ts
producing the same results

Benefit: the IDL allows ArkTS peer generation

## Integration Step 5: ArkTS

First ArkTS Peers and C++ bridge code created and checked to the BZ workspace (a sig workspace?).

Benefit: can measure ArkTS component performance