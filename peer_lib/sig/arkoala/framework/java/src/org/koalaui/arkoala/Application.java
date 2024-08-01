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
        var app = Application.startApplication();
        try {
            for (int i = 0; i < 10; i++) {
                app.loopIteration(0, i);
                Thread.sleep(100);
            }
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

    }
    public static Application startApplication() {
        return new Application().start();
    }

    public void enter(long env, int what) {
        System.out.println("enter " + env);
        loopIteration(env, what);
    }

    public void loopIteration(long env, int what) {
        if (what == 3 && env != 0) {
            callJSAPI(env, new JSAPIArgument("test", "arg" + what));
        }
        checkEvents(what);
        updateState();
        render();
    }

    private void callJSAPI(long env, JSAPIArgument arg) {
        var serializer = SerializerBase.get(Serializer::createSerializer, 0);
        serializer.writeString(arg.name);
        serializer.writeString(arg.value);
        NativeModule._CallExternalAPI(1 /* JS VM */, env, 1, serializer.asArray(), serializer.currentPosition());
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
