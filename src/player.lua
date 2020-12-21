player = class {
	sprite = 2,
	draw = draw_sprite(2),
	explosion = 50,
	speed = 1,
	shot_sfx = 0,
	shot_delay = 30,
	col = { l=1,r=7,u=3,d=7 },
	hit = standard_hit,
}

player_bullet = bullet {
	colors = heat_colors,
	dy = -5,
	width = 1,
    col = { l=0, r=1, u=0, d=6 }
}

function player:new()
	return self {
    	x = 60,
		y = screen_height,
		atk = 0,
	}:add()
end

function player:die()
	self:explode()
	sfx(7)
	big_explosion(self.x, self.y)
	player_die()
end

function player:shoot()
	if self.atk == 0 then
		sfx(self.shot_sfx)
		player_bullet:new(self.x, self.y - 4)
		player_bullet:new(self.x + 7, self.y - 4)
		self.atk = self.shot_delay
	end
end

function player:update()
	local x,y,speed = self.x,self.y,self.speed

	dx = 0
	dy = 0

	if btn(0) then dx-=speed end
	if btn(1) then dx+=speed end
	if btn(2) then dy-=speed end
	if btn(3) then dy+=speed end

	x += dx
	y += dy

	if x<0 and dx<0 then x=0; dx=0 end
	if x>120 and dx>0 then x=120; dx=0 end
	if y<0 and dy<0 then y=0; dy=0 end
	if y>screen_height-8 and dy>0 then y=screen_height-8; dy=0 end
	if (y>screen_height-8) y-=speed

	self.x,self.y=x,y

    -- TODO refactor out into a separate "weapon" table
	if (self.atk > 0) self.atk -= 1

	if self.iframes then
		self.iframes -= 1
		if (self.iframes <= 0) self.iframes = nil
	end

	if (btn(4)) self:shoot()
end
