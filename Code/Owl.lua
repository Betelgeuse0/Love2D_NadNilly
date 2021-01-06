
function Owl(x, y, movex, movey, speed, dirx, diry)
	local o = {update = OwlUpdate, draw = OwlDraw, dead = false, name = "owl"}
	o.anim = NewHorizontalAnimation(OWLSPRITESHEET, 71, 57, {0, 1, 2, 3})
	o.animDead = NewHorizontalAnimation(OWLSPRITESHEET, 71, 57, {4})
	o.movex = movex or 0
	o.movey = movey or 0
	o.speed = speed or 0
	o.dirx = dirx or 0
	o.diry = diry or 0

	o.centerx, o.centery = x, y
	SetUpPhysics(o, x, y, 71, 71, "static", 1, true, 1, o)
	table.insert(objs, o)
	return o
end

function OwlUpdate(o, dt, i)
	if o.dead then 
		if o.deathTime == nil then 
			o.vely = 10
			o.rAdd = math.random(-1, 1) * 0.2
			o.deathTime = 5
		elseif o.deathTime > 0 then
			o.physics.body:setY(o.physics.body:getY() + o.vely)
			o.deathTime = o.deathTime - dt
			o.physics.body:setAngle(o.physics.body:getAngle() + o.rAdd)
		else
			objs.remove(i)
		end
	else
		UpdateAnimation(dt, o.anim, 0.2)

		local x, y = o.physics.body:getX(), o.physics.body:getY()
		--print(o.centerx, o.physics.body:getX())

		if o.dirx > 0 then
			if x < (o.centerx + (o.movex / 2)) then 
				o.physics.body:setX(x + o.speed * dt)
			else
				o.dirx = -1
			end
		elseif o.dirx < 0 then 
			if x > (o.centerx - (o.movex / 2)) then 
				o.physics.body:setX(x - o.speed * dt)
			else
				o.dirx = 1
			end
		end

		if o.diry > 0 then
			if y < (o.centery + (o.movey / 2)) then 
				o.physics.body:setY(y + o.speed * dt)
			else
				o.diry = -1
			end
		elseif o.diry < 0 then 
			if y > (o.centery - (o.movey / 2)) then 
				o.physics.body:setY(y - o.speed * dt)
			else
				o.diry = 1
			end
		end
	end
end

function OwlDraw(o)
	--DrawPhysics(o, {0, 1, 0, 1})
	if o.dead then 
		DrawPhysicsAnimation(o, o.animDead, 35, 31, 2, 2)
	else
		DrawPhysicsAnimation(o, o.anim, 35, 31, 2, 2)
	end
end