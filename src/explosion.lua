
explosion = entity {}

function explosion_make(p, dx, dy)
	explosion:spawn{
		x = p.x,
        y = p.y,
        dx = p.dx,
        dy = p.dy,
		size = p.explosion,
		ttl = mid(5, p.explosion, 15)
	}
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
        local age = max(1, 6 - self.ttl)
        local x,y = self.x,self.y
        local c = heat_colors[age]
        local s = self.size * (1 + (age - 1) * 0.1)
        color(c)
        fillp(explosion_dither[age])
        circfill(x, y, s)
        fillp()
    end
end

function class:explode()
    explosion_make(self)
    self:remove()
end

big_explosion = function(self, px, py)
    for i = 1, 10 do
        wait(i)
        explosion_make({
            x = px + rnd(40) - 20,
            y = py + rnd(40) - 20,
            explosion = (rnd(2) + 1) * (11 - i)
        })
    end
end