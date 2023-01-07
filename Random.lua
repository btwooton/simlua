local Random = {}


function Random.exponential(mean)
	return - mean * math.log(math.random())
end

return Random
