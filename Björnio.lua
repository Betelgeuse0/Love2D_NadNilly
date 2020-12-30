function Björnio(x, y)
	local o = {x = x, y = y, update = BjörnioUpdate, draw = BjörnioDraw}
	table.insert(objs, o)
	return o	--new instance
end

function BjörnioUpdate(o)
	o.y = o.y - 1
end

function BjörnioDraw(o)
	love.graphics.setColor(0, 0, 1, 1)
	love.graphics.circle("fill", o.x, o.y, 40)
end