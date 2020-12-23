player = entity {
	tag = "player",
	sprite = 2,
	x = 60,
	y = screen_h,
	atk = 0,
	draw = draw_sprite(2),
	explosion = big_explosion{size=50},
	die_sfx = 7,
	speed = 1,
	shot_sfx = 0,
	shot_delay = 30,
	col = { l=1,r=7,u=3,d=7 },
	bounce = { l=0,r=screen_w,u=0,d=screen_h },
	scripts = {
		function(self)
			repeat
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
				yield()
			until false
		end
	}
}

player_bullet = bullet {
	tag = "player_bullet",
	colors = heat_colors,
	dy = -5,
	width = 1,
    col = { l=0, r=1, u=0, d=6 }
}

function player:die()
	entity.die(self)
	player_die()
end
