local ListQueue = require "ListQueue"

local Resource = {}
Resource.__index = Resource

function constructor(self, env, capacity)
	local object = {}
	object.capacity = capacity
	object.env = env
	object.queue = ListQueue()
	object.count = 0
	object.users = {}
	setmetatable(object, Resource)
	return object
end


function Resource:request()

end


function Resource:release(request)
end


setmetatable(Resource, { __call = constructor })

return Resource
