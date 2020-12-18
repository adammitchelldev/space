enemies = layer {}

enemy = class {
    layer = enemies,
    sprite = 3,
    sfx = 2,
    bounce_sfx = 3,
    explosion = 8,
    speed = 0x2,
    value = 10,
    col = { l=0, r=8, u=0, d=8 }
}

enemy_green = enemy {
    sprite = 4,
    explosion = 16,
    value = 100,
    speed = 0x1
}

function enemy_make()
	enemy {
		x = rnd(120),
		y = -8,
        dx = rnd(3) - 2,
    }:add()
    score += 2
    sfx(enemy.sfx)
end

function enemy_green_make()
    enemy_green {
		x = rnd(120),
		y = -8,
        dx = rnd(7) - 4,
    }:add()
    score += 10
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
    local dx

    for p in layer_each(players) do
        if self.x < p.x then
            dx = 0x0.2
        elseif self.x > p.x then
            dx = -0x0.2
        end
    end

    if self.y > 80 then
        self.dx += dx
    end

    sfx(4) --TODO constant
    
    enemy.update(self)
end

function enemy:draw()
	fillp(0)
	spr(self.sprite, self.x, self.y)
end