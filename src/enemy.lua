enemies = layer {}

enemy = class {
    layer = enemies,
    draw = draw_sprite(3),
    sfx = 3,
    bounce_sfx = 2,
    explosion = 8,
    speed = 1,
    value = 100,
    col = { l=0, r=8, u=0, d=8 }
}

enemy_green = enemy {
    draw = draw_sprite(4),
    explosion = 16,
    value = 1000,
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
    if self.y > 128 then
        self:remove()
    end
end

function enemy_green:update()
    for p in layer_each(players) do
        if self.y > p.y - 60 then
            if self.x < p.x then
                self.dx += 0x0.2
            elseif self.x > p.x then
                self.dy = -0x0.2
            end
        end
    end

    sfx(4) --TODO constant
    
    enemy.update(self)
end
