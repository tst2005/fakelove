do
local package = require("package")
assert(package.preload)
print("preload:")
for k,v in pairs(package.preload) do print(type(v), k) end
print("")

assert(package.loaded)
print("loaded:")
for k,v in pairs(package.loaded) do print(type(v), k) end
print("")

local function verboserequire(name)
	print("")
	print("loading "..name.." ...")
	local res = require(name)
	print(name.." loaded", res)
	for k,v in pairs(package.loaded) do
		print(
			k==name and "-->" or "", 
			type(v),
			k,
			k==name and "<-"..("-"):rep(10) or ""
		)
	end
	return res
end

--verboserequire "queue"
--local todo = verboserequire "todo"
--TODO2 = assert(todo.TODO2)
--TODO  = assert(todo.TODO)

--verboserequire "lua-compat-env"
--verboserequire "love.filesystem"

end
