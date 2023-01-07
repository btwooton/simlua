local Timeout = require "Timeout"
local Process = require "Process"
local PriorityQueue = require "PriorityQueue"

local Environment = {}
Environment.__index = Environment


local function construct(self)
	local object = {
		now = 0,
		queue = PriorityQueue(),
		event_id = 0
	}
	setmetatable(object, Environment)
	return object
end

setmetatable(Environment, {__call = construct})

function Environment:schedule(event, delay)
	delay = delay or 0
	self.queue:push(setmetatable({ 
		time = self.now + delay, eid = self.event_id,
		["event"] = event
	}, {
		__lt = function(a, b) return a['time'] < b['time'] end,
		__gt = function(a, b) return a['time'] > b['time'] end,
		__eq = function(a, b) return a['time'] == b['time'] end
	}))
	self.event_id = self.event_id + 1
end

function Environment:timeout(delay, value)
	return Timeout(self, delay, value)
end


function Environment:process(generator)
	return Process(self, generator)
end


function Environment:run(limit)

	while (self.queue:getLength() > 0) do
		if (self.now >= limit) then
			return
		end
		local triple = self.queue:pop()
		self.now = triple.time
		local eid = triple.eid
		local current_event = triple.event
		for _, callback in ipairs(current_event.callbacks) do
			if (self.now >= limit) then
				return
			end
			callback(current_event)
		end
	end
end

return Environment
