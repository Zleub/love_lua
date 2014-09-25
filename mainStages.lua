function love.load()
	Stage = require 'Stage'
	Stage:new('stagetest')
	print(Stage.Conf.key)
end

function love.update(dt)
end

function love.draw()
end
