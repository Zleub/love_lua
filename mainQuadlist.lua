function data_print(data)
	love.graphics.print(data, 0, i)
	i = i + 11
end

function load_tilesets(data)
	table.insert(images, love.graphics.newImage(data.image))
end

function print_images(data)
	love.graphics.draw(data)
end

function love.load()
	love.graphics.print("loading")
	pretty = require 'pl.pretty'
	tablex = require 'pl.tablex'

	map = require 'pokemap2'
	tilesets = map.tilesets
	layers = map.layers

	-- images = {}
	-- tablex.foreach(map.tilesets, load_tilesets)
	Quadlist_mod = require 'Quadlist'
	Quadtileset = Quadlist:new(tilesets[1])

end

function draw_map(layer)
	local i
	local j
	local k

	local m = 0
	local n = 0

	k = 1
	j = 0
	while j < layer.height do
		i = 1
		m = 0
		while i <= layer.width do
			love.graphics.draw(Quadtileset[0], Quadtileset[ layer.data[k] ], m, n)
			m = m + 16
			i = i + 1
			k = k + 1
		end
		n = n + 16
		j = j + 1
	end
end

function love.draw()
	-- tablex.foreach(images, print_images)

	-- love.graphics.print( pretty.write(images, '  ', 1) )
	draw_map(layers[1])
end
