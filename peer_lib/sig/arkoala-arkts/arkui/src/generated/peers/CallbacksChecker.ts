import { Deserializer } from "./Deserializer";
import { deserializeAndCallCallback } from "./CallbackDeserializeCall"
import { ResourceHolder, KUint8ArrayPtr } from "@koalaui/interop"
import { nativeModule } from "#components"

enum CallbackEventKind {
    Event_CallCallback = 0,
    Event_HoldManagedResource = 1,
    Event_ReleaseManagedResource = 2,
}

const bufferSize = 1024
const byteBuffer = new byte[bufferSize]
const buffer = new Uint8Array(bufferSize)
const deserializer = new Deserializer(buffer.buffer as ArrayBuffer, bufferSize)
export function checkArkoalaCallbacks() {
    while (true) {
        deserializer.resetCurrentPosition()
        let result = nativeModule()._CheckArkoalaCallbackEvent(byteBuffer, bufferSize)
        if (result == 0) break

        for (let i = 0; i < bufferSize; i++)
            buffer[i] = byteBuffer[i]

        const eventKind = deserializer.readInt32() as CallbackEventKind
        switch (eventKind) {
            case CallbackEventKind.Event_CallCallback: {
                deserializeAndCallCallback(deserializer)
                break;
            } 
            case CallbackEventKind.Event_HoldManagedResource: {
                const resourceId = deserializer.readInt32()
                ResourceHolder.instance().hold(resourceId)
                break;
            } 
            case CallbackEventKind.Event_ReleaseManagedResource: {
                const resourceId = deserializer.readInt32()
                ResourceHolder.instance().release(resourceId)
                break;
            }
            default: throw new Error(`Unknown callback event kind ${eventKind}`)
        }
    }
}
