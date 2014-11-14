
-- module
local m = love.event
assert(love, "love module required")
assert(type(m)=="table", "module love.event is not a table object!")

local Queue = require("queue")

-- module internal data
local internaldata = {}
internaldata.event = Queue.new()


if love and not love.event then
	love.event = {}
end

m.poll = function()
	return function()
		if internaldata.event:size() > 0 then
			return unpack(internaldata.event:lpop())
		end
	end
end
m.pump = function() end
m.push = function(e, a, b, c)
	internaldata.event:rpush({e, a, b, c})
--	if e == "q" then
--		os.exit()
--	end
end

-- TODO
m.wait = function()
	local e, a, b, c = nil, nil, nil, nil
	return e, a, b, c
end

-- register the internal data into main table
getInternalDataTable().event = internaldata

return m
