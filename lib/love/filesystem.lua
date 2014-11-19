
local love = require("love")
assert(love, "love module required")

local m = love.filesystem or {}
love.filesystem = assert(m)


--require "io"

--require("todo")
--assert(TODO2 and TODO)

local os = require "os"
assert(os.getenv)

local lfs = require "lfs" -- http://keplerproject.github.com/luafilesystem/manual.html
assert(lfs,		"lfs module required")
assert(lfs.currentdir,	"lfs.currentdir not supported ?!")
assert(lfs.attributes,	"lfs.attributes not supported ?!")
assert(lfs.dir,		"lfs.dir not supported ?!")

-------------------------------------------------------------------------------

-- module internal data
local internaldata = {}


local pwd = function() return lfs.currentdir() end
--local pwd2 = function() return os.getenv("PWD") end

local function fsload (filename)
	local rfsexists, handler = pcall(loadfile, filename)
	if rfsexists and handler then
		return handler
	end

	return nil
end

local function getattrmode(name)
	return lfs.attributes(name, "mode")
end
local function isDirectory(name)
	local mode = getattrmode(name)
	return mode == "directory"
end
local function isFile(name)
	local mode = getattrmode(name)
	return mode == "file"
end
local function exists(name)
	local mode = getattrmode(name)
	return mode and true or false
end

local function enumerate(dir)
	-- Note: lfs is for lua filesystem not love filesystem
	local files = {}
	for file in lfs.dir(dir) do
		if file ~= "." and file ~= ".." then
			files:insert(file)
		end
	end
end

local function mkdir(name)
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

--assert(love, "love module required")
--assert(love.filesystem, "LOVE.filesystem")

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
local getInternalDataTable = love.getInternalDataTable
getInternalDataTable().filesystem = internaldata

return m
