-- Compiled with roblox-ts v1.2.7
local TS = _G[script]
local Signal = TS.import(script, TS.getModule(script, "@rbxts", "goodsignal").src)
local _remotes = TS.import(script, script.Parent, "remotes")
local Events = _remotes.Events
local Functions = _remotes.Functions
local arrayPathToString = TS.import(script, script.Parent, "path").arrayPathToString
local ReplicaClient
do
	ReplicaClient = setmetatable({}, {
		__tostring = function()
			return "ReplicaClient"
		end,
	})
	ReplicaClient.__index = ReplicaClient
	function ReplicaClient.new(...)
		local self = setmetatable({}, ReplicaClient)
		return self:constructor(...) or self
	end
	function ReplicaClient:constructor(Name, initialData)
		self.Name = Name
		self.Loaded = false
		self.Started = Signal.new()
		self.Changed = Signal.new()
		self.PathChanged = Signal.new()
		self.Data = initialData
		self:RequestData()
		local _replicas = ReplicaClient.Replicas
		local _self = self
		-- ▼ Map.set ▼
		_replicas[Name] = _self
		-- ▲ Map.set ▲
		Events.SetValue.OnClientEvent:Connect(function(name, value)
			if name == self.Name then
				local old = self.Data
				self.Data = value
				self.Changed:Fire(value, old)
			end
		end)
		Events.SetPath.OnClientEvent:Connect(function(name, path, value)
			if name == self.Name then
				local pathArray = type(path) == "string" and string.split(path, ".") or path
				-- Cache Data
				local _object = {}
				local _spread = self.Data
				if type(_spread) == "table" then
					for _k, _v in pairs(_spread) do
						_object[_k] = _v
					end
				end
				local newData = _object
				local oldData = self.Data
				-- Update path
				-- eslint-disable-next-line @typescript-eslint/no-explicit-any
				local pointer = newData
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
				-- Commit Changes
				self.Data = newData
				self.Changed:Fire(newData, oldData)
				self.PathChanged:Fire(type(path) == "string" and path or arrayPathToString(path), value)
			end
		end)
	end
	function ReplicaClient:GetValue()
		return self.Data
	end
	function ReplicaClient:RequestData()
		task.defer(function()
			local initialData = Functions.RequestData:InvokeServer(self.Name)
			if initialData ~= nil then
				self.Loaded = true
				self.Started:Fire(initialData)
			end
		end)
	end
	ReplicaClient.Replicas = {}
end
return ReplicaClient
