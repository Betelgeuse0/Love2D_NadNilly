--please note: make all sections above 0,0 except the first section
--			   make all section have the same dimensions it's easy to calculate when we need a new section
--			   
level = {info = {}}

function PlatformTemplate(x, y, image, tileAmount)
	image = image or STONE
	tileAmount = tileAmount or 1

	if image == WOOD then
		frames = WOOD_FRAMES
	elseif image == DIRT then
		frames = DIRT_FRAMES
	elseif image == GRASS then
		frames = GRASS_FRAMES
	else
		frames = STONE_FRAMES
	end

	return {basey = y, x = x, y = y, image = image, tileAmount = tileAmount, frames = frames, name = "platform"}
end

function OwlTemplate(x, y, movex, movey, speed, dirx, diry)
	return {basey = y, x = x, y = y, movex = movex, movey = movey, speed = speed, dirx = dirx, diry = diry, name = "owl"}
end

function EggTemplate(x, y)
	return {basey = y, x = x, y = y, preset = EGG_PRESET[math.random(#EGG_PRESET)], name = "egg"}
end

function BeanTemplate(x, y, speed, jumpForce)
	return {basey = y, x = x, y = y, speed = speed, jumpForce = jumpForce, name = "bean"}
end

function level:update()
	for j,t in ipairs(self.info) do
		--check if template is below the camera and if it is then place it relative to top
		if (t.y - 80) > (-Camera.y + WINDOW_HEIGHT) then 

			if (t.y == self.top) then
				self:setRelativeToTop(t)
				self.top = t.y
			else
				self:setRelativeToTop(t)
			end
			
			self:genObj(t)

		end
	end
end

function level:addSection(platformTemplates)	--add a "section" of the level (an array of platform templates)
	--table.insert(self.sections, platformTemplates)
	tableInsertContents(self.info, platformTemplates)
end

function level:setRelativeToTop(t)
	t.y = self.top + t.basey
end

function level:genObj(t)
	if t.name == "platform" then 
		Platform(t.x, t.y, t.image, t.tileAmount, t.frames)
	elseif t.name == "owl" then 
		Owl(t.x, t.y, t.movex, t.movey, t.speed, t.dirx, t.diry)
	elseif t.name == "egg" then 
		Egg((t.x / 2) + 16, t.y / 2, t.preset.image, t.preset.frames)
	elseif t.name == "bean" then 
		Bean(t.x, t.y, t.speed, t.jumpForce)
	end

end

function level:generate()
	--generate objects from templates
	self.top = 0
	local newTop = self.top
	for i,t in ipairs(self.info) do
		self:setRelativeToTop(t)
		if (t.name == "platform") then 
			if (t.y < newTop) then 
				newTop = t.y
			end
		end
		self:genObj(t)
	end
	self.top = newTop
end

local mapColors = 
{
	background = {r = 78/255, g = 190/255, b = 218/255, a = 1}, 
	stonePlatform = {r = 123/255, g = 121/255, b = 121/255, a = 1},
	woodPlatform = {r = 182/255, g = 129/255, b = 63/255, a = 1},
	dirtPlatform = {r = 84/255, g = 52/255, b = 35/255, a = 1},
	grassPlatform = {r = 34/255, g = 177/255, b = 76/255, a = 1},
	--bjornio = {r = 1, g = 128/255, b = 0, a = 1}, --bjornio will be set manually
	owl = {r = 136/255, g = 0, b = 21/255, a = 1},
	owlHor = {r = 181/255, g = 0, b = 28/255, a = 1},
	owlVer = {r = 227/255, g = 0, b = 34/255, a = 1},
	owlDiag1 = {r = 1, g = 9/255, b = 46/255, a = 1},
	owlDiag2 = {r = 1, g = 62/255, b = 90/255, a = 1},
	egg = {r = 1, g = 1, b = 128/255, a = 1},
	bean = {r = 54/255, g = 1, b = 54/255, a = 1}
}

function colorEquals(c1, c2)
	return c1.r == c2.r and c1.g == c2.g and c1.b == c2.b and c1.a == c2.a
end

function colorIsPlatform(c)
	return colorEquals(c, mapColors.stonePlatform) or colorEquals(c, mapColors.woodPlatform)
		or colorEquals(c, mapColors.dirtPlatform) or colorEquals(c, mapColors.grassPlatform)
end

function colorPrint(c)
	print(c.r, c.g, c.b, c.a)
end

function level:addSectionsFromImage(sectionNames)
	for i,v in ipairs(sectionNames) do 
		self:addSectionFromImage(v)
	end
end

function level:addSectionFromImage(filename) --note make images from a 44x25 file
	local image = love.graphics.newImage(filename)
	local section = {}
	local imageData = love.image.newImageData(filename)

	--find the base top
	local baseTop = 0

	if (#self.info > 0) then 
		tableForEach(self.info, 
			function (v)
				if (v.name == "platform" and v.y < baseTop) then 
					baseTop = v.y 
				end
			end)
	end

	for x = 0, image:getWidth() - 1 do
		for y = 0, image:getHeight() - 1 do 
			r, g, b, a = imageData:getPixel(x, y)
			local color = {r = r, g = g, b = b, a = a}
			local prevColor = nil
			if x > 0 then 
				pr, pg, pb, pa = imageData:getPixel(x - 1, y)
				prevColor = {r = pr, g = pg, b = pb, a = pa}
			end

			if not colorEquals(color, mapColors.background) and (not colorIsPlatform(color) or (prevColor == nil or not colorEquals(color, prevColor))) then 
				local posx, posy = x * 32, (image:getHeight() - y) * 32 * -1 + baseTop

				local w, h = 0, 0
				if (colorIsPlatform(color)) then 
					w, h = self:scanPlatformTileDimensions(image, imageData, x, y)
					posx = (x + (w/2)) * 32
				end

				if colorEquals(color, mapColors.stonePlatform) then 
					table.insert(section, PlatformTemplate(posx, posy, STONE, w/2, STONE_FRAMES))
				elseif colorEquals(color, mapColors.woodPlatform) then 
					table.insert(section, PlatformTemplate(posx, posy, WOOD, w/2, WOOD_FRAMES))
				elseif colorEquals(color, mapColors.dirtPlatform) then 
					table.insert(section, PlatformTemplate(posx, posy, DIRT, w/2, DIRT_FRAMES))
				elseif colorEquals(color, mapColors.grassPlatform) then 
					table.insert(section, PlatformTemplate(posx, posy, GRASS, w/2, GRASS_FRAMES))
				elseif colorEquals(color, mapColors.owl) then 
					table.insert(section, OwlTemplate(posx, posy, 0, 0, 0, 0, 0))
				elseif colorEquals(color, mapColors.owlHor) then 
					table.insert(section, OwlTemplate(posx, posy, 400, 0, 500, 1, 0))
				elseif colorEquals(color, mapColors.owlVer) then 
					table.insert(section, OwlTemplate(posx, posy, 0, 400, 500, 0, 1))
				elseif colorEquals(color, mapColors.owlDiag1) then 
					table.insert(section, OwlTemplate(posx, posy, 400, 400, 500, 1, 1))
				elseif colorEquals(color, mapColors.owlDiag2) then 
					table.insert(section, OwlTemplate(posx, posy, 400, 400, 500, 1, -1))
				elseif colorEquals(color, mapColors.egg) then 
					table.insert(section, EggTemplate(posx, posy))
				elseif colorEquals(color, mapColors.bean) then 
					table.insert(section, BeanTemplate(posx, posy, 100, -150))
				end
			end
		end
	end
	tableInsertContents(self.info, section)
end

function level:scanPlatformTileDimensions(image, imageData, x, y)

	local r, g, b, a = imageData:getPixel(x, y)
	local startColor = {r = r, g = g, b = b, a = a}

	local width = 0
	local color = startColor 
	while x < image:getWidth() and colorEquals(color, startColor) do 
		r, g, b, a = imageData:getPixel(x, y)
		x = x + 1
		width = width + 1
		color = {r = r, g = g, b = b, a = a}
	end

	return width, 1
end