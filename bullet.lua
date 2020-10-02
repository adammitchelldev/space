function bullet_make(x, y, speed, width)
	local b = {
		x = x,
		y = y,
		speed = speed,
		width = width or 1
	}
	sfx(0)
	system_add(bullets, b)
end

function bullet_update(b)
	b.y -= b.speed

	--hacking in collision for now
	forsys(enemies, function(e)
		if b.x + 2 > e.x and b.x < e.x + 6 and b.y + 4 + b.speed > e.y and b.y < e.y + 8 then
			local ey = min(e.y + 7, b.y + b.speed)
			explosion_make(b.x, ey, bullet.explosion)
			system_remove(bullets, b)
			system_remove(enemies, e)
		end
	end)

	if b.y < -16 then
		system_remove(bullets, b)
	end
end

function bullet_draw(b)
	local x = b.x
	local y = b.y
	local c = 1
	fillp(0)
	for i = b.speed, 1, -1 do
		color(heat_colors[c])
		rectfill(x, y, x + b.width - 1, y + i - 1)
		y += i
		if (c < 5) c += 1
	end
end