require("Code/physicsExtra")
require("Code/mathExtra")
require("Code/Björnio")
require("Code/ObjManaging")
require("Code/platform")

function love.load()
	--love.window.setMode(800, 600)
	world = love.physics.newWorld(0, 9.81*64, true)
	Björnio(400, 300, 80, 80, "dynamic", 0.5)
	Platform(500, 300, 200, 5)


	local ground = {}
	ground.body = love.physics.newBody(world, 300, 500) --remember, the shape (the rectangle we create next) anchors to the body from its center, so we have to move it to (650/2, 650-50/2)
  	ground.shape = love.physics.newRectangleShape(800, 50) --make a rectangle with a width of 650 and a height of 50
  	ground.fixture = love.physics.newFixture(ground.body, ground.shape, 0.5) --attach shape to body
  	objs.ground = ground
end

function love.update(dt)
	objs.update(dt)
	world:update(dt) --this puts the world into motion
 
end

function love.draw()
	objs.draw()

	love.graphics.setColor(0.28, 0.63, 0.05) -- set the drawing color to green for the ground
  	love.graphics.polygon("fill", objs.ground.body:getWorldPoints(objs.ground.shape:getPoints()))
end
