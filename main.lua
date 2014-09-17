function love.load()
	Doors = require 'Doors'
	Doors:new(3)
	print(Doors.size)
end

-- function love.update(dt)
-- 	Doors:update()
-- end

function love.draw()
	Doors:draw()
end


