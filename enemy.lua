function enemy_draw(e)
	fillp(0)
	spr(3, e.x, e.y)
end

function enemy_make()
	e = {
		x = rnd(120),
		y = -8,
		dx = rnd(3) - 2,
	}
	system_add(enemies, e)
end

function enemy_update(e)
	e.x += e.dx
	e.y += 0b0.0001
	if e.x > 120 then
		e.x = 120
		e.dx = -e.dx
	elseif e.x < 0 then 
		e.x = 0
		e.dx = -e.dx
	end
end