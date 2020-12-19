bullets = layer {}

bullet = class {
    layer = bullets,
    explosion = 5,
    col = { l=0, r=2, u=0, d=6 }
}

function bullet_make(x, y, speed, width)
	bullet {
		x = x,
		y = y,
		speed = speed,
		width = width or 1
	}:add()
end

function bullet:update()
	self.y -= self.speed

	if self.y < -16 then
		self:remove()
	end
end

function bullet:draw()
	local x = self.x
	local y = self.y
	local c = 1
	fillp(0)
	for i = self.speed, 1, -1 do
		color(heat_colors[c])
		rectfill(x, y, x + self.width - 1, y + i - 1)
		y += i
		if (c < 5) c += 1
	end
end