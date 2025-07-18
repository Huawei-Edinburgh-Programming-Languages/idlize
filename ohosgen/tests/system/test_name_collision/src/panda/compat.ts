import { registerNativeModuleLibraryName } from '@koalaui/interop';
export { resize, test } from '../../generated/arkts';

export function init() {
    registerNativeModuleLibraryName('InteropNativeModule', 'TEST_NAME_COLLISIONNativeModule');
}
