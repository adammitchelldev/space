powerup = class {
    draw = draw_sprite(16),
    dy = 0.5,
    col = { l=-2,r=7,u=-2,d=7 },
    update = {
        move,
        remove_oob
    }
}

function powerup_make(orig)
    powerup {
        x = orig.x + 2,
        y = orig.y + 2
    }:add()
end

function powerup:collect(p)
    sfx(6)
	self:remove()
	score_add(25)
	play(text_rising_box("250", self.x + 4, self.y - 8))
	if p.shot_delay > 20 then
		p.shot_delay -= 3
		play(text_rising_box("gUN uP", self.x + 4, self.y))
	elseif p.shot_delay > 10 then
		p.shot_delay -= 2
		play(text_rising_box("gUN uP", self.x + 4, self.y))
	elseif p.shot_delay > 5 then
		p.shot_delay -= 1
		play(text_rising_box("gUN uP", self.x + 4, self.y))
	else
		play(text_rising_box("max!", self.x, self.y))
    end
end
