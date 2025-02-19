import { AsyncCallback } from './base';
import Context from './Context';
import StartOptions from './StartOptions';
import Want from './Want';

export default class UIAbilityContext extends Context {
  startAbility(want: Want, callback: AsyncCallback<void>): void;
  startAbility(want: Want, options: StartOptions, callback: AsyncCallback<void>): void;
  startAbility(want: Want, options?: StartOptions): Promise<void>;

  terminateSelf(callback: AsyncCallback<void>): void;
  terminateSelf(): Promise<void>;

}