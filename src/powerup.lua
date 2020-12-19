powerups = layer {}

powerup = class {
    layer = powerups,
    sprite = 16,
    speed = 1,
    col = { l=0,r=5,u=0,d=5 }
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