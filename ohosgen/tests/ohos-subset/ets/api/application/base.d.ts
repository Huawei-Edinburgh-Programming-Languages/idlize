export interface AsyncCallback<T> {
  (err: BusinessError<T>, data: string): void;
}

interface Error {
  name: string;
  message: string;
  stack?: string;
}

export interface BusinessError<T = void> extends Error {
  code: number;
  data?: string;
}

// export interface BusinessError<T = void> extends Error {
//   code: number;
//   data?: T;
// }

// export interface AsyncCallback<T, E = void> {
//   (err: BusinessError<E>, data: T): void;
// }
