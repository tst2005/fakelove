
local love = require("love")
assert(love, "love module required")

local m = love.keyboard or {}
love.keyboard = assert(m)

return m
