import * as idl from '@idlizer/core'

const API_METADATA_TAGS = [
    'since',
    'syscap',
    'form',
    'crossplatform',
    'atomicservice',
    'systemapi',
    'FAModelOnly',
    'StageModelOnly'
]

export function getAPIAnnotation(node: idl.IDLEntry | undefined): string | undefined {
    const docinfo = node?.documentation
    if (!docinfo) return undefined

    const lastBlock = docinfo.match(/\/\*\*[\s\S]*?\*\//g)?.at(-1) ?? ''

    const tags = new Map<string, string | boolean>()
    for (const [, name, value] of lastBlock.matchAll(/@(\w+)(?:\s+([^\n@]+))?/g)) {
        if (API_METADATA_TAGS.includes(name)) tags.set(name, value?.trim().replace(/\*\/?\s*$/, '') || true)
    }

    const since = tags.get('since')
    if (!since) return undefined

    const otherTags = Array.from(tags.entries())
        .filter(([key]) => key !== 'since')
        .sort(([a], [b]) => a.localeCompare(b))
        .map(([key, value]) => 
            typeof value === 'boolean' ? `${key}: true` : `${key}: "${value}"`
        )

    return `// @!APILevel[${[since, ...otherTags].join(', ')}]`
}