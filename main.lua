function love.load()
   lg = love.graphics
   li = love.image
   lf = love.filesystem
   w,h = lg.getWidth(),lg.getHeight()

   transitions = lf.getDirectoryItems('transitions')

   transIndex = 1
   transition = lg.newImage('transitions/' .. transitions[transIndex])

   image = lg.newImage('test.jpg')

   effect = lg.newShader [[
      extern Image trans;
      extern number time;
      extern number duration;
      vec4 effect(vec4 color,Image tex,vec2 tc,vec2 pc)
      {
         vec4 img_color = Texel(tex,tc);
         vec4 trans_color = Texel(trans,tc);
         number white_level   = (trans_color.r + trans_color.b + trans_color.b)/3;
         number max_white   = time/duration;

         if (white_level <= max_white)
         {
            return img_color;
         }

         img_color.a = 0;
         return img_color;
      }
   ]]

   t = 0
   duration = 1
   effect:send("duration",duration)
   effect:send("trans",transition)

   canvas = lg.newCanvas(lg.getWidth(),lg.getHeight())
   canvas:renderTo(function() lg.draw(image) end)
end
function love.update(dt)
   t = t + dt
   effect:send("time",t)
end

function love.keypressed(key)
   if key == 'r' then
      t = 0
   end

   if key == 'left' or key == 'right' then
      if key == 'left' then
         if transIndex >=2 then
            transIndex = transIndex - 1
         end
      elseif key == 'right' then
         if transIndex <= #transitions-1 then
            transIndex = transIndex + 1
         end
      end
      transition = lg.newImage('transitions/' .. transitions[transIndex])
      effect:send("trans",transition)
      t = 0
   end
end

function love.draw()
   lg.setShader(effect)
   lg.draw(image)
   lg.setShader()
   lg.print(love.timer.getFPS(),lg.getWidth()-30,10)
   lg.print(transitions[transIndex],10,10)
end
