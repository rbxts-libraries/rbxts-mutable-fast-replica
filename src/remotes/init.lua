-- Compiled with roblox-ts v1.2.7
local TS = _G[script]
local _constructor = TS.import(script, script, "constructor")
local createEvents = _constructor.createEvents
local createFunctions = _constructor.createFunctions
local Events = createEvents({ "SetValue", "SetPath" })
local Functions = createFunctions({ "RequestData" })
return {
	Events = Events,
	Functions = Functions,
}
