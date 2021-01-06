--DIMENSIONS
RAW_WINDOW_WIDTH = 1280
RAW_WINDOW_HEIGHT = 720
WINDOW_SCALE = 0.909
WINDOW_WIDTH = RAW_WINDOW_WIDTH / WINDOW_SCALE
WINDOW_HEIGHT = RAW_WINDOW_HEIGHT / WINDOW_SCALE
WINDOW_WIDTH_CENTER = WINDOW_WIDTH / 2
WINDOW_HEIGHT_CENTER = WINDOW_HEIGHT / 2

--PLATFORM
PLATFORM_HEIGHT = 32	--should be 32
PLATFORM_WIDTH = 64		--should be 64
ANIM_SPEED = 0.3

--PLAYER (BJORNIO) MECHANICS
SCORE = 0
ACTIVEBULLETS = {}

--IMAGES
	--MAP
--MAP_PALETTE = love.graphics.newImage("Sprites/mapPalette.png")
	--BJORN
BJORNFALLING = love.graphics.newImage("Sprites/Bjornio/BjornFalling.png")
BJORNIDLE = love.graphics.newImage("Sprites/Bjornio/BjornIdle.png")
BJORNIO = love.graphics.newImage("Sprites/Bjornio/Bjornio.png")
BJORNIOSHOOTING = love.graphics.newImage("Sprites/Bjornio/BjornioShooting.png")
BJORNJUMP = love.graphics.newImage("Sprites/Bjornio/BjornJump.png")
BJORNWALK = love.graphics.newImage("Sprites/Bjornio/BjornWalk.png")
BULLET = love.graphics.newImage("Sprites/Bjornio/bullet.png")

--AUDIO
SHOT = love.audio.newSource('Audio/shot.mp3', 'static')
SHOT:setVolume(0.5)
JUMP = love.audio.newSource('Audio/jump.wav', 'static')
--SHOT:setPitch(2.5)	--optional
	
	--EGGS
DARKYELLOWSPOTEGG = love.graphics.newImage("Sprites/Eggs/darkyellowspotegg.png")
DOGEGG  = love.graphics.newImage("Sprites/Eggs/dogegg.png")
EGG  = love.graphics.newImage("Sprites/Eggs/egg.png")
EVILEGG  = love.graphics.newImage("Sprites/Eggs/evilegg.png")
GOLDEGG  = love.graphics.newImage("Sprites/Eggs/goldegg-SpriteSheet.png")
HOLYEGG  = love.graphics.newImage("Sprites/Eggs/holyegg.png")
ICYEGG  = love.graphics.newImage("Sprites/Eggs/icyegg.png")
PURPLESTRIPEDEGG  = love.graphics.newImage("Sprites/Eggs/purplestripedegg.png")
REDSPOTEGG  = love.graphics.newImage("Sprites/Eggs/redspotegg.png")
SMILEYEGG  = love.graphics.newImage("Sprites/Eggs/smilyegg.png")
SOURAPPLEEGG  = love.graphics.newImage("Sprites/Eggs/sourappleegg.png")
SPARKLES = love.graphics.newImage("Sprites/Eggs/sparkles-SpriteSheet.png")
--LIST OF EGGS AND THEIR FRAMES FOR ANIM
EGG_PRESET = {
	{image = DARKYELLOWSPOTEGG}, 
	{image = DOGEGG},
	{image = EVILEGG},
	{image = GOLDEGG, frames = {0, 1, 2}},
	{image = HOLYEGG},
	{image = ICYEGG},
	{image = PURPLESTRIPEDEGG},
	{image = REDSPOTEGG},
	{image = SMILEYEGG},
	{image = SOURAPPLEEGG},
}
	
	--ENVIRONMENT
BACKGROUND = love.graphics.newImage("Sprites/Environment/background.png")
STONE = love.graphics.newImage("Sprites/Environment/StoneViney.png")
STONE:setWrap("repeat", "repeat")
STONE_FRAMES = {0,1,2}
WOOD = love.graphics.newImage("Sprites/Environment/plainWood.png")
WOOD:setWrap("repeat", "repeat")
WOOD_FRAMES = {0}
DIRT = love.graphics.newImage("Sprites/Environment/dirt.png")
DIRT:setWrap("repeat", "repeat")
DIRT_FRAMES = {0}
GRASS = love.graphics.newImage("Sprites/Environment/grass.png")
GRASS:setWrap("repeat", "repeat")
GRASS_FRAMES = {0}
	
	--UNITS
OWLSPRITESHEET = love.graphics.newImage("Sprites/Units/owl-SpriteSheet.png")
