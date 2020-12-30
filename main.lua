require("ObjExample")

function love.load()
	Obj2(400, 300)
	Obj(200, 400)
	Björnio(500, 400)
end

function love.update(dt)
	objs.update(dt)
end

function love.draw()
	objs.draw()
end
