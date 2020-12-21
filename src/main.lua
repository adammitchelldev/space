lives = 0
score = 0
hiscore = 0
waiting = true
alive = false
next_powerup = 0

screen_height = 114

players = layer(player)
enemies = layer(enemy)
bullets = layer(bullet)
player_bullets = layer(player_bullet)
enemy_bullets = layer(enemy_bullet)
powerups = layer(powerup)
explosions = layer(explosion)
texts = layer(text)

function score_add(x)
	if (alive) score += x >> 16
end

function roll_powerup(x, y)
	next_powerup -= 1
	if next_powerup <= 0 then
		sfx(9)
		powerup_make({x = x, y = y})
		next_powerup = flr(rnd(5)) + 10
	end
end

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
	powerups:remove()

	sfx(5)
	lives = 2
	waiting = false
	score = 0
	alive = true
	next_powerup = flr(rnd(5)) + 10
	player:new()
	-- level_simple()
	level_test()
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

function player_die(p)
	if lives > 0 then
		play(function()
			wait(200)
			lives -= 1
			player:new().iframes = 120
		end)
	else
		game_over()
	end
end

game_over = script(function()
	level_stop()
	alive = false
	save_hiscore()
	wait(60)
	local t = text_box("game over", 46, 60)
	t.bg = false
	text_scene_type(t, "gAME oVER", 5)
	wait(120)
	waiting = true
	t:remove()
end)


function _update60()
	if waiting and btn() != 0 then
		reset()
	end

	script_update()

	starfield:update()

	players:update()
	enemies:update()
	bullets:update()
	powerups:update()
	
	explosions:update()

	collision_update()
end

function _draw()
	cls()
	clip(0, 128-screen_height, 128, 128)
	camera(0, screen_height-128)
	starfield:draw()
	enemies:draw()
	player_bullets:draw()
	enemy_bullets:draw()
	explosions:draw()
	powerups:draw()
	players:draw()
	texts:draw()

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

	--print(stat(1), 0, 0, 7)
end