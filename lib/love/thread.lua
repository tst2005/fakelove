-- module
local m = love.thread
assert(love, "love module required")
assert(type(m)=="table", "module love.thread is not a table object!")

return m
