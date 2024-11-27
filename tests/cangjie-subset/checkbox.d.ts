/*
 * Copyright (c) 2021-2023 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

declare interface CheckboxOptions {
  name?: string;
  indicatorBuilder?: CustomBuilder;
}

declare interface CheckBoxConfiguration extends CommonConfiguration<CheckBoxConfiguration> {
  name: string;
  selected: boolean;
  // triggerChange: Callback<boolean>;
}

interface CheckboxInterface {
  (options?: CheckboxOptions): CheckboxAttribute;
}

declare type OnCheckboxChangeCallback  = (value: boolean) => void;

declare class CheckboxAttribute extends CommonMethod<CheckboxAttribute> {
  select(value: boolean): CheckboxAttribute;
  selectedColor(value: ResourceColor): CheckboxAttribute;
  shape(value: CheckBoxShape): CheckboxAttribute;
  unselectedColor(value: ResourceColor): CheckboxAttribute;
  mark(value: MarkStyle): CheckboxAttribute;
  onChange(callback: (value?: boolean) => void): CheckboxAttribute;
  // contentModifier(modifier: ContentModifier<CheckBoxConfiguration>): CheckboxAttribute;
}

declare const Checkbox: CheckboxInterface;

declare const CheckboxInstance: CheckboxAttribute;
