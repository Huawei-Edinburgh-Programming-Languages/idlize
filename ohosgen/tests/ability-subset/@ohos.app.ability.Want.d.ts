
export default class Want {
  /**
   * bundle name
   *
   * @type { ?string }
   * @syscap SystemCapability.Ability.AbilityBase
   * @since 9
   */
  /**
   * bundle name
   *
   * @syscap SystemCapability.Ability.AbilityBase
   * @crossplatform
   * @since 10
   */
  /**
   * bundle name
   *
   * @type { ?string }
   * @syscap SystemCapability.Ability.AbilityBase
   * @crossplatform
   * @atomicservice
   * @since 11
   */
  bundleName?: string;

  /**
   * ability name
   *
   * @type { ?string }
   * @syscap SystemCapability.Ability.AbilityBase
   * @since 9
   */
  /**
   * ability name
   *
   * @syscap SystemCapability.Ability.AbilityBase
   * @crossplatform
   * @since 10
   */
  /**
   * ability name
   *
   * @type { ?string }
   * @syscap SystemCapability.Ability.AbilityBase
   * @crossplatform
   * @atomicservice
   * @since 11
   */
  abilityName?: string;

  /**
   * device id
   *
   * @type { ?string }
   * @syscap SystemCapability.Ability.AbilityBase
   * @since 9
   */
  /**
   * device id
   *
   * @type { ?string }
   * @syscap SystemCapability.Ability.AbilityBase
   * @atomicservice
   * @since 11
   */
  deviceId?: string;

  /**
   * The description of a URI in a Want.
   *
   * @type { ?string }
   * @syscap SystemCapability.Ability.AbilityBase
   * @since 9
   */
  /**
   * The description of a URI in a Want.
   *
   * @type { ?string }
   * @syscap SystemCapability.Ability.AbilityBase
   * @atomicservice
   * @since 11
   */
  uri?: string;

  /**
   * The description of the type in this Want.
   *
   * @type { ?string }
   * @syscap SystemCapability.Ability.AbilityBase
   * @since 9
   */
  /**
   * The description of the type in this Want.
   *
   * @type { ?string }
   * @syscap SystemCapability.Ability.AbilityBase
   * @atomicservice
   * @since 11
   */
  /**
   * The description of the type in this Want.
   *
   * @type { ?string }
   * @syscap SystemCapability.Ability.AbilityBase
   * @crossplatform
   * @atomicservice
   * @since 16
   */
  type?: string;

  /**
   * The options of the flags in this Want.
   *
   * @type { ?number }
   * @syscap SystemCapability.Ability.AbilityBase
   * @since 9
   */
  /**
   * The options of the flags in this Want.
   *
   * @type { ?number }
   * @syscap SystemCapability.Ability.AbilityBase
   * @atomicservice
   * @since 11
   */
  flags?: number;

  /**
   * The description of an action in an want.
   *
   * @type { ?string }
   * @syscap SystemCapability.Ability.AbilityBase
   * @since 9
   */
  /**
   * The description of an action in an want.
   *
   * @type { ?string }
   * @syscap SystemCapability.Ability.AbilityBase
   * @atomicservice
   * @since 11
   */
  action?: string;

  /**
   * The description of the WantParams object in an Want
   *
   * @type { ?object }
   * @syscap SystemCapability.Ability.AbilityBase
   * @since 9
   */
  /**
   * The description of the WantParams object in an Want
   *
   * @type { ?object }
   * @syscap SystemCapability.Ability.AbilityBase
   * @crossplatform
   * @since 10
   */
  /**
   * The description of the WantParams object in an Want
   *
   * @type { ?Record<string, Object> }
   * @syscap SystemCapability.Ability.AbilityBase
   * @crossplatform
   * @atomicservice
   * @since 11
   */
  parameters?: Record<string, Object>;

  /**
   * The description of a entities in a Want.
   *
   * @type { ?Array<string> }
   * @syscap SystemCapability.Ability.AbilityBase
   * @since 9
   */
  /**
   * The description of a entities in a Want.
   *
   * @type { ?Array<string> }
   * @syscap SystemCapability.Ability.AbilityBase
   * @atomicservice
   * @since 11
   */
  entities?: Array<string>;

  /**
   * The description of an module name in an want.
   *
   * @type { ?string }
   * @syscap SystemCapability.Ability.AbilityBase
   * @since 9
   */
  /**
   * The description of an module name in an want.
   *
   * @syscap SystemCapability.Ability.AbilityBase
   * @crossplatform
   * @since 10
   */
  /**
   * The description of an module name in an want.
   *
   * @type { ?string }
   * @syscap SystemCapability.Ability.AbilityBase
   * @crossplatform
   * @atomicservice
   * @since 11
   */
  moduleName?: string;

  /**
   * The description of fds in a Want.
   *
   * @type { ?Record<string, number> }
   * @readonly
   * @syscap SystemCapability.Ability.AbilityBase
   * @atomicservice
   * @since 15
   */
  readonly fds?: Record<string, number>;
}
