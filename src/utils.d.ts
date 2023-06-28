import type { TargetClients } from "./types";
export declare type DeepReadonly<T> = {
    readonly [P in keyof T]: DeepReadonly<T[P]>;
};
export declare const forPlayers: (clients: TargetClients, callback: (player: Player) => void) => void;
