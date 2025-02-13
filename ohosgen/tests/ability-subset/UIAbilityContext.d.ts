import { AsyncCallback } from './@ohos.base';
import Want from './@ohos.app.ability.Want';
//import StartOptions from '../@ohos.app.ability.StartOptions';

export default class UIAbilityContext {

  startAbility(want: Want, callback: AsyncCallback<void>): void;

  //startAbility(want: Want, options: StartOptions, callback: AsyncCallback<void>): void;

  //startAbility(want: Want, options?: StartOptions): Promise<void>;

  terminateSelf(callback: AsyncCallback<void>): void;

  terminateSelf(): Promise<void>;
}
