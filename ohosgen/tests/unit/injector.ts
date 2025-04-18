
import { DTSHelloInjector } from "./test_injectors"


export function injector_DTSHello_hello_enter(receiver: DTSHelloInjector) {
    console.log("DTS Hello Injector: enter")
    console.log(`injector count before: ${receiver.count}`)
    receiver.count = 123
    console.log(`injector count after : ${receiver.count}`)
}
