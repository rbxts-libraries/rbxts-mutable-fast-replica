-- Compiled with roblox-ts v1.2.7
-- eslint-disable-next-line @typescript-eslint/no-explicit-any
-- eslint-disable @typescript-eslint/no-explicit-any
-- eslint-enable @typescript-eslint/no-explicit-any
-- eslint-disable prettier/prettier
-- eslint-enable prettier/prettier
local arrayPathToString = function(path)
	if type(path) == "string" then
		return path
	else
		local stringPath = ""
		for _, node in ipairs(path) do
			stringPath ..= node .. "."
		end
		local _stringPath = stringPath
		local _arg1 = #stringPath - 1
		return string.sub(_stringPath, 0, _arg1)
	end
end
return {
	arrayPathToString = arrayPathToString,
}
