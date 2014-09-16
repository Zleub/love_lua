Doors = {}
Doors.size
Doors.mode

Doors.majorgrids
Doors.minorgrids

function Doors.update(dt)
	if love.mouse.isDown("l") then
		Doors.mode = "major"
	end
	if love.mouse.isDown("r") then
		Doors.mode = "minor"
	end
end

function Doors.draw()
	if mode == 'major' then
		for k,v in pairs(Doors.majorgrids) do
			love.graphics.draw('line', v:unpack())
		end
	else
		for k,v in pairs(Doors.minorgrids) do
			love.graphics.draw('line', v:unpack())
		end
	end
end

return (Doors)
