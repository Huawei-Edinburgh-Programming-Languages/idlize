

/**
 * Defines the basic async callback.
 * @typedef AsyncCallback
 * @syscap SystemCapability.Base
 * @since 6
 */
/**
 * Defines the basic async callback.
 * @typedef AsyncCallback
 * @syscap SystemCapability.Base
 * @crossplatform
 * @since 10
 */
/**
 * Defines the basic async callback.
 * @typedef AsyncCallback
 * @syscap SystemCapability.Base
 * @crossplatform
 * @atomicservice
 * @since 11
 */
/**
 * Defines the basic async callback.
 * @typedef AsyncCallback<T, E = void>
 * @syscap SystemCapability.Base
 * @crossplatform
 * @form
 * @atomicservice
 * @since 12
 */
export interface AsyncCallback<T, E = void> {
  /**
   * Defines the callback data.
   * @param { BusinessError<E> } err
   * @param { T } data
   * @syscap SystemCapability.Base
   * @since 6
   */
  /**
   * Defines the callback data.
   * @param { BusinessError<E> } err
   * @param { T } data
   * @syscap SystemCapability.Base
   * @crossplatform
   * @since 10
   */
  /**
   * Defines the callback data.
   * @param { BusinessError<E> } err
   * @param { T } data
   * @syscap SystemCapability.Base
   * @crossplatform
   * @atomicservice
   * @since 11
   */
  /**
   * Defines the callback data.
   * @param { BusinessError<E> } err
   * @param { T } data
   * @syscap SystemCapability.Base
   * @crossplatform
   * @form
   * @atomicservice
   * @since 12
   */
  (err: BusinessError<E>, data: T): void;
}

/**
 * Defines the error interface.
 * @typedef BusinessError
 * @syscap SystemCapability.Base
 * @since 6
 */
/**
 * Defines the error interface.
 * @typedef BusinessError
 * @syscap SystemCapability.Base
 * @crossplatform
 * @since 10
 */
/**
 * Defines the error interface.
 * @typedef BusinessError
 * @syscap SystemCapability.Base
 * @crossplatform
 * @atomicservice
 * @since 11
 */
/**
 * Defines the error interface.
 * @extends Error
 * @typedef BusinessError<T = void>
 * @syscap SystemCapability.Base
 * @crossplatform
 * @form
 * @atomicservice
 * @since 12
 */
export interface BusinessError<T = void> extends Error {
  /**
   * Defines the basic error code.
   * @type { number } code
   * @syscap SystemCapability.Base
   * @since 6
   */
  /**
   * Defines the basic error code.
   * @type { number } code
   * @syscap SystemCapability.Base
   * @crossplatform
   * @since 10
   */
  /**
   * Defines the basic error code.
   * @type { number } code
   * @syscap SystemCapability.Base
   * @crossplatform
   * @atomicservice
   * @since 11
   */
  /**
   * Defines the basic error code.
   * @type { number } code
   * @syscap SystemCapability.Base
   * @crossplatform
   * @form
   * @atomicservice
   * @since 12
   */
  code: number;
  /**
   * Defines the additional information for business
   * @type { ?T } data
   * @syscap SystemCapability.Base
   * @since 9
   */
  /**
   * Defines the additional information for business
   * @type { ?T } data
   * @syscap SystemCapability.Base
   * @crossplatform
   * @since 10
   */
  /**
   * Defines the additional information for business
   * @type { ?T } data
   * @syscap SystemCapability.Base
   * @crossplatform
   * @atomicservice
   * @since 11
   */
  /**
   * Defines the additional information for business
   * @type { ?T } data
   * @syscap SystemCapability.Base
   * @crossplatform
   * @form
   * @atomicservice
   * @since 12
   */
  data?: T;
}
