function Platform(x, y, w, h)
	local o = {update = PlatformUpdate, draw = PlatformDraw}
	SetUpPhysics(o, x, y, w, h, "static", 1, true)
	table.insert(objs, o)
	return o	--new instance
end

function PlatformUpdate(o, dt, i)
	--StaticFall(o, dt, 50)
	--todo: add death here
end

function PlatformDraw(o)
	DrawPhysics(o, {0, 0, 1, 1})
end