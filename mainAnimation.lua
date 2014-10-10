function spriteup(sprite_nbr, pixel_row)
	local Quadlist = {}
	local i = 0

	while i ~= sprite_nbr do
		table.insert(
			Quadlist,
			love.graphics.newQuad(
				0 + i * sprite_width,
				pixel_row,
				sprite_width,
				sprite_height,
				sprite_file:getDimensions()
			)
		)
		i = i + 1
	end
	return Quadlist
end

function love.load()
	sprite_timer = 5 -- in seconds
	sprite_nbr = 4 -- sprite in 1 animation
	sprite_file = love.graphics.newImage("images/firetest.png")
	sprite_width = 128
	sprite_height = 80

	Quadlist = spriteup(16, 0)
	monster = spriteup(1, 80)
	index = 1
	sprite = Quadlist[index]

	timing = 1
	animate = 0
	rate = 1
end

function mappin()
	if love.keyboard.isDown("left") then
		if index ~= 8 then
			index = 8
		else
			animate = 1
		end
	end

	if love.keyboard.isDown("right") then
		if index ~= 11 then
			index = 11
		else
			animate = 1
		end
	end

	if love.keyboard.isDown("up") then
		if index ~= 2 then
			index = 2
		else
			animate = 1
		end
	end

	if love.keyboard.isDown("down") then
		if index ~= 5 then
			index = 5
		else
			animate = 1
		end
	end
end

function love.update(dt)
	-- local duration = sprite_timer / 4

	-- if animate == 0 then
	-- 	mappin()
	-- 	sprite = Quadlist[index]
	-- else
	-- 	if timing < sprite_timer then
	-- 		if timing > 0 and timing < duration then
	-- 			sprite = Quadlist[index]
	-- 		end
	-- 		if timing > duration and timing < duration * 2 then
	-- 			sprite = Quadlist[index + 1]
	-- 		end
	-- 		if timing > duration * 2 and timing < duration * 3 then
	-- 			sprite = Quadlist[index - 1]
	-- 		end
	-- 		if timing > duration * 3 and timing < sprite_timer then
	-- 			sprite = Quadlist[index]
	-- 		end

	-- 		timing = timing + dt * rate
	-- 	else
	-- 		animate = 0
	-- 		timing = 0
	-- 	end
	-- end
	timing = timing + dt * 10
	print(timing)
	if timing > 16 + 1 then
		timing = 1
	end
	sprite = Quadlist[math.floor(timing)]
end

function love.draw()
	local x = 0
	local y = 0

	love.graphics.draw(
		sprite_file,
		sprite,
		x,
		y
	)
	love.graphics.draw(
		sprite_file,
		monster[1],
		x,
		y
	)

end
