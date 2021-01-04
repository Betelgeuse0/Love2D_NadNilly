function Platform(x, y, image, tileAmount, frames)
	local o = {}
	o.update = PlatformUpdate 
	o.draw = PlatformDraw 
	o.image = image
	o.tileAmount = tileAmount
	o.frames = frames or 0
	o.platform = NewHorizontalAnimation(o.image, o.tileAmount * PLATFORM_WIDTH, PLATFORM_HEIGHT, o.frames)
	SetUpPhysics(o, x, y, PLATFORM_WIDTH * o.tileAmount, PLATFORM_HEIGHT, "static", 1, true)
	table.insert(objs, o)
	return o	--new instance
end

function PlatformUpdate(o, dt, i)
	UpdateAnimation(dt, o.platform, ANIM_SPEED)
end

function PlatformDraw(o)
	--DrawPhysics(o, {0, 0, 1, 1})	--Uncomment to test collision zone
	DrawPlatformAnimation(o, o.platform, (PLATFORM_WIDTH * o.tileAmount / 2), PLATFORM_HEIGHT/2)
end