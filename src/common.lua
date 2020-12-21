function bounce(self)
    if self.bounce then
        local bounced
        local b = self.bounce
        if b.l and self.x < b.l and self.dx < 0 then
            self.x = b.l
            self.dx = -self.dx
            bounced = true
        elseif b.r and self.x > b.r and self.dx > 0 then
            self.x = b.r
            self.dx = -self.dx
            bounced = true
        elseif b.u and self.y < b.u and self.dy < 0 then
            self.y = b.u
            self.dy = -self.dy
            bounced = true
        elseif b.d and self.y > b.d and self.dy > 0 then
            self.y = b.d
            self.dy = -self.dy
            bounced = true
        end
        if (bounced and b.sfx) sfx(b.sfx)
    end
end

function remove_oob(self)
    local x,y,w,h = self.x,self.y,self.w or 8,self.h or 8
    if (y > screen_height) or y < -h or x > 128 or x < -w then
        self:remove()
    end
end

function move(self)
    self.x += self.dx or 0
    self.y += self.dy or 0
end

function standard_hit(self, obj)
    if (self.iframes or obj.iframes) return
    if self.health then
        self.health -= 1
        if (self.health > 0) return
    end
    self:die()
end
