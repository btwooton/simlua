
-- Local List Type that Implements a Queue
local ListQueue = {}
ListQueue.__index = ListQueue


function constructor()
	local object = {first = 0, last = -1}
	setmetatable(object, ListQueue)
	return object
end

setmetatable(ListQueue, { __call = constructor })

function ListQueue:pushleft(value)
	local first = self.first - 1
	self.first = first
	self[first] = value
end

function ListQueue:pushright(value)
	local last = self.last + 1
	self.last = last
	self[last] = value
end

function ListQueue:popleft()
	local first = self.first
	if first > self.last then error("list is empty") end
	local value = self[first]
	self[first] = nil -- allow garbage collection
	self.first = first + 1
	return value
end

function ListQueue:popright()
	local last = self.last
	if self.first > last then error("list is empty") end
	local value = self[last]
	self[last] = nil
	self.last = last - 1
	return value
end

function ListQueue:length()
	return self.last - self.first + 1
end


return ListQueue
