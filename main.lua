require("Code/slam")
require("Code/physicsExtra")
require("Code/mathExtra")
require("Code/animations")
require("Code/Egg")
require("Code/Björnio")
require("Code/ObjManaging")
require("Code/platform")
require("Code/Owl")
require("Code/tableExtra")
require("Code/worldGeneration")
require("Code/Camera")
require("Code/global")
require("Code/callbacks")
require("Code/projectile")

function love.load()
  love.graphics.setBackgroundColor(0, .4, .7, 1)	--temporary backgruond color for vibes
	Camera:init(RAW_WINDOW_WIDTH, RAW_WINDOW_HEIGHT)
	Camera:set(0, Camera.x + WINDOW_HEIGHT)
	world = love.physics.newWorld(0, 9.81*150, true)	--OG gravity 9.81 * 64
	world:setCallbacks(beginContact, endContact, preSolve, postSolve)
	--NOTE: make sure to put y positions <= 0
	local section = 
	{
		PlatformTemplate(430, -110, GRASS, 2),
	    PlatformTemplate(775, -350, STONE, 2),
	    PlatformTemplate(650, -550, WOOD, 2),
	    PlatformTemplate(525, -750, DIRT, 1),
	    PlatformTemplate(425, -950, STONE, 2),
	    PlatformTemplate(300, -1000, STONE, 2)
	}

	level:addSection(section)
	level:addSection(section)
	--level:addSection(section)
	level:generate()

	Egg(100, -200, GOLDEGG, {0, 1, 2})
	Egg(100, -200, GOLDEGG, {0, 1, 2})
	Egg(300, -200, DOGEGG)
	Egg(300, -200, EVILEGG)
	Owl(300, -200, 400, 400, 500, 1, 0)

	local ground = {}
	--ground.body = love.physics.newBody(world, 640, 600) --remember, the shape (the rectangle we create next) anchors to the body from its center, so we have to move it to (650/2, 650-50/2)
  	--ground.shape = love.physics.newRectangleShape(1280, 30) --make a rectangle with a width of 650 and a height of 50
  	ground.body = love.physics.newBody(world, WINDOW_WIDTH_CENTER, 0) --remember, the shape (the rectangle we create next) anchors to the body from its center, so we have to move it to (650/2, 650-50/2)
  	ground.shape = love.physics.newRectangleShape(WINDOW_WIDTH, 30)
  	ground.fixture = love.physics.newFixture(ground.body, ground.shape, 0.5) --attach shape to body
  	objs.ground = ground

  	--Spawn Bjornio last so he overlaps!
  	Björnio(775, -500)
end

function love.update(dt)
	world:update(dt) --this puts the world into motion
	objs.update(dt)
	--Camera:move(0, 1)
end

function love.draw()
	Camera:draw(WINDOW_SCALE)
	objs.draw()

	love.graphics.setColor(0.28, 0.63, 0.05) -- set the drawing color to green for the ground
  	love.graphics.polygon("fill", objs.ground.body:getWorldPoints(objs.ground.shape:getPoints()))
end
