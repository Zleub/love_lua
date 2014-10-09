function insert(shapes, x, y, cell_size)
	print("insert_new:")
	x1, y1 = x, y
	x2, y2 = 0, 0 - cell_size
	for i = 1, 9 do
		if i % 3 == 1 then
			y2 = y2 + cell_size
		-- end
		-- if i / 3then
			x2 = 0
		end
		print(table.getn(shapes) + 1)
		print(x1 + x2..", "..y1 + y2..", "..cell_size)
		table.insert(shapes, Collider:addRectangle(x1 + x2, y1 + y2, cell_size, cell_size))
		x2 = x2 + cell_size
	end
end

function love.load()
	pretty = require('pl.pretty')
	HC = require 'hardoncollider'
	Collider = HC(16)

	shapes = {}
	-- insert(shapes, 225, 225, 50)
	-- insert(shapes, 150, 150, 100)
	-- insert(shapes, 75, 75, 150)
	insert(shapes, 187, 187, 75)
	insert(shapes, 150, 150, 100)
	insert(shapes, 75, 75, 150)
	insert(shapes, 0, 0, 200)



	shapes.mouse = Collider:addCircle(0, 0, 5)
end

function close_polygon_left(x10, y10, x20, y20, x30, y30, x40, y40, x11, y11, x21, y21, x31, y31, x41, y41)
	print(x10, y10, x20, y20, x30, y30, x40, y40, x11, y11, x21, y21, x31, y31, x41, y41)
	return x20, y20, x21, y21, x11, y11, x10, y10
end

function close_polygon_right(x10, y10, x20, y20, x30, y30, x40, y40, x11, y11, x21, y21, x31, y31, x41, y41)
	return x40, y40, x41, y41, x31, y31, x30, y30
end

function get_collision()
	local save = {}
	local k = 1

	while k < table.getn(shapes) + 1 do
		if k + 9 < table.getn(shapes) + 1 and shapes[k]:collidesWith(shapes.mouse) and shapes[k + 9]:collidesWith(shapes.mouse) then
			table.insert(save, shapes[k])
			table.insert(save, shapes[k + 9])

			x10, y10, x20, y20, x30, y30, x40, y40 = shapes[k]._polygon:unpack()
			x11, y11, x21, y21, x31, y31, x41, y41 = shapes[k + 9]._polygon:unpack()

			table.insert(save, Collider:addPolygon(x20, y20, x21, y21, x11, y11, x10, y10))
			table.insert(save, Collider:addPolygon(x40, y40, x41, y41, x31, y31, x30, y30))
			break
		end
		k = k + 1
	end
	return save
end

function love.update(dt)
	shapes.mouse:moveTo(love.mouse.getPosition())
	save = get_collision()
	-- pretty.dump(save)
end

function love.draw()
	love.graphics.setDefaultFilter('nearest', 'nearest')
	for k,v in pairs(save) do
		v:draw('line')
	end

	-- for k,v in pairs(shapes) do
	-- 	v:draw('line')
	-- end


	shapes.mouse:draw("line")
	love.graphics.rectangle("line", 187, 187, 75 * 3, 75 * 3)
	-- love.graphics.line(262, 262, 0, 0)
	-- love.graphics.line(375, 262, 600, 0)
	-- love.graphics.line(262, 375, 0, 600)
	-- love.graphics.line(375, 375, 600, 600)
	love.graphics.print(love.timer.getFPS())
end
