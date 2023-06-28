/// <reference types="@rbxts/compiler-types" />
declare type Str<T> = Extract<T, string>;
declare type StringPathImpl<T, K extends keyof T> = K extends string ? T[K] extends Record<string, any> ? T[K] extends ArrayLike<any> ? K | `${K}.${StringPathImpl<T[K], Exclude<keyof T[K], keyof any[] | "length" | `${number}`>>}` : K | `${K}.${StringPathImpl<T[K], keyof T[K]>}` : K : never;
declare type ArrayPathImpl<T, K extends keyof T> = K extends string ? T[K] extends Record<string, any> ? T[K] extends ArrayLike<any> ? [K] | [K, ...ArrayPathImpl<T[K], Exclude<keyof T[K], keyof any[] | "length">>] : [K] | [K, ...ArrayPathImpl<T[K], keyof T[K]>] : [K] : never;
export declare type ArrayPath<T> = ArrayPathImpl<T, keyof T>;
export declare type StringPath<T> = StringPathImpl<T, keyof T>;
export declare type Path<T> = StringPath<T> | ArrayPath<T>;
export declare type ArrayPathToString<T extends string[]> = T extends [infer A] ? `${Str<A>}` : T extends [infer A, infer B] ? `${Str<A>}.${Str<B>}` : T extends [infer A, infer B, infer C] ? `${Str<A>}.${Str<B>}.${Str<C>}` : T extends [infer A, infer B, infer C, infer D] ? `${Str<A>}.${Str<B>}.${Str<C>}.${Str<D>}` : T extends [infer A, infer B, infer C, infer D, infer E] ? `${Str<A>}.${Str<B>}.${Str<C>}.${Str<D>}.${Str<E>}` : T extends [infer A, infer B, infer C, infer D, infer E, infer F] ? `${Str<A>}.${Str<B>}.${Str<C>}.${Str<D>}.${Str<E>}.${Str<F>}` : T extends [infer A, infer B, infer C, infer D, infer E, infer F, infer G] ? `${Str<A>}.${Str<B>}.${Str<C>}.${Str<D>}.${Str<E>}.${Str<F>}.${Str<G>}` : never;
declare type StringPathValue<T, P extends StringPath<T>> = P extends `${infer K}.${infer Rest}` ? K extends keyof T ? Rest extends StringPath<T[K]> ? StringPathValue<T[K], Rest> : never : never : P extends keyof T ? T[P] : never;
export declare type PathValue<T, P extends Path<T>> = P extends ArrayPath<T> ? StringPathValue<T, ArrayPathToString<P>> : P extends StringPath<T> ? StringPathValue<T, P> : never;
export declare type PathValues<T, P extends Path<T>, V = PathValue<T, P>> = {
    [K in keyof V]: V[K];
};
export declare const arrayPathToString: <D>(path: Path<D>) => StringPathImpl<D, keyof D>;
export {};
