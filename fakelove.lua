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

--[[ VERSION=0.3.20110903 ]]--

local print = print
local module = module
local assert = assert
--local require = require

function nothing(...) end
function TODO2(...)
	local a1 = ...
	a1 = a1 or "???"
	return function(...)
		print("TODO:", a1)
	end
end
function TODO(...) print("TODO...") end

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

local BASEDIR = dirname(arg[0])
--if BASEDIR ~= "" then
do
	local p1 = pathjoin(BASEDIR, "lib/?.lua")
	local p2 = pathjoin(BASEDIR, "lib/?/init.lua")
	package.path = p1..";"..p2..";"..package.path
end
--end

local alt = require("alternatives")
alt.debugcallback = print

alt.alias("love.screen", "love-screen")

alt.setrequire = require -- the original one

local fakelove = {}
-- set what requirei() function we must use
fakelove.require = alt.require

fakelove.internaldata = {}
function getInternalDataTable()
        return fakelove.internaldata
end

local lovemoduleload = function(modname, love)
	assert(love, "love table not exists??")

	if not love[modname] then
		love[modname] = {}
		local origrequire = fakelove.require
		local m = origrequire("love."..modname)
		--printf("debug m = %s ; love[%s] = %s", m, modname, love[modname])

		--FIXME: module() must not be use like that !!
		--module("love."..modname)
	end
	return love[modname]
end

-- patch the require function
require = function(modname)
	--print("require called for", modname)
	if modname == "conf.lua" or modname == "main.lua" then
		local ok, result = pcall(dofile, modname)
		if not ok then
			error("raise a error conf.lua or main.lua not found")
		end
		return ok
	end

	if modname:find("^love\.") then
		local submodname = modname:gsub("^love\.(.*)$", "%1")
		return lovemoduleload(submodname, love)
	end

	local ok, result = pcall(dofile, modname..".lua")
	if ok then
		return result
	end
	local origrequire = fakelove.require
	return origrequire(modname)
end

require("embeded/boot")

