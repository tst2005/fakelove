--require("io")
--require("os")
--require("socket")

local _M = love or {} -- the love module

local internaldata = {}
function getInternalDataTable()
	return internaldata
end
_M.getInternalDataTable = getInternalDataTable

-- what is the love.arg.options.game.set() ?

--module("love")

love = _M
return _M -- return the love module
