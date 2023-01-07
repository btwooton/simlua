local PriorityQueue = require "PriorityQueue"

local pq = PriorityQueue()

pq:push(5)
pq:push(2)
pq:push(10)
pq:push(1)
pq:push(4)
pq:push(3)
pq:push(7)
pq:push(6)
pq:push(8)
pq:push(9)

while (pq:getLength() > 0) do
	print("Popping next element from PriorityQueue")
	local popped = pq:pop()
	print("Popped "..tostring(popped))
end
