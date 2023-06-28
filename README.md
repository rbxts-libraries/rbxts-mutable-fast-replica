# (Mutable) Fast Replica

This is a fork of [@rbxts/fast-replica](https://www.npmjs.com/package/@rbxts/fast-replica) that removes the reliance of the `DeepReadonly` type, allowing for mutable permutations to pass. Everyrthing else is the same ([this uses version 3.0.2 of @rbxts/fast-replica](https://www.npmjs.com/package/@rbxts/fast-replica/v/3.0.2)).

A simple and intuitive package for sharing data from server to client. Structured in a similar manner to `@flamework/networking`.

This is preferable to `@rbxts/replica-service` if you are looking for fully pre-defined replicas that will be automatically initialized before use.

## API:

### FastReplica (Shared)

FastReplica.createReplicas<Replicas>(initialData: Replicas): GlobalReplicas
The Replicas that will be created, it is considered good practice to only call this once.

### Replica Client

#### readonly Replica.Name: string

The ID the Replica identifies as.

#### Replica.Loaded

Whether the server has sent information to the replica yet. Do **NOT** modify this value.

#### Replica.GetValue(): DeepReadonly<Data>

Returns the current value of the Replica.

#### Replica.Started: Signal<(data: DeepReadonly<Data>) => void>

A signal that fires when the replica is first initialized by the server. Do note that you can use the Replica before then, but it will only contain the initial value.

#### Replica.Changed: Signal<(data: DeepReadonly<Data>) => void>

A signal that fires every time the server sends new data to the client.

#### Replica.PathChanged: Signal<(path: Path<Data>, value: PathValue<P>) => void>

A signal that fires when the server only changes a specific path.

### Replica Server

#### readonly Replica.Name: string

The ID the Replica identifies as.

#### Replica.SetValue(clients: Player | Player[] | "All", Value: Data): void

Syncs the value provided with the clients specified within the arguments.

#### Replica.SetPath(clients: Player | Player[] | "All", path: Path<Data> Value: Data): void

Syncs the specific path value to the clients provided

#### Replica.Assimilate(clients: Player | Player[]): void

Assimilate the client's value back to what "All" should have.

#### Replica.GetValue(player: Player): Data

Fetches the value the specific player current is using.

#### Replica.Started: Signal<(player: Player, data: DeepReadonly<Data>) => void>

A signal that fires when a player is first initialized by the server.

#### Replica.Changed: Signal<(player: Player, data: DeepReadonly<Data>) => void>

A signal that fires every time the server sends new data to a client.

#### Replica.PathChanged: Signal<(path: Path<Data>, value: PathValue<P>) => void>

A signal that fires when the only a specific path on the provided clients will be changed.

## Code Examples:

### Shared

```TS
// shared/replicas.ts
import { FastReplica } from "@rbxts/fast-replica";

type Replicas = { Profile: { Level: number } };
export const globalReplicas = FastReplica.createReplicas<Replicas>({
    Profile: { Level: 0 }, // Initial Value (For when not replicated and default replication)
    State: "Intermission", // Can be any value that could be naturally replicated via RemoteEvents!
    ExtraData: {
        Players: {
            Local: 1,
        },
    },
})
```

### Client

```TS
// client/replicas.ts
import { globalReplicas } from "shared/replicas";
export const Replicas = globalReplicas.client;
```

```TS
import { Replicas } from "client/replicas";

Replicas.Profile.Changed.Connect((value, old) => print(value.Level)); // Fires every time the Value is changed on the server.
Replicas.State.Started.Connect((value) => print(value)); // This fires when the server first syncs the data.
print(Replicas.State.GetValue()); // Fetches and prints the value.
Replicas.ExtraData.PathChanged.Connect((path, value) => print(`Path changed: ${path}: ${value}`));
```

### Server

```TS
// server/replicas.ts
import { globalReplicas } from "shared/replicas";
export const Replicas = globalReplicas.server;
```

```TS
import { Replicas } from "client/replicas";
import { Players } from "@rbxts/services";

task.wait(2.5)
Replicas.Profile.Started.Connect((player: Player, value) => print(`${player.DisplayName}: ${tostring(value)}`)); // Fires when the server sends the initial data to a player.
Replicas.Profile.Changed.Connect((player: Player, value) => print(`${player.DisplayName}: ${tostring(value)}`)); // Fires every time the server sends data to a player.
Replicas.Profile.SetPath("All", "Level", { Level: 10 }); // Sets the value to every player.
Replicas.State.SetValue(Players.GetPlayers(), "Spectating"); // This accepts Player instances or an array of Players as well!
print(Replicas.State.GetValue(Players.GetPlayers()[0])); // Prints the value for a specific player.
Replicas.ExtraData.SetPath("All", "Players.Local", 2);
```
