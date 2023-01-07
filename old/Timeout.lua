local Event = require "Event"
local Timeout = {}
Timeout.__index = Timeout


local function constructor(self, env, delay, value)
	value = value or true
	local object = Event(env)
	setmetatable(object, Timeout)
	object.delay = delay
	object.value = value
	object.env:schedule(object, object.delay)
	return object
end

setmetatable(Timeout, { __call = constructor, __index = Event })


return Timeout




