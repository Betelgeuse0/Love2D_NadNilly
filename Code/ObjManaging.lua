
objs = {}

function objs.update(dt)
	for i,o in ipairs(objs) do 
		o:update(dt, i)
		objs.globalUpdate(o, i)
	end
end

function objs.draw()
	for i,o in ipairs(objs) do 
		o:draw()
	end
end

function objs.remove(i)
	local o = objs[i]
	if o.physics ~= nil then 
		o.physics.body:destroy()
		o.physics = nil
	end
	table.remove(objs, i)
end

--for specific updates we want to apply globally to the objects

function objs.globalUpdate(o, i)

	--destroy objects that go out of the bottom of the screen
	local oy = nil

	if o.name == "egg" then 
		local x, y = GetPolygonCenter(o)
		oy = o.y or y
	elseif o.name ~= "Bjornio" then 
		oy = o.physics.body:getY()
	end

	if oy ~= nil and (oy - 80) > (-Camera.y + WINDOW_HEIGHT) then 
		objs.remove(i);
	end
end