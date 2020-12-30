require("Obj2")
require("Obj")
require("Björnio")

objs = {}

function objs.update(dt)
	for i,o in ipairs(objs) do 
		o:update(dt)
	end
end

function objs.draw()
	for i,o in ipairs(objs) do 
		o:draw()
	end
end

