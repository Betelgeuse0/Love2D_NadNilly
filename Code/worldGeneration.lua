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
	elseif image == GRASS then
		frames = GRASS_FRAMES
	else
		frames = STONE_FRAMES
	end

	return {x = x, y = y, image = image, tileAmount = tileAmount, frames = frames}
end

function level:addSection(platformTemplates)	--add a "section" of the level (an array of platform templates)
	table.insert(self, platformTemplates)
end

function level:generate()
	local top = 0
	for i,s in ipairs(self) do 
		local newTop = top
		for i,pt in ipairs(s) do
			local yPos = top + pt.y
			Platform(pt.x, yPos, pt.image, pt.tileAmount, pt.frames)
			if (yPos < newTop) then
				newTop = yPos 
			end  
		end
		top = newTop
	end
	tableClear(self) --clear everything since we don't need it anymore
end



