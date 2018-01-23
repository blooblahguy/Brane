player = player or CreateObject("object", "Player", UIParent)

function player:update()

	player:SetSize(20, 12)
	player:SetColor(255,255,255, 50)
	player:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 20, 20)

	player.body = player.body or CreateObject("frame", nil, player)
	player.body:SetColor(255,180, 50)
	player.body:SetSize(18, 8)
	player.body:SetPoint("TOP", player, "TOP", 0, 4)

	player.neck = player.neck or CreateObject('frame', nil, player)
	player.neck:SetSize(14, 4)
	player.neck:SetColor(240,240,230)
	player.neck:SetPoint("BOTTOM", player.body, "TOP", 0, 2)

	player.head = player.head or CreateObject("frame", nil, player)
	player.head:SetColor(255,255,230)
	player.head:SetSize(20, 11)
	player.head:SetPoint("BOTTOM", player.body, "TOP")

	player.eye_1 = player.eye_1 or CreateObject("frame", nil, player.head)
	player.eye_1:SetColor(120, 60, 10)
	player.eye_1:SetSize(3, 2)
	player.eye_1:SetPoint("BOTTOMLEFT", player.head, "BOTTOMLEFT", 4, 0)

	player.eye_2 = player.eye_2 or CreateObject("frame", nil, player.head)
	player.eye_2:SetColor(120, 60, 10)
	player.eye_2:SetSize(3, 2)
	player.eye_2:SetPoint("BOTTOMRIGHT", player.head, "BOTTOMRIGHT", -4, 0)

	player.hair = player.hair or CreateObject('frame', nil, player.head)
	player.hair:SetSize(20, 8)
	player.hair:SetColor(150, 80, 10)
	player.hair:SetPoint("TOP", player.head, "TOP")

	player.left_leg = player.left_leg or CreateObject('frame', nil, player)
	player.left_leg:SetColor(150, 80, 10)
	player.left_leg:SetSize(8, 3)
	player.left_leg:SetPoint("TOPLEFT", player.body, "BOTTOMLEFT", 0, 0)

	player.right_leg = player.right_leg or CreateObject('frame', nil, player)
	player.right_leg:SetColor(150, 80, 10)
	player.right_leg:SetSize(8, 3)
	player.right_leg:SetPoint("TOPRIGHT", player.body, "BOTTOMRIGHT", 0, 0)

	player.left_arm = player.left_arm or CreateObject('frame', nil, player)
	player.left_arm:SetColor(255,255,230)
	player.left_arm:SetSize(3, 6)
	player.left_arm:SetPoint("TOPRIGHT", player.body, "TOPLEFT", 1, 1)

	player.right_arm = player.right_arm or CreateObject('frame', nil, player)
	player.right_arm:SetColor(255,255,230)
	player.right_arm:SetSize(3, 6)
	player.right_arm:SetPoint("TOPLEFT", player.body, "TOPRIGHT", -1, 1)


	-- head
	-- love.graphics.setColor(255, 255, 255)
	-- love.graphics.rectangle("fill", 20, 20, 20*player.scale, 24*player.scale, 30*player.scale, 30*player.scale)

	-- -- hair
	-- love.graphics.setColor(205, 150, 50)
	-- love.graphics.rectangle("fill", 20, 20, 20*player.scale, 10*player.scale, 5*player.scale, 5*player.scale)
end

return player