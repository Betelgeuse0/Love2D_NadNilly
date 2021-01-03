--please note: make all sections above 0,0 except the first section
--			   make all section have the same dimensions it's easy to calculate when we need a new section
--			   
level = {}

function PlatformTemplate(x, y, w, h, image)
	if image == nil then
		image = BLOQUE
	end
	return {x = x, y = y, width = w, height = h}
end

function level:addSection(platformTemplates)	--add a "section" of the level (an array of platform templates)
	table.insert(self, platformTemplates)
end

function level:generate()	--generate a section from index "i"
	for i,s in ipairs(self) do 
	        for i,pt in ipairs(s) do
	            Platform(pt.x, pt.y, pt.width, pt.height)
	        end
	    end
end




