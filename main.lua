require("Code/physicsExtra")
require("Code/mathExtra")
require("Code/animations")
require("Code/Egg")
require("Code/Björnio")
require("Code/ObjManaging")
require("Code/platform")

--Make window size bigger first thing
love.window.setMode(980, 720)
love.graphics.setBackgroundColor(0, .4, .8, 1)	--temporary backgruond color for vibes

function love.load()
	world = love.physics.newWorld(0, 9.81*64, true)
	--Platforms in vertical order
	Platform(450, 300, 450, 5)
	Platform(700, 150, 200, 5)
	Platform(950, 0, 400, 5)
	Platform(775, -180, 60, 5)
	Platform(650, -350, 60, 5)
	Platform(525, -500, 60, 5)
	Platform(425, -650, 60, 5)
	Platform(300, -800, 60, 5)

	Egg(100, 200, "Sprites/Eggs/goldegg-SpriteSheet.png", {0, 1, 2})
	Egg(300, 200, "Sprites/Eggs/dogegg.png")

	local ground = {}
	ground.body = love.physics.newBody(world, 512, 600) --remember, the shape (the rectangle we create next) anchors to the body from its center, so we have to move it to (650/2, 650-50/2)
  	ground.shape = love.physics.newRectangleShape(500, 30) --make a rectangle with a width of 650 and a height of 50
  	ground.fixture = love.physics.newFixture(ground.body, ground.shape, 0.5) --attach shape to body
  	objs.ground = ground

  	--Spawn Bjornio last so he overlaps!
  	Björnio(300, 200)
end

function love.update(dt)
	world:update(dt) --this puts the world into motion
	objs.update(dt)
end

function love.draw()
	love.graphics.scale(0.5)
	objs.draw()

	love.graphics.setColor(0.28, 0.63, 0.05) -- set the drawing color to green for the ground
  love.graphics.polygon("fill", objs.ground.body:getWorldPoints(objs.ground.shape:getPoints()))
end
