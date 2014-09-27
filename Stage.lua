pretty = require 'pl.pretty'
tablex = require 'pl.tablex'

Stage = {}

function Stage.update(dt, stage)
	stage.winwidth, stage.winheight = love.graphics.getDimensions()
end

function Stage.draw(stage)
	local img_width
	local img_height
	local scale_x
	local scale_y
	local scale_1
	local scale_2

	for k, v in pairs(stage.images) do
		img_width, img_height = stage.images[k]:getDimensions()

		if stage.data[k].width and stage.data[k].height then
			scale_x = img_width / stage.data[k].width
			scale_y = img_height / stage.data[k].height
		else
			scale_x = img_width / (stage.winwidth - stage.data[k].x)
			scale_y = img_height / (stage.winheight - stage.data[k].y)
		end

		scale_1 = img_width / stage.winwidth
		scale_2 = img_height / stage.winheight
		-- print("scale_1: ", scale_1)
		-- print("scale_2: ", scale_2)
		-- print("scale_x: ", scale_x)
		-- print("scale_y: ", scale_y)

		love.graphics.print(scale_x, k * 50, 0)
		love.graphics.print(scale_y, k * 50, 11)

		print(stage.data[k].name, 1 / (scale_x * scale_1), 1 / (scale_y * scale_2))

		if stage.data[k].scaled == true then
			love.graphics.draw(stage.images[k], stage.data[k].x, stage.data[k].y, 0,
				1 / (scale_x * scale_1), 1 / (scale_y * scale_2) )
		else
			love.graphics.draw(stage.images[k], stage.data[k].x, stage.data[k].y, 0,
				1 / (scale_x), 1 / (scale_y) )
		end
	end
end

function Stage.initdata(data, index, newstage)
	if data.image then
		newstage.images[index] = love.graphics.newImage(data.image)
	end
end

function Stage.new(name)
	local newstage = require (name)

	newstage.images = {}
	tablex.foreach(newstage.data, Stage.initdata, newstage)
	return newstage
end

return Stage
