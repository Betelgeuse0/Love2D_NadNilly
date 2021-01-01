require("Code/physicsExtra")
require("Code/mathExtra")
require("Code/animations")
require("Code/Egg")
require("Code/platform")
require("Code/Björnio")
require("Code/ObjManaging")


function love.load()
	--love.window.setMode(800, 600)
	--global variables lol
	world = love.physics.newWorld(0, 9.81*64, true)
	time = 0

	Björnio(300, 300, 80, 80, "dynamic", 0.5)

	Egg(100, 200, "Sprites/goldegg-SpriteSheet.png")

	local ground = {}
	ground.body = love.physics.newBody(world, 300, 500) --remember, the shape (the rectangle we create next) anchors to the body from its center, so we have to move it to (650/2, 650-50/2)
  	ground.shape = love.physics.newRectangleShape(800, 50) --make a rectangle with a width of 650 and a height of 50
  	ground.fixture = love.physics.newFixture(ground.body, ground.shape, 0.5) --attach shape to body
  	objs.ground = ground
end

function love.update(dt)
	time = time + dt --game time in delta time (seconds)
	world:update(dt) --this puts the world into motion
	objs.update(dt)
end

function love.draw()
	objs.draw()

	love.graphics.setColor(0.28, 0.63, 0.05) -- set the drawing color to green for the ground
  	love.graphics.polygon("fill", objs.ground.body:getWorldPoints(objs.ground.shape:getPoints()))
end
