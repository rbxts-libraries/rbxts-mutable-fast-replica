/// <reference types="@rbxts/types" />
/// <reference types="@rbxts/compiler-types" />
/// <reference types="goodsignal" />
import Signal from "@rbxts/goodsignal";
import { Path, PathValue } from "./path";
// import { DeepReadonly } from "./utils";
declare class ReplicaClient<D> {
    readonly Name: string;
    static readonly Replicas: Map<String, ReplicaClient<unknown>>;
    private Data;
    /**
     * Will be set to true when the server first contacts the client.
     * @readonly
     */
    Loaded: boolean;
    /**
     * Should fire only once when the server initializes the client.
     */
    readonly Started: Signal<(data: D) => void, false>;
    /**
     * Fires every time the Client value is changed.
     */
    readonly Changed: Signal<(data: D, old: D) => void, false>;
    /**
     * Fires when only a certain path within the client value is changed.
     */
    readonly PathChanged: Signal<(<P extends Path<D>>(path: P, value: PathValue<D, P>) => void), false>;
    constructor(Name: string, initialData: D);
    /**
     * Gets the current Replica Value
     * @returns Data
     */
    GetValue(): D;
    private RequestData;
}
export = ReplicaClient;
