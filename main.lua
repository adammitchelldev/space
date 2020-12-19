score = 0
hiscore = 0
alive = false

function score_add(x)
	if (alive) score += x
end

function _init()
	cartdata("space")
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
	if btnp(5) then
		save_hiscore()
		reset()
	end

	score_add(1)

	starfield:update()
	players:update()

	enemies:update()
	bullets:update()
	powerups:update()

	for e, b in collision_pairs(enemies, bullets) do
		sfx(1)
		e:explode()
		b:explode()
		score_add(e.value)
		if rnd(20) < 1 then
			powerup_make(e)
		end
	end

	for p, e in collision_pairs(players, enemies) do
		sfx(1)
		p:explode()
		alive = false
		save_hiscore()
	end

	for p, pu in collision_pairs(players, powerups) do
		sfx(6)
		pu:remove()
		if p.shot_delay > 1 then
			p.shot_delay -= 1
		end
	end

	explosions:update()

	--TODO put this somewhere else
	if rnd(1) < rnd(score / (score + 5000)) then

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

	color(7)
	cursor(2,2)
	print(hiscore)
	cursor(2,10)
	print(score)
end