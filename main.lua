pretty = require 'pl.pretty'

function love.load()
	heros = {
		love.graphics.newImage("images/Hero3.png"),
		love.graphics.newImage("images/Hero1.png"),
		love.graphics.newImage("images/Hero2.png"),
		love.graphics.newImage("images/Hero3.png"),
		love.graphics.newImage("images/Hero1.png")
	}

	index = 3
   transition_left = love.graphics.newImage('transitions/Untitled_left.png')
 transition_right = love.graphics.newImage('transitions/Untitled_right.png')

	effect = love.graphics.newShader [[
      extern Image trans;
      extern number max_w;
      vec4 effect(vec4 color,Image tex,vec2 tc,vec2 pc)
      {
         vec4 img_color = Texel(tex,tc);
         vec4 trans_color = Texel(trans,tc);
         number white_level   = (trans_color.r + trans_color.g + trans_color.b)/3;
         number max_white   = max_w;

         if (white_level <= max_white)
         {
            return img_color;
         }

         img_color.a = 0;
         return img_color;
      }
   ]]

   effect:send("trans", transition_left)
   effect:send("max_w", 1)

   x = heros[index]:getDimensions()
   y = 0
   t = 0

   rate = 3
end

function love.update(dt)
	t = t + dt
	h_width, h_height = heros[index]:getDimensions()
	w_width, w_height = love.window.getDimensions()


	if x < h_width then
		x = x + dt * 100 * rate
		if x > h_width then
			x = h_width
		end
	elseif x > h_width then
		x = x - dt * 100 * rate
		if x < h_width then
			x = h_width
		end
	else
		animate = 0
	end

	effect:send("max_w", t * rate)
end

function love.keypressed(key)
	if key == 'r' then
		x = heros[index]:getDimensions()
		y = 0
		t = 0
	end

	if key == 'right' then
		index = index - 1
		if index < 2 then
			index = 4
		end
		t = 0
		x = h_width  * 2
		y = 0
		animate = 1
		effect:send("trans", transition_right)
	elseif key == 'left' then
		index = index + 1
		if index > 4 then
			index = 2
		end
		t = 0
		x = 0
		y = 0
		animate = 1
		effect:send("trans", transition_left)
		end

end

function love.draw()
	if animate == 1 then
		love.graphics.setShader(effect)
		love.graphics.draw(heros[index], x, y)
		love.graphics.setShader()
	else
		love.graphics.draw(heros[index], x, y)
	end
end
