-- Compiled with roblox-ts v1.2.7
local TS = _G[script]
local Signal = TS.import(script, TS.getModule(script, "@rbxts", "goodsignal").src)
local RunService = TS.import(script, TS.getModule(script, "@rbxts", "services")).RunService
local _remotes = TS.import(script, script.Parent, "remotes")
local Events = _remotes.Events
local Functions = _remotes.Functions
local forPlayers = TS.import(script, script.Parent, "utils").forPlayers
local ReplicaServer
do
	ReplicaServer = setmetatable({}, {
		__tostring = function()
			return "ReplicaServer"
		end,
	})
	ReplicaServer.__index = ReplicaServer
	function ReplicaServer.new(...)
		local self = setmetatable({}, ReplicaServer)
		return self:constructor(...) or self
	end
	function ReplicaServer:constructor(Name, initialData)
		self.Name = Name
		self.initialData = initialData
		self.Data = {}
		self.Started = Signal.new()
		self.Changed = Signal.new()
		self.PathChanged = Signal.new()
		local _replicas = ReplicaServer.Replicas
		local _self = self
		-- ▼ Map.set ▼
		_replicas[Name] = _self
		-- ▲ Map.set ▲
	end
	function ReplicaServer:SetValue(clients, value)
		forPlayers(clients, function(player)
			-- ▼ Map.set ▼
			self.Data[player] = value
			-- ▲ Map.set ▲
			self.Changed:Fire(player, value)
			Events.SetValue:FireClient(player, self.Name, value)
		end)
		if clients == "All" then
			self.initialData = value
		end
	end
	function ReplicaServer:SetPath(clients, path, value)
		local pathArray = type(path) == "string" and string.split(path, ".") or path
		forPlayers(clients, function(player)
			local _object = {}
			local _spread = self.Data[player]
			if type(_spread) == "table" then
				for _k, _v in pairs(_spread) do
					_object[_k] = _v
				end
			end
			local data = _object
			-- eslint-disable-next-line @typescript-eslint/no-explicit-any
			local pointer = data
			do
				local i = 0
				local _shouldIncrement = false
				while true do
					if _shouldIncrement then
						i += 1
					else
						_shouldIncrement = true
					end
					if not (i < #pathArray - 1) then
						break
					end
					pointer = pointer[pathArray[i + 1]]
				end
			end
			pointer[pathArray[#pathArray - 1 + 1]] = value
			-- ▼ Map.set ▼
			self.Data[player] = data
			-- ▲ Map.set ▲
			self.Changed:Fire(player, data)
			self.PathChanged:Fire(player, path, value)
			Events.SetPath:FireClient(player, self.Name, path, value)
		end)
		if clients == "All" then
			local _object = {}
			local _spread = self.initialData
			if type(_spread) == "table" then
				for _k, _v in pairs(_spread) do
					_object[_k] = _v
				end
			end
			local data = _object
			-- eslint-disable-next-line @typescript-eslint/no-explicit-any
			local pointer = data
			do
				local i = 0
				local _shouldIncrement = false
				while true do
					if _shouldIncrement then
						i += 1
					else
						_shouldIncrement = true
					end
					if not (i < #pathArray - 1) then
						break
					end
					pointer = pointer[pathArray[i + 1]]
				end
			end
			pointer[pathArray[#pathArray - 1 + 1]] = value
			self.initialData = data
		end
	end
	function ReplicaServer:Assimilate(clients)
		self:SetValue(clients, self.initialData)
	end
	function ReplicaServer:GetValue(player)
		if not (self.Data[player] ~= nil) then
			local _data = self.Data
			local _initialData = self.initialData
			-- ▼ Map.set ▼
			_data[player] = _initialData
			-- ▲ Map.set ▲
		end
		return self.Data[player]
	end
	ReplicaServer.Replicas = {}
end
if RunService:IsServer() then
	Functions.RequestData.OnServerInvoke = function(player, name)
		local _result = ReplicaServer.Replicas[name]
		if _result ~= nil then
			_result = _result:GetValue(player)
		end
		return _result
	end
end
return ReplicaServer
