Camera = {x = 0, y = 0}		--x,y coordinates from the center of the camera

function Camera:init(windowx, windowy)
	windowx = windowx or 800
	windowy = windowy or 600
	love.window.setMode(windowx, windowy)
end

function Camera:move(x, y)
	self.x = self.x + x
	self.y = self.y + y
end

function Camera:set(x, y)
	self.x = x
	self.y = y
end

function Camera:draw(scale)
	love.graphics.setDefaultFilter("nearest", "nearest")
	scale = scale or 1
	love.graphics.scale(scale)
	love.graphics.translate(self.x, self.y)
end

