pretty = require 'pl.pretty'

function Quadlist(tileset)
	local i = 0
	local j = 0
	local Quadlist = {}

	Quadlist[0] = love.graphics.newImage(tileset.image)
	while j < tileset.imageheight do
		i = 0
		while i < tileset.imagewidth do
			table.insert(Quadlist,
				love.graphics.newQuad(i, j, tileset.tilewidth, tileset.tileheight,
					tileset.imagewidth, tileset.imageheight))
			i = i + tileset.tilewidth
		end
		j = j + tileset.tileheight
	end

	return Quadlist
end

function draw_isolayer(quads, map)
	local i
	local j
	local k

	local m
	local n

	k = 1
	j = 0
	while j < map.layer.height do
		i = 1
		m = love.window.getWidth() / 2 - (map.tilesets[1].tilewidth / 2) * (j + 1)
		n = 0 + (map.tilesets[1].tileheight / 2) * (j + 1)

		while i <= map.layer.width do
			if map.layer.data[k] ~= 0 then
				-- love.graphics.draw(quads[0], quads[ map.layer.data[k] ], m, n, 0)
				love.graphics.draw(quads[0], quads[ 1 ], m, n, 0)
				love.graphics.draw(quads[0], quads[ 2 ], m, n, 0)
				love.graphics.draw(quads[0], quads[ 3 ], m, n, 0)
				love.graphics.draw(quads[0], quads[ 4 ], m, n, 0)
			end
			m = m + map.tilesets[1].tilewidth / 2
			n = n + map.tilesets[1].tileheight / 2
			i = i + 1
			k = k + 1
		end
		j = j + 1
	end
end

function love.load()

	map = {
		tilesets = {
			{
				image = 'images/tilemath/test1.png',
				tilewidth = 128,
				tileheight = 64,
				imagewidth = 512,
				imageheight = 256
			}
		},
		layer = {
			width = 5,
			height = 5,
			data = {
				2, 2, 2, 2, 2,
				2, 2, 2, 2, 2,
				2, 2, 2, 2, 2,
				2, 2, 2, 2, 2,
				2, 2, 2, 2, 2
			}
		}
	}

	quads = Quadlist(map.tilesets[1])
end

function love.update(dt)
end

function love.draw()
	-- quads[0]:setFilter('nearest')

	love.graphics.rectangle("fill", 0, 0, love.window.getWidth(), love.window.getHeight())
	draw_isolayer(quads, map)
end
