entity = class{}

function entity:hit(ent)
    if (self.dead or self.iframes or self.shielded or ent.iframes) return
    if self.health then
        self.health -= 1
        if (self.health > 0) return
    end
    self:die()
end

function entity:die()
    if (self.die_sfx) sfx(self.die_sfx)
    if (self.explosion) self.explosion:new(self)
    self:remove()
end

function entity:remove()
    w:remove(self)
    self.dead = true
end

function entity:spawn(t, ...)
    local ent = w:add(self(t or {}))

    if ent.scripts then
        for f in all(ent.scripts) do
            ent:play(f, ...)
        end
    end

    return ent
end

entity.play = script_play

function entity:update()
    script_update(self)

    -- iframes
    if self.iframes then
		self.iframes -= 1
		if (self.iframes <= 0) self.iframes = nil
    end

    -- move
    self.x += self.dx
    self.y += self.dy
    
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

    -- ttl
    if self.ttl then
        self.ttl -= 1
        if self.ttl <= 0 then
            self:die()
        end
    end

    -- remove oob
    if self.remove_oob then
        local x,y = self.x,self.y
        if (y > screen_h) or y < -self.h or x > 128 or x < -self.w then
            self:remove()
        end
    end
end