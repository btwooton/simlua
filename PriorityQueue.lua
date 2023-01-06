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

function PriorityQueue:heapifyDownward()
	local current_idx = 1
	while current_idx <= self.length do
		local swap_child = current_idx * 2
		if swap_child <= self.length and self[current_idx] > self[swap_child] then
			local right_child = current_idx * 2 + 1
			if right_child <= self.length and self[right_child] < self[swap_child] then
				swap_child = right_child
			end
			local temp = self[swap_child]
			self[swap_child] = self[current_idx]
			self[current_idx] = temp
			current_idx = swap_child
		else
			return
		end
	end

end

function PriorityQueue:getLength()
	return self.length
end


return PriorityQueue
