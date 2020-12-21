bullet = class {
	explosion = 5,
	dx = 0,
	update = {
		move,
		remove_oob
	},
	hit = standard_hit
}

function bullet:new(x, y)
	return self {
		x = x,
		y = y,
	}:add()
end

function bullet:die(obj)
	sfx(1)
	self:explode()
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