@@ -76,23 +76,6 @@
 KOALA_INTEROP_V2(SetDrawNodeDelay, Ark_Int32, Ark_Int64)
 
 // TODO: Remove all this.
-KInt impl_TestPerfNumber(KInt value) {
-    return value + 1;
-}
-KOALA_INTEROP_1(TestPerfNumber, KInt, KInt)
-
-void impl_TestPerfNumberWithArray(KByte* data, KInt length) {
-    if (GetCurrentLogger()->needGroupedLog(1)) {
-        string out("TestPerfNumberWithArray(");
-        out.append(std::to_string(data[0]));
-        out.append(", ");
-        out.append(std::to_string(length));
-        out.append(")");
-        GetCurrentLogger()->appendGroupedLog(1, out.c_str());
-    }
-}
-KOALA_INTEROP_V2(TestPerfNumberWithArray, KByte*, KInt)
-
 void disposeNode(KNativePointer* ptr) {
     GetArkUIBasicNodeAPI()->disposeNode((Ark_NodeHandle)ptr);
 }
@@ -24,40 +24,32 @@
 #include "logging.h"
 #include "dynamic-loader.h"
 
-#ifdef KOALA_WINDOWS
-inline void* defaultModule() {
-    return GetModuleHandle(nullptr);
-}
-#else
-inline void* defaultModule() {
-    return RTLD_DEFAULT;
+// For logging we use operations exposed via interop, SetLoggerSymbol() is called
+// when library is loaded.
+const GroupLogger* loggerInstance = GetDefaultLogger();
+
+const GroupLogger* GetDummyLogger() {
+    return loggerInstance;
 }
-#endif
 
-// For logging we use operations exposed via interop, GetCurrentLogger() is an external
-// symbol for dummy implementation, exposed by interop bridge.
-const GroupLogger* GetCurrentLoggerDynamic() {
-    static const GroupLogger* (*impl)() = nullptr;
-    if (impl == nullptr) {
-        impl = reinterpret_cast<const GroupLogger* (*)()>(findSymbol(defaultModule(), "GetCurrentLogger"));
-    }
-    return impl();
+extern "C" INTEROP_API_EXPORT void SetLoggerSymbol(const GroupLogger* logger) {
+    loggerInstance = logger;
 }
 
 void startGroupedLog(int kind) {
-    GetCurrentLoggerDynamic()->startGroupedLog(kind);
+    GetDummyLogger()->startGroupedLog(kind);
 }
 void stopGroupedLog(int kind) {
-    GetCurrentLoggerDynamic()->stopGroupedLog(kind);
+    GetDummyLogger()->stopGroupedLog(kind);
 }
 const char* getGroupedLog(int kind) {
-    return GetCurrentLoggerDynamic()->getGroupedLog(kind);
+    return GetDummyLogger()->getGroupedLog(kind);
 }
 int needGroupedLog(int kind) {
-    return GetCurrentLoggerDynamic()->needGroupedLog(kind);
+    return GetDummyLogger()->needGroupedLog(kind);
 }
 void appendGroupedLog(int kind, const std::string& str) {
-    GetCurrentLoggerDynamic()->appendGroupedLog(kind, str.c_str());
+    GetDummyLogger()->appendGroupedLog(kind, str.c_str());
 }
 
 void dummyClassFinalizer(KNativePointer* ptr) {
@@ -16,11 +16,10 @@
 #include <tuple>
 #include <string>
 
-#include "arkoala-logging.h"
 #include "library.h"
 #include "dynamic-loader.h"
 
-#include "arkoala-logging.h"
+#include "interop-logging.h"
 #include "arkoala_api_generated.h"
 
 // TODO: rework for generic OHOS case.
@@ -68,6 +67,7 @@
             }
         }
         if (getAPI == nullptr) {
+            const GroupLogger* logger = GetDefaultLogger();
             void* module = FindModule(kind);
             if (!module) {
                 if (result)
