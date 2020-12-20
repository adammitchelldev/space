players = layer {}

player = class {
	layer = players,
	sprite = 2,
	explosion = 50,
	speed = 1,
	shot_sfx = 0,
	shot_delay = 30,
	col = { l=1,r=7,u=3,d=7 }
}

function player_make()
	player {
    	x = 60,
    	y = 120,
		atk = 0,
	}:add()
end

function player:shoot()
	if self.atk == 0 then
		sfx(self.shot_sfx)
		bullet_make(bullet, self.x, self.y - 4)
		bullet_make(bullet, self.x + 7, self.y - 4)
		self.atk = self.shot_delay
	end
end

function player:update()
	local dx = 0
	local dy = 0

	if (btn(0)) dx -= 1
	if (btn(1)) dx += 1
	if (btn(2)) dy -= 1
	if (btn(3)) dy += 1

	self.x += dx * self.speed
	self.y += dy * self.speed

	if (self.x < 0) self.x = 0
	if (self.x > 120) self.x = 120
	if (self.y < 0) self.y = 0
	if (self.y > 120) self.y = 120

    -- TODO refactor out into a separate "weapon" table
	if (self.atk > 0) self.atk -= 1

	if (btn(4)) self:shoot()
end

function player:draw()
	fillp(0)
	spr(self.sprite, self.x, self.y)
end