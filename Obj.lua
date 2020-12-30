function Obj(x, y)
	local o = {x = x, y = y, update = ObjUpdate, draw = ObjDraw}
	table.insert(objs, o)
	return o	--new instance
end

function ObjUpdate(o, dt)
	o.x = o.x + 1
end

function ObjDraw(o)
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.circle("fill", o.x, o.y, 10)
end