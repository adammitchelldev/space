function _init()
	starfield_make()
	player_init()
	enemy_make()
end

function _update60()
	starfield_update()
	player_update()

	layer_foreach(enemies, enemy_update)
	layer_foreach(bullets, bullet_update)

	for e, b in collision_pairs(enemies, bullets) do
		e:explode()
		b:explode()
	end

	layer_foreach(explosions, explosion_update)

	if (flr(rnd(20)) == 0) enemy_make()
end

function _draw()
	cls()
	starfield_draw()
	layer_foreach(enemies, enemy_draw)
	layer_foreach(bullets, bullet_draw)
	layer_foreach(explosions, explosion_draw)
	player_draw()
end