Quadlist = {}

function Quadlist:new(tileset)
	local i = 1
	local j = 1
	local Quadlist = {}

	Quadlist[0] = love.graphics.newImage(tileset.image)
	while j < tileset.imageheight do
		i = 1
		while i < tileset.imagewidth do
			table.insert(Quadlist,
				love.graphics.newQuad(i, j, 16, 16,
					tileset.imagewidth, tileset.imageheight))
			i = i + 16
		end
		j = j + 16
	end

	return Quadlist
end

return Quadlist
