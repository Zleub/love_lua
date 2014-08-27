function love.load()
	debug = 1

	animation = {}
	animation[1] = love.graphics.newImage("anim-test/01.png")
	animation[2] = love.graphics.newImage("anim-test/02.png")
	animation[3] = love.graphics.newImage("anim-test/03.png")
	animation[4] = love.graphics.newImage("anim-test/04.png")
	animation[5] = love.graphics.newImage("anim-test/05.png")
	animation[6] = love.graphics.newImage("anim-test/06.png")

	image_dimension = 16

	image_width, image_heigth = animation[1]:getDimensions()
	if (image_dimension ~= image_width) then
		image_dimension = image_width
	end
	if (image_dimension ~= image_heigth) then
		image_dimension = image_heigth
	end

	HC = require 'hardoncollider'
	Collider = HC(16, collision_stop, on_collision)

	player_radius = 16 / 2
	player_start_x = love.window.getWidth() / 2 - player_radius / 2
	player_start_y = love.window.getHeight() / 2 - player_radius / 2

	shape_player = Collider:addCircle(player_start_x, player_start_y, player_radius)

	shape_monster = Collider:addCircle(0, 0, player_radius)

	shape_map = Collider:addCircle(love.window.getWidth() / 2, love.window.getHeight() / 2, love.window.getWidth() / 2 - player_radius * 2)
	shape_circle = Collider:addCircle(love.window.getWidth() / 2, love.window.getHeight() / 2, love.window.getHeight() / 2)

	frame_nbr = 1
	time = 0
	rate = 3

	mana = 25
	dash = 0

	mouse = Collider:addRectangle(200,200, 20, 20)
	mouse:moveTo(love.mouse.getPosition())
end

function collision_stop(dt, shape_a, shape_b, mtv_x, mtv_y)
end

function on_collision(dt, shape_a, shape_b)
end

function undashed_move(dt)
	if love.keyboard.isDown("left") then
		shape_player:move(-100 * dt, 0)
		if shape_player:collidesWith(shape_map) == false then
			shape_player:move(100 * dt, 0)
		end
		if shape_player:collidesWith(shape_monster) == true then
			shape_player:move(100 * dt, 0)
		end
		if shape_player:collidesWith(mouse) == true then
			shape_player:move(100 * dt, 0)
		end
	end

	if love.keyboard.isDown("right") then
		shape_player:move(100 * dt, 0)
		if shape_player:collidesWith(shape_map) == false then
			shape_player:move(-100 * dt, 0)
		end
		if shape_player:collidesWith(shape_monster) == true then
			shape_player:move(-100 * dt, 0)
		end
		if shape_player:collidesWith(mouse) == true then
			shape_player:move(-100 * dt, 0)
		end
	end

	if love.keyboard.isDown("up") then
		shape_player:move(0, -100 * dt)
		if shape_player:collidesWith(shape_map) == false then
			shape_player:move(0, 100 * dt)
		end
		if shape_player:collidesWith(shape_monster) == true then
			shape_player:move(0, 100 * dt)
		end
		if shape_player:collidesWith(mouse) == true then
			shape_player:move(-100 * dt, 0)
		end
	end

	if love.keyboard.isDown("down") then
		shape_player:move(0, 100 * dt)
		if shape_player:collidesWith(shape_map) == false then
			shape_player:move(0, -100 * dt)
		end
		if shape_player:collidesWith(shape_monster) == true then
			shape_player:move(0, -100 * dt)
		end
		if shape_player:collidesWith(mouse) == true then
			shape_player:move(-100 * dt, 0)
		end
	end
end

function dashed_move(dt)
	if love.keyboard.isDown("left") then
		shape_player:move(-750 * dt, 0)
		mana = mana - 1
		if shape_player:collidesWith(shape_map) == false then
			shape_player:move(650 * dt, 0)
			if shape_player:collidesWith(shape_map) == false then
				shape_player:move(100 * dt, 0)
			end
		end
	end

	if love.keyboard.isDown("right") then
		shape_player:move(750 * dt, 0)
		mana = mana - 1
		if shape_player:collidesWith(shape_map) == false then
			shape_player:move(-650 * dt, 0)
			if shape_player:collidesWith(shape_map) == false then
				shape_player:move(-100 * dt, 0)
			end
		end
	end

	if love.keyboard.isDown("up") then
		shape_player:move(0, -750 * dt)
		mana = mana - 1
		if shape_player:collidesWith(shape_map) == false then
			shape_player:move(0, 650 * dt)
			if shape_player:collidesWith(shape_map) == false then
				shape_player:move(0, 100 * dt)
			end
		end
	end

	if love.keyboard.isDown("down") then
		shape_player:move(0, 750 * dt)
		mana = mana - 1
		if shape_player:collidesWith(shape_map) == false then
			shape_player:move(0, -650 * dt)
			if shape_player:collidesWith(shape_map) == false then
				shape_player:move(0, -100 * dt)
			end
		end
	end
end

function traditional_mapping(dt)
	if love.keyboard.isDown("q") and mana > 0 then
		dash = 1
	else
		dash = 0
	end

	if dash == 0 then
		undashed_move(dt)
	else
		dashed_move(dt)
	end
end

function monster_move(dt, x_diff, y_diff)
	test1 = x_diff
	test2 = y_diff

	if math.abs(x_diff) > math.abs(y_diff) then
		if x_diff > 0 then
			shape_monster:move(200 * dt, 0)
		else
			shape_monster:move(-200 * dt, 0)
		end
	else
		if y_diff > 0 then
			shape_monster:move(0, 200 * dt)
		else
			shape_monster:move(0, -200 * dt)
		end
	end
end

function love.update(dt)
	mouse:moveTo(love.mouse.getPosition())

	shape_player_center_x, shape_player_center_y = shape_player:center()
	shape_monster_center_x, shape_monster_center_y = shape_monster:center()

	if shape_monster:collidesWith(shape_player) == false then
		monster_move(dt, shape_player_center_x - shape_monster_center_x, shape_player_center_y - shape_monster_center_y)
	end

	traditional_mapping(dt)

	time = time + dt

	frame_nbr = frame_nbr + (dt * rate)
	if frame_nbr > 7 then
		frame_nbr = 1
	end

	width, height = animation[math.floor(frame_nbr)]:getDimensions()

	if dash == 0 and mana < 100 then
		mana = mana + (dt * 6)
	end
end

function love.draw()
	if debug == 1 then
		shape_map:draw('line')
		shape_circle:draw('line')
		love.graphics.setColor(255,0,0)
		shape_player:draw('fill')
		love.graphics.setColor(255, 255, 255)

		love.graphics.print("time: "..time, 0, 0)
		love.graphics.print("math.floor(frame_nbr): "..math.floor(frame_nbr), 0, 11)
		love.graphics.print("shape_player_center_x: "..shape_player_center_x, 0, 22)
		love.graphics.print("shape_player_center_y: "..shape_player_center_y, 0, 33)
		love.graphics.print("shape_monster_center_x: "..shape_monster_center_x, 0, 44)
		love.graphics.print("shape_monster_center_y: "..shape_monster_center_y, 0, 55)
		love.graphics.print("width: "..width, 0, 66)
		love.graphics.print("height: "..height, 0, 77)
		love.graphics.print("mouse_x: "..love.mouse.getX(), 0, 88)
		love.graphics.print("mouse_y: "..love.mouse.getY(), 0, 99)
		love.graphics.print("image_dimension: "..image_dimension, 0, 110)
	end

	shape_player_center_x, shape_player_center_y = shape_player:center()
	shape_monster_center_x, shape_monster_center_y = shape_monster:center()

	mouse:draw("line")
	love.graphics.draw(animation[math.floor(frame_nbr)], shape_player_center_x - (width / 2), shape_player_center_y - (height / 2))
	shape_monster:draw()
	love.graphics.print("mana: "..math.floor(mana), love.window.getWidth() - 100, 0)
end
