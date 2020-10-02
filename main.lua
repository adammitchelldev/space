local player = {}

-- System API
function system_add(system, ent)
	system[ent] = ent
end

function system_remove(system, ent)
	system[ent] = nil
end

-- Layers
players = {}
bullets = {}
explosions = {}

enemies = {}


-- Explosion
function explosion_make(x, y, size)
	e = {
		x = x,
		y = y,
		size = size,
		age = 0
	}
	sfx(1)
	system_add(explosions, e)
end

function explosion_update(e)
	e.age += 1
	if (e.age > 5) system_remove(explosions, e)
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

-- Starfield
stars = {}
function starfield_make()
	for i = 1,100 do
		stars[i] = {
			x = rnd(128),
			y = rnd(136) - 8,
		}
	end
end

function starfield_update()
	for s in all(stars) do
		s.y += 1
		if s.y > 128 then
			s.y = rnd(8) - 8
			s.x = rnd(128)
		end
	end
end

function starfield_draw()
	color(1)
	fillp(0)
	for s in all(stars) do
		pset(s.x, s.y)
	end
end

-- Enemies
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

function enemy_draw(e)
	fillp(0)
	spr(3, e.x, e.y)
end

-- Main
function _init()
	starfield_make()
	player_init()
	enemy_make()
end

function forsys(system, func)
	for k, v in pairs(system) do
		func(v)
	end
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