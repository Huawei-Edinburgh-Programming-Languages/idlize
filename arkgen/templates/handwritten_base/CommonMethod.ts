/** @memo */
public gesture(gesture: GestureType, mask?: GestureMask): this {
    if (this.checkPriority("gesture")) {
        const gesture_casted = gesture as (GestureType)
        const mask_casted = mask as (GestureMask | undefined)
        this.getPeer()?.gestureAttribute(gesture_casted, mask_casted)
        return this
    }
    return this
}
/** @memo */
public priorityGesture(gesture: GestureType, mask?: GestureMask): this {
    if (this.checkPriority("priorityGesture")) {
        const gesture_casted = gesture as (GestureType)
        const mask_casted = mask as (GestureMask | undefined)
        this.getPeer()?.priorityGestureAttribute(gesture_casted, mask_casted)
        return this
    }
    return this
}
/** @memo */
public parallelGesture(gesture: GestureType, mask?: GestureMask): this {
    if (this.checkPriority("parallelGesture")) {
        const gesture_casted = gesture as (GestureType)
        const mask_casted = mask as (GestureMask | undefined)
        this.getPeer()?.parallelGestureAttribute(gesture_casted, mask_casted)
        return this
    }
    return this
}

// /** @memo */
// public gesture(gesture: ArkGestureInterface | ArkGestureGroup, mask: GestureMask) {
//     if (this.checkPriority("gesture")) {
//         if (gesture instanceof ArkGestureInterface) {
//             let singleGesture = gesture as ArkGestureInterface
//             singleGesture.setGesture(0, this.getPeer, mask)
//             return this
//         } else {
//             let gestureGroup = gesture as ArkGestureGroup
//             gestureGroup.addGestureGrpupToNode(0, this.getPeer, mask)
//         }
//     }
//     return this
// }

// /** @memo */
// public priorityGesture(gesture: ArkGestureInterface | ArkGestureGroup, mask?: GestureMask): this {
//     if (this.checkPriority("priorityGesture")) {
//         if (gesture instanceof ArkGestureInterface) {
//             let singleGesture = gesture as ArkGestureInterface
//             singleGesture.setGesture(1, this.getPeer, mask)
//             return this
//         } else {
//             let gestureGroup = gesture as ArkGestureGroup
//             gestureGroup.addGestureGrpupToNode(1, this.getPeer, mask)
//         }
//     }
//     return this
// }

// /** @memo */
// public parallelGesture(gesture: ArkGestureInterface | ArkGestureGroup, mask?: GestureMask): this {
//     if (this.checkPriority("parallelGesture")) {
//         if (gesture instanceof ArkGestureInterface) {
//             let singleGesture = gesture as ArkGestureInterface
//             singleGesture.setGesture(2, this.getPeer, mask)
//             return this
//         } else {
//             let gestureGroup = gesture as ArkGestureGroup
//             gestureGroup.addGestureGrpupToNode(2, this.getPeer, mask)
//         }
//     }
//     return this
// }
