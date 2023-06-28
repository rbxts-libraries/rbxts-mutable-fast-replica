import ReplicaClient from "./replica-client";
import ReplicaServer from "./replica-server";
declare type Replicas = {
    [key in string]: unknown;
};
declare type ServerReplicas<R> = {
    [key in keyof R]: ReplicaServer<R[key]>;
};
declare type ClientReplicas<R> = {
    [key in keyof R]: ReplicaClient<R[key]>;
};
declare type GlobalReplicas<R extends Replicas> = {
    server: ServerReplicas<R>;
    client: ClientReplicas<R>;
};
export declare namespace FastReplica {
    const createReplicas: <R extends Replicas>(initialValues: R) => GlobalReplicas<R>;
}
export {};
