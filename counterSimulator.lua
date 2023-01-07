local Simulator = require "Simulator"
local Event = require "Event"


local function counter(event, simulator)
	print("The time is "..tostring(event.time))
	if event.time < 10 then
		event.time = event.time + 2
		simulator:insert(event)
	end
end

local sim = Simulator()

sim:insert(Event(0, counter))
sim:doAllEvents()

