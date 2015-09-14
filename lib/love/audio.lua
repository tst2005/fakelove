
local love = require("love")
assert(love, "love module required")

local m = love.audio or {}
love.audio = assert(m)

-- module internal data
local internaldata = {}

internaldata.volume = 0 -- is 0 is a valid ? doc told between 0.0f and 1.0f.

m.getNumSources = TODO
m.getOrientation = TODO
m.getPosition = TODO
m.getVelocity = TODO
m.getVolume = function()
	return internaldata.volume
end
m.newSource = TODO
m.pause = TODO
m.play = function(source)
	internaldata.playing = true
	internaldata.source = source
	return
end
m.resume = TODO
m.rewind = TODO
m.setOrientation = TODO
m.setPosition = TODO
m.setVelocity = TODO
m.setVolume = function(volume) -- 1.0f is max and 0.0f is off. 
	internaldata.volume = volume
end
m.stop = function()
	internaldata.playing = false
end

-- register the internal data into main table
getInternalDataTable().audio = internaldata

return m
