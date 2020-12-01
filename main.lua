io.stdout:setvbuf("no")
require("character")
require("npcs")
require("textbox")

function love.load()
	listOfRectangles = {}
	createCharacter()
	i = 1
	while i < 4 
		do
		newNPC = createNPC()
		if not checkCollision(character, newNPC) then
			if table.getn(listOfRectangles) > 1 then
				for x,y in ipairs(listOfRectangles) do
					if not checkCollision(newNPC, y) then
						table.insert(listOfRectangles, newNPC)
					end
				end
			else
				table.insert(listOfRectangles, newNPC)

			end

			i = i + 1
		else 
			print("Generated NPC collides with player!")
		end
	end
	createTextbox()
	createNameBox()
end


-- Store characters old position at all times
-- Make a movement
-- If movement would collide, bring them back to old position?

function love.update(dt)
 
 	if not textbox.active then
		characterMovement(dt)
 	end


	if love.keyboard.isDown("escape") then
		love.event.quit()
	end
end

function love.draw()
	drawCharactersAndNPCs()

	if (textbox.active) then
		love.graphics.setColor(textbox.colors.background)
	    love.graphics.rectangle('fill',
	        textbox.x, textbox.y,
	        textbox.width, textbox.height)

	    love.graphics.setColor(textbox.colors.text)
	    love.graphics.printf(textbox.text,
	        textbox.x, textbox.y,
	        textbox.width, 'left')

	    love.graphics.setColor(namebox.colors.background)
	    love.graphics.rectangle('fill',
	        namebox.x, namebox.y,
	        namebox.width, namebox.height)

	    love.graphics.setColor(namebox.colors.text)
	    love.graphics.printf(namebox.text,
	        namebox.x, namebox.y,
	        namebox.width, 'left')

	end
end

function drawCharactersAndNPCs()
	love.graphics.setColor(128,128,128)

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

function love.keypressed(key)
	if key == 'space' then
		for i,v in ipairs(listOfRectangles) do
			if checkIfNextTo(character, v) then
				textbox.active = not textbox.active
				textbox.text = "Hi, I am rectangle " .. i
				namebox.active = not namebox.active
				namebox.text = "Rectangle" .. i
				print("Hi, I am rectangle " .. i)
				return
			end
		end
	end
	if key == 'v' then
		textbox.active = not textbox.active
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

-- Function to see if character is next to a specific object
function checkIfNextTo(a, b)
	local a_left = a.x
	local a_right = a.x + a.width
	local a_top = a.y
	local a_bottom = a.y + a.height

	local b_left = b.x
	local b_right = b.x + b.width
	local b_top = b.y
	local b_bottom = b.y + b.height

	if (a_right <= b_left and a_right >= b_left - 10) or
	(a_left >= b_right and a_left <= b_right + 10) or
	(a_bottom <= b_top and a_bottom >= b_top - 10) or
	(a_top >= b_bottom and a_top <= b_bottom + 10) then
		return true
	else
		return false
	end
end



