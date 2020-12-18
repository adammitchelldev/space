score = 0
hiscore = 0

function _init()
	cartdata("space")
	load_hiscore()

	starfield:init()
end

function reset()
	players:remove()
	enemies:remove()
	bullets:remove()
	player_make()
	enemy_make()
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
	if btnp(5) then
		save_hiscore()
		reset()
	end

	starfield:update()
	players:update()

	enemies:update()
	bullets:update()

	for e, b in collision_pairs(enemies, bullets) do
		e:explode()
		b:explode()
		score += 10
	end

	for p, e in collision_pairs(players, enemies) do
		p:explode()
		save_hiscore()
	end

	explosions:update()

	if (max(0, flr(rnd(20 - (score / 200)))) == 0) enemy_make()
end

function _draw()
	cls()
	starfield:draw()
	enemies:draw()
	bullets:draw()
	explosions:draw()
	players:draw()

	color(7)
	cursor(2,2)
	print(hiscore)
	cursor(2,10)
	print(score)
end