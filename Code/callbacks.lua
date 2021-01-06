function beginContact(a, b, coll)
	bulletContact(a,b)
 	local userData1 = a:getUserData()
 	local userData2 = b:getUserData()


 	if userData1 == nil or userData2 == nil or (userData1.name ~= "Bjornio" and userData2.name ~= "Bjornio") then 
 		return 
 	end

 	local bjorn, obj

 	if userData1.name == "Bjornio" then 
 		bjorn = userData1
 		obj = userData2
 	else 
 		bjorn = userData2
 		obj = userData1
 	end

 	if obj.name == "egg" then 
	 	SCORE = SCORE + 1
	 	obj.pickup = true
	elseif obj.name == "owl" then
		local velx, vely = bjorn.physics.body:getLinearVelocity()
		local ypos = bjorn.physics.body:getY() + 84/2
		local oypos = obj.physics.body:getY() - 31/2

		if vely > 0 and ypos < oypos then
			obj.dead = true
			bjorn.physics.body:applyLinearImpulse(0, -2750 * 1)
		else
			--TODO put a sound right here!!!!!!!
			bjorn.health = bjorn.health - 1
			print(bjorn.health)
			bjorn.physics.body:setLinearVelocity(velx, 0)
			bjorn.physics.body:applyLinearImpulse(0, -2750)
		end
	end
end

function bulletContact(a, b)
 	local userData1 = a:getUserData()
 	local userData2 = b:getUserData()


 	if userData1 == nil or userData2 == nil or (userData1.name ~= "bullet" and userData2.name ~= "bullet") then 
 		return 
 	end

 	local bullet, obj

 	if userData1.name == "bullet" then 
 		bullet = userData1
 		obj = userData2
 	else 
 		bullet = userData2
 		obj = userData1
 	end

	if obj.name == "owl" then
		obj.dead = true
		bullet.hasHit = true
	end
end
 
function endContact(a, b, coll)
 	--print(a:getUserData(), "endContact with", b:getUserData())
end
 
function preSolve(a, b, coll)
 	--print(a:getUserData(), "preSolve with", b:getUserData())
end
 
function postSolve(a, b, coll, normalimpulse, tangentimpulse)
 	--print(a:getUserData(), "postSolve with", b:getUserData())
end