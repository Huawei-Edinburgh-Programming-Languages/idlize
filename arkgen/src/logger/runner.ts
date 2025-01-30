import { isMainThread, workerData, MessagePort } from "node:worker_threads"

const SPINNER = [
    "[    ]",
    "[=   ]",
    "[==  ]",
    "[=== ]",
    "[====]",
    "[ ===]",
    "[  ==]",
    "[   =]",
    "[    ]",
    "[   =]",
    "[  ==]",
    "[ ===]",
    "[====]",
    "[=== ]",
    "[==  ]",
    "[=   ]"
]
let spinnerIdx = 0
let interval: ReturnType<typeof setInterval> | null = null

let message = ''
function makeLine() {
    return '\x1b[2K\r' + SPINNER[spinnerIdx] + ' ' + message
}
function frozeLine() {
    return '\x1b[2K\r' + '       ' + message + '\n'
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
    interval = setInterval(runAnimation, 1000)
    const port = workerData as MessagePort
    port.on('message', (msg) => {
        process.stdout.write(frozeLine())
        message = msg
        printLine()
    })
}
