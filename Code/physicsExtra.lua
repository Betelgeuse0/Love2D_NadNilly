function SetUpPhysics(o, x, y, width, height, dynamic, mass, fixedRotation, friction)
	local physics = {}
	physics.body = love.physics.newBody(world, x, y, dynamic)
	physics.body:setFixedRotation(fixedRotation)
  	physics.shape = love.physics.newRectangleShape(width, height) --make a rectangle with a width of 650 and a height of 50
  	physics.fixture = love.physics.newFixture(physics.body, physics.shape, mass) --attach shape to body
  	physics.fixture:setFriction(--[[friction or]] physics.fixture:getFriction())
  	o.physics = physics
end

function SetUpPhysicsPolygon(o, dynamic, mass, fixedRotation, friction, x, y, x1, y1, x2, y2, x3, y3, x4, y4, x5, y5, x6, y6, x7, y7, x8, y8)
	local physics = {}
	physics.body = love.physics.newBody(world, x, y, dynamic)
	physics.body:setFixedRotation(fixedRotation)
	physics.shape = love.physics.newPolygonShape(x1, y1, x2, y2, x3, y3, x4, y4, x5, y5, x6, y6, x7, y7, x8, y8)
	physics.fixture = love.physics.newFixture(physics.body, physics.shape, mass) --attach shape to body
	o.physics = physics
end

function GetPolygonCenter(o)
	x1, y1, x2, y2, x3, y3, x4, y4, x5, y5, x6, y6, x7, y7, x8, y8 = o.physics.body:getWorldPoints(o.physics.shape:getPoints())
	local points = {x1, y1, x2, y2, x3, y3, x4, y4, x5, y5, x6, y6, x7, y7, x8, y8}
	local averagex = 0
	local averagey = 0
	local count = 0
	for i,v in ipairs(points) do
		if v == nil then 
			break
		elseif (i % 2) == 0 then 
			averagey = averagey + v
		else
			averagex = averagex + v
		end
		count = count + 1
	end

	averagex = averagex / (count / 2)
	averagey = averagey / (count / 2)
	return averagex, averagey
end

function GetSpeed(velx, vely)
	return distance(velx, vely, 0, 0)
end

function ObjGetSpeed(o)
	local velx, vely = o.physics.body:getLinearVelocity()
	return GetSpeed(velx, vely)
end