require("Code/slam")
require("Code/physicsExtra")
require("Code/mathExtra")
require("Code/animations")
require("Code/Egg")
require("Code/Bjornio")
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
require("Code/Bean")

function love.load()
	love.window.setTitle("Björnio")
  	love.graphics.setBackgroundColor(0, .4, .7, 1)	--temporary backgruond color for vibes
	Camera:init(RAW_WINDOW_WIDTH, RAW_WINDOW_HEIGHT)
	Camera:set(0, Camera.y + WINDOW_HEIGHT)
	Camera.speed, Camera.maxSpeed = 1, 4

	world = love.physics.newWorld(0, 9.81*150, true)	--OG gravity 9.81 * 64
	world:setCallbacks(beginContact, endContact, preSolve, postSolve)
	
	setSeed = false

	local groundBase = Platform(640, -14, DIRT, 25, DIRT_FRAMES)
	groundBase.name = "groundBase";

  	--Spawn Bjornio last so he overlaps!
  	BJORN = Björnio(775, -500) 

end

function love.update(dt)
	if not setSeed then
		setSeed = true
		math.randomseed(dt)

		local sectionImageNames = 
		{
			"Sprites/LevelDesign/mapSection0.png",
			"Sprites/LevelDesign/mapSection1.png",
			"Sprites/LevelDesign/mapSection2.png",
			"Sprites/LevelDesign/mapSection3.png",
			"Sprites/LevelDesign/mapSection4.png",
		}

		sectionImageNames = tableRandomized(sectionImageNames)
		level:addSectionsFromImage(sectionImageNames)
		level:generate()
	end
	world:update(dt) --this puts the world into motion
	level:update()
	objs.update(dt)

	Camera:move(0, Camera.speed)

	--gradually increase the camera speed
	if (Camera.speed < Camera.maxSpeed) then 
		Camera.speed = Camera.speed + (dt / 35)
	end
end


function love.draw()
	--background
	love.graphics.setColor(BGCOLOR, BGCOLOR, BGCOLOR, 1)
	love.graphics.draw(BACKGROUND, 0, -400)

	--camera and objects drawing
	Camera:draw(WINDOW_SCALE)
	objs.draw()

	--score 
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.setNewFont(35)
	love.graphics.print("SCORE:" .. SCORE, 10, -Camera.y + 10, 0, 1, 1)
 
	--game over lose message
	if LOSE then
		love.graphics.setColor({.7,.1,.1,1})
    	love.graphics.setNewFont(290 - (BGCOLOR * 100))
		love.graphics.print("YOU LOSE", 10 + (BGCOLOR * 300), -Camera.y + 100 , 0.15, 1, 1)
	end
end

--[[function love.errorhandler(msg)
	print(msg)
	--return errorDisplayer:send(msg)
end]]
