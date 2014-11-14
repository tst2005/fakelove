require "io"
require "os"
require "lfs" -- http://keplerproject.github.com/luafilesystem/manual.html

-- module
local m = love.filesystem
assert(love, "love module required")
assert(type(m)=="table", "module love.filesystem is not a table object!")

-- module internal data
local internaldata = {}


local pwd = function() return lfs.currentdir() end
--local pwd2 = function() return os.getenv("PWD") end

local fsload = function(filename)
	local rfsexists, handler = pcall(loadfile, filename)
	if rfsexists and handler then
		return handler
	end

	return nil
end

local getattrmode = function(name)
	return lfs.attributes(name, "mode")
end
local isDirectory = function(name)
	local mode = getattrmode(name)
	return mode == "directory"
end
local isFile = function(name)
	local mode = getattrmode(name)
	return mode == "file"
end
local exists = function(name)
	local mode = getattrmode(name)
	return mode and true or false
end

local enumerate = function(dir)
	-- Note: lfs is for lua filesystem not love filesystem
	local files = {}
	for file in lfs.dir(dir) do
		if file ~= "." and file ~= ".." then
			files:insert(file)
		end
	end
end

local mkdir = function(name)
	--TODO: is creation accept absolute path ?
	--TODO: only create inside SaveDirectory
	return false
end

internaldata.identity = "" -- "" or nil ?
internaldata.source = "NotSet" -- used by setSource
internaldata.XDG_DATA_HOME = os.getenv("XDG_DATA_HOME")
internaldata.HOME = os.getenv("HOME")

if internaldata.XDG_DATA_HOME then
	internaldata.AppdataDirectory = internaldata.XDG_DATA_HOME
	--internaldata.SaveDirectory = string.format("%s/%s", internaldata.XDG_DATA_HOME, "/love/"
elseif internaldata.HOME then
	internaldata.AppdataDirectory = internaldata.HOME
	--internaldata.SaveDirectory = (internaldata.HOME, "./local/share/love/"):format("%s/%s")
else
	error("No such XDG_DATA_HOME or HOME environnement")
end
internaldata.UserDirectory = internaldata.HOME
internaldata.WorkingDirectory = pwd()

assert(love, "love module required")
assert(love.filesystem, "LOVE.filesystem")

m.enumerate           = enumerate
m.exists              = exists
m.getAppdataDirectory = function() return internaldata.AppdataDirectory end
m.getLastModified     = TODO2("love.filesystem.getLastModified")
m.getSaveDirectory    = function() return internaldata.SaveDirectory end
m.getUserDirectory    = function() return internaldata.UserDirectory end
m.getWorkingDirectory = function() return internaldata.WorkingDirectory end
m.init                = function() end
m.isDirectory         = isDirectory
m.isFile              = isFile
m.lines               = TODO2("love.filesystem.lines")
m.load                = fsload
m.mkdir               = mkdir
m.newFile             = TODO2("love.filesystem.newFile")
m.newFileData         = TODO2("love.filesystem.newFileData")
m.read                = TODO2("love.filesystem.read")
m.remove              = TODO2("love.filesystem.remove")
m.setIdentity         = function(name)
	internaldata.identity = name
	--FIXME: need to update AppdataDirectory and/or SaveDirectory
end
m.setSource           = function(source) internaldata.source = source end
m.write               = TODO2("love.filesystem.write")


-- custom function (not present in v0.7.1)
m.getIdentity         = function() return internaldata.identity end

-- register the internal data into main table
getInternalDataTable().filesystem = internaldata

return m
