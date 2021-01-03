
function Owl(x, y)
	local o = {update = OwlUpdate, draw = OwlDraw}
	o.anim = NewHorizontalAnimation(OWLSPRITESHEET, 71, 57, {0, 1, 2, 3})
	--SetUpPhysics(o, x, y, 41, 51, "static", 1, true, 0)
	SetUpPhysics(o, x, y, 71, 71, "static", 1, true, 0)
	table.insert(objs, o)
	return o
end

function OwlUpdate(o, dt, i)
	UpdateAnimation(dt, o.anim, 0.2)
	--StaticFall(o, dt, 50)
end

function OwlDraw(o)
	--DrawPhysics(o, {0, 1, 0, 1})
	DrawPhysicsAnimation(o, o.anim, 35, 31, 2, 2)
end