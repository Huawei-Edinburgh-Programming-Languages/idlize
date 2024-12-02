package org.koalaui.interop;
import org.koalaui.arkoala.NativeModule;

import java.lang.ref.Cleaner;

public class Finalizable {

    private static final Cleaner cleaner = Cleaner.create();

    private static class Finalizer implements Runnable {

        private long ptr;
        private long finalizer;

        private Finalizer(long ptr, long finalizer) {
            this.ptr = ptr;
            this.finalizer = finalizer;
        }

        @Override
        public void run() {
            NativeModule._InvokeFinalizer(ptr, finalizer);
        }

        /////

        static Finalizer create(long ptr, long finalizer) {
            return new Finalizer(ptr, finalizer);
        }
    }

    public long ptr;
    public long finalizer;

    public Finalizable(long ptr, long finalizer) {
        cleaner.register(this, Finalizer.create(ptr, finalizer));
    }
}
