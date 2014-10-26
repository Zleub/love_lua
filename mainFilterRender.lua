pretty = require 'pl.pretty'

function love.load()
	img = love.graphics.newImage('images/test render.png')
end

function love.update(dt)
end

function love.draw()
	img:setFilter('nearest')

	love.graphics.draw(img, 0, 0)

	love.graphics.draw(img, 0, 30, 0, 2, 2)

	love.graphics.draw(img, 0, 100, 0, 3, 3)

	love.graphics.draw(img, 0, 200, 0, 4, 4)

	love.graphics.draw(img, 0, 300, 0, 5, 5)

end
