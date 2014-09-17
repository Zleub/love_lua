pretty = require 'pl.pretty'

function love.load()
	Doors = require 'Doors'
	Doors:new(5, 1000)
end

function love.update(dt)
	Doors:update()
end

function love.draw()
	Doors:draw()
end


