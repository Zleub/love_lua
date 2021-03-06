function build(x1, y1, size)
	return {
		x1, y1,
		x1, y1 + size,
		x1 + size, y1 + size,
		x1 + size, y1,
		x1, y1
	}
end

function insert(cells, x, y, cell_size)
	x1, y1 = x, y
	x2, y2 = 0, 0 - cell_size
	for i = 1, 9 do
		if i % 3 == 1 then
			y2 = y2 + cell_size
		-- end
		-- if i / 3then
			x2 = 0
		end
		print(x1 + x2..", "..y1 + y2..", "..cell_size)
		table.insert(cells, build(x1 + x2, y1 + y2, cell_size))
		x2 = x2 + cell_size
	end
end

function love.load()
	cell_size = 50

	cells = {}

	insert(cells, 100, 100, 50)

	insert(cells, 62, 62, 75)

	insert(cells, 24, 24, 100)
end

function love.update(dt)
end

function love.draw()
	bonus = {}

	for k,v in pairs(cells) do
		love.graphics.line(v)
	end

	-- for k,v in pairs(bonus) do
	-- 	love.graphics.line(v)
	-- end

end
