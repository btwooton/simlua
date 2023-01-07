local Event = require "Event"

local ev1 = Event(10)
local ev2 = Event(20)

print(ev1)
print(ev2)
print(ev1 < ev2)
