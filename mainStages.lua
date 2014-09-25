pretty = require 'pl.pretty'

function love.load()
	Stage = require 'Stage'
	stagetest = Stage.new('stagetest')

	print(pretty.write(Stage, "  ", true))
	print("<-------------->")
	print(pretty.write(stagetest, "  ", true))
end

function love.update(dt)
	Stage.update(dt, stagetest)
end

function love.draw()
	Stage.draw(stagetest)
end
