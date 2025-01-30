import { isMainThread } from "node:worker_threads"

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

function runAnimation() {
    console.log(SPINNER[spinnerIdx])
    spinnerIdx = (spinnerIdx + 1) % SPINNER.length
}

console.log("LAUNCHING!!!!")
if (!isMainThread) {
    if (interval) {
        clearInterval(interval)
        interval = null
    }
    interval = setInterval(runAnimation, 80)
}
