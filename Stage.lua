Stage = {}
Stage.test = "test"

function Stage:new(name)
	self.Conf = require (name)
end

return Stage
