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

env:process(alarm(env))
env:process(alarm2(env))

env:run()

