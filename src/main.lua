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
	collision_add_listener
}, {
	collision_remove_listener
})

main_scripts = {}
function play(f, ...) return script_play(main_scripts, f, ...) end

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
		powerup:spawn{x = x, y = y}
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
	play(achieve_loop)
	starfield:init()
	reset()
end

function reset()
	-- if (active_level) active_level:remove()

	w:process{function(e) e:remove() end}

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
		local t = text:new("gAME oVER", 46, 60)
		text_scene_type(t, 5)
		wait(120)
		waiting = true
		t:remove()
	end)
end

update_systems = {
	function(e) if e.update then e:update() end end,
}

draw_systems = {
	draw_shielding,
	function(e) if e.draw then e:draw() end end,
	draw_shielded
}

class.x,class.y,class.dx,class.dy,class.w,class.h = 0,0,0,0,8,8

function _update60()
	-- TODO custom menu?
	-- What we could do is force draw a menu around the pause menu
	-- locations and flip() it before allowing the pause
	-- if(btn(6)) poke(0x5f30,1)
	if waiting and btn()&0x3F != 0 then
		start()
	end

	starfield:update()

	script_update(main_scripts)

	w:process(update_systems)

	collision_update()
end

function _draw()
	cls()
	clip(0, 128-screen_h, screen_w, 128)
	camera(0, screen_h-128)
	starfield:draw()

	w:process(draw_systems)

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