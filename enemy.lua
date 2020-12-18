enemies = layer {}

enemy = class {
    layer = enemies,
    sprite = 3,
    explosion = 8,
    col = { l=0, r=8, u=0, d=8 }
}

function enemy_make()
	enemy {
		x = rnd(120),
		y = -8,
        dx = rnd(3) - 2,
    }:add()
end

function enemy:update()
	self.x += self.dx
	self.y += 0x2
	if self.x > 120 then
		self.x = 120
		self.dx = -self.dx
	elseif self.x < 0 then 
		self.x = 0
		self.dx = -self.dx
    end
    if self.y > 128 then
        self:remove()
    end
end

function enemy:draw()
	fillp(0)
	spr(self.sprite, self.x, self.y)
end