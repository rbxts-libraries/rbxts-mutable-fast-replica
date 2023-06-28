/// <reference types="@rbxts/types" />
/// <reference types="@rbxts/compiler-types" />
/// <reference types="goodsignal" />
import Signal from "@rbxts/goodsignal";
import { Path, PathValue } from "./path";
// import { DeepReadonly } from "./utils";
import type { TargetClients, TargetPlayers } from "./types";
declare class ReplicaServer<D> {
    readonly Name: string;
    private initialData;
    static readonly Replicas: Map<String, ReplicaServer<unknown>>;
    private Data;
    /**
     * Fires when the server initializes a player.
     */
    readonly Started: Signal<(player: Player, value: D) => void, false>;
    /**
     * Fires when the server sends new data to a player.
     */
    readonly Changed: Signal<(player: Player, value: D) => void, false>;
    /**
     * Fires when the server only changes a path in a player's value.
     */
    readonly PathChanged: Signal<(<P extends Path<D>>(player: Player, path: P, value: PathValue<D, P>) => void), false>;
    constructor(Name: string, initialData: D);
    /**
     * Sets the data of the specified clients to the provided data.
     * @param clients Clients that the value will replicate to. Can be a Player, an Array, or "All".
     * @param value The value replicated.
     */
    SetValue(clients: TargetClients, value: D): void;
    /**
     *
     * @param clients Clients that the value will replicate to. Can be a Player, an Array, or "All".
     * @param path A string seperated by '.'s
     * @param value Destination value
     */
    SetPath<P extends Path<D>>(clients: TargetClients, path: P, value: PathValue<D, P>): void;
    /**
     * Resets the specified clients back to the 'All' value.
     * @param clients The target clients
     */
    Assimilate(clients: TargetPlayers): void;
    /**
     * Finds the current value the player should have.
     * @param player Target player
     * @returns Current Value
     */
    GetValue(player: Player): D;
}
export = ReplicaServer;
