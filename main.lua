

local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
-- encoding
function base64enc(data)
    return ((data:gsub('.', function(x) 
        local r,b='',x:byte()
        for i=8,1,-1 do r=r..(b%2^i-b%2^(i-1)>0 and '1' or '0') end
        return r;
    end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
        if (#x < 6) then return '' end
        local c=0
        for i=1,6 do c=c+(x:sub(i,i)=='1' and 2^(6-i) or 0) end
        return b:sub(c+1,c+1)
    end)..({ '', '==', '=' })[#data%3+1])
end

-- decoding
function base64dec(data)
    data = string.gsub(data, '[^'..b..'=]', '')
    return (data:gsub('.', function(x)
        if (x == '=') then return '' end
        local r,f='',(b:find(x)-1)
        for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end
        return r;
    end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
        if (#x ~= 8) then return '' end
        local c=0
        for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(7-i) or 0) end
        return string.char(c)
    end))
end

g = {}
g.frames = {}
g.frames['BACKGROUND'] = {}
g.frames['LOW'] = {}
g.frames['NORMAL'] = {}
g.frames['HIGH'] = {}
g.frames['UI'] = {}

UIParent = {}
UIParent.attr = {}
UIParent.attr.name = "UIParent"

require('lib.camera')
Input = Input or require('lib.input')
objects = {}

-- textures[layer] {}
function CreateObject(type, name, parent)
	local frame = {}

	if (not name) then
		name = "TABLE: "..base64enc(love.timer.getTime()..love.math.random(0, 1000))
	end

	function frame:SetSize(w, h)
		self.attr.height = h
		self.attr.width = w
	end
	
	function frame:SetColor(r, g, b, a)
		a = a ~= nil and a or 255
		self.attr.colors = {r, g, b, a}
	end
	function frame:SetPoint(sp, a, ap, x, y)
		if (not a and not _G[a]) then
			print("anchor "..a.attr.name.." does not exist")
			return false
		end

		x = x or 0
		y = y or 0
		a = a or UIParent

		self.attr.selfPoint = sp
		self.attr.anchor = a
		self.attr.anchorPoint = ap
		self.attr.xOfs = x
		self.attr.yOfs = y
	end

	local attr = {}
	attr.parent = parent
	attr.frame_children = {}
	attr.texture_children = {}
	attr.font_children = {}
	attr.width = 0
	attr.height = 0
	attr.strata = "NORMAL"
	attr.level = 1
	attr.alpha = 1
	attr.hidden = 0
	attr.selfPoint = nil
	attr.anchor = UIParent
	attr.anchorPoint = nil
	attr.xOfs = 0
	attr.yOfs = 0
	attr.name = name
	attr.colors = {}

	frame.attr = attr

	frame.placed = {}

	if (name ~= "UIParent") then
		table.insert(g.frames[attr.strata], frame)
	end
	_G[name] = frame
	return frame
end
function CreateTexture(name, strata)
	local texture = {}
	function texture:SetTexture()

	end

	function texture:SetShape()
		
	end

	function texture:SetPoint()
		
	end

	texture.attr = {}
	texture.attr.type = "rectangle" -- polygon | circle | rectangle | triangle
	texture.attr.fill = "fill" -- fill | line
	
end

player = require('player')

-- Runs first
function love.load()
	window = {}
	window.height = love.graphics.getHeight()
	window.width = love.graphics.getWidth()

	player.ground = player.y
	player.y_velocity = 0
	player.jump_height = -300
	player.gravity = -500
	player.bonus_size = 0


	-- UIParent
	UIParent = CreateObject("frame", "UIParent", nil)

	
	input = Input()
	input:bind('s', function() print(2) end)
	input:bind('mouse1', 'left_click')
	--objects.ground = CreateObject()
end

-- Runs second
function love.update(dt) -- elapsed = time since last frame update
	require('lib.lurker').update()

	if input:pressed('left_click') then print('The left mouse button '..dt) end
	if input:released('left_click') then print('Not  left mouse button') end
	--if input:down('left_click') then print('The left mouse button is being held down!') end

	if (player.bonus_size <= 0) then
		player.bonus_size = 0
	else
		player.bonus_size = player.bonus_size - (player.speed * dt)
	end


	UIParent:SetSize(love.graphics.getWidth(), love.graphics.getHeight())
	

	test = test or CreateObject("frame", nil, UIParent)
	test:SetSize(150, 150)
	test:SetPoint("CENTER", UIParent, "CENTER", 0, 0)

	test2 = test2 or CreateObject("frame", nil, test)
	test2:SetSize(100,100)
	test2:SetPoint("CENTER", test, "TOPRIGHT", 0, 0)

	test3 = test3 or CreateObject("frame", nil, test2)
	test3:SetSize(50,50)
	test3:SetPoint("RIGHT", test, "LEFT", 0, 0)
	test3.attr.alpha = 0.5
	player:update()
end

-- Runs third
function love.draw()
	camera:set()


	-- Draw UIParent
	love.graphics.setColor(255, 255, 0, 25)
	love.graphics.rectangle("fill", 0, 0, UIParent.attr.width, UIParent.attr.height)

	for i, frame in ipairs(g.frames['NORMAL']) do
		local fx, fy = 0, 0

		if (frame.attr.hidden == 0 and frame.attr.anchor.attr.hidden == 0 and frame.attr.selfPoint) then

			-- X Axis Self
			if (frame.attr.selfPoint == "CENTER" or frame.attr.selfPoint == "TOP" or frame.attr.selfPoint == "BOTTOM") then
				fx = fx - (frame.attr.width / 2)
			elseif (string.find(frame.attr.selfPoint, "RIGHT")) then
				fx = fx - frame.attr.width
			end

			-- X Axis Anchor
			if (frame.attr.anchorPoint == "CENTER" or frame.attr.anchorPoint == "TOP" or frame.attr.anchorPoint == "BOTTOM") then
				fx = fx + (frame.attr.anchor.attr.width / 2)
			elseif (string.find(frame.attr.anchorPoint, "RIGHT")) then
				fx = fx + frame.attr.anchor.attr.width
			end
			-- + own x offset
			fx = fx + frame.attr.xOfs
			-- + anchor x offset
			fx = fx + (frame.attr.anchor.placed.fx or 0)

			-- Y Axis Self
			if (frame.attr.selfPoint == "CENTER" or frame.attr.selfPoint == "LEFT" or frame.attr.selfPoint == "RIGHT") then
				fy = fy - (frame.attr.height / 2)
			elseif (string.find(frame.attr.selfPoint, "BOTTOM")) then
				fy = fy - frame.attr.height
			end

			-- Y Axis Anchor
			if (frame.attr.anchorPoint == "CENTER" or frame.attr.anchorPoint == "LEFT" or frame.attr.anchorPoint == "RIGHT") then
				fy = fy + (frame.attr.anchor.attr.height / 2)
			elseif (string.find(frame.attr.anchorPoint, "BOTTOM")) then
				fy = fy + frame.attr.anchor.attr.height
			end
			-- + own y offset
			fy = fy + frame.attr.yOfs
			-- + own anchor offset
			fy = fy + (frame.attr.anchor.placed.fy or 0)

			frame.placed.fy = fy
			frame.placed.fx = fx

			if (#frame.attr.colors > 2) then
				love.graphics.setColor(unpack(frame.attr.colors))
			else
				love.graphics.setColor(139 * i, 69 * i, 25 * i, 255 * frame.attr.alpha)
			end
			love.graphics.rectangle("fill", fx, fy, frame.attr.width, frame.attr.height)
		end
	end

	-- ground
	--love.graphics.setColor(139, 69, 19, 255)
    --love.graphics.rectangle("fill", 0, window.height - 100, window.width, 100)

	-- player
	--love.graphics.setColor(255, 0, 255, 255)
    --love.graphics.rectangle("fill", 0 + player.x, player.y, 20 + player.bonus_size, 20 + player.bonus_size)


	camera:unset()
end
-- Display happens