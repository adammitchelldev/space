function enemy_make()
	local e = enemy {
		x = rnd(120),
		y = -8,
        dx = rnd(3) - 2,
    }
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

function enemy_draw(e)
	fillp(0)
	spr(enemy.sprite, e.x, e.y)
end