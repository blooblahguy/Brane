require('lib.camera')
require('player')

-- Runs first
function love.load()
	window = {}
	window.height = love.graphics.getHeight()
	window.width = love.graphics.getWidth()
end

-- Runs second
function love.update(elapsed) -- elapsed = time since last frame update
	require('lib.lurker').update()
end

-- Runs third
function love.draw()
	camera:set()

	-- ground
	love.graphics.setColor(139, 69, 19, 255)
    love.graphics.rectangle("fill", 0, window.height - 100, window.width, 100)

	-- sky
	love.graphics.setColor(0, 255 * 0.6, 255 *.9, 255)
    love.graphics.rectangle("fill", 0, 0, window.width, window.height - 100)


	camera:unset()
end
-- Display happens