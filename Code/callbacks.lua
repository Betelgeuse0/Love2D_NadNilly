function beginContact(a, b, coll)
 	local userData1 = a:getUserData()
 	local userData2 = b:getUserData()

 	if userData1 == nil or userData2 == nil or (userData1.name ~= "Bjornio" and userData2.name ~= "Bjornio") then 
 		return 
 	end
 	SCORE = SCORE + 1
 	if userData1.pickup ~= nil then 	--pick up the item
 		userData1.pickup = true
 	else
 		userData2.pickup = true
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