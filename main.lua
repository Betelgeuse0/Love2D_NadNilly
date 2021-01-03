require("Code/physicsExtra")
require("Code/mathExtra")
require("Code/animations")
require("Code/Egg")
require("Code/Björnio")
require("Code/ObjManaging")
require("Code/platform")
require("Code/global")

--Make window size bigger first thing
love.window.setMode(RAW_WINDOW_WIDTH, RAW_WINDOW_HEIGHT)	--Effectively 1422x800
love.graphics.setBackgroundColor(0, .4, .8, 1)	--temporary backgruond color for vibes

function love.load()
	world = love.physics.newWorld(0, 9.81*150, true)	--OG gravity 9.81 * 64
	--Platforms in vertical order
	--Platform dimensions: min length: 60    min width: 30
	Platform(450, 300, 450, 32)
	Platform(700, 150, 200, 32)
	Platform(950, 0, 400, 32)
	Platform(775, -230, 64, 32)
	Platform(650, -370, 64, 32)
	Platform(525, -520, 64, 32)
	Platform(425, -680, 64, 32)
	Platform(300, -820, 64, 32)

	Egg(100, 200, "Sprites/Eggs/goldegg-SpriteSheet.png", {0, 1, 2})
	Egg(300, 200, "Sprites/Eggs/dogegg.png")

	local ground = {}
	--ground.body = love.physics.newBody(world, 640, 600) --remember, the shape (the rectangle we create next) anchors to the body from its center, so we have to move it to (650/2, 650-50/2)
  	--ground.shape = love.physics.newRectangleShape(1280, 30) --make a rectangle with a width of 650 and a height of 50
  	ground.body = love.physics.newBody(world, WINDOW_WIDTH_CENTER, 700) --remember, the shape (the rectangle we create next) anchors to the body from its center, so we have to move it to (650/2, 650-50/2)
  	ground.shape = love.physics.newRectangleShape(WINDOW_WIDTH, 30)
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
	love.graphics.scale(WINDOW_SCALE)
	objs.draw()

	love.graphics.setColor(0.28, 0.63, 0.05) -- set the drawing color to green for the ground
  love.graphics.polygon("fill", objs.ground.body:getWorldPoints(objs.ground.shape:getPoints()))
end
