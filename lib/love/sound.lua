
local love = require("love")
assert(love, "love module required")

local m = love.sound or {}
love.sound = assert(m)

-- module internal data
local internaldata = {}

local newSoundData_1 = function(decoder)
	--TODO
end
local newSoundData_2 = function(filename)
	--TODO

end
local newSoundData_3 = function(samples, rate, bits, channels)
	--TODO
end

local newDecoder_1 = function(file, buffer)
	--TODO
end

local newDecoder_2 = function(filename, buffer)
	--TODO
end


m.newDecoder = function(file, buffer)
	if file:type() == "file" then
		local file = f
		return newDecoder_1(file, buffer)
	elseif file:type() == "string" then
		local filename = f
		return newDecoder_2(filename, buffer)
	end
end
m.newSoundData = function(...)
	local arg1 = ...
	if arg1:type() == "decoder" then
		return newSoundData_1(arg1)
	end
	--TODO
end

-- register the internal data into main table
getInternalDataTable()sound = internaldata

return m
