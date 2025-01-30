import * as path from "node:path"
import { MessagePort, Worker } from "node:worker_threads"

const ESCAPE_SEQUENCE = '\x1b'

const COLORS = {
    FG: {
        BLACK:   30,
        RED:     31,
        GREEN:   32,
        YELLOW:  33,
        BLUE:    34,
        MAGENTA: 35,
        CYAN:    36,
        WHITE:   37,
    },
    BG: {
        BLACK:   40,
        RED:     41,
        GREEN:   42,
        YELLOW:  43,
        BLUE:    44,
        MAGENTA: 45,
        CYAN:    46,
        WHITE:   47,
    }
}

const DECORATIONS = {
    BOLD:      1,
    ITALIC:    3,
    UNDERLINE: 4,
}

function cmd(code:string) {
    return `${ESCAPE_SEQUENCE}${code}`
}

function clr() {
    return `${ESCAPE_SEQUENCE}[0m`
}

function style(code:number) {
    return cmd(`[${code}m`)
}

interface StyledFunction {
    (text:string): string
    styles: string[]
}

function styled(code:number): StyledFunction {
    const prefix = style(code)
    const fun: StyledFunction = (text:string) => {
        return `${prefix}${text}${clr()}`
    }
    fun.styles = [prefix]
    return fun
}

export const S = {
    text: {
        black:   styled(COLORS.FG.BLACK),
        red:     styled(COLORS.FG.RED),
        green:   styled(COLORS.FG.GREEN),
        yellow:  styled(COLORS.FG.YELLOW),
        blue:    styled(COLORS.FG.BLUE),
        magenta: styled(COLORS.FG.MAGENTA),
        cyan:    styled(COLORS.FG.CYAN),
        white:   styled(COLORS.FG.WHITE),

        bold:      styled(DECORATIONS.BOLD),
        italic:    styled(DECORATIONS.ITALIC),
        underline: styled(DECORATIONS.UNDERLINE),
    },

    and: (...funcs:StyledFunction[]): StyledFunction => {
        const styles = funcs.flatMap(it => it.styles)
        const fun: StyledFunction = (text:string) => {
            return `${styles.join('')}${text}${clr()}`
        }
        fun.styles = styles
        return fun
    }
}

//////////////////////////////////////

const RUNNER = path.join(__dirname, 'runner.js')
let runner: {
    worker: Worker
    port: MessagePort
 } | null = null

const animation = {
    begin: () => {
        const { port1, port2 } = new MessageChannel()
        const worker = new Worker(RUNNER, {
            workerData: port2,
            transferList: [port2]
        })
        worker.on('exit', () => {
            console.error("EXITED")
        })
        runner = {
            worker,
            port: port1
        }

    },
    end: () => {
        runner?.worker.terminate()
    },
    send: (msg:string) => {
        runner?.worker.postMessage(msg)
    },
}

//////////////////////////////////////

const logger = {

    debug: (msg:string) => {
        animation.send(msg)
    },
    info: (msg:string) => {
        animation.send(msg)
    },
    warn: (msg:string) => {
        animation.send(msg)
    },
    error: (msg:string) => {
        animation.send(msg)
    },

    print: (msg:string) => {
        animation.send(msg)
    }
}

//////////////////////////////////////

export const cli = {
    logger,
    animation,
}
