import { registerNativeModuleLibraryName } from '@koalaui/interop';
export { Rectangle, resize } from '../../generated/arkts';

export function init() {
    registerNativeModuleLibraryName('InteropNativeModule', 'TEST_FQNNativeModule');
}
