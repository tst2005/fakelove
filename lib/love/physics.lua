
local love = require("love")
assert(love, "love module required")

local m = love.physics or {}
love.physics = assert(m)

return m
