-- Compiled with roblox-ts v1.2.7
local TS = _G[script]
local _services = TS.import(script, TS.getModule(script, "@rbxts", "services"))
local ReplicatedStorage = _services.ReplicatedStorage
local RunService = _services.RunService
local RemoteContainer = RunService:IsServer() and Instance.new("Folder") or (ReplicatedStorage:WaitForChild("@rbxts/fast-replica", 5))
if RunService:IsServer() then
	RemoteContainer.Name = "@rbxts/fast-replica"
	RemoteContainer.Parent = ReplicatedStorage
end
local createEvents = function(remotes)
	if RunService:IsServer() then
		local remoteEvents = {}
		for _, remote in ipairs(remotes) do
			local remoteEvent = Instance.new("RemoteEvent")
			remoteEvent.Name = remote
			remoteEvent.Parent = RemoteContainer
			remoteEvents[remote] = remoteEvent
		end
		return remoteEvents
	else
		local remoteEvents = {}
		for _, remote in ipairs(remotes) do
			local remoteEvent = RemoteContainer:WaitForChild(remote, 15)
			remoteEvents[remote] = remoteEvent
		end
		return remoteEvents
	end
end
local createFunctions = function(remotes)
	if RunService:IsServer() then
		local remoteEvents = {}
		for _, remote in ipairs(remotes) do
			local remoteEvent = Instance.new("RemoteFunction")
			remoteEvent.Name = remote
			remoteEvent.Parent = RemoteContainer
			remoteEvents[remote] = remoteEvent
		end
		return remoteEvents
	else
		local remoteEvents = {}
		for _, remote in ipairs(remotes) do
			local remoteEvent = RemoteContainer:WaitForChild(remote, 15)
			remoteEvents[remote] = remoteEvent
		end
		return remoteEvents
	end
end
return {
	createEvents = createEvents,
	createFunctions = createFunctions,
}
