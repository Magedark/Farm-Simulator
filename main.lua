require("character")
require("npcs")

function love.load()
	listOfRectangles = {}
	for i=1, 3 do
		createNPC(listOfRectangles)
	end
	createCharacter(listOfRectangles)
end


function love.update(dt)
	print(character.x)


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
	for i,v in ipairs(listOfRectangles) do
		love.graphics.rectangle("line", v.x, v.y, v.width, v.height)
		print(v.x)
	end

end
