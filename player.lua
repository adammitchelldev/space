function player_init()
    player.x = 60
    player.y = 120
    player.atk = 0
end

function player_shoot()
    if player.atk == 0 then
		bullet_make(player.x + 3, player.y - 4, player.shot.speed, player.shot.width)
		player.atk = player.shot.delay
	end
end

function player_update()
	local dx = 0
	local dy = 0

	if (btn(0)) dx -= 1
	if (btn(1)) dx += 1
	if (btn(2)) dy -= 1
	if (btn(3)) dy += 1

	player.x += dx
	player.y += dy

    -- TODO refactor out into a separate "weapon" table
	if (player.atk > 0) player.atk -= 1

	if (btn(4)) player_shoot()
end

function player_draw()
	spr(player.sprite, player.x, player.y)
end