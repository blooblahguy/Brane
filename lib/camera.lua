camera = {}
camera.x = 0
camera.y = 0
camera.scaleX = 1
camera.scaleY = 1
camera.rotation = 0
camera.dragging = false
camera.dragging_x = 0
camera.dragging_y = 0

function camera:set()
	if (self.dragging) then
		--print(love.mouse.getPosition())
		local mx, my = love.mouse.getPosition()

		self.x = self.x + (camera.dragging_x - mx)
		self.y = self.y + (camera.dragging_y - my)
		camera.dragging_x = mx
		camera.dragging_y = my
		--camera:setPosition(love.mouse.getPosition())
	end

	love.graphics.push()
	love.graphics.rotate(-self.rotation)
	love.graphics.scale(1 / self.scaleX, 1 / self.scaleY)
	love.graphics.translate(-self.x, -self.y)
end

function camera:unset()
	love.graphics.pop()
end

function camera:move(dx, dy)
	self.x = self.x + (dx or 0)
	self.y = self.y + (dy or 0)
end

function camera:rotate(dr)
	self.rotation = self.rotation + dr
end

function camera:scale(sx)
	self.scaleX = self.scaleX + sx
	self.scaleY = self.scaleY + sx
end

function camera:setPosition(x, y)
	self.x = x or self.x
	self.y = y or self.y
end

function camera:setScale(sx, sy)
	self.scaleX = sx or self.scaleX
	self.scaleY = sy or self.scaleY

	camera:setPosition(love.mouse.getPosition())
end

-- mouse controls
function love.wheelmoved(x, y)
    if y > 0 then
        camera:scale(-.1)
    elseif y < 0 then
        camera:scale(.1)
    end
end

function love.mousereleased(x, y, button)
	if button == 2 then
		camera.dragging_x = 0
		camera.dragging_y = 0
		camera.dragging = false
	end
end
function love.mousepressed(x, y, button)
	if button == 2 then
		camera.dragging_x = x
		camera.dragging_y = y
		camera.dragging = true
	end
end