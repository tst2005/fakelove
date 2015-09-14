
--require "love.event"
print("main")

local count
love.load = function()
	count=0
end

love.update = function(dt)
	count=count+1
	if count>20 then
		print("love.event.push('q')")
		love.event.push('q')
	end
	print("count", count, "dt", dt)
end

--dofile("test.lua")
