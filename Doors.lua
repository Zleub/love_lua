pretty = require 'pl.pretty'

Doors = {}

function Doors:new_grid(size, pix_size_x, pix_size_y)
	local grid = {}
	local cell_size_x = math.floor(pix_size_x / size)
	local cell_size_y = math.floor(pix_size_y / size)

	local margin_x = love.window.getWidth() - pix_size_x
	local margin_y = love.window.getHeight() - pix_size_y

	print("size:", size)
	print("pix_size_x:", pix_size_x, "pix_size_y:", pix_size_y)
	print("cell_size_x:", cell_size_x, "cell_size_y:", cell_size_y)
	print("margin_x:", margin_x, "margin_x:", margin_y)
	local x_tmp, y_tmp = 0, 0 - cell_size_y
	for i = 1, size * size do
		if i % size == 1 then
			y_tmp = y_tmp + cell_size_y
			x_tmp = 0
		end

		local x1, y1 = margin_x / 2 + x_tmp, margin_y / 2 + y_tmp
		local x2, y2 = margin_x / 2 + cell_size_x + x_tmp, margin_y / 2 + y_tmp
		local x3, y3 = margin_x / 2 + cell_size_x + x_tmp, margin_y / 2 + cell_size_y + y_tmp
		local x4, y4 = margin_x / 2 + x_tmp, margin_y / 2 + cell_size_y + y_tmp
		table.insert(grid, self.Collider:addPolygon(x1, y1, x2, y2, x3, y3, x4, y4))
		x_tmp = x_tmp + cell_size_x
	end
	return grid
end

function Doors:build_major()
	local grids = {}
	for i = 0, self.size do
		if i == 0 then
			table.insert(grids, self:new_grid(self.size, love.window.getDimensions()))
		else
			table.insert(grids, self:new_grid(self.size, love.window.getWidth() - i * (self.depth_field), love.window.getHeight() - i * (self.depth_field)))
		end
	end
	return grids
end

function Doors:new(size, depth_field)
	self.HC = require 'hardoncollider'
	self.Collider = self.HC(16)
	self.mouse = self.Collider:addPoint(love.mouse.getPosition())
	self.size = size
	self.depth_field = depth_field
	self.mode = 'major'
	self.majorgrids = self:build_major()
	self.minorgrids = {}
	print("new end")
	-- pretty.dump(self.majorgrids)
end

function Doors:get_collision()
	local save = {}
	local k = 1
	local p = 1
	-- local max = self.size * self.size
	local max = self.size * self.size

	-- print("table.getn(self.majorgrids[1])", table.getn(self.majorgrids[1]))

	while p < self.size + 1 do
		while k < table.getn(self.majorgrids[p]) + 1 do
			if k + self.size < table.getn(self.majorgrids[p]) + 1 and self.majorgrids[p][k]:collidesWith(self.mouse) then
			print("deladmere dd 	")
				table.insert(save, self.majorgrids[p][k])
				table.insert(save, self.majorgrids[p][k + self.size])

				x10, y10, x20, y20, x30, y30, x40, y40 = self.majorgrids[p][k]._polygon:unpack()
				x11, y11, x21, y21, x31, y31, x41, y41 = self.majorgrids[p + 1][k]._polygon:unpack()

				table.insert(save, self.Collider:addPolygon(x20, y20, x21, y21, x11, y11, x10, y10))
				table.insert(save, self.Collider:addPolygon(x40, y40, x41, y41, x31, y31, x30, y30))
				break
			end
			k = k + 1
		end
		p = p + 1
	end
	pretty.dump(save)
	return save
end

function Doors:update()
	self.mouse:moveTo(love.mouse.getPosition())
	-- local k = 1
	-- while k < table.getn(self.majorgrids) + 1 do
	-- 	if k + self.size * self.size < table.getn(self.majorgrids) + 1 then
	-- 	k = k + 1
	-- end
-- end
	self.todraw = self:get_collision()

	if love.mouse.isDown("l") then
		self.mode = "major"
	end
	if love.mouse.isDown("r") then
		self.mode = "minor"
	end
end

function Doors:draw()
	if self.mode == 'major' then
		for k,v in pairs(self.majorgrids) do
			for key,value in pairs(v) do
				value:draw()
			end
		end
	else
		for k,v in pairs(self.minorgrids) do
			print(v)
			love.graphics.draw('line', v:unpack())
		end
	end
	for k,v in pairs(self.todraw) do
		v:draw("fill")
	end
end

return (Doors)
