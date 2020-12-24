-- bullet base class

bullet = entity {
	remove_oob = true,
	explosion = explosion {
		size = 4,
		layer = fg_fx -- draw on top!
	},
	die_sfx = 1,
	age = 0,
	scripts = {
		function(self)
			repeat
				self.age += 1
				yield()
			until false
		end
	}
}

function bullet:new(base, ox, oy)
	return self:spawn{
		x = base.x + (ox or 0) + self.dx,
		y = base.y + (oy or 0) + self.dy
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
	local l = abs(self.dy)+1
	local m = abs(self.dy)+2-self.age
	for i = l, mid(0,m,l), -1 do
		color(colors[c])
		rectfill(x, y, x + self.width - 1, y + i - 1)
		y -= i * step
		if (c < #colors) c += 1
	end
end