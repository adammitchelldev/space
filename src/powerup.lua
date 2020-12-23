powerup = entity {
    tag = "powerup",
    remove_oob = true,
    draw = draw_sprite(16),
    dy = 0.5,
    col = { l=-2,r=7,u=-2,d=7 },
}

function gun_up(self)
    text_rising:new("gUN uP", self.x + 4, self.y)
end

-- This can be cut down and generified to all powerups
function powerup:collect(p)
    sfx(6)
	self:remove()
	score_add(25)
	text_rising:new("250", self.x + 4, self.y - 8)
	if p.shot_delay > 20 then
		p.shot_delay -= 3
		gun_up(self)
	elseif p.shot_delay > 10 then
		p.shot_delay -= 2
		gun_up(self)
	elseif p.shot_delay > 5 then
        p.shot_delay -= 1
        if p.shot_delay > 5 then
            gun_up(self)
        else
            achieve(5)
            text_rising:new("maxed!", self.x + 4, self.y)
        end
    end
end
