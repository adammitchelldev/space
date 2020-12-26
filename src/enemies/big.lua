-- big boss enemy

function enemy_shoot_big(self)
    wait(200)
    repeat
        local r = flr(rnd(50))
        if r < 30 then
            for i = 1, 8 do
                sfx(11)
                enemy_bullet:new(self, 2, 12)
                enemy_bullet:new(self, 12, 12)
                wait(6)
            end
        else
            local d = flr(rnd(2))
            if (d == 0) d = -1
            for i = 1, 5 do
                sfx(11)
                local dx = (i - 3) * d
                enemy_bullet:new(self, 2, 12).dx = dx
                enemy_bullet:new(self, 12, 12).dx = dx
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
    sprite = 14,
    sprite_w = 2,
    sprite_h = 2,
    explosion = big_explosion,
    die_sfx = 7,
    value = 250,
    health = 50,
    dx = 0.5,
    dy = 0.25,
    w = 16,
    h = 16,
    bounce = { l=24, r=screen_w-24, u=10, d=50 },
    bounce_sfx = false,
    coll = true,
    coll_l = 2,
    coll_r = 14,
    coll_u = 2,
    coll_d = 14,
    scripts = {
        enemy_move_fast,
        enemy_shoot_big,
        enemy_big_sfx -- TODO make a generic sound function
    }
}

function enemy_big:die()
    enemy.die(self)
    boss_kills += 1
    lives += 1
    if (boss_kills == 1) achieve(3)
    if (boss_kills == 5) achieve(6)
end

function enemy_big:remove()
    sfx(-1,2)
    enemy.remove(self)
end