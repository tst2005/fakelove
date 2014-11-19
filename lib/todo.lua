local function TODO2(...)
        local a1 = ...
        a1 = a1 or "???"
        return function(...)
                print("TODO:", a1)
        end
end
local function TODO(...) print("TODO...") end

return {
	TODO2 = TODO2,
	TODO  = TODO,
}
