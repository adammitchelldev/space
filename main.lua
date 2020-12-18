-- Layers
bullets = {}
explosions = {}
enemies = {}

-- Main
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

	collision_pairs(enemies, bullets, function(e, b)
		enemy_explode(e)
		bullet_explode(b)
	
	end)

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