function love.load()
	Collider = require "hardoncollider"
	HC = Collider.new(16)

	gravityRate = 100

	Elements = {}
	Elements.floor = HC:addRectangle(-10, 500, 620, 110)
	Elements.mouse = HC:addCircle(love.window.getWidth() / 2, love.window.getHeight() / 2, 10)
	table.insert(Elements, HC:addRectangle(100, 100, 100, 300))


	Elements[1]:rotate(45)
end

function love.update(dt)
	-- gravity stuff
	i = 1
	while i < table.getn(Elements) + 1 do
		print(Elements[i]:rotation())
		if Elements[i]:collidesWith(Elements.floor) and Elements[i]:rotation() % 90 ~= 0 then
			Elements[i]:rotate(dt)
		else
			Elements[i]:move(0, dt * gravityRate)
		end
		i = i + 1
	end

	Elements.mouse:moveTo(love.mouse.getPosition())
	if (Elements.mouse:collidesWith(Elements[1])) then
		-- Elements[1]:move
		print("delamderd")
	end
end

function love.draw()
	for k,v in pairs(Elements) do
		v:draw()
	end
end
