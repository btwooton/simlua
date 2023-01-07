local Event = require "Event"
local Simulator = require "Simulator"
local Random = require "Random"

local function particle(event, simulator)
	print("A particle disintigrated at t = "..tostring(event.time))
end

local sim = Simulator()

sim:insert(Event(Random.exponential(4.0), particle))
sim:insert(Event(Random.exponential(4.0), particle))
sim:insert(Event(Random.exponential(4.0), particle))
sim:insert(Event(Random.exponential(4.0), particle))
sim:insert(Event(Random.exponential(4.0), particle))

sim:doAllEvents()
