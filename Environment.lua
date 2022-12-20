local Timeout = require "Timeout"
local Process = require "Process"
local ListQueue = require "ListQueue"

local Environment = {}
Environment.__index = Environment


local function construct(self)
	local object = {
		now = 0,
		queue = ListQueue(),
		event_id = 0
	}
	setmetatable(object, Environment)
	return object
end

setmetatable(Environment, {__call = construct})

function Environment:schedule(event, delay)
	delay = delay or 0
	self.queue:pushright({ 
		time = self.now + delay, eid = self.event_id,
		["event"] = event
	})
	self.event_id = self.event_id + 1
end

function Environment:timeout(delay, value)
	return Timeout(self, delay, value)
end


function Environment:process(generator)
	return Process(self, generator)
end


function Environment:run(limit)

	while (self.queue:length() > 0) do
		if (self.now >= limit) then
			return
		end
		local triple = self.queue:popleft()
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
