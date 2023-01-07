local Event = require "Event"
local Beep = {}
Beep.__index = Beep


local function constructor(class, time)
	local object = {}
	object.time = time
	setmetatable(object, class)
	return object
end

function Beep:execute(simulator)
	print("The time is "..tostring(self.time).." beep!")
end

-- Beep inherits from Event
Beep.__lt = Event.__lt
setmetatable(Beep, { __call = constructor, __index = Event })

return Beep
