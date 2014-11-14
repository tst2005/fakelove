-- module
local m = love.audio
assert(love, "love module required")
assert(type(m)=="table", "module love.audio is not a table object!")

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
m.play = TODO
m.resume = TODO
m.rewind = TODO
m.setOrientation = TODO
m.setPosition = TODO
m.setVelocity = TODO
m.setVolume = function(volume)
	internaldata.volume = volume
end
m.stop = TODO

-- register the internal data into main table
getInternalDataTable().audio = internaldata

return m
