io.stdout:setvbuf("no")
require("character")
require("npcs")

function love.load()
	listOfRectangles = {}
	for i=1, 3 do
		createNPC(listOfRectangles)

	end
	createCharacter()
end


-- Store characters old position at all times
-- Make a movement
-- If movement would collide, bring them back to old position?

function love.update(dt)

	characterMovement(dt)

	if love.keyboard.isDown("escape") then
		love.event.quit()
	end
end

function love.draw()
	local mode
	mode = "line"
	love.graphics.rectangle(mode, character.x, character.y, character.width, character.height)

	for i,v in ipairs(listOfRectangles) do
		print("Drawing " .. i)
		if checkCollision(character, v) then
			mode = "fill"
		else
			mode = "line"
		end
		love.graphics.rectangle(mode, v.x, v.y, v.width, v.height)
	end
end

function checkCharacterCollisions()
	for i,v in ipairs(listOfRectangles) do
		if checkCollision(character, v) then
			print(i .. " is colliding")
			return true
		else
			print(i .. " not colliding!")

			return false
		end
	end
end

function characterMovement(dt)
	if love.keyboard.isDown("right") and character.x < love.graphics.getWidth() - character.width then
		previousX = character.x
		character.x = character.x + 200 * dt
		for i,v in ipairs(listOfRectangles) do
			if checkCollision(character, v) then
				character.x = previousX
			end
		end
	elseif love.keyboard.isDown("left")  and character.x > 0 then
		previousX = character.x
		character.x = character.x - 200 * dt
		for i,v in ipairs(listOfRectangles) do
			if checkCollision(character, v) then
				character.x = previousX
			end
		end
	elseif love.keyboard.isDown("up") and character.y > 0  then
		previousY = character.y
		character.y = character.y - 200 * dt
		for i,v in ipairs(listOfRectangles) do
			if checkCollision(character, v) then
				character.y = previousY
			end
		end
	elseif love.keyboard.isDown("down") and character.y < love.graphics.getHeight() - character.height then
		previousY = character.y
		character.y = character.y + 200 * dt
		for i,v in ipairs(listOfRectangles) do
			if checkCollision(character, v) then
				character.y = previousY
			end
		end
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


