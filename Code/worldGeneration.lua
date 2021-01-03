--please note: make all sections above 0,0 except the first section
--			   make all section have the same dimensions it's easy to calculate when we need a new section
--			   
level = {}

function PlatformTemplate(x, y, w, h, image)
	image = image or BLOQUE
	w = w or 64
	h = h or 32
	return {x = x, y = y, width = w, height = h}
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
			Platform(pt.x, yPos, pt.width, pt.height)
			if (yPos < newTop) then
				newTop = yPos 
			end  
		end
		top = newTop
	end
	tableClear(self) --clear everything since we don't need it anymore
end



