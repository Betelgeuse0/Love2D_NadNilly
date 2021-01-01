function Egg(x, y, file)
	--local o = {update = EggUpdate, draw = EggDraw, image = love.graphics.newImage(imageFileName)}
	local o = {update = EggUpdate, draw = EggDraw, anim = NewHorizontalAnimation(file, 43, 53, {0, 1, 2})}
	local x1, y1 = x + 21, y + 4
	local x2, y2 = x + 15, y - 17
	local x3, y3 = x, y - 27
	local x4, y4 = x - 15, y - 17
	local x5, y5 = x - 21, y + 4
	local x6, y6 = x - 16, y + 17
	local x7, y7 = x, y + 27
	local x8, y8 = x + 16, y + 17
	SetUpPhysicsPolygon(o, "dynamic", 0.3, false, 3, x, y, x1, y1, x2, y2, x3, y3, x4, y4, x5, y5, x6, y6, x7, y7, x8, y8)
	table.insert(objs, o)
	return o	--new instance
end

function EggUpdate(o, dt, i)
	UpdateAnimation(dt, o.anim, 0.2)
end

function EggDraw(o)
	DrawPhysicsAnimation(o, o.anim, 22, 25)
end