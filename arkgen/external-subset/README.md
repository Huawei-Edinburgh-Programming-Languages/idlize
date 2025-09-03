# About

A set of handwritten source files appended to code generation by `Idlize`. 

There are two scenarios of code generation:
1. Internal generation by `Idlize` to do sanity testing.
2. Generation to `koala_projects`.

# subset.json

`subset`:

Denotes the source files used with the `1st` scenario.

A source file is searched by the following order:
1. In the subset.
2. If not found - in `koala_projects`.

`generatedSubset`:

Denotes the source files used with the `2nd` scenario.

A source file is searched only in the subset.