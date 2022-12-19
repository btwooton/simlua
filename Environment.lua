local Timeout = require "Timeout"
local Process = require "Process"


local Environment = {}
Environment.__index = Environment

-- Local List Type that Implements a Queue
List = {}

function List.new()
	return {first = 0, last = -1}
end

function List.pushleft(list, value)
	local first = list.first - 1
	list.first = first
	list[first] = value
end

function List.pushright(list, value)
	local last = list.last + 1
	list.last = last
	list[last] = value
end

function List.popleft(list)
	local first = list.first
	if first > list.last then error("list is empty") end
	local value = list[first]
	list[first] = nil -- allow garbage collection
	list.first = first + 1
	return value
end

function List.popright(list)
	local last = list.last
	if list.first > last then error("list is empty") end
	local value = list[last]
	list[last] = nil
	list.last = last - 1
	return value
end

function List.length(list)
	return list.last - list.first + 1
end


local function construct(self)
	local object = {
		now = 0,
		queue = List.new(),
		event_id = 0
	}
	setmetatable(object, Environment)
	return object
end

setmetatable(Environment, {__call = construct})

function Environment:schedule(event, delay)
	delay = delay or 0
	List.pushright(self.queue, { 
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

	while (List.length(self.queue) > 0) do
		if (self.now >= limit) then
			return
		end
		local triple = List.popleft(self.queue)
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
