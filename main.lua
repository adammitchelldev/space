function _init()
	starfield:init()
	player_make()
	enemy_make()
end

function _update60()
	starfield:update()
	players:update()

	enemies:update()
	bullets:update()

	for e, b in collision_pairs(enemies, bullets) do
		e:explode()
		b:explode()
	end

	for p, e in collision_pairs(players, enemies) do
		p:explode()
	end

	explosions:update()

	if (flr(rnd(20)) == 0) enemy_make()
end

function _draw()
	cls()
	starfield:draw()
	enemies:draw()
	bullets:draw()
	explosions:draw()
	players:draw()
end