import { isMainThread, workerData, MessagePort } from "node:worker_threads"
import { S } from "./style"
import { SECRET_END_PHRASE } from "./shared"

const SPINNER = [
    "[ ]",
    "[o]",
    "[O]",
    "[^]",
    "[O]",
    "[o]",
    "[_]",
]
let spinnerIdx = 0
let interval: ReturnType<typeof setInterval> | null = null

function colorStatus(kind:string) {
    switch (kind) {
        case 'warn': return S.text.yellow
        case 'error': return S.text.red
    }
    return S.text.green
}

let message = ''
function makeLine() {
    return '\x1b[2K\r' + S.text.blue(SPINNER[spinnerIdx]) + ' ' + S.text.bold(message)
}
function frozeLine(kind:string) {
    return '\x1b[2K\r' + colorStatus(kind)('... ') + S.text.gray(message) + '\n'
}

function printLine() {
    process.stdout.write(makeLine())
}

function runAnimation() {
    printLine()
    spinnerIdx = (spinnerIdx + 1) % SPINNER.length
}

if (!isMainThread) {
    if (interval) {
        clearInterval(interval)
        interval = null
    }
    interval = setInterval(runAnimation, 120)
    const port = workerData as MessagePort
    port.on('message', ({ msg, kind }) => {
        if (msg === SECRET_END_PHRASE && kind === 'system') {
            process.stdout.write(frozeLine(kind))
            if (interval) {
                clearInterval(interval)
                interval = null
            }
            return
        }
        if (message !== '') {
            process.stdout.write(frozeLine('log'))
        }
        message = msg
        if (kind !== 'log') {
            process.stdout.write(frozeLine(kind))
            message = ''
        }
        printLine()
    })
}
