-- Compiled with roblox-ts v1.2.7
local TS = _G[script]
local Players = TS.import(script, TS.getModule(script, "@rbxts", "services")).Players
local forPlayers = function(clients, callback)
	local playersArray
	if clients == "All" then
		playersArray = Players:GetPlayers()
	elseif typeof(clients) == "Instance" and clients:IsA("Player") then
		playersArray = { clients }
	else
		playersArray = clients
	end
	-- ▼ ReadonlyArray.forEach ▼
	for _k, _v in ipairs(playersArray) do
		callback(_v, _k - 1, playersArray)
	end
	-- ▲ ReadonlyArray.forEach ▲
end
return {
	forPlayers = forPlayers,
}
