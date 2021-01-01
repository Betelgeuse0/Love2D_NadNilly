function Egg(x, y, file, frames)
	--local o = {update = EggUpdate, draw = EggDraw, image = love.graphics.newImage(imageFileName)}
	local o

	if frames == nil then 
		o = {update = EggUpdate, draw = EggDraw, image = love.graphics.newImage(file)}
	else
		o = {update = EggUpdate, draw = EggDraw, anim = NewHorizontalAnimation(file, 43, 53, frames)}
	end

	local x1, y1 = x + 22, y + 4
	local x2, y2 = x + 15, y - 15
	local x3, y3 = x, y - 26
	local x4, y4 = x - 15, y - 15
	local x5, y5 = x - 22, y + 4
	local x6, y6 = x - 16, y + 17
	local x7, y7 = x, y + 25
	local x8, y8 = x + 16, y + 17
	SetUpPhysicsPolygon(o, "dynamic", 1, false, 5, x, y, x1, y1, x2, y2, x3, y3, x4, y4, x5, y5, x6, y6, x7, y7, x8, y8)
	table.insert(objs, o)
	return o	--new instance
end

function EggUpdate(o, dt, i)
	if o.anim ~= nil then
		UpdateAnimation(dt, o.anim, 0.2)
	end
end

function EggDraw(o)
	--DrawPhysics(o, {0, 1, 0, 1})
	if o.anim == nil then 
		DrawPhysicsImage(o, o.image, 21, 27)
	else
		DrawPhysicsAnimation(o, o.anim, 21, 27)
	end
end