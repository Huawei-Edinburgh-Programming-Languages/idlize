/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
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

/**
 * @file
 * @kit BasicServicesKit
 */

/**
 * Obtains battery information of a device.
 * <p>Battery information includes the remaining battery power,
 * voltage, temperature, model, and charger type.
 *
 * @namespace batteryInfo
 * @syscap SystemCapability.PowerManager.BatteryManager.Core
 * @since 20
 */
declare namespace batteryInfo {
  /**
   * Sets the battery config by scene name.
   *
   * @param { string } sceneName - Indicates the battery charging scene name.
   * sceneName parameter must be of type string.
   * @param { string } sceneValue - Indicates the battery charging scene value.
   * sceneValue parameter must be of type string.
   * @returns { int } Return to set the charging configuration result.
   * @throws { BusinessError } 202 - Permission verification failed. A non-system application calls a system API.
   * @throws { BusinessError } 5100101 - Failed to connect to the service.
   * @syscap SystemCapability.PowerManager.BatteryManager.Core
   * @systemapi
   * @since 20
   */
  function setBatteryConfig(sceneName: string, sceneValue: string): int;

  /**
   * Queries the battery config by scene name.
   *
   * @param { string } sceneName - Indicates the battery charging scene name.
   * sceneName parameter must be of type string.
   * @returns { string } Returns the battery charging configuration, returns "" otherwise.
   * @throws { BusinessError } 202 - Permission verification failed. A non-system application calls a system API.
   * @throws { BusinessError } 5100101 - Failed to connect to the service.
   * @syscap SystemCapability.PowerManager.BatteryManager.Core
   * @systemapi
   * @since 20
   */
  function getBatteryConfig(sceneName: string): string;

  /**
   * Checks the battery config is enable by scene name.
   *
   * @param { string } sceneName - Indicates the battery charging scene name.
   * sceneName parameter must be of type string.
   * @returns { boolean } Returns true if the device supports the charging scene, returns false otherwise.
   * @throws { BusinessError } 202 - Permission verification failed. A non-system application calls a system API.
   * @throws { BusinessError } 5100101 - Failed to connect to the service.
   * @syscap SystemCapability.PowerManager.BatteryManager.Core
   * @systemapi
   * @since 20
   */
  function isBatteryConfigSupported(sceneName: string): boolean;

  /**
   * Battery state of charge (SoC) of the current device, in percent.
   *
   * @returns { int } Returns the battery state of charge (SoC) of the current device, in percent.
   * @syscap SystemCapability.PowerManager.BatteryManager.Core
   * @since 20
   */
  function batterySOC(): int;

  /**
   * Battery charging status of the current device.
   *
   * @returns { BatteryChargeState } Returns the battery charging status of the current device.
   * @syscap SystemCapability.PowerManager.BatteryManager.Core
   * @since 20
   */
  function chargingStatus(): BatteryChargeState;

  /**
   * Battery health state of the current device.
   *
   * @returns { BatteryHealthState } Returns the battery health state of the current device.
   * @syscap SystemCapability.PowerManager.BatteryManager.Core
   * @since 20
   */
  function healthStatus(): BatteryHealthState;

  /**
   * Charger type of the current device.
   *
   * @returns { BatteryPluggedType } Returns the charger type of the current device.
   * @syscap SystemCapability.PowerManager.BatteryManager.Core
   * @since 20
   */
  function pluggedType(): BatteryPluggedType;

  /**
   * Battery voltage of the current device, in µV.
   *
   * @returns { int } Returns the battery voltage of the current device, in µV.
   * @syscap SystemCapability.PowerManager.BatteryManager.Core
   * @since 20
   */
  function voltage(): int;

  /**
   * Battery technology of the current device.
   *
   * @returns { string } Returns the battery technology of the current device.
   * @syscap SystemCapability.PowerManager.BatteryManager.Core
   * @since 20
   */
  function technology(): string;

  /**
   * Battery temperature of the current device, in 0.1℃.
   *
   * @returns { int } Returns the battery temperature of the current device, in 0.1℃.
   * @syscap SystemCapability.PowerManager.BatteryManager.Core
   * @since 20
   */
  function batteryTemperature(): int;

  /**
   * Battery present state of the current device.
   *
   * @returns { boolean } Returns true if the battery is present; returns false if the battery is absent.
   * @syscap SystemCapability.PowerManager.BatteryManager.Core
   * @since 20
   */
  function isBatteryPresent(): boolean;

  /**
   * Battery capacity level of the current device.
   *
   * @returns { BatteryCapacityLevel } Returns the battery capacity level of the current device.
   * @syscap SystemCapability.PowerManager.BatteryManager.Core
   * @since 20
   */
  function batteryCapacityLevel(): BatteryCapacityLevel;

  /**
   * Estimated remaining time for the current device to be fully charged, in ms.
   *
   * @returns { long } Returns the estimated remaining time for the current device to be fully charged, in ms.
   * @syscap SystemCapability.PowerManager.BatteryManager.Core
   * @systemapi
   * @since 20
   */
  function estimatedRemainingChargeTime(): long;

  /**
   * Battery total energy of the current device, in mAh.
   *
   * @returns { int } Returns the battery total energy of the current device, in mAh.
   * @syscap SystemCapability.PowerManager.BatteryManager.Core
   * @systemapi
   * @since 20
   */
  function totalEnergy(): int;

  /**
   * Battery immediate current of the current device, in mA.
   *
   * @returns { int } Returns the battery immediate current of the current device, in mA.
   * @syscap SystemCapability.PowerManager.BatteryManager.Core
   * @since 20
   */
  function nowCurrent(): int;

  /**
   * Battery remaining energy of the current device, in mAh.
   *
   * @returns { int } Returns the battery remaining energy of the current device, in mAh.
   * @syscap SystemCapability.PowerManager.BatteryManager.Core
   * @systemapi
   * @since 20
   */
  function remainingEnergy(): int;

  /**
   * Charger type of a device.
   *
   * @enum { int }
   * @syscap SystemCapability.PowerManager.BatteryManager.Core
   * @since 20
   */
  export enum BatteryPluggedType {
    /**
     * Unknown type
     *
     * @syscap SystemCapability.PowerManager.BatteryManager.Core
     * @since 20
     */
    NONE,
    /**
     * AC charger
     *
     * @syscap SystemCapability.PowerManager.BatteryManager.Core
     * @since 20
     */
    AC,
    /**
     * USB charger
     *
     * @syscap SystemCapability.PowerManager.BatteryManager.Core
     * @since 20
     */
    USB,
    /**
     * Wireless charger
     *
     * @syscap SystemCapability.PowerManager.BatteryManager.Core
     * @since 20
     */
    WIRELESS
  }

  /**
   * Battery charging status of a device.
   *
   * @enum { int }
   * @syscap SystemCapability.PowerManager.BatteryManager.Core
   * @since 20
   */
  export enum BatteryChargeState {
    /**
     * Unknown state.
     *
     * @syscap SystemCapability.PowerManager.BatteryManager.Core
     * @since 20
     */
    NONE,
    /**
     * The battery is being charged.
     *
     * @syscap SystemCapability.PowerManager.BatteryManager.Core
     * @since 20
     */
    ENABLE,
    /**
     * The battery is not being charged.
     *
     * @syscap SystemCapability.PowerManager.BatteryManager.Core
     * @since 20
     */
    DISABLE,
    /**
     * The battery is fully charged.
     *
     * @syscap SystemCapability.PowerManager.BatteryManager.Core
     * @since 20
     */
    FULL
  }

  /**
   * Battery health status of a device.
   *
   * @enum { int }
   * @syscap SystemCapability.PowerManager.BatteryManager.Core
   * @since 20
   */
  export enum BatteryHealthState {
    /**
     * Unknown state.
     *
     * @syscap SystemCapability.PowerManager.BatteryManager.Core
     * @since 20
     */
    UNKNOWN,
    /**
     * The battery is in healthy state.
     *
     * @syscap SystemCapability.PowerManager.BatteryManager.Core
     * @since 20
     */
    GOOD,
    /**
     * The battery is overheated.
     *
     * @syscap SystemCapability.PowerManager.BatteryManager.Core
     * @since 20
     */
    OVERHEAT,
    /**
     * The battery voltage is over high.
     *
     * @syscap SystemCapability.PowerManager.BatteryManager.Core
     * @since 20
     */
    OVERVOLTAGE,
    /**
     * The battery temperature is low.
     *
     * @syscap SystemCapability.PowerManager.BatteryManager.Core
     * @since 20
     */
    COLD,
    /**
     * The battery is dead.
     *
     * @syscap SystemCapability.PowerManager.BatteryManager.Core
     * @since 20
     */
    DEAD
  }

  /**
   * Battery capacity level of a device.
   *
   * @enum { int }
   * @syscap SystemCapability.PowerManager.BatteryManager.Core
   * @since 20
   */
  export enum BatteryCapacityLevel {
    /**
     * The battery is in full capacity level.
     *
     * @syscap SystemCapability.PowerManager.BatteryManager.Core
     * @since 20
     */
    LEVEL_FULL,
    /**
     * The battery is in high capacity level.
     *
     * @syscap SystemCapability.PowerManager.BatteryManager.Core
     * @since 20
     */
    LEVEL_HIGH,
    /**
     * The battery is in normal capacity level.
     *
     * @syscap SystemCapability.PowerManager.BatteryManager.Core
     * @since 20
     */
    LEVEL_NORMAL,
    /**
     * The battery is in low capacity level.
     *
     * @syscap SystemCapability.PowerManager.BatteryManager.Core
     * @since 20
     */
    LEVEL_LOW,
    /**
     * The battery is in warning low capacity level.
     *
     * @syscap SystemCapability.PowerManager.BatteryManager.Core
     * @since 20
     */
    LEVEL_WARNING,
    /**
     * The battery is in critical low capacity level.
     *
     * @syscap SystemCapability.PowerManager.BatteryManager.Core
     * @since 20
     */
    LEVEL_CRITICAL,
    /**
     * The battery is in the lowest capacity level, system will shut down automatically in a few seconds.
     *
     * @syscap SystemCapability.PowerManager.BatteryManager.Core
     * @since 20
     */
    LEVEL_SHUTDOWN
  }

  /**
   * Extra key of common event COMMON_EVENT_BATTERY_CHANGED.
   *
   * @enum { string }
   * @syscap SystemCapability.PowerManager.BatteryManager.Core
   * @since 20
   */
  export enum CommonEventBatteryChangedKey {
    /**
     * Extra code of batterySOC.
     *
     * @syscap SystemCapability.PowerManager.BatteryManager.Core
     * @since 20
     */
    EXTRA_SOC = 'soc',
    /**
     * Extra code of chargingStatus.
     *
     * @syscap SystemCapability.PowerManager.BatteryManager.Core
     * @since 20
     */
    EXTRA_CHARGE_STATE = 'chargeState',
    /**
     * Extra code of healthStatus.
     *
     * @syscap SystemCapability.PowerManager.BatteryManager.Core
     * @since 20
     */
    EXTRA_HEALTH_STATE = 'healthState',
    /**
     * Extra code of pluggedType.
     *
     * @syscap SystemCapability.PowerManager.BatteryManager.Core
     * @since 20
     */
    EXTRA_PLUGGED_TYPE = 'pluggedType',
    /**
     * Extra code of voltage.
     *
     * @syscap SystemCapability.PowerManager.BatteryManager.Core
     * @since 20
     */
    EXTRA_VOLTAGE = 'voltage',
    /**
     * Extra code of technology.
     *
     * @syscap SystemCapability.PowerManager.BatteryManager.Core
     * @since 20
     */
    EXTRA_TECHNOLOGY = 'technology',
    /**
     * Extra code of batteryTemperature.
     *
     * @syscap SystemCapability.PowerManager.BatteryManager.Core
     * @since 20
     */
    EXTRA_TEMPERATURE = 'temperature',
    /**
     * Extra code of isBatteryPresent.
     *
     * @syscap SystemCapability.PowerManager.BatteryManager.Core
     * @since 20
     */
    EXTRA_PRESENT = 'present',
    /**
     * Extra code of batteryCapacityLevel.
     *
     * @syscap SystemCapability.PowerManager.BatteryManager.Core
     * @since 20
     */
    EXTRA_CAPACITY_LEVEL = 'capacityLevel'
  }
}
export default batteryInfo;