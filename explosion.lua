function explosion_make(x, y, size)
	local e = {
		x = x,
		y = y,
		size = size,
		age = 0
	}
	sfx(1)
	layer_add(explosions, e)
end

function explosion_update(e)
	e.age += 1
	if (e.age > 5) layer_remove(explosions, e)
end

function explosion_draw(e)
	local x = e.x
	local y = e.y
	local c = heat_colors[e.age]
	local s = e.size * (1 + (e.age - 1) * 0.2)
	color(c)
	fillp(explosion_dither[e.age])
	circfill(x, y, s)
end