
local love = require("love")
assert(love, "love module required")

local m = love.image or {}
love.image = assert(m)

return m
