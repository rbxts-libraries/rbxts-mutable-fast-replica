/// <reference types="@rbxts/types" />
declare type RemoteEvents<R extends string> = {
    [key in R]: RemoteEvent;
};
declare type RemoteFunctions<R extends string> = {
    [key in R]: RemoteFunction;
};
export declare const createEvents: <R extends string>(remotes: R[]) => RemoteEvents<R>;
export declare const createFunctions: <R extends string>(remotes: R[]) => RemoteFunctions<R>;
export {};
