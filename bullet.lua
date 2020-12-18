function bullet_make(x, y, speed, width)
	local b = {
		x = x,
		y = y,
		speed = speed,
		width = width or 1,
		col = bullet.col
	}
	sfx(0)
	layer_add(bullets, b)
end

function bullet_explode(b)
	explosion_make(b.x, b.y, bullet.explosion)
	layer_remove(bullets, b)
end

function bullet_update(b)
	b.y -= b.speed

	if b.y < -16 then
		layer_remove(bullets, b)
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