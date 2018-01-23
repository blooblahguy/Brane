keyboard = {}

keyboard.binds = {}
keyboard.bindsHolds = {}

function keyboard:update()
	keyboard.press = {}
	for key, fn in pairs(keyboard.binds) do

	end
end


function keyboard.bindHold(key, fn)
	if (love.keyboard.isDown(key)) then
		if (fn) then
			fn()
		else
			return true
		end
	end 
end 
function keyboard.bind(key, fn, direction)
	if not direction then direction = "down" end

	if (love.keyboard.isDown(key) and not keyboard.press[key]) then
		-- can run this function once here
		keyboard.press[key] = true
		if (direction == "down") then
			if (fn) then
				fn()
			else
				return true
			end
		end
	elseif (not love.keyboard.isDown(key)) then
		if (keyboard.press[key] and direction == "up") then
			if (fn) then
				fn()
			else
				return true
			end
		end
		keyboard.press[key] = nil
	end
end