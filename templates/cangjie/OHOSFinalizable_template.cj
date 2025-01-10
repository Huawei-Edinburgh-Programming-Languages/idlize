/*
 * Copyright (c) 2024 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package idlize

public type pointer = UInt64

public interface MaterializedBase {
    func getPeer(): Finalizable
}

public open class Wrapper {
    var ptr: pointer
    init (ptr: pointer) {
        this.ptr = ptr
    }
    func toString(): String {
        return "[native object <> at ]"
    }
}

public abstract class FinalizableBase <: Wrapper {
    var finalizer: pointer
    var cleaner: ?NativeThunk = Option.None
    var managed: Bool
    init (ptr: pointer, finalizer: pointer, managed: Bool) {
        super(ptr)
        this.finalizer = finalizer
        this.managed = managed
    }
}


public class Finalizable <: FinalizableBase {
    func createHandle(): ?String {
        return Option.None
    }
    init (ptr: pointer, finalizer: pointer, managed: Bool) {
        super(ptr, finalizer, managed)
    }
    init (ptr: pointer, finalizer: pointer) {
        super(ptr, finalizer, true)
    }

    func makeNativeThunk(ptr: pointer, finalizer: pointer, handle: ?String): NativeThunk {
        return NativeThunkImpl(ptr, finalizer, handle)
    }
}

public interface Thunk {
    func clean(): Unit
}

public abstract class NativeThunk <: Thunk {
    var finalizer: pointer
    var obj: pointer
    var name: ?String

    init (obj: pointer, finalizer: pointer, name: ?String) {
        this.finalizer = finalizer
        this.obj = obj
        this.name = name
    }

    public func clean() {
        this.obj = 0
    }

    public func destroyNative(ptr: pointer, finalizer: pointer): Unit
}

public class NativeThunkImpl <: NativeThunk {
    init (ptr: pointer, finalizer: pointer, name: ?String) {
        super(ptr, finalizer, name)
    }
    public func destroyNative(ptr: pointer, finalizer: pointer): Unit {
        NativeModule._InvokeFinalizer(ptr, finalizer)
    }
}
