score = 0
hiscore = 0
alive = false

function score_add(x)
	if (alive) score += x >> 15
end

function score_print(score, x, y, pad)
	local n = score
	pad = pad or 0
	for i = 1, pad do
		x -= 4
		print("0", x, y)
	end
	repeat
		x -= 4
		print((n % 0x0000.000a) << 16, x, y)
		n /= 10
	until n == 0
end

function _init()
	cartdata("space")
	menuitem(2, "clear hiscore", function()
		dset(0, 0)
		hiscore = 0
	end)
	load_hiscore()

	starfield:init()
end

function reset()
	players:remove()
	enemies:remove()
	bullets:remove()
	sfx(5)
	player_make()
	enemy_make()
	alive = true
	score = 0
end

function load_hiscore()
	hiscore = dget(0)
end

function save_hiscore()
	if score > hiscore then
		hiscore = score
		dset(0, hiscore)
	end
end

function _update60()
	if not alive and btnp(5) then
		reset()
	end

	score_add(1)

	starfield:update()

	players:update()
	enemies:update()
	bullets:update()
	powerups:update()

	grid_enemies = collision_grid(enemies)
	grid_players = collision_grid(players)
	grid_bullets = collision_grid(bullets)
	grid_powerups = collision_grid(powerups)

	collision_grid_pairs_foreach(grid_enemies, grid_bullets, function(e, b)
		sfx(1)
		e:explode()
		b:explode()
		score_add(e.value)
		if rnd(20) < 1 then
			powerup_make(e)
		end
	end)

	collision_grid_pairs_foreach(grid_players, grid_enemies, function(p, e)
		sfx(1)
		p:explode()
		alive = false
		save_hiscore()
	end)

	collision_grid_pairs_foreach(grid_players, grid_powerups, function(p, pu)
		sfx(6)
		pu:remove()
		score_add(1000)
		if p.shot_delay > 1 then
			p.shot_delay -= 1
		end
	end)

	explosions:update()

	--TODO put this somewhere else
	if rnd(1) < rnd(score / ((score + 1))) then

		if flr(rnd(50)) == 0 then
			enemy_green_make()
		else
			enemy_make()
		end
	end
end

function _draw()
	cls()
	starfield:draw()
	enemies:draw()
	bullets:draw()
	explosions:draw()
	powerups:draw()
	players:draw()

	-- color(9)
	-- collision_grid_draw_debug(grid_enemies)
	-- color(10)
	-- collision_grid_draw_debug(grid_bullets)
	-- color(11)
	-- collision_grid_draw_debug(grid_players)

	color(7)
	score_print(hiscore, 128, 2, 1)
	score_print(score, 128, 10, 1)

	if not alive then
		print("pRESS ❎ TO PLAY", 32, 60)
	end
end