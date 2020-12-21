players = layer {}

player = class {
	layer = players,
	sprite = 2,
	explosion = 50,
	speed = 1,
	accel = 0x0.4,
	drag = 0x0.E,
	shot_sfx = 0,
	shot_delay = 30,
	col = { l=1,r=7,u=3,d=7 }
}

function player_make()
	return player {
    	x = 60,
		y = screen_height,
		dx = 0,
		dy = -1,
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
	local x,y,dx,dy,accel,speed,drag = self.x,self.y,self.dx,self.dy,self.accel,self.speed,self.drag

	-- dx *= drag
	-- dy *= drag
	dx = 0
	dy = 0
	accel = 1

	if btn(0) then dx-=accel end
	if btn(1) then dx+=accel end
	if btn(2) then dy-=accel end
	if btn(3) then dy+=accel end

	-- if dx>speed then dx=speed elseif dx<-speed then dx=-speed end
	-- if dy>speed then dy=speed elseif dy<-speed then dy=-speed end

	-- if vec_len2(dx, dy) > speed * speed then
	-- 	dx, dy = vec_xy_normalize(dx, dy, speed)
	-- end

	x += dx
	y += dy

	if x<0 and dx<0 then x=0; dx=0 end
	if x>120 and dx>0 then x=120; dx=0 end
	if y<0 and dy<0 then y=0; dy=0 end
	if y>screen_height-8 and dy>0 then y=screen_height-8; dy=0 end

	self.x,self.y,self.dx,self.dy=x,y,dx,dy

    -- TODO refactor out into a separate "weapon" table
	if (self.atk > 0) self.atk -= 1

	if self.iframes then
		self.iframes -= 1
		if (self.iframes <= 0) self.iframes = nil
	end

	if (btn(4)) self:shoot()
end

function player:draw()
	fillp(0)
	if (self.iframes and self.iframes & 1 == 1) return
	spr(self.sprite, self.x, self.y)
end