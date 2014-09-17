HC = require 'hardoncollider'
Collider = HC(16)
pretty = require 'pl.pretty'

Doors = {}

function new_grid(size, pix_size_x, pix_size_y)
	local grid = {}

	for i = 1, size * size do

		table.insert(grid, Collider:addPolygon(100,100, 50,200, 300,100))
	end
	return grid
end

function build_major(size)
	local grids = {}
	for i = 0, size do
		if i == 0 then
			table.insert(grids, new_grid(size, love.window.getDimensions()))
		-- else
		-- 	table.insert(grids, "new grids of polygon from decremented window size")
		end
	end
	return grids
end

function Doors:new(size)
	self.size = size
	self.mode = 'major'
	self.majorgrids = build_major(size)
	self.minorgrids = {}
	print("new end")
	pretty.dump(self.majorgrids)
end

function Doors:update()
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
	-- else
	-- 	for k,v in pairs(self.minorgrids) do
	-- 		print(v)
	-- 		love.graphics.draw('line', v:unpack())
	-- 	end
	end
end

return (Doors)
