function enemy_shoot(self)
    repeat
        wait(flr(rnd(340)) + 40)
        sfx(11)
        enemy_bullet:new(self.x + 2, self.y + 4)
    until false
end

enemy = class {
    tag = "enemy",
    remove_oob = true,
    explosion = 6,
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

function enemy:new(t)
	t = self(t):add()
    if (t.sfx) sfx(t.sfx)
end

function enemy:die()
    if (self.die_sfx) sfx(self.die_sfx)
	self:explode()
    score_add(self.value)
    kills += 1
    if (kills == 1) achieve(1)
    if (kills == 50) achieve(2)
    if (kills == 1000) achieve(4)
	play(text_rising_box(tostr(self.value).."0", self.x, self.y))
	roll_powerup(self.x, self.y)
end

enemy_normal = enemy {
    draw = draw_sprite(3),
    sfx = 3,
    bounce = {l=0,r=120,u=0,d=50,sfx=3},
    value = 10,
    dy = 1,
    scripts = {
        enemy_shoot
    }
}

enemy_green = enemy {
    draw = draw_sprite(4),
    explosion = 10,
    die_sfx = 8,
    value = 50,
    dy = 1,
    scripts = {
        function(self)
            local p
            repeat
                yield()
                p = next(collision_layers["player"])
            until p and vec_dist2(self, p) < (50 * 50)

            local dx, dy = vec_xy_normalize(p.x - self.x, p.y - self.y, 4)
            self.dx, self.dy = 0, 0
            for i = 1,20 do
                sfx(4)
                yield()
            end
            self.dx, self.dy = dx, dy
            repeat
                sfx(4) -- TODO make this an actual sound loop
                yield()
            until false
        end
    }
}

function enemy_shoot_big(self)
    wait(200)
    repeat
        local r = flr(rnd(50))
        if r < 30 then
            for i = 1, 8 do
                sfx(11)
                enemy_bullet:new(self.x + 2, self.y + 12)
                enemy_bullet:new(self.x + 12, self.y + 12)
                wait(6)
            end
        else
            local d = flr(rnd(2))
            if (d == 0) d = -1
            for i = 1, 5 do
                sfx(11)
                local dx = (i - 3) * d
                enemy_bullet:new(self.x + 2, self.y + 12).dx = dx
                enemy_bullet:new(self.x + 12, self.y + 12).dx = dx
                wait(20)
            end
        end
        wait(flr(rnd(50)) + 100)
    until false
end

function enemy_move_fast(self)
    repeat
        wait(flr(rnd(100))+200)
        if rnd(2) < 1 then
            self.dx *= 2
            self.dy *= 2
            wait(flr(rnd(20))+20)
            self.dx /= 2
            self.dy /= 2
        else
            self.dx = -self.dx
        end
    until false
end

function enemy_big_sfx(self)
    if stat(18) != 12 then
        sfx(12,2)
    end
end

enemy_big = enemy {
    remove_oob = false,
    draw = draw_sprite(14, 0, 0, 2, 2),
    explosion = 40,
    die_sfx = 7,
    value = 250,
    health = 50,
    dy = 0.25,
    bounce = { l=24, r=88, u=10, d=35 },
    bounce_sfx = false,
    col = { l=2, r=14, u=2, d=14 },
    scripts = {
        enemy_move_fast,
        enemy_shoot_big,
        enemy_big_sfx -- TODO make a generic sound function
    }
}

function enemy_big:die()
    enemy_big:super().die(self)
    big_explosion(self.x, self.y)
    boss_kills += 1
    if (boss_kills == 1) achieve(3)
    if (boss_kills == 5) achieve(6)
end

function enemy_big:remove()
    sfx(-1,2)
    enemy_big:super().remove(self)
end

enemy_hunter = enemy {
    draw = draw_sprite(5),
    value = 200,
    bounce = {l=0,r=120,u=0,d=16},
    dx = 2,
    explosion = 15,
    die_sfx = 8,
    scripts = {
        function(self)
            repeat
                local p
                repeat
                    yield()
                    p = next(collision_layers["player"])
                until p and abs(self.x - p.x) <= 8

                for i = 1, 3 do
                    wait(2)
                    sfx(11)
                    enemy_bullet:new(self.x + 3, self.y + 6).dy = 4
                end
                self.dx = -self.dx
                wait(60)
            until false
        end,
        function(self)
            repeat
                wait(flr(rnd(100))+20)
                self.dx = -self.dx
            until false
        end
    }
}
