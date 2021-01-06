--Make new bullet
function shootBullet(x, y, direction)
	y = y - 4	--make the bullet same height as bjornio
	if direction == 1 then
		xvel = 1000
		x = x + 60  --make it so bullet shoot from right side of bjornio
	else
		x = x - 60
		xvel = -1000
	end
    local bullet = {image = BULLET, x = x, y = y, velx = xvel, vely = 0, direction = direction, hasHit = false, name = "bullet"}
    SetUpPhysics(bullet, x, y-6, 16, 12, "dynamic", 0, true, nil, bullet)
    --bullet.physics.body:setBullet(true)

    if not lost then	--If you lose, don't shoot bullets. maybe remove this.
    	table.insert(ACTIVEBULLETS, bullet)
	end
    return bullet
end

--Update current bullets and clean em up
function projectileUpdater(dt)
	for i,bullet in ipairs(ACTIVEBULLETS) do      --Make bullet move
		bullet.x = bullet.x + (bullet.velx * dt)			--bullet speed
		bullet.physics.body:setX(bullet.x)	--- (16 * bullet.direction) + bullet.velx * dt
		bullet.physics.body:setY(bullet.y-6)
	end

	for i,bullet in ipairs(ACTIVEBULLETS) do		--Clean up projectile
		if bullet.x > WINDOW_WIDTH or bullet.x < 0 or bullet.hasHit then
			bullet.physics.body:destroy()
			table.remove(ACTIVEBULLETS, i)
		end
	end
end
