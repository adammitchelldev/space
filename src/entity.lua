-- base entity class
-- this is where all the good logic lives

-- the rationale behind having all of the
-- logic in one place is that behaviour
-- is explicit and interacting "systems"
-- are easier to deal with.

-- entity types subclass this class and
-- configure their behaviour by setting
-- various table entries, allowing for
-- the flexibility of ECS definitions
-- but without needing a full ECS system.
-- (saves a lot of tokens!)

-- the most flexible entry is "scripts",
-- which allows the entity to provide a list
-- of coroutines that will be resumed
-- every frame; use this for custom entity
-- behaviour.

entity = class {
    x = 0,
    y = 0,
    dx = 0,
    dy = 0,
    w = 8,
    h = 8
}

-- spawns a *copy* of this entity
-- a.k.a instantiating a prefab
function entity:spawn(t, ...)
    local ent = self(t or {})
    ent:add(...)
    return ent
end

-- add the entity to the correct layer
-- and kick off any attached scripts
function entity:add(...)
    if (self.layer) self.layer[self] = self
    if self.scripts then
        for f in all(self.scripts) do
            self:play(f, ...)
        end
    end
end

-- hit is the generic "bullet collision" handler
-- used for players, enemies and bullets
function entity:hit(ent)
    if (self.dead or self.iframes or self.shielded or ent.iframes) return
    if self.health then
        self.health -= 1
        if (self.health > 0) return
    end
    self:die()
end

-- die counts as removing but has extra logic
-- this method is commonly hooked into
function entity:die()
    if (self.die_sfx) sfx(self.die_sfx)
    if (self.explosion) self.explosion:new(self)
    self:remove()
end

-- does the actual removal logic, an entity
-- directly removed is marked as dead so it
-- doesn't die again
function entity:remove()
    if (self.layer) self.layer[self] = nil
    self.dead = true
end

-- using the script util, although we should
-- really make this either a base class thing or
-- just move the script logic here
entity.play = script_play

-- per frame update logic
function entity:update()
    -- using the script util
    script_update(self)

    -- iframes
    if self.iframes then
		self.iframes -= 1
		if (self.iframes <= 0) self.iframes = nil
    end

    -- move
    self.x += self.dx
    self.y += self.dy

    -- bounce
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