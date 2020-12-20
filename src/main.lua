score = 0
hiscore = 0
alive = false
waiting = true

function score_add(x)
	if (alive) score += x >> 15
end

function score_print(score, x, y, pad)
	if score == 0 then pad = 0 else pad = pad or 0 end
	for i = 1, pad do
		x -= 4
		print("0", x, y)
	end
	local n = score
	repeat
		x -= 4
		print((n % 0x0000.000a) << 16, x, y)
		n /= 10
	until n == 0
end

function _init()
	cartdata("space")
	menuitem(1, "clear hiscore", function()
		dset(0, 0)
		hiscore = 0
	end)
	load_hiscore()

	starfield:init()
end

function reset()
	level_stop()

	players:remove()
	enemies:remove()
	bullets:remove()
	enemy_bullets:remove()
	powerups:remove()

	sfx(5)
	player_make()
	alive = true
	waiting = false
	score = 0
	level_simple()
end

function load_hiscore()
	hiscore = dget(0)
end

function save_hiscore()
	if score > hiscore then
		hiscore = score
		dset(0, hiscore)
		play(function()
			t = text_box("hI-sCORE!!", 45, 20)
			t.bg = nil
			for i = 1,10 do
				wait(10)
				t.fg = nil
				sfx(10)
				wait(10)
				t.fg = 7
			end
			wait(30)
			t:remove()
		end)
	end
end

function player_enemy_collision(p, e)
	level_stop()

	sfx(1)
	p:explode()
	alive = false
	sfx(7)
	big_explosion(p.x, p.y)

	play(function()
		local t = text_box("game over", 46, 60)
		t.bg = false
		text_scene_type(t, "gAME oVER", 5)
		wait(50)
		waiting = true
		t:remove()
	end)
	save_hiscore()
end

function _update60()
	if waiting and btnp(5) then
		reset()
	end

	score_add(1)

	script_update()

	starfield:update()

	players:update()
	enemies:update()
	bullets:update()
	enemy_bullets:update()
	powerups:update()

	grid_enemies = collision_grid(enemies)
	grid_players = collision_grid(players)
	grid_bullets = collision_grid(bullets)
	grid_enemy_bullets = collision_grid(enemy_bullets)
	grid_powerups = collision_grid(powerups)

	collision_grid_pairs_foreach(grid_enemies, grid_bullets, function(e, b)
		sfx(1)
		b:explode()
		if e.health then
			e.health -= 1
			if (e.health > 0) return
		end
		e:explode()
		score_add(e.value)
		play(text_rising_box(tostr(e.value).."0", e.x, e.y))
		if rnd(20) < 1 then
			sfx(9)
			powerup_make(e)
		end
	end)

	collision_grid_pairs_foreach(grid_players, grid_enemies, player_enemy_collision)
	collision_grid_pairs_foreach(grid_players, grid_enemy_bullets, player_enemy_collision)

	collision_grid_pairs_foreach(grid_players, grid_powerups, function(p, pu)
		sfx(6)
		pu:remove()
		score_add(500)
		play(text_rising_box("5000", pu.x + 4, pu.y - 8))
		if p.shot_delay > 20 then
			p.shot_delay -= 3
			play(text_rising_box("gUN uP", pu.x + 4, pu.y))
		elseif p.shot_delay > 10 then
			p.shot_delay -= 2
			play(text_rising_box("gUN uP", pu.x + 4, pu.y))
		elseif p.shot_delay > 1 then
			p.shot_delay -= 1
			play(text_rising_box("gUN uP", pu.x + 4, pu.y))
		else
			play(text_rising_box("max!", pu.x, pu.y))
		end
	end)

	explosions:update()

	--TODO put this somewhere else
	-- if rnd(1) < rnd(score / ((score + 1))) then

	-- 	if flr(rnd(10)) == 0 then
	-- 		enemy_green_make()
	-- 	else
	-- 		enemy_make()
	-- 	end
	-- end
end

function _draw()
	cls()
	starfield:draw()
	enemies:draw()
	bullets:draw()
	enemy_bullets:draw()
	explosions:draw()
	powerups:draw()
	players:draw()
	texts:draw()

	-- color(9)
	-- collision_grid_draw_debug(grid_enemies)
	-- color(10)
	-- collision_grid_draw_debug(grid_bullets)
	-- color(11)
	-- collision_grid_draw_debug(grid_players)

	color(7)
	score_print(hiscore, 128, 2, 1)
	score_print(score, 128, 10, 1)

	if waiting then
		print("pRESS ❎ TO PLAY", 31, 60)
	end

	print(stat(1), 0, 0, 7)
end