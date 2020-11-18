require("character")
require("npcs")

function love.load()
	listOfRectangles = {}
	for i=1, 3 do
		createNPC(listOfRectangles)

	end
	createCharacter()
end


function love.update(dt)
	-- print(character.x)


	if love.keyboard.isDown("right") and character.x < love.graphics.getWidth() - character.width then
		character.x = character.x + 200 * dt
	elseif love.keyboard.isDown("left")  and character.x > 0 then
		character.x = character.x - 200 * dt	
	elseif love.keyboard.isDown("up") and character.y > 0 then
		character.y = character.y - 200 * dt	
	elseif love.keyboard.isDown("down") and character.y < love.graphics.getHeight() - character.height then
		character.y = character.y + 200 * dt
	end



	if love.keyboard.isDown("escape") then
		love.event.quit()
	end
end

function love.draw()
	local mode
	mode = "line"
	love.graphics.rectangle(mode, character.x, character.y, character.width, character.height)

	for i,v in ipairs(listOfRectangles) do
		if checkCollision(character, v) then
			mode = "fill"
		else
			mode = "line"
		end
		love.graphics.rectangle(mode, v.x, v.y, v.width, v.height)
	end
end


function checkCollision(a, b)
	local a_left = a.x
	local a_right = a.x + a.width
	local a_top = a.y
	local a_bottom = a.y + a.height
	
	local b_left = b.x
	local b_right = b.x + b.width
	local b_top = b.y
	local b_bottom = b.y + b.height

	if a_right > b_left and
	a_left < b_right and
	a_bottom > b_top and
	a_top < b_bottom then
		return true
	else
		return false
	end
end