lives = 0
score = 0
hiscore = 0
waiting = true
alive = false
next_powerup = 0
kills = 0
boss_kills = 0

screen_height = 114

-- players = layer(player)
-- enemies = layer(enemy)
-- bullets = layer(bullet)
-- player_bullets = layer(player_bullet)
-- enemy_bullets = layer(enemy_bullet)
-- powerups = layer(powerup)
-- explosions = layer(explosion)
-- texts = layer(text)

-- layers = {
-- 	layer(player),
-- 	layer(enemy),
-- 	layer(bullet),
-- 	layer(powerup),
-- 	layer(explosion),
-- 	layer(texts)
-- }

w = world({
	script_add_listener,
	collision_add_listener
}, {
	collision_remove_listener
})

function score_add(x)
	if (alive) score += x >> 16
	-- use google to convert number to hex, then shift right 4 digits
	-- remember to remove a 0!
	if (score > 0x0.4E20) achieve(7)
	if (score > 0x0.C350) achieve(8)
	if (score > 0x1.86A0) achieve(9)
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
	menuitem(1, "clear achieves", clear_achievements)
	menuitem(2, "clear hiscore", function()
		dset(0, 0)
		hiscore = 0
	end)
	load_hiscore()

	starfield:init()
end

function reset()
	level_stop()

	w:process{function(e) e:remove() end}

	sfx(5)
	lives = 2
	waiting = false
	score = 0
	alive = true
	kills = 0
	boss_kills = 0
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

-- TODO move these scripts onto a game manager
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

update_systems = {
	update_scripts,
	function(e) if e.update then e:update() end end,
	move,
	bounce,
	remove_oob,
	ttl
}

draw_systems = {
	function(e)
		e:draw()
	end
}

class.x,class.y,class.dx,class.dy = 0,0,0,0

function _update60()
	-- TODO custom menu?
	-- What we could do is force draw a menu around the pause menu
	-- locations and flip() it before allowing the pause
	-- if(btn(6)) poke(0x5f30,1)
	if waiting and btn()&0x3F != 0 then
		reset()
	end

	script_update()

	starfield:update()

	w:process(update_systems)

	collision_update()
end

function _draw()
	cls()
	clip(0, 128-screen_height, 128, 128)
	camera(0, screen_height-128)
	starfield:draw()

	w:process(draw_systems)

	clip()
	camera(0,0)
	color(7)
	score_print(hiscore, 128, 1, 1)
	score_print(score, 128, 8, 1)
	-- print(kills.."/"..boss_kills, 60, 1)

	for i = 1, lives do
		spr(player.sprite, (i * 9) - 8, 1)
	end

	if waiting then
		print("pRESS ANY BUTTON", 32, 60)
	end

	--print(stat(1), 0, 0, 7)
end