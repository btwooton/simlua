local Event = require "Event"
local Process = {}
Process.__index = Process

local function constructor(self, env, generator)
	local object = Event(env)
	setmetatable(object, Process)
	object.generator = generator
	local start = env:timeout(0)
	table.insert(start.callbacks, function(event) object:resume(event) end)
	return object
end


function Process:resume(event)
	if (event.value ~= nil) then
		local generator = self.generator
		local send = function() 
			return coroutine.resume(generator, nil) 
		end
		local status, resume_status, event = pcall(send)
		if (status and resume_status and event) then
			table.insert(
				event.callbacks, 
				function(event) self:resume(event) end
			)
		else
			return
		end
	end
end

setmetatable(Process, { __call = constructor, __index = Event })


return Process
