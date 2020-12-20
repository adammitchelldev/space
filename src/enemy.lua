enemies = layer {}

enemy = class {
    layer = enemies,
    draw = draw_sprite(3),
    sfx = 3,
    bounce_sfx = 2,
    bounce = { l=0, r=120, u=0, d=60 },
    explosion = 8,
    x = 60,
    y = -8,
    dy = 1,
    dx = 0,
    value = 75,
    col = { l=0, r=8, u=0, d=8 }
}

enemy_green = enemy {
    draw = draw_sprite(4),
    explosion = 16,
    value = 1250,
    dy = 2,
    bounce = false
}

function enemy_make(t)
    t = t or {
		x = rnd(120),
		y = -8,
        dx = rnd(4) - 2,
    }
	enemy(t):add()
    sfx(enemy.sfx) -- TODO make this an event
end

function enemy_green_make(t)
    t = t or {
		x = rnd(120),
		y = -8,
        dx = 0,
    }
    enemy_green(t):add()
    sfx(enemy.sfx)
end

function enemy_green:explode()
    sfx(8)
    enemy.explode(self)
end

function enemy_move(self)
    self.x += self.dx
    self.y += self.dy

    if self.bounce then
        local b = self.bounce
        if b.l and self.x < b.l and self.dx < 0 then
            self.x = b.l
            self.dx = -self.dx
            sfx(self.bounce_sfx)
        elseif b.r and self.x > b.r and self.dx > 0 then
            self.x = b.r
            self.dx = -self.dx
            sfx(self.bounce_sfx)
        elseif b.u and self.y < b.u and self.dy < 0 then
            self.y = b.u
            self.dy = -self.dy
            sfx(self.bounce_sfx)
        elseif b.d and self.y > b.d and self.dy > 0 then
            self.y = b.d
            self.dy = -self.dy
            sfx(self.bounce_sfx)
        end
    end

    -- TODO this should pick up the play area size
    if self.y >= 128 or self.y < -8 or self.x >= 128 or self.x < -8 then
        self:remove()
    end
end

function enemy_shoot(self)
    repeat
        wait(flr(rnd(340)) + 40)
        sfx(11)
        bullet_make(enemy_bullet, self.x + 2, self.y + 4, 2, 4)
    until false
end

enemy.update = {
    enemy_move,
    enemy_shoot
}

enemy_green.update = {
    function(self)
        local p = layer_each(players)()
        if (not p) return
        
        if vec_dist2(self, p) < (64 * 64) then
            local d = {
                x = p.x - self.x,
                y = p.y - self.y
            }
            vec_normalize(d, 4)
            self.dx = 0
            self.dy = 0
            for i = 1,20 do
                sfx(4)
                wait(1)
            end
            self.dx = d.x
            self.dy = d.y
            repeat
                sfx(4)
                wait(1)
            until false
        end
    end,
    enemy_move
}
