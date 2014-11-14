-- module
local m = love.timer
assert(love, "love module required")
assert(type(m)=="table", "module love.timer is not a table object!")

-- TODO: move socket hack to external file like sleep.lua ?
if not socket then
	local socket = require("socket")
else
	local socket = socket
end
assert(socket.gettime, "socket.gettime required")
assert(socket.select,  "socket.select required")

-- gettime in seconds
local gettime = socket.gettime

-- source: http://lua-users.org/wiki/SleepFunction
local sleep = function(sec)
	socket.select(nil, nil, sec)
end

local steptime = gettime()
local deltatime = 0
local internaldata = {}
internaldata.steptime = function() return steptime end

m.getDelta = function()
	return deltatime -- in seconds
end

-- FIXME: do the real calculation
m.getFPS = function()
	return 50 -- lol
end

m.getMicroTime = function()
	local t = 0
	return t -- in seconds
end

m.getTime = function()
	return gettime() -- in seconds
end

m.sleep = function(ms)
	local ok = pcall(sleep, ms/1000)

	if not ok then
		-- failure is usually due ^C then quit
		if love and love.event and love.event.push then
			print("sleep() interrupted, exiting.")
			love.event.push("q")
		end
	end
end

m.step = function()
	local now = gettime()
	deltatime = now - steptime
	steptime = now
end

-- register the internal data into main table
getInternalDataTable().timer = internaldata

return m
