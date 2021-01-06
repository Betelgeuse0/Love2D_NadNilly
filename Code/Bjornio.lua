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
	o.healthCooldown = 0	--timer on how often bjornio can be hit
	o.canBeHit = true		--Marks whether or not he can take another hit
	o.flashTimer = 0		--Make bjornio flash when hit
	SetUpPhysics(o, x, y, 50, 150, "dynamic", 0.34, true, nil, o)	--Lower mass parameter = higher jump

	table.insert(objs, o)
	return o	--new instance
end

function BjörnioUpdate(o, dt, i)
	if not LOSE then 		--if not lost, let player play!!
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
			JUMP:play()
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
			o.animCurrent = o.animShooting
		end
		--Enforce healthloss cooldown
		o.healthCooldown = o.healthCooldown + dt
		if o.healthCooldown > 3 then
			o.canBeHit = true
			o.healthCooldown = 0
		end

		--Keep track of when to make bjornio flash after being hit
		o.flashTimer = o.flashTimer + dt
		if o.flashTimer > 0.3 then
			o.flashTimer = 0
		end
			
			--Enforce death
		if o.health <= 0 then
			LOSESOUND:play()
			LOSE = true
		elseif (o.physics.body:getY() - 80) > (-Camera.y + WINDOW_HEIGHT) then
			LOSESOUND:play()
		    LOSE = true
		end
	else	--lose
		if BGCOLOR > 0 then		--make losing fancy
			BGCOLOR = BGCOLOR - (dt/5)
			o.physics.body:setX(o.physics.body:getX() + 25)
			o.physics.body:setY(o.physics.body:getY() + 25)
		end
	end

end

function BjörnioDraw(o)
	--Draw Bjornio
    --DrawPhysics(o, {0, 0, 1, 1})	--Uncomment to see collision zone
	DrawBjornioAnimation(o, o.animCurrent, 63, 83, o.direction)

	--Draw health bar
    i = 1
    while i < o.health + 1 do
    	love.graphics.draw(EGG, WINDOW_WIDTH - (30 * i), -Camera.y + 10 , 0, .6, .6, 0, 0)
    	i = i + 1
    end

	--Draw bullets
	for i,bullets in ipairs(ACTIVEBULLETS) do
        love.graphics.draw(bullets.image, bullets.x, bullets.y, 0, -bullets.direction, 1, 0, 15)
    	--DrawPhysics(bullets, {0,0,1,1})	--uncomment to see collision zone
    end


end

