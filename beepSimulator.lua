local Event = require "Event"
local Simulator = require "Simulator"

local function beep(event, simulator)
	print("Time time is "..tostring(event.time).." beep!")
end

local sim = Simulator()
sim:insert(Event(4, beep))
sim:insert(Event(1, beep))
sim:insert(Event(1.5, beep))
sim:insert(Event(2.0, beep))

sim:doAllEvents()
