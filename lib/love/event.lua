
local love = require("love")
assert(love, "love module required")

-- module
local m = love.event or {}
love.event = assert(m)

local Queue = require("queue")

-- module internal data
local internaldata = {}
internaldata.event = Queue.new()


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
