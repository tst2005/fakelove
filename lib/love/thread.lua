
local love = require("love")
assert(love, "love module required")

local m = love.thread or {}
love.thread = assert(m)

return m
