function SetUpPhysics(o, x, y, width, height, dynamic, mass, fixedRotation)
	local physics = {}
	physics.body = love.physics.newBody(world, x, y, dynamic)
	physics.body:setFixedRotation(fixedRotation)
  	physics.shape = love.physics.newRectangleShape(width, height) --make a rectangle with a width of 650 and a height of 50
  	physics.fixture = love.physics.newFixture(physics.body, physics.shape, mass) --attach shape to body
  	o.physics = physics
end

function DrawPhysics(o, color)
	love.graphics.setColor(color[1], color[2], color[3], color[4]) -- set the drawing color to green for the ground
  	love.graphics.polygon("fill", o.physics.body:getWorldPoints(o.physics.shape:getPoints()))
end

function GetSpeed(velx, vely)
	return distance(velx, vely, 0, 0)
end

function ObjGetSpeed(o)
	local velx, vely = o.physics.body:getLinearVelocity()
	return GetSpeed(velx, vely)
end