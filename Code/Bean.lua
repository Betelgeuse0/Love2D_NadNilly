
function Bean(x, y, speed, jumpF)
	local o = {update = BeanUpdate, draw = BeanDraw, dead = false, name = "bean"}
	o.speed = speed
	o.jumpTimeSeconds = 1 --one second jump intervals
	o.jumpTimer = 0.5		  --tracks the jump time
	o.jumpForce = jumpF   --how strong the jump is
	o.moving = false
	o.anim = NewHorizontalAnimation(BEANSPRITESHEET, 40, 40, {0, 1, 2})
	o.animDir = 1
	SetUpPhysics(o, x, y, 40, 40, "dynamic", 0.2, true, 1, o)
	table.insert(objs, o)
	return o
end

function BeanUpdate(o, dt, i)

	UpdateAnimation(dt, o.anim, 0.2)

	if o.dead then 
		if o.deathTime == nil then 
			SCORE = SCORE + 1
			o.vely = 10
			o.rAdd = math.random(-1, 1) * 0.2
			o.deathTime = 5
			o.physics.body:setType("static")
		elseif o.deathTime > 0 then
			o.physics.body:setY(o.physics.body:getY() + o.vely)
			o.deathTime = o.deathTime - dt
			o.physics.body:setAngle(o.physics.body:getAngle() + o.rAdd)
		else
			objs.remove(i)
		end
	else
		--follow bjorn if he's in close enough proximity
		local bjornX, bjornY = BJORN.physics.body:getX(), BJORN.physics.body:getY()
		local x, y = o.physics.body:getX(), o.physics.body:getY()
		local velx, vely = o.physics.body:getLinearVelocity()
		o.animDir = sign(bjornX - x)

		local dist = distance(x, y, bjornX, bjornY)
		local distX = math.abs(x - bjornX)

		if dist < 1000 and distX > 25 then
			o.moving = true
			o.physics.body:setLinearVelocity(o.animDir * o.speed, vely)
			if o.jumpTimer > 0 then 
				o.jumpTimer = o.jumpTimer - dt
			else 
				o.jumpTimer = o.jumpTimeSeconds
				o.physics.body:applyLinearImpulse(0, o.jumpForce)
			end
		end
	end
end

function BeanDraw(o)
	if (o.moving) then 
		DrawDirectionalAnimation(o, o.anim, 20, 20, o.animDir)
	end
end