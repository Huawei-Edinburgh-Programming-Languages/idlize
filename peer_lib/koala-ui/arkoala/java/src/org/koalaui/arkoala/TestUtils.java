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

import java.util.function.Function;

public class TestUtils {
    public static <T> void assertEquals(String name, T expected, T actual) {
        if (!expected.equals(actual)) {
            System.out.printf("TEST %s FAIL:\n  EXPECTED \"%s\"\n  ACTUAL   \"%s\"\n", name, expected.toString(), actual.toString());
        } else {
            System.out.printf("TEST %s PASS\n", name);
        }
    }

    public static <T> void assertThrows(String name, Function<Void, T> fn) {
        boolean caught = false;
        try {
            fn.apply(null);
        } catch (Throwable e) {
            caught = true;
        }
        if (!caught) {
            System.out.printf("TEST %s FAIL:\n  No exception thrown\n", name);
        } else {
            System.out.printf("TEST %s PASS\n", name);
        }
    }
}
