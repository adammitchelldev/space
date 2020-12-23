-- main logic
-- this is where _init _update and _draw live

main_scripts = {}
-- helper function to play global scripts
-- that don't belong to a specific entity
function play(f, ...) return script_play(main_scripts, f, ...) end

-- TODO find a better home
function roll_powerup(x, y)
	next_powerup -= 1
	if next_powerup <= 0 then
		sfx(9)
		powerup:spawn{x = x, y = y}
		next_powerup = flr(rnd(5)) + 10
	end
end

-- TODO find a better home, game.lua?
function score_add(x)
	if (alive) score += x >> 16
	-- use google to convert number to hex, then shift right 4 digits
	-- remember to remove a 0!
	if (score > 0x0.4E20) achieve(7)
	if (score > 0x0.C350) achieve(8)
	if (score > 0x1.86A0) achieve(9)
end

-- TODO ditto, also reduce token count
function score_print(score, x, y, pad)
	if score == 0 then pad = 0 else pad = pad or 0 end
	local i = 1
	while i <= pad do
		x -= 4
		print("0", x, y)
		if ((i % 3)==0) x-=1
		i += 1
	end
	local n = score
	repeat
		x -= 4
		print((n % 0x0000.000a) << 16, x, y)
		n /= 10
		if ((i % 3)==0) x-=1
		i += 1
	until n == 0
end

function reset()
	if (active_level) active_level:remove()

	for i in pairs(bg_fx) do i:remove() end
	for i in pairs(player_bullets) do i:remove() end
	for i in pairs(enemies) do i:remove() end
	for i in pairs(enemy_bullets) do i:remove() end
	for i in pairs(players) do i:remove() end
	for i in pairs(fg_fx) do i:remove() end
	for i in pairs(game_text) do i:remove() end

	waiting = true
	alive = false
	lives = 2
	score = 0
	kills = 0
	boss_kills = 0
	next_powerup = flr(rnd(5)) + 10
end

function start()
	sfx(5)
	waiting = false
	alive = true
	player:spawn{}
	active_level = level_simple:spawn{}
	-- active_level = level_test:spawn{}
end

function load_hiscore()
	hiscore = dget(0)
end

function save_hiscore()
	if score > hiscore then
		hiscore = score
		dset(0, hiscore)
		play(function()
			t = text:new("hI-sCORE!!", 45, 20)
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

function player_die(p)
	if lives > 0 then
		play(function()
			wait(120)
			lives -= 1
			player:spawn{iframes = 120}
		end)
	else
		game_over()
	end
end

-- TODO move these scripts onto a game manager
function game_over()
	play(function()
		active_level:remove()
		alive = false
		save_hiscore()
		wait(60)
		local t = text:new("gAME oVER", 64, 64)
		text_scene_type(t, 5)
		wait(120)
		waiting = true
		t:remove()
	end)
end

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

	script_update(main_scripts)
	if (active_level) script_update(active_level)

	for i in pairs(bg_fx) do i:update() end
	for i in pairs(player_bullets) do i:update() end
	for i in pairs(enemies) do i:update() end
	for i in pairs(enemy_bullets) do i:update() end
	for i in pairs(powerups) do i:update() end
	for i in pairs(players) do i:update() end
	for i in pairs(fg_fx) do i:update() end
	for i in pairs(game_text) do i:update() end

	local players_grid = collision_grid(players)
	local enemies_grid = collision_grid(enemies)
	local player_bullets_grid = collision_grid(player_bullets)
	local enemy_bullets_grid = collision_grid(enemy_bullets)
	local powerups_grid = collision_grid(powerups)

	collision_grid_pairs_foreach(players_grid, enemies_grid, function(p, e)
		p:hit(e)
		e:hit(p)
	end)
	collision_grid_pairs_foreach(players_grid, enemy_bullets_grid, function(p, b)
		p:hit(b)
		b:hit(p)
	end)
	collision_grid_pairs_foreach(players_grid, powerups_grid, function(p, pu)
		pu:collect(p)
	end)
	collision_grid_pairs_foreach(player_bullets_grid, enemies_grid, function(b, e)
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