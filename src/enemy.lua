enemies = layer {}

enemy = class {
    layer = enemies,
    draw = draw_sprite(3),
    sfx = 3,
    bounce_sfx = 2,
    explosion = 8,
    speed = 1,
    value = 75,
    col = { l=0, r=8, u=0, d=8 }
}

enemy_green = enemy {
    draw = draw_sprite(4),
    explosion = 16,
    value = 1250,
    speed = 2
}

function enemy_make()
	enemy {
		x = rnd(120),
		y = -8,
        dx = rnd(4) - 2,
    }:add()
    score_add(2)
    sfx(enemy.sfx)
end

function enemy_green_make()
    enemy_green {
		x = rnd(120),
		y = -8,
        dx = rnd(2) - 1,
    }:add()
    score_add(10)
    sfx(enemy.sfx)
end

function enemy_green:explode()
    sfx(8)
    enemy.explode(self)
end

function enemy:update()
	self.x += self.dx
	self.y += self.speed
	if self.x > 120 then
		self.x = 120
        self.dx = -self.dx
        sfx(self.bounce_sfx)
	elseif self.x < 0 then 
		self.x = 0
        self.dx = -self.dx
        sfx(self.bounce_sfx)
    end
    if self.y > 128 or self.y < -8 then
        self:remove()
    end
end

function enemy_green:update_2()
    local p = layer_each(players)()
    if (not p) return
    
    if vec_dist2(self, p) < (64 ^ 2) then
        local d = {
            x = p.x - self.x,
            y = p.y - self.y
        }
        vec_normalize(d, 4)
        self.dx = 0
        self.speed = 0
        for i = 1,20 do
            sfx(4)
            wait(1)
        end
        self.dx = d.x
        self.speed = d.y
        repeat
            sfx(4)
            wait(1)
        until false
    end
end
