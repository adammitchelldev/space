explosions = layer {}

explosion = class {
    layer = explosions
}

function explosion_make(p)
	explosion {
		x = p.x,
		y = p.y,
		size = p.explosion,
		age = 0
	}:add()
end

function explosion:update()
	self.age += 1
	if (self.age > 5) self:remove()
end

do
    local explosion_dither = {
        0b0000000000000000,
        0b1010000010100000,
        0b1010010110100101,
        0b1111010111110101,
        0b1111010111110101,
    }

    function explosion:draw()
        local x = self.x
        local y = self.y
        local c = heat_colors[self.age]
        local s = self.size * (1 + (self.age - 1) * 0.2)
        color(c)
        fillp(explosion_dither[self.age])
        circfill(x, y, s)
    end
end

function class:explode()
    explosion_make(self)
    self:remove()
end