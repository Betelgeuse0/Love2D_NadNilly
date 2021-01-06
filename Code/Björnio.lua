function Björnio(x, y)
	local o = {name = "Bjornio"}
	o.update = BjörnioUpdate
	o.draw = BjörnioDraw
	o.animIdle = NewHorizontalAnimation(BJORNIDLE, 137, 159, {0, 1})
	o.animWalk = NewHorizontalAnimation(BJORNWALK, 137, 159, {0, 1, 2, 3, 4, 5})
	o.animJump = NewHorizontalAnimation(BJORNJUMP, 137, 159, {0, 1})
	o.animFalling = NewHorizontalAnimation(BJORNFALLING, 137, 159, {0, 1})
	o.animShooting = NewHorizontalAnimation(BJORNIOSHOOTING, 137, 159, {0, 1, 2})
	o.animCurrent = o.animIdle
	o.animSpeed = 0.25
	o.direction = 1
	o.jumping = false
	o.timer = 0
	o.health = 10
	SetUpPhysics(o, x, y, 50, 150, "dynamic", 0.4, true, nil, o)	--Lower mass parameter = higher jump

	table.insert(objs, o)
	return o	--new instance
end

function BjörnioUpdate(o, dt, i)
	local velApply = 2750
	local maxSpeed = 250
	local speed = ObjGetSpeed(o)
	local velx, vely = o.physics.body:getLinearVelocity()

	--Animation
	UpdateAnimation(dt, o.animCurrent, o.animSpeed)
	projectileUpdater(dt)

	--Enforce speed cap
	if (math.abs(velx) > maxSpeed) then
		o.physics.body:setLinearVelocity(sign(velx) * maxSpeed, vely)
	end

	--Jump
	if love.keyboard.isDown('w') and math.abs(vely) == 0 then	--and don't jump if you're already jumping
		o.physics.body:applyLinearImpulse(0, -velApply * 1)
	elseif vely < -0.5 then		--When jumping up
		o.jumping = true
		o.animCurrent = o.animJump
		o.animSpeed = 0.09
	elseif vely > 95 then		--When falling fast enough
		o.jumping = true
		o.animCurrent = o.animFalling
		o.animSpeed = 0.1
	else						--When no longer falling go back to idle
		o.jumping = false
		o.animCurrent = o.animIdle
		o.animSpeed = 0.25
	end


	--Move left and right
	if love.keyboard.isDown('a') then 
		o.physics.body:applyLinearImpulse(-velApply * 0.05, 0)
		if not o.jumping then
			o.animCurrent = o.animWalk
			o.animSpeed = 0.05
		end
		o.direction = -1	--face left
	elseif love.keyboard.isDown('d') then 
		o.physics.body:applyLinearImpulse(velApply * 0.05, 0)
		if not o.jumping then
			o.animCurrent = o.animWalk
			o.animSpeed = 0.05
		end
		o.direction = 1		--face right
	elseif math.abs(velx) > 10 then 	--Make less "slippery" and go back to idle animation
		o.physics.body:applyLinearImpulse(-sign(velx) * maxSpeed * 5 * 0.05, 0)	--This 0.05 MUST be the same as the others since that's the proportion
		o.animCurrent = o.animIdle
		o.animSpeed = 0.25
	end 


	--shoot
	o.timer = o.timer + dt
	if love.keyboard.isDown('space') and o.timer > 0.5 then   --shoot
		o.physics.body:applyLinearImpulse(-o.direction * 800, -800)
		SHOT:play()
		o.timer = 0
		shootBullet(o.physics.body:getX(), o.physics.body:getY(), o.direction)
	end

	--Enforce health
	if o.health <= 0 then
		print("deth")
	end
end

function BjörnioDraw(o)
	--Draw Bjornio
    --DrawPhysics(o, {0, 0, 1, 1})	--Uncomment to see collision zone
	DrawPhysicsAnimationFlippable(o, o.animCurrent, 63, 83, o.direction)

	--Draw bullets
	for i,bullets in ipairs(ACTIVEBULLETS) do
        love.graphics.draw(bullets.image, bullets.x, bullets.y, 0, -bullets.direction, 1, 0, 15)
    	--DrawPhysics(bullets, {0,0,1,1})	--uncomment to see collision zone
    end

    --Draw health bar
    --drawHealth(o)
    i = 1
    while i < o.health do
    	love.graphics.draw(EGG, WINDOW_WIDTH - (30 * i), -WINDOW_HEIGHT + 10, 0, .6, .6, 0, 0)
    	i = i + 1
    end
end

