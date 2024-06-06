export class IncrementalNode {}

export function remember(fn: () => void): void {}

export function NodeAttach<Node extends IncrementalNode>(
    create: () => Node,
    /** @memo */
    update: (node: Node) => void
) { throw new Error("not implemented") }