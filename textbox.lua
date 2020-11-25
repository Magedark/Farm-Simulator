-- https://stackoverflow.com/questions/40756230/how-to-create-textbox-in-love2d

function createTextbox()
	textbox = {
    x = 40,
    y = 40,
    width = 400,
    height = 200,
    text = 'hello',
    active = false,
    colors = {
        background = { 255, 255, 255, 255 },
        text = { 1, 1, 1, 255 }
   		}
	}
end