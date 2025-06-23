# HPPGEN

This is the prototype of idl generation from .hpp files

## Requirements

1. clang++ (tested with v14)

## Getting started

```bash
npm run compile
node . "input-hpp-file" > "output-idl-file"
```

Should work
```
node . example/source/simple.hpp
```

## Next steps

Generated .idl files can be used as input to ohosgen.
