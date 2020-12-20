bullets = layer {}
enemy_bullets = layer {}

bullet = class {
	layer = bullets,
	colors = heat_colors,
	explosion = 5,
    col = { l=0, r=1, u=0, d=6 }
}

enemy_bullet = bullet {
	layer = enemy_bullets,
	colors = alien_colors,
	col = { l=1, r=3, u=0, d=2 }
}

function bullet_make(ty, x, y, dy, width)
	ty {
		x = x,
		y = y,
		dy = dy,
		width = width or 1
	}:add()
end

function bullet:update()
	self.y += self.dy

	if self.y >= 128 or self.y < -8 or self.x >= 128 or self.x < -8 then
        self:remove()
    end
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
	for i = abs(self.dy), 1, -1 do
		color(colors[c])
		rectfill(x, y, x + self.width - 1, y + i - 1)
		y -= i * step
		if (c < #colors) c += 1
	end
end