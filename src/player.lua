player_bullet = bullet {
	layer = player_bullets,
	colors = heat_colors,
	dy = -5,
	w = 1,
	coll = true,
	coll_r = 1,
	coll_d = 6
}

player = entity {
	layer = players,
	sprite = 2,
	x = 60,
	y = screen_h,
	atk = 0,
	explosion = big_explosion{size=50},
	die_sfx = 7,
	speed = 1,
	shot_sfx = 0,
	shot_delay = 30,
	coll = true,
	coll_l = 1,
	coll_r = 7,
	coll_u = 3,
	coll_d = 7,
	bounce = { l=0,r=screen_w,u=0,d=screen_h }
}

function player:update()
	local dx,dy,speed = 0,0,self.speed
			
	if (btn(0)) dx-=speed
	if (btn(1)) dx+=speed
	if (btn(2)) dy-=speed
	if (btn(3)) dy+=speed

	self.dx,self.dy = dx,dy

	-- TODO refactor out into a separate "weapon" table
	if (self.atk > 0) self.atk -= 1

	if btn(4) and self.atk == 0 then
		sfx(self.shot_sfx)
		player_bullet:new(self, 0, 4)
		player_bullet:new(self, 7, 4)
		self.atk = self.shot_delay
	end

	entity.update(self)
end

function player:die()
	entity.die(self)
	player_die()
end
