--GUI
GUI = {}

function GUI.drawText(windowx, windowy, text, size, color, offsetx, offsety)
	love.graphics.setColor(color)
	love.graphics.setNewFont(size)
	love.graphics.print(text, windowx, -Camera.y + windowy, 0, 1, 1, offsetx, offsety)
end
