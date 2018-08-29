#!/usr/bin/env lua5.1
--[[
    This file is a part of the fakelove project
    ----

    Copyright (C) 2008-2011  TsT <tst@worldmaster.fr>

    This program is free software: you can redistribute it and/or
    modify it under the terms of the GNU General Public License as
    published by the Free Software Foundation, either version 3 of
    the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program. If not, see <http://www.gnu.org/licenses/>.
]]--

--[[
  Hello,
  If you found a bug or have a question, don't hesitate to contact me
  by email at <tst@worldmaster.fr> (in french or english please)
  Thanks,
  Have fun!
]]--

local _PATCH_MODULE_PATH_=true

--[[ VERSION=0.3.20110903 ]]--

local print = print
local module = module
local assert = assert
--local require = require

function nothing(...) end

local function foreachtostring(...)
	local list = {...}
	local max = #list
	local new = {}
	for i = 1,max,1 do
		local item = list[i]
		table.insert(new, tostring(item))
	end
	return unpack(new)
end

--if not printf then
function printf(fmt, ...)
	print(string.format(fmt, foreachtostring(...)))
end
--end

local function dirname(path)
	assert(type(path)=="string", "path must be a string")
        local rpos = path:reverse():find('/', 1, true)
        local pos = rpos and path:len() - rpos or 0
        local dir = path:sub(1,pos)
        return path:sub(1,1) == "/" and dir:sub(1,1) ~= "/" and "/"..dir or dir
end
local function pathjoin(dir1, dir2)
        if dir1:sub(-1, -1) == "/" or dir1 == "" then
                return dir1..dir2
        end
        return dir1.."/"..dir2
end

assert(arg)
local BASEDIR = dirname(arg[0])
--if BASEDIR ~= "" then
if  _PATCH_MODULE_PATH_ then
do
	local p1 = pathjoin(BASEDIR, "lib/?.lua")
	local p2 = pathjoin(BASEDIR, "lib/?/init.lua")
	package.path = table.concat({p1, p2, package.path}, ";")
end
end
--end

local todo = require("todo")
TODO2 = todo.TODO2
TODO  = todo.TODO

local CE = require("compat_env")

--x-local alt = require("alternatives")
--x-alt.debugcallback = print

--alt.alias("love.screen", "love-screen")

--x-alt.setrequire = require -- the original one

local fakelove = {}
-- set what require() function we must use
--x-fakelove.require = alt.require
fakelove.require = require

fakelove.internaldata = {}
function getInternalDataTable()
        return fakelove.internaldata
end

local function require_conflua_mainlua(modname)
	local ok, result = pcall(dofile, modname)
	if not ok then
		error("raise a error "..modname.." not found")
	end
	return ok
end
local function trydofile_fakefs(modname)
	local fakefs = require("package").fakefs or {}
	if fakefs[modname] then
		print("fakefs is used for "..modname)
		return loadstring(fakefs[modname])()
	end
end
local function trydofile(modname)
	local ok, result = pcall(trydofile_fakefs, modname)
	if ok then
		return result
	end
	local ok, result = pcall(dofile, modname..".lua")
	if ok then
		return result
	end
end


-- patch the require function
require = function(modname)
	if modname == "conf.lua" or modname == "main.lua" then
		print("require called for", modname, "<--- special")
		return require_conflua_mainlua(modname)
	end
	if modname == "embeded/boot" then
		print("require called for", modname, "<--- special")
		return trydofile(modname)
	end
	print("require called for", modname)

	if modname:find("^love%..*") then
		return fakelove.require(modname)
	end

	local ok, result = pcall(fakelove.require, modname)
	if ok then
		print("require success with normal module", modname)
		return result
	end
	local ok2, result2 = pcall(dofile, modname..".lua")
	if ok2 then
		print("require success with +.lua module", modname)
		return result
	end
	return fakelove.require(modname)
end

_G.no_game_code = false -- workaround for strictness.lua

--require("embeded/boot") -- quiet ugly
print("trydofile called for embeded/boot <--- special")
trydofile("embeded/boot")

