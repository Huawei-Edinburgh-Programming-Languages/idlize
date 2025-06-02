import * as idl from '@idlizer/core/idl'

interface NameGenerator {
    (kind:idl.IDLKind): string,
}

type SelectDistribution = (len:number) => number

class Producer {
    constructor(
        private random: () => number,
        private nameGenerator: NameGenerator,
    ) {}

    private depth = 0
    private dive<T>(op:() => T): T {
        this.depth += 1
        const r = op()
        this.depth -= 1
        return r
    }

    ///

    private nTimes<T>(n:number, op:(idx:number) => T): T[] {
        return Array.from({ length: n }, (_, i) => op(i))
    }
    private select<T>(vals:T[], dist: SelectDistribution): T {
        return vals[dist(vals.length)]
    }
    private flip(weight:number = 0.5): boolean {
        return this.random() < weight
    }
    private selectWeighted<T>(vals:[number, T][]): T {
        const weights = vals.map(([w,]) => w)
        const s = weights.reduce((a, x) => a + x, 0)
        const p = this.random() * s
        let x = 0
        let r = -1
        while (x <= p) {
            ++r
            x += weights[r]
        }
        return vals[r][1]
    }
    private getNumber(from:number, to:number, dist:SelectDistribution): number {
        const len = from - to
        return to + Math.floor(dist(len) * len)
    }

    ///

    private uni(): SelectDistribution {
        return (len) => Math.floor(this.random() * len)
    }

    //////////////////////////////////////////////////////////////////

    generateEntry(): idl.IDLEntry {
        return this.selectWeighted<() => idl.IDLEntry>([
            [1, () => this.generateInterface()],
            [0, () => this.generateCallback()],
        ])()
    }

    // Interface
    generateInterface(): idl.IDLInterface {
        return idl.createInterface(
            this.nameGenerator(idl.IDLKind.Interface),
            this.select([
                idl.IDLInterfaceSubkind.Class,
                idl.IDLInterfaceSubkind.Interface,
            ], this.uni()),
            [], // inheritance
            [], // constructors
            [], // constants
            this.nTimes(3, () => this.generateProperty()), // properties
            this.nTimes(5, () => this.generateMethod()), // methods
            [], // callables
            [], // type parameters
        )
    }
    // Import
    // Callback
    generateCallback(): idl.IDLCallback {
        return idl.createCallback(
            this.nameGenerator(idl.IDLKind.Callback),
            this.nTimes(3, () => this.generateParameter()),
            this.generateReturnType()
        )
    }
    // Const
    // Property
    generateProperty(): idl.IDLProperty {
        return idl.createProperty(
            this.nameGenerator(idl.IDLKind.Property),
            this.generateType(),
            this.flip(),
            this.flip(),
            this.flip(),
        )
    }
    // Parameter
    generateParameter(): idl.IDLParameter {
        return idl.createParameter(
            this.nameGenerator(idl.IDLKind.Parameter),
            this.generateType(),
        )
    }
    // Method
    generateMethod(): idl.IDLMethod {
        return idl.createMethod(
            this.nameGenerator(idl.IDLKind.Method),
            this.nTimes(3, () => this.generateParameter()),
            this.generateReturnType(),
            {
                isAsync: this.flip(0.05),
                isFree: false,
                isOptional: this.flip(0.3),
                isStatic: this.flip(0.3)
            }
        )
    }
    // Callable
    // Constructor
    // Enum
    // EnumMember
    // Typedef

    private depthC() {
        return 2 * this.depth
    }
    generateType(): idl.IDLType {
        return this.dive(() => {
            const d = this.depthC()
            return this.selectWeighted<() => idl.IDLType>([
                [3 + d, () => this.generatePrimitiveType()],
                [3 + d, () => this.generateReferenceType()],
                // [3 + d, () => this.generateTypeParameterType()],
                [1, () => this.generateContainerType()],
                [1, () => this.generateMaybeUnionType()],
                [1, () => this.generateOptionalType()],
            ])()
        })
    }
    generateReturnType(): idl.IDLType {
        return this.selectWeighted<() => idl.IDLType>([
            [2, () => idl.IDLVoidType],
            [1, () => this.generateType()]
        ])()
    }

    // PrimitiveType
    generatePrimitiveType(): idl.IDLPrimitiveType {
        return this.selectWeighted([
            [3, idl.IDLPointerType],
            [2, idl.IDLBooleanType],
            // [0, idl.IDLI8Type],
            // [0, idl.IDLU8Type],
            // [0, idl.IDLI16Type],
            // [0, idl.IDLU16Type],
            [3, idl.IDLI32Type],
            // [0, idl.IDLU32Type],
            [1, idl.IDLI64Type],
            // [0, idl.IDLU64Type],
            // [0, idl.IDLF16Type],
            [1, idl.IDLF32Type],
            // [0, idl.IDLF64Type],
            [1, idl.IDLBigintType],
            [8, idl.IDLNumberType],
            [1, idl.IDLStringType],
            // [0, idl.IDLAnyType],
            [1, idl.IDLUndefinedType],
            [1, idl.IDLUnknownType],
            [1, idl.IDLObjectType],
            // [0, idl.IDLThisType],
            // [0, idl.IDLDate],
            [0.3, idl.IDLBufferType],
        ])
    }
    // ContainerType
    generateContainerType(): idl.IDLContainerType {
        const containerKind:idl.IDLContainerKind = this.selectWeighted([
            // [1, 'Promise'],
            [7, 'sequence'],
            [1, 'record']
        ])
        return idl.createContainerType(
            containerKind,
            this.nTimes(containerKind === 'record' ? 2 : 1, () => this.generateType())
        )
    }
    // ReferenceType
    generateReferenceType(): idl.IDLReferenceType {
        // const typeArguments = this.nTimes(
        //     this.selectWeighted([
        //         [50 + this.depthC(), 0],
        //         [15,                 1],
        //         [5,                  2],
        //     ]),
        //     () => this.generateType()
        // )
        return idl.createReferenceType(
            this.nameGenerator(idl.IDLKind.ReferenceType),
            // typeArguments.length ? typeArguments : undefined
        )
    }
    // UnionType
    generateMaybeUnionType(): idl.IDLType {
        const union = this.generateUnionType()
        const types: idl.IDLType[] = []
        const names = new Set<string>()
        idl.forEachChild(union, (node) => {
            if (!idl.isType(node)) {
                throw new Error("Oh no")
            }
            if (idl.isUnionType(node)) {
                return
            }
            const name = idl.printType(node)
            if (names.has(name)) {
                return
            }
            names.add(name)
            types.push(node)
        })
        if (types.length > 1) {
            return idl.createUnionType(types)
        }
        return types[0]
    }
    generateUnionType(): idl.IDLUnionType {
        return idl.createUnionType(
            this.nTimes(this.getNumber(2, 3, this.uni()), () => this.generateType())
        )
    }
    // TypeParameterType
    generateTypeParameterType(): idl.IDLTypeParameterType {
        return idl.createTypeParameterReference(
            this.nameGenerator(idl.IDLKind.TypeParameterType)
        )
    }
    // OptionalType
    generateOptionalType(): idl.IDLOptionalType {
        return idl.createOptionalType(
            this.generateType() // fix: not undefined here !!!
        )
    }

    // Version
    // Namespace
    // File
    generateFile(): idl.IDLFile {
        return idl.createFile(
            this.nTimes(10, () => this.generateEntry()),
            'synthetic-generated',
            ['test.test.test']
        )
    }
}

export function newGenerator() {
    let nameCounter = 0
    const savedNames:string[] = []
    const nameGenerator: NameGenerator = (kind) => {
        const defaultName = `val${++nameCounter}`
        switch (kind) {
            case idl.IDLKind.Parameter: return `param${++nameCounter}`

            case idl.IDLKind.ReferenceType: return savedNames[Math.floor(Math.random() * savedNames.length)]

            case idl.IDLKind.Callback:
            case idl.IDLKind.Interface: {
                savedNames.push(defaultName)
                return defaultName
            }
        }
        return defaultName
    }
    return new Producer(Math.random /* BAD RANDOMIZER */, nameGenerator)
}
