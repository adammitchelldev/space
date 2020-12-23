bullet = entity {
	remove_oob = true,
	explosion = explosion{size=4},
	die_sfx = 1
}

function bullet:new(base, ox, oy)
	return self:spawn{
		x = base.x + (ox or 0),
		y = base.y + (oy or 0)
	}
end

function bullet:draw()
	local x = self.x
	local y = self.y
	local c = 1
	fillp(0)
	local step = sgn(self.dy)
	if step == 1 then
		y += self.dy
	end
	local colors = self.colors
	for i = abs(self.dy)+1, 0, -1 do
		color(colors[c])
		rectfill(x, y, x + self.width - 1, y + i - 1)
		y -= i * step
		if (c < #colors) c += 1
	end
end