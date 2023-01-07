local Event = {}
Event.__index = Event

local function constructor(class, time, process)
	local object = {}
	object.time = time
	object.process = process
	setmetatable(object, class)
	return object
end

function Event.__lt(a, b)
	return a['time'] < b['time']
end

function Event:execute(simulator)
	if self.process ~= nil then
		self.process(self, simulator)
	else
		print("Executing event at time "..tostring(self.time))
	end
end


setmetatable(Event, { __call = constructor })

return Event
