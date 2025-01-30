import * as path from "node:path"
import { isMainThread, MessagePort, Worker, workerData } from "node:worker_threads"
import { SECRET_END_PHRASE } from "./shared"

//////////////////////////////////////

const RUNNER = path.join(__dirname, 'runner.js')
let runnerHandler: {
    worker?: Worker
    port?: MessagePort
 } | null = null

if (!isMainThread) {
    const { handle } = workerData
    runnerHandler = {
        port: handle
    }
}

const runner = {
    begin: () => {
        const { port1, port2 } = new MessageChannel()
        const worker = new Worker(RUNNER, {
            workerData: port2,
            transferList: [port2]
        })
        runnerHandler = {
            worker,
        }
        return port1
    },
    end: () => {
        runner.send({ msg: SECRET_END_PHRASE, kind: 'system'})
        runnerHandler?.worker?.terminate()
    },
    send: (message:{ msg: string, kind: string }) => {
        runnerHandler?.port?.postMessage(message)
    },
}

//////////////////////////////////////

const logger = {

    debug: (msg:string) => {
        runner.send({ msg, kind: 'debug'})
    },
    info: (msg:string) => {
        runner.send({ msg, kind: 'info' })
    },
    warn: (msg:string) => {
        runner.send({ msg, kind: 'warn' })
    },
    error: (msg:string) => {
        runner.send({ msg, kind: 'error' })
    },

    print: (msg:string) => {
        runner.send({ msg, kind: 'log'})
    }
}

//////////////////////////////////////

export const cli = {
    logger,
    runner,
}
