-- main logic
-- this is where _init _update and _draw live

function _init()
	cartdata("space")
	load_hiscore()

	-- start achieve loop
	play(achieve_display_loop)

	starfield:init()
	reset()
end

function _update60()
	starfield:update()

	script_update(game_scripts)
	if (active_level) script_update(active_level)

	for i in pairs(bg_fx) do i:update() end
	for i in pairs(player_bullets) do i:update() end
	for i in pairs(enemies) do i:update() end
	for i in pairs(enemy_bullets) do i:update() end
	for i in pairs(powerups) do i:update() end
	for i in pairs(players) do i:update() end
	for i in pairs(fg_fx) do i:update() end
	for i in pairs(game_text) do i:update() end

	grid_players = collision_grid(players)
	grid_enemies = collision_grid(enemies)
	grid_player_bullets = collision_grid(player_bullets)
	grid_enemy_bullets = collision_grid(enemy_bullets)
	grid_powerups = collision_grid(powerups)

	collision_grid_pairs_foreach(grid_players, grid_enemies, function(p, e)
		p:hit(e)
		e:hit(p)
	end)
	collision_grid_pairs_foreach(grid_players, grid_enemy_bullets, function(p, b)
		p:hit(b)
		b:hit(p)
	end)
	collision_grid_pairs_foreach(grid_players, grid_powerups, function(p, pu)
		pu:collect(p)
	end)
	collision_grid_pairs_foreach(grid_player_bullets, grid_enemies, function(b, e)
		e:hit(b)
		b:hit(e)
	end)

	-- TODO custom menu?
	-- What we could do is force draw a menu around the pause menu
	-- locations and flip() it before allowing the pause
	-- if(btn(6)) poke(0x5f30,1)
	if waiting and btn()&0x3F != 0 then
		start()
	end
end

function _draw()
	cls()
	clip(0, 128-screen_h, screen_w, 128)
	camera(0, screen_h-128)

	starfield:draw()

	for i in pairs(bg_fx) do i:draw() end
	-- TODO this as a bg_fx entity
	for i in pairs(enemies) do draw_shielding(i) end
	for i in pairs(player_bullets) do i:draw() end
	for i in pairs(enemies) do i:draw() end
	for i in pairs(enemy_bullets) do i:draw() end
	for i in pairs(powerups) do i:draw() end
	for i in pairs(players) do i:draw() end
	for i in pairs(fg_fx) do i:draw() end
	for i in pairs(game_text) do i:draw() end

	clip()
	camera(0,0)
	color(7)
	score_print(hiscore, 128, 1, 1)
	score_print(score, 128, 8, 1)

	for i = 1, lives do
		spr(player.sprite, (i * 9) - 8, 1)
	end

	if waiting then
		print("pRESS ANY BUTTON", 32, 60)
	end
end