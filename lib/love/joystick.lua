
local love = require("love")
assert(love, "love module required")

local m = love.joystick or {}
love.joystick = assert(m)

-- module internal data
local internaldata = {}

internaldata.numJoysticks = 0

m.close = TODO
m.getAxes = TODO
m.getAxis = TODO
m.getBall = TODO
m.getHat = TODO
m.getName = TODO
m.getNumAxes = TODO
m.getNumBalls = TODO
m.getNumButtons = TODO
m.getNumHats = TODO
m.getNumJoysticks = function() return internaldata.numJoysticks end
m.isDown = TODO
m.isOpen = TODO
m.open = TODO

-- register the internal data into main table
getInternalDataTable().joystick = internaldata

return m
