--please note: make all sections above 0,0 except the first section
--			   make all section have the same dimensions it's easy to calculate when we need a new section
--			   
level = {}

function PlatformTemplate(x, y, image, tileAmount)
	image = image or STONE
	tileAmount = tileAmount or 1

	if image == WOOD then
		frames = WOOD_FRAMES
	elseif image == DIRT then
		frames = DIRT_FRAMES
	else
		frames = STONE_FRAMES
	end

	return {x = x, y = y, image = image, tileAmount = tileAmount, frames = frames, name = "platform"}
end

function OwlTemplate(x, y, movex, movey, speed, dirx, diry)
	return {x = x, y = y, movex = movex, movey = movey, speed = speed, dirx = dirx, diry = diry, name = "owl"}
end

function EggTemplate(x, y)
	return {x = x, y = y, preset = EGG_PRESET[math.random(#EGG_PRESET)], name = "egg"}
end

function level:addSection(platformTemplates)	--add a "section" of the level (an array of platform templates)
	table.insert(self, platformTemplates)
end

function level:generate()
	local top = 0
	for i,s in ipairs(self) do 
		local newTop = top
		for i,t in ipairs(s) do
			local yPos = top + (t.y or t.physics.body:getY())
			if t.name == "platform" then 
				Platform(t.x, yPos, t.image, t.tileAmount, t.frames)
				if (yPos < newTop) then
					newTop = yPos 
				end  
			elseif t.name == "owl" then 
				Owl(t.x, yPos, t.movex, t.movey, t.speed, t.dirx, t.diry)
			elseif t.name == "egg" then 
				Egg(t.x, yPos, t.preset.image, t.preset.frames)
			end
		end
		top = newTop
	end
	tableClear(self) --clear everything since we don't need it anymore
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
	egg = {r = 1, g = 1, b = 128/255, a = 1}
}

function colorEquals(c1, c2)
	return c1.r == c2.r and c1.g == c2.g and c1.b == c2.b and c1.a == c2.a
end

function colorIsPlatform(c)
	return colorEquals(c, mapColors.stonePlatform) or colorEquals(c, mapColors.woodPlatform)
		or colorEquals(c, mapColors.dirtPlatform) or colorEquals(c, mapColors.grassPlatform)
end

function level:addSectionFromImage(filename) --note make images from a 44x25 file
	local image = love.graphics.newImage(filename)
	local section = {}
	local imageData = love.image.newImageData(filename)

	local x = 0

	for x = 0, image:getWidth() - 1 do
		for y = 0, image:getHeight() - 1 do 
			r, g, b, a = imageData:getPixel(x, y)
			local color = {r = r, g = g, b = b, a = a}
			local prevColor = nil
			if x > 0 then 
				pr, pg, pb, pa = imageData:getPixel(x - 1, y)
				prevColor = {r = pr, g = pg, b = pb, a = pa}
			end

			if not colorEquals(color, mapColors.background) and (prevColor == nil or not colorEquals(color, prevColor)) then 
				local posx, posy = x * 32, (image:getHeight() - y) * 32 * -1
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
					local w, h = self:scanPlatformTileDimensions(imageData, x, y)
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
				end
			end
		end
	end

	table.insert(self, section)
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
