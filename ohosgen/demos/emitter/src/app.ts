import { emitter } from "#compat"

export function run() {
    console.log(`Event emitter test app`)

    // function emit(event: InnerEvent, data?: EventData): void;
    const innerEvent: emitter.InnerEvent = {
        eventId: 42,
        priority: emitter.EventPriority.HIGH
    };
    emitter.emit(innerEvent)
    emitter.emit(innerEvent, {
        data: {}
    } as emitter.EventData)

    //   function emit(eventId: string, data?: EventData): void;
    emitter.emit("someEvent")
    emitter.emit("someEvent", {
        data: {}
    } as emitter.EventData)

    // function emit(eventId: string, options: Options, data?: EventData): void;
    emitter.emit("someEvent", {priority: emitter.EventPriority.LOW} as emitter.Options)
    emitter.emit("someEvent", {priority: emitter.EventPriority.LOW} as emitter.Options, {
        data: {}
    } as emitter.EventData)
}
