
local love = require("love")
assert(love, "love module required")

local m = love.mouse or {}
love.mouse = assert(m)

return m
