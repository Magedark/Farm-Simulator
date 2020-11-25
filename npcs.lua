function createNPC()
	npc = {}
	npc.width = 70
	npc.height = 90
	npc.speed = 100
	npc.x = love.math.random(0, love.graphics.getWidth() - npc.width) 
	npc.y = love.math.random(0, love.graphics.getHeight() - npc.height)
	return npc
end