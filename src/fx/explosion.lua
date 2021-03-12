-- explosions!!!

explosion = entity {
    layer = bg_fx, -- bg by default
    size = 10
}

-- TODO rename to something more descriptive
function explosion:new(base)
	self:spawn{
		x = base.x,
        y = base.y,
        dx = base.dx,
        dy = base.dy
    }
end

function explosion:add(...)
    entity.add(self, ...)
    self.ttl = mid(5, self.size, 15)
end

big_explosion = explosion {
    size = 40,
    scripts = {
        function(self)
            for i = 1, 10 do
                wait(i)
                explosion:spawn{
                    x = self.x + rnd(40) - 20,
                    y = self.y + rnd(40) - 20,
                    dx = self.dx,
                    dy = self.dy,
                    size = (rnd(2) + 1) * (11 - i)
                }
            end
        end
    }
}

do
    local explosion_dither = {
        0b0000000000000000,
        0b1010000010100000,
        0b1010010110100101,
        0b1111010111110101,
        0b1111010111110101
    }

    function explosion:draw()
        local age = max(1, 6 - self.ttl)
        local x,y = self.x,self.y
        local c = heat_colors[age]
        local s = self.size * (1 + (age - 1) * 0.1)
        color(c)
        fillp(explosion_dither[age])
        circfill(x, y, s)
        fillp(0)
    end
end
