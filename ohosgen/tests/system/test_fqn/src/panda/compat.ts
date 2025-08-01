import { registerNativeModuleLibraryName } from '@koalaui/interop';
export { Sizes, resize } from '../../generated/arkts';

export function init() {
    registerNativeModuleLibraryName('InteropNativeModule', 'TEST_FQNNativeModule');
}
