-- function love.load()
-- 	pretty = require 'pl.pretty'
-- 	tablex = require 'pl.tablex'

-- 	debug = 1

-- 	HC = require 'hardoncollider'
-- 	Collider = HC(16)

-- 	Entities = require 'entities'

-- 	Entities:new('player')
-- 	player = Entities.player
-- 	player.start_x = love.window.getWidth() / 2 - player.radius / 2
-- 	player.start_y = love.window.getHeight() / 2 - player.radius / 2
-- 	player.shape = Collider:addCircle(player.start_x, player.start_y, player.radius)

-- 	Entities:new('monster')
-- 	monster = Entities.monster
-- 	monster.shape = Collider:addCircle(0, 0, 8)

-- 	shape_map = Collider:addCircle(love.window.getWidth() / 2, love.window.getHeight() / 2, love.window.getWidth() / 2 - player.radius * 2)
-- 	shape_circle = Collider:addCircle(love.window.getWidth() / 2, love.window.getHeight() / 2, love.window.getHeight() / 2)

-- 	time = 0
-- 	frame_rate = 3
-- 	mana = 25
-- 	dash = 0
-- end

-- function undashed_move(dt)
-- 	if love.keyboard.isDown("left") then
-- 		player.shape:move(-100 * dt, 0)
-- 		if player.shape:collidesWith(shape_map) == false then
-- 			player.shape:move(100 * dt, 0)
-- 		end
-- 		if player.shape:collidesWith(monster.shape) == true then
-- 			player.shape:move(100 * dt, 0)
-- 		end
-- 	end

-- 	if love.keyboard.isDown("right") then
-- 		player.shape:move(100 * dt, 0)
-- 		if player.shape:collidesWith(shape_map) == false then
-- 			player.shape:move(-100 * dt, 0)
-- 		end
-- 		if player.shape:collidesWith(monster.shape) == true then
-- 			player.shape:move(-100 * dt, 0)
-- 		end
-- 	end

-- 	if love.keyboard.isDown("up") then
-- 		player.shape:move(0, -100 * dt)
-- 		if player.shape:collidesWith(shape_map) == false then
-- 			player.shape:move(0, 100 * dt)
-- 		end
-- 		if player.shape:collidesWith(monster.shape) == true then
-- 			player.shape:move(0, 100 * dt)
-- 		end
-- 	end

-- 	if love.keyboard.isDown("down") then
-- 		player.shape:move(0, 100 * dt)
-- 		if player.shape:collidesWith(shape_map) == false then
-- 			player.shape:move(0, -100 * dt)
-- 		end
-- 		if player.shape:collidesWith(monster.shape) == true then
-- 			player.shape:move(0, -100 * dt)
-- 		end
-- 	end
-- end

-- function dashed_move(dt)
-- 	if love.keyboard.isDown("left") then
-- 		player.shape:move(-750 * dt, 0)
-- 		mana = mana - 1
-- 		if player.shape:collidesWith(shape_map) == false then
-- 			player.shape:move(650 * dt, 0)
-- 			if player.shape:collidesWith(shape_map) == false then
-- 				player.shape:move(100 * dt, 0)
-- 			end
-- 		end
-- 	end

-- 	if love.keyboard.isDown("right") then
-- 		player.shape:move(750 * dt, 0)
-- 		mana = mana - 1
-- 		if player.shape:collidesWith(shape_map) == false then
-- 			player.shape:move(-650 * dt, 0)
-- 			if player.shape:collidesWith(shape_map) == false then
-- 				player.shape:move(-100 * dt, 0)
-- 			end
-- 		end
-- 	end

-- 	if love.keyboard.isDown("up") then
-- 		player.shape:move(0, -750 * dt)
-- 		mana = mana - 1
-- 		if player.shape:collidesWith(shape_map) == false then
-- 			player.shape:move(0, 650 * dt)
-- 			if player.shape:collidesWith(shape_map) == false then
-- 				player.shape:move(0, 100 * dt)
-- 			end
-- 		end
-- 	end

-- 	if love.keyboard.isDown("down") then
-- 		player.shape:move(0, 750 * dt)
-- 		mana = mana - 1
-- 		if player.shape:collidesWith(shape_map) == false then
-- 			player.shape:move(0, -650 * dt)
-- 			if player.shape:collidesWith(shape_map) == false then
-- 				player.shape:move(0, -100 * dt)
-- 			end
-- 		end
-- 	end
-- end

-- function traditional_mapping(dt)
-- 	if love.keyboard.isDown("q") and mana > 0 then
-- 		dash = 1
-- 	else
-- 		dash = 0
-- 	end

-- 	if dash == 0 then
-- 		undashed_move(dt)
-- 	else
-- 		dashed_move(dt)
-- 	end
-- end

-- function monster_move(dt, x_diff, y_diff)
-- 	x_diff = math.floor(x_diff / 10)
-- 	y_diff = math.floor(y_diff / 10)
-- 	test1 = x_diff
-- 	test2 = y_diff


-- 	if math.abs(x_diff) > math.abs(y_diff) then
-- 		if x_diff > 0 then
-- 			monster.shape:move(200 * dt, 0)
-- 		else
-- 			monster.shape:move(-200 * dt, 0)
-- 		end
-- 	elseif math.abs(x_diff) < math.abs(y_diff) then
-- 		if y_diff > 0 then
-- 			monster.shape:move(0, 200 * dt)
-- 		else
-- 			monster.shape:move(0, -200 * dt)
-- 		end
-- 	else
-- 		if x_diff > 0 and y_diff > 0 then
-- 			monster.shape:move(200 * dt, 200 * dt)
-- 		elseif x_diff > 0 and y_diff < 0 then
-- 			monster.shape:move(200 * dt, -200 * dt)
-- 		elseif x_diff < 0 and y_diff > 0 then
-- 			monster.shape:move(-200 * dt, 200 * dt)
-- 		elseif x_diff < 0 and y_diff < 0 then
-- 			monster.shape:move(-200 * dt, -200 * dt)
-- 		end
-- 	end
-- end

-- function love.update(dt)

-- 	if monster.shape:collidesWith(player.shape) == false then
-- 		monster_move(dt, player.shape_center_x - monster.shape_center_x, player.shape_center_y - monster.shape_center_y)
-- 	end

-- 	traditional_mapping(dt)

-- 	time = time + dt

-- 	Entities:update(dt)

-- 	if dash == 0 and mana < 100 then
-- 		mana = 100 -- mana + (dt * 6)
-- 	end
-- end

-- function love.draw()
-- 	if debug == 1 then
-- 		shape_map:draw('line')
-- 		shape_circle:draw('line')
-- 		love.graphics.setColor(255,0,0)
-- 		player.shape:draw('fill')
-- 		love.graphics.setColor(255, 255, 255)


-- 		love.graphics.print("time: "..time, 0, 0)
-- 		love.graphics.print("shape_player_center_x: "..player.shape_center_x, 0, 22)
-- 		love.graphics.print("shape_player_center_y: "..player.shape_center_y, 0, 33)
-- 		love.graphics.print("shape_monster_center_x: "..monster.shape_center_x, 0, 44)
-- 		love.graphics.print("shape_monster_center_y: "..monster.shape_center_y, 0, 55)

-- 		love.graphics.print("FPS: " .. love.timer.getFPS(), 0, 77)

-- 		-- love.graphics.print("test1: "..test1, 200, 200)
-- 		-- love.graphics.print("test2: "..test2, 220, 220)
-- 	end

-- 	love.graphics.draw( player.frames[ math.floor(player.frames_cnt) ], player.shape_center_x - (player.frames_width / 2), player.shape_center_y - (player.frames_height / 2))

-- 	monster.shape:draw()
-- 	love.graphics.print("mana: "..math.floor(mana), love.window.getWidth() - 100, 0)
-- end






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

	map = require 'pokemap'
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
			love.graphics.draw(Quadtileset[0], Quadtileset[layer.data[k] ], m, n)
			m = m + 15
			i = i + 1
			k = k + 1
		end
		n = n + 15
		j = j + 1
	end
end

function love.draw()
	-- tablex.foreach(images, print_images)

	-- love.graphics.print( pretty.write(images, '  ', 1) )
	draw_map(layers[1])
end