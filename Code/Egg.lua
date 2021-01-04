function Egg(x, y, img, frames)
	--local o = {update = EggUpdate, draw = EggDraw, image = love.graphics.newImage(imageFileName)}
	local o

	if frames == nil then 
		o = {update = EggUpdate, draw = EggDraw, image = img, pickup = false}
	else
		o = {update = EggUpdate, draw = EggDraw, anim = NewHorizontalAnimation(img, 43, 53, frames), pickup = false}
	end
	o.sparkles = NewHorizontalAnimation(SPARKLES, 43, 53, {0, 1, 2, 3})

	local x1, y1 = x + 22, y + 4
	local x2, y2 = x + 15, y - 15
	local x3, y3 = x, y - 26
	local x4, y4 = x - 15, y - 15
	local x5, y5 = x - 22, y + 4
	local x6, y6 = x - 16, y + 17
	local x7, y7 = x, y + 25
	local x8, y8 = x + 16, y + 17
	SetUpPhysicsPolygon(o, "dynamic", 1, false, 1, o, x, y, x1, y1, x2, y2, x3, y3, x4, y4, x5, y5, x6, y6, x7, y7, x8, y8)
	table.insert(objs, o)
	return o	--new instance
end

function EggUpdate(o, dt, i)
	if o.pickup then 
		UpdateAnimation(dt, o.sparkles, 0.2) --update sparkles animation
		--set physics to nil, play pickup animation, increment player score, and die when done
		if o.physics ~= nil then 
			o.deathTimer = 1.8
			o.x, o.y = GetPolygonCenter(o)
			o.r = o.physics.body:getAngle()
			o.physics.fixture:destroy()
			o.physics = nil
		end

		o.deathTimer = o.deathTimer - dt 

		if o.deathTimer <= 0 then 
			objs.remove(i)
		end
	elseif o.anim ~= nil then
		UpdateAnimation(dt, o.anim, 0.2)
	end
end

function EggDraw(o)
	--DrawPhysics(o, {0, 1, 0, 1})

	if o.physics == nil then 
		--play sparkle animation
		DrawAnimation(o.sparkles, o.x, o.y, o.r, 21, 27)
	else
		if o.anim == nil then 
			DrawPhysicsImage(o, o.image, 21, 27)
		else
			DrawPhysicsAnimation(o, o.anim, 21, 27)
		end
	end
end