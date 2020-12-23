-- TODO reduce token count
function bounce(self)
    local b = self.bounce
    if b then
        local nobounce,l,r,u,d,dx,dy = true,b.l,b.r and b.r-self.w,b.u,b.d and b.d-self.h,self.dx,self.dy
        if l and self.x < l and dx <= 0 then
            self.x,self.dx,nobounce = l,-dx
        elseif r and self.x > r and dx >= 0 then
            self.x,self.dx,nobounce = r,-dx
        end
        if u and self.y < u and self.dy <= 0 then
            self.y,self.dy,nobounce = u,-dy
        elseif d and self.y > d and self.dy >= 0 then
            self.y,self.dy,nobounce = d,-dy
        end
        if (not nobounce and b.sfx) sfx(b.sfx)
    end
end

function remove_oob(self)
    if self.remove_oob then
        local x,y = self.x,self.y
        if (y > screen_h) or y < -self.h or x > 128 or x < -self.w then
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