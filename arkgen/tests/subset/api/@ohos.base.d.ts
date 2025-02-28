export interface Callback<T> {
  (data: T): void;
}

export interface ErrorCallback<T extends Error = BusinessError> {
  (err: T): void;
}

export interface AsyncCallback<T, E = void> {
  (err: BusinessError<E>, data: T): void;
}

export interface BusinessError<T = void> extends Error {
  code: number;
  data?: T;
}
