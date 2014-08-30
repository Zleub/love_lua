Entities = {}

function Entities:new(name)
	Entities[name] = {
		name = name,
		animation = {}
	}
end

return Entities
