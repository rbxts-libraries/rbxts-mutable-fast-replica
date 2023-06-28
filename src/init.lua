-- Compiled with roblox-ts v1.2.7
local TS = _G[script]
local RunService = TS.import(script, TS.getModule(script, "@rbxts", "services")).RunService
local ReplicaClient = TS.import(script, script, "replica-client")
local ReplicaServer = TS.import(script, script, "replica-server")
local FastReplica = {}
do
	local _container = FastReplica
	local createReplicas = function(initialValues)
		if RunService:IsServer() then
			local server = {}
			for i, v in pairs(initialValues) do
				local _replicaServer = ReplicaServer.new(i, v)
				-- ▼ Map.set ▼
				server[i] = _replicaServer
				-- ▲ Map.set ▲
			end
			return {
				server = server,
				client = nil,
			}
		else
			local client = {}
			for i, v in pairs(initialValues) do
				local _replicaClient = ReplicaClient.new(i, v)
				-- ▼ Map.set ▼
				client[i] = _replicaClient
				-- ▲ Map.set ▲
			end
			return {
				server = nil,
				client = client,
			}
		end
	end
	_container.createReplicas = createReplicas
end
return {
	FastReplica = FastReplica,
}
