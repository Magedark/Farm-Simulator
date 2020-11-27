-- https://stackoverflow.com/questions/40756230/how-to-create-textbox-in-love2d

function createTextbox()
	textbox = {
    x = 5,
    y = love.graphics.getHeight() - 105,
    width = love.graphics.getWidth() - 10,
    height = 100,
    text = 'hello',
    active = false,
    colors = {
        background = { 128, 128, 128, 255 },
        text = { 0, 0, 0, 255 }
   		}
	}
end