function Björnio(x, y, w, h, dyn, m)
	local o = {update = BjörnioUpdate, draw = BjörnioDraw}
	SetUpPhysics(o, x, y, w, h, dyn, m, true)
	table.insert(objs, o)
	return o	--new instance
end

function BjörnioUpdate(o, dt, i)
	local velApply = 2000
	local maxSpeed = 200
	local speed = ObjGetSpeed(o)
	local velx, vely = o.physics.body:getLinearVelocity()

	--Enforce speed cap
	if (math.abs(velx) > maxSpeed) then
		o.physics.body:setLinearVelocity(sign(velx) * maxSpeed, vely)
	end

	--Jump
	if love.keyboard.isDown('w') and math.abs(vely) < 1 then	--and don't jump if you're already jumping
		o.physics.body:applyLinearImpulse(0, -velApply * 0.75)
	end

	--Move left and right
	if love.keyboard.isDown('a') then 
		o.physics.body:applyLinearImpulse(-velApply * 0.05, 0)
	elseif love.keyboard.isDown('d') then 
		o.physics.body:applyLinearImpulse(velApply * 0.05, 0)
	elseif math.abs(velx) > 10 then 		--Make less "slippery"
		o.physics.body:applyLinearImpulse(-sign(velx) * maxSpeed * 5 * 0.05, 0)	--This 0.05 MUST be the same as the others since that's the proportion
	end 

end

function BjörnioDraw(o)
	DrawPhysics(o, {0, 0, 1, 1})
end