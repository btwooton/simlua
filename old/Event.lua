local Event = {}
Event.__index = Event


local function constructor(self, environment)
	local object = {
		env = environment,
		value = nil,
		callbacks = {}
	}
	setmetatable(object, Event)
	return object
end

function Event:succeed(value)
	self.value = value
	self.env.schedule(self)
end

setmetatable(Event, { __call = constructor })

return Event
