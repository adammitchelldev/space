-- base enemy class

enemy = entity {
    tag = "enemy",
    remove_oob = true,
    explosion = explosion{size=6},
    die_sfx = 1,
    col = { l=0, r=8, u=0, d=8 },
}

enemy_bullet = bullet {
    tag = "enemy_bullet",
	colors = alien_colors,
	width = 2,
	dy = 1.5,
	col = { l=1, r=3, u=0, d=2 }
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
