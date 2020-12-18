-- System API
function system_add(system, ent)
	system[ent] = ent
end

function system_remove(system, ent)
	system[ent] = nil
end

function forsys(system, func)
	for k, v in pairs(system) do
		func(v)
	end
end

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
	forsys(enemies, enemy_update)
	forsys(bullets, bullet_update)
	forsys(explosions, explosion_update)

	if (flr(rnd(20)) == 0) enemy_make()
end

function _draw()
	cls()
	starfield_draw()
	forsys(enemies, enemy_draw)
	forsys(bullets, bullet_draw)
	forsys(explosions, explosion_draw)
	player_draw()
end