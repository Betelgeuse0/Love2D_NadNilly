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

	if (speed < maxSpeed) then
		if love.keyboard.isDown('a') then 
			o.physics.body:applyForce(-velApply, 0)
		elseif love.keyboard.isDown('d') then 
			o.physics.body:applyForce(velApply, 0)
		elseif speed > 10 then 
			print("stopping")
			o.physics.body:applyForce(-sign(velx) * maxSpeed * 5, 0)
		end
		--elseif love.keyboard.isDown('w') then 
			--o.physics.body:applyForce(velApply, 0)
		--end 
	end
end

function BjörnioDraw(o)
	DrawPhysics(o, {0, 0, 1, 1})
end