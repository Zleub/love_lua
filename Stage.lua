pretty = require 'pl.pretty'
tablex = require 'pl.tablex'

Stage = {}

function Stage.update(dt, stage)
	stage.winwidth, stage.winheight = love.graphics.getDimensions()
end

function Stage.draw(stage)
	local scale_x
	local scale_y

	for k, v in pairs(stage.todraw) do
		scale_x = stage.data[k].width / stage.winwidth
		scale_y = stage.data[k].height / stage.winheight
		-- love.graphics.print(scale_x, k * 50, 0)
		-- love.graphics.print(scale_y, k * 50, 11)
		love.graphics.draw(stage.todraw[k], stage.data[k].x, stage.data[k].y, 0,
			scale_x, scale_y)
	end
end

function Stage.initdata(data, index, newstage)
	if data.image then
		newstage.todraw[index] = love.graphics.newImage(data.image)
	end
end

function Stage.new(name)
	local newstage = require (name)

	newstage.todraw = {}
	tablex.foreach(newstage.data, Stage.initdata, newstage)
	return newstage
end

return Stage
