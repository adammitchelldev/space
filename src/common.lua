-- TODO reduce token count
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
        end
        if b.u and self.y < b.u and self.dy < 0 then
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
    if self.remove_oob then
        local x,y,w,h = self.x,self.y,self.w or 8,self.h or 8
        if (y > screen_height) or y < -h or x > 128 or x < -w then
            self:remove()
        end
    end
end

function ttl(self)
    if self.ttl then
        self.ttl -= 1
        if self.ttl <= 0 then
            self:die()
        end
    end
end

function move(self)
    self.x += self.dx
    self.y += self.dy
end

function draw_shielded(self)
    if self.shielded then
        sspr(0,20,12,12,self.x-2,self.y-2)
    end
end

function class:hit(obj)
    if (self.iframes or self.shielded or obj.iframes) return
    if self.health then
        self.health -= 1
        if (self.health > 0) return
    end
    if not self.dead then
        self.dead = true
        self:die()
    end
end

-- make optional death_fx
function class:die()
    self:remove()
end

function class:add()
    w:add(self)
    return self
end

function class:remove()
    w:remove(self)
    self.dead = true
    return self
end