local Simulator = {}
local PriorityQueue = require "PriorityQueue"
Simulator.__index = Simulator


local function constructor(class)
	local object = {}
	object.time = 0
	object.events = PriorityQueue()
	setmetatable(object, class)
	return object
end


function Simulator:now() 
	return self.time
end


function Simulator:doAllEvents() 
	local event = self.events:pop()
	while event ~= nil do
		self.time = event.time
		event:execute(self)
		event = self.events:pop()
	end
end


function Simulator:insert(event)
	self.events:push(event)
end


setmetatable(Simulator, { __call = constructor })

return Simulator
