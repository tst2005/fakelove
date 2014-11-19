
local love = require("love")
assert(love, "love module required")

local m = love.graphics or {}
love.graphics = assert(m)

-- module internal data
local internaldata = {}

local print = print
local printf = printf

internaldata.screen_modes = {
	{ width =  320, height = 240 },
	{ width =  640, height = 480 },
	{ width =  800, height = 600 },
	{ width = 1024, height = 768 },
}
internaldata.width  = 800
internaldata.height = 600
internaldata.fullscreen = false
internaldata.caption = "NotSet"

internaldata.scissor = nil

local newFont = function(name, size)
  return {
    getWidth = function(self, text) return #text * size end,
    getHeight = function(self, text) return size end,
  }
end


m.getCaption = function()
	return internaldata.caption
end
m.setCaption = function(title)
	internaldata.caption = title
end

m.checkMode = function(width, height, fullscreen)
	return true
end

m.getModes = function()
	return internaldata.screen_modes
end

m.setMode = function(width, height, fullscreen, vsync, fsaa)
	local success = true
	if success then
		internaldata.width  = width
		internaldata.height = height
		internaldata.fullscreen = fullscreen
	end
	return success
end

m.getHeight = function() return internaldata.height end
m.getWidth = function() return internaldata.width end

m.toggleFullscreen = function(...)
	local success = true
	if success then
		internaldata.fullscreen = not internaldata.fullscreen
	end
	return success
end

m.isCreated = function() return true end
--[[
m.circle = TODO
]]--
m.clear = function() end
m.draw = TODO2("love.graphics.draw")
--[[
m.drawq = TODO
m.getBackgroundColor = TODO
m.getBlendMode = TODO
m.getColor = TODO
m.getColorMode = TODO
m.getFont = TODO
m.getLineStipple = TODO
m.getLineStyle = TODO
m.getLineWidth = TODO
m.getMaxPointSize = TODO
m.getPointSize = TODO
m.getPointStyle = TODO
]]--
m.getScissor = function()
	return unpack(internaldata.scissor)
end
--[[
m.line = TODO
]]--
m.newFont = newFont
--[[
m.newFramebuffer = TODO
m.newImage = TODO
m.newImageFont = TODO
m.newParticleSystem = TODO
m.newQuad = TODO
m.newScreenshot = TODO
m.newSpriteBatch = TODO
m.point = TODO
m.polygon = TODO
]]--
m.pop = function() end
m.present = function() end
m.print = function(text, x, y, r, sx, sy)
	--printf("love.graphics.print(%s, %s, %s, %s, %s, %s)", text, tostring(x), tostring(y), tostring(r), tostring(sx), tostring(sy))
end
m.printf = function(text, x, y, limit, align)
	--printf("love.graphics.printf(%s, ...)", text)
end
--[[
m.push = TODO
m.quad = TODO
m.rectangle = TODO
m.reset = TODO
m.rotate = TODO
m.scale = TODO
]]--
m.setBackgroundColor = function(...)
	-- setBackgroundColor(red, green, blue)
	-- setBackgroundColor(rgb) -- for <= 0.7.0 This variant is not supported in earlier versions
end
m.setBlendMode = TODO2("love.graphics.setBlendMode")
m.setColor = TODO2("love.graphics.setColor")
m.setColorMode = TODO2("love.graphics.setColorMode")
m.setFont = TODO2("love.graphics.setFont")
m.setIcon = TODO2("love.graphics.setIcon")
m.setLine = TODO2("love.graphics.setLine")
m.setLineStipple = TODO2("love.graphics.setLineStipple")
m.setLineStyle = TODO2("love.graphics.setLineStyle")
m.setLineWidth = TODO2("love.graphics.setLineWidth")
m.setPoint = TODO2("love.graphics.setPoint")
m.setPointSize = TODO2("love.graphics.setPointSize")
m.setPointStyle = TODO2("love.graphics.setPointStyle")
m.setRenderTarget = TODO2("love.graphics.setRenderTarget")
m.setScissor = function(...)
	if arg == nil or #arg == 0 then
		-- case: setScissor()
		-- reset scissor
		return
	end
	-- case: setScissor(x, y, width, height)
	local x, y, width, height = ...
	internaldata.scissor = pack(x, y, width, height)
	return
end
--[[
m.translate = TODO
m.triangle = TODO
]]--

-- register the internal data into main table
getInternalDataTable().graphics = internaldata

return m
