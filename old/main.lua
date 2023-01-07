local Environment = require "Environment"

env = Environment()

function alarm(env)
	local thread = coroutine.create(function()
		coroutine.yield(env:timeout(5))
		print(env.now)
		print("Alarm")
	end)
	return thread
end
	

function alarm2(env)
	local thread = coroutine.create(function()
		coroutine.yield(env:timeout(200))
		print(env.now)
		print("Alarm 2")
	end)
	return thread
end


function car_process(env)
	function charge(duration)
		local thread = coroutine.create(function()
			coroutine.yield(env:timeout(duration))
		end)
		return thread
	end
	local thread = coroutine.create(function()
		while(true) do
			print("Start parking and charging at " .. tostring(env.now))
			charge_duration = 5
			coroutine.yield(env:timeout(charge_duration))
			 
			-- The charge process has finished and we can start driving
			print("Start driving at " .. tostring(env.now))
			trip_duration = 2
			coroutine.yield(env:timeout(trip_duration))
		end
	end)
	return thread
end

env:process(alarm2(env))
env:process(alarm(env))
env:run(250)

