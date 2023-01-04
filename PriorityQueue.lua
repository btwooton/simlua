-- Implements a PriortyQueue
local PriorityQueue = {}
PriorityQueue.__index = PriorityQueue


function constructor()
	local object = {length = 0}
	setmetatable(object, PriorityQueue)
	return object
end

setmetatable(PriorityQueue, { __call = constructor })

function PriorityQueue:push(value)
	local idx = self.length + 1
	self.length = self.length + 1
	self[idx] = value
	self:heapifyUpward(idx)
end

function PriorityQueue:heapifyUpward(idx)
	if idx == 1 then
		return
	else
		local parent = idx // 2
		if self[parent] > self[idx] then
			local temp = self[parent]
			self[parent] = self[idx]
			self[idx] = temp
			self:heapifyUpward(parent)
		end
	end
end

function PriorityQueue:pop()
	if self.length == 0 then error("queue is empty") end
	local value = self[1]
	self[1] = self[self.length]
	self[self.length] = nil -- allow garbage collection
	self.length = self.length - 1
	self:heapifyDownward()
	return value
end

function PriorityQueue:length()
	return self.length
end


return PriorityQueue
