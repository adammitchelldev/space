powerup = class {
    sprite = 16,
    speed = 0.5,
    col = { l=-2,r=7,u=-2,d=7 }
}

function powerup_make(orig)
    powerup {
        x = orig.x + 2,
        y = orig.y + 2
    }:add()
end

function powerup:update()
    self.y += self.speed
    if self.y > 128 then
        self:remove()
    end
end

function powerup:draw()
	fillp(0)
    spr(self.sprite, self.x, self.y)
end