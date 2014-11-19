
local love = require("love")
assert(love, "love module required")

local m = love.font or {}
love.font = assert(m)

--[[
m.newFontData = TODO
m.newGlyphData = TODO
m.newRasterizer = TODO
]]--

return m
