Entities = {}

function Entities:new(name)
	Entities[name] = {
		name = name,
		frames = {},
		frames_nbr = 1,
		frames_cnt = 1,
		frames_height = 0,
		frames_width = 0,
		radius = 0,
		shape_center_x = 0,
		shape_center_y = 0,
	}

	files = love.filesystem.getDirectoryItems("animation/"..name)
	count = tablex.size(files)

	i = 1
	while i < count + 1 do
		local file = "animation/"..name.."/"..files[i]
		if love.filesystem.isFile(file) then
			table.insert(Entities[name].frames, love.graphics.newImage(file))
			Entities[name].frames_nbr = Entities[name].frames_nbr + 1
		end
		i = i + 1
	end

	if Entities[name].frames[1] ~= nil then
		Entities[name].frames_width, Entities[name].frames_height = Entities[name].frames[1]:getDimensions()
		Entities[name].radius = Entities[name].frames_width / 2
	else
		print("Beware, "..name.." doesn't have some frames")
	end
end

function Entities:update(dt)
	for key, Entity in pairs(Entities) do
		if type(Entity) == "table" then
			-- Update frames_cnt
			Entity.frames_cnt = Entity.frames_cnt + (dt * frame_rate)
			if Entity.frames_cnt > Entity.frames_nbr then
				Entity.frames_cnt = 1
			end
			-- Update shape_center
			Entity.shape_center_x, Entity.shape_center_y = Entity.shape:center()
		end
	end
end

return Entities
