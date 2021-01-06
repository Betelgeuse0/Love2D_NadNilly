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
require("Code/GUI")

function love.load()
  	love.graphics.setBackgroundColor(0, .4, .7, 1)	--temporary backgruond color for vibes
	Camera:init(RAW_WINDOW_WIDTH, RAW_WINDOW_HEIGHT)
	Camera:set(0, Camera.y + WINDOW_HEIGHT)
	world = love.physics.newWorld(0, 9.81*150, true)	--OG gravity 9.81 * 64
	world:setCallbacks(beginContact, endContact, preSolve, postSolve)
	level:addSectionFromImage("Sprites/LevelDesign/section3.png")
	level:addSectionFromImage("Sprites/LevelDesign/testSection2.png")
	level:addSectionFromImage("Sprites/LevelDesign/testSection.png")

	setSeed = false
	

	Platform(640, -14, DIRT, 25, DIRT_FRAMES)	--ground base

  	--Spawn Bjornio last so he overlaps!
  	Björnio(775, -500)
end

function love.update(dt)
	if not setSeed then
		setSeed = false 
		math.randomseed(dt)
		level:generate()
	end
	world:update(dt) --this puts the world into motion
	objs.update(dt)
	Camera:move(0, 1)
end

function love.draw()
	--background
	love.graphics.setColor(BGCOLOR, BGCOLOR, BGCOLOR, 1) -- set the drawing color to green for the ground
	love.graphics.draw(BACKGROUND, 0, -400)
	Camera:draw(WINDOW_SCALE)
	objs.draw()

	if LOSE then
		love.graphics.setColor({.7,.1,.1,1})
    	love.graphics.setNewFont(290 - (BGCOLOR * 100))
		love.graphics.print("YOU LOSE", 10 + (BGCOLOR * 300), -Camera.y + 100 , 0.15, 1, 1)
	end
end
