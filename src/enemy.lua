-- base enemy class

enemy = entity {
    layer = enemies,
    remove_oob = true,
    explosion = explosion{size=6},
    die_sfx = 1,
    coll = true,
    coll_r = 8,
    coll_d = 8
}

enemy_bullet = bullet {
    layer = enemy_bullets,
	colors = alien_colors,
	w = 2,
	dy = 1.5,
    coll = true,
    coll_l=1,
    coll_r=3,
    coll_d=2
}

function enemy:die()
    entity.die(self)
    score_add(self.value)
    kills += 1
    if (kills == 1) achieve(1)
    if (kills == 50) achieve(2)
    if (kills == 1000) achieve(4)
	text_rising:new(tostr(self.value).."0", self.x, self.y)
    roll_powerup(self.x + 2, self.y + 2) -- TODO center
end
