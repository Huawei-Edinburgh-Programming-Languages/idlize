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
package org.koalaui.arkoala;

class JSAPIArgument {
    JSAPIArgument(String name, String value) {
        this.name = name;
        this.value = value;
    }
    String name;
    String value;
}

public class Application {
    Application() {}

    public static void main(String[] args) {
        var vmEntry = NativeModule._SimulateVirtualMachine(1);
        NativeModule._ProvideIntCallbackOnHost(vmEntry);
        var app = Application.startApplication(vmEntry);
        try {
            for (int i = 0; i < 10; i++) {
                app.loopIteration(vmEntry, i, 0);
                Thread.sleep(100);
            }
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }

    public static Application startApplication(long vmEntry) {
        return new Application().start();
    }

    public void enter(long env, int what, int arg0) {
        loopIteration(env, what, arg0);
    }

    public void loopIteration(long vmEntry, int what, int arg0) {
        if (what == 3 && arg0 != 0) {
            NativeModule._CallIntCallbackOnHost(vmEntry, arg0, new byte[]{1, 2, 3}, 3);
        }
        if (what == 4 && arg0 != 0) {
            NativeModule._CallIntCallbackOnGuest(vmEntry, arg0, new byte[]{1, 2, 3, 4}, 4);
        }
        checkEvents(what);
        updateState();
        render();
    }

    private void callJSAPI(long vmEntry, JSAPIArgument arg, int callback) {
        var serializer = SerializerBase.get(Serializer::createSerializer, 0);
        serializer.writeString(arg.name);
        serializer.writeString(arg.value);
        NativeModule._CallExternalAPI(vmEntry, callback, serializer.asArray(), serializer.currentPosition());
    }

    private byte[] buffer = new byte[256];

    void checkEvents(int what) {
        System.out.println("checkEvents " + what);
        NativeModule._CheckArkoalaGeneratedEvents(buffer, buffer.length);
    }

    void updateState() {
        System.out.println("updateState");
    }

    void render() {
        System.out.println("render");
    }

    public Application start() {
        return this;
    }
}
