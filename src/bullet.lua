-- bullet base class

bullet = entity {
	remove_oob = true,
	explosion = explosion {
		size = 4,
		layer = fg_fx -- draw on top!
	},
	h = 20, -- for oob
	die_sfx = 1,
	age = 0
}

function bullet:new(base, ox, oy)
	return self:spawn{
		x = base.x + (ox or 0) + self.dx,
		y = base.y + (oy or 0) + self.dy
	}
end

function bullet:update()
	entity.update(self)
	self.age += 1
end

function bullet:draw()
	local colors, x, y, dy, c = self.colors, self.x, self.y, self.dy, 1
	local step, l, m = sgn(dy), abs(dy) + 1, abs(dy) + 2 - self.age
	if step == 1 then
		y += dy
	end
	for i = l, mid(0,m,l), -1 do
		color(colors[c])
		rectfill(x, y, x + self.w - 1, y + i - 1)
		y -= i * step
		if (c < #colors) c += 1
	end
end