function Obj2Update(o, dt)
	o.x = o.x - 1
end

function Obj2Draw(o)
	love.graphics.setColor(1, 0, 0, 1)
	love.graphics.circle("fill", o.x, o.y, 20)
end

function Obj2(x, y)
	local o = {x = x, y = y, update = Obj2Update, draw = Obj2Draw}
	table.insert(objs, o)
	return o	--new instance
end

