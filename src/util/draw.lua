-- drawing util

-- TODO axe this and move to entity
function draw_sprite(n, x, y, ...)
    x = x or 0
    y = y or 0
    local args = pack(...)
    return function(self)
        fillp(0)
        if not (self.iframes and self.iframes & 1 == 1) then
            spr(n, self.x + x, self.y + y, unpack(args))
        end
        if self.shielded then
            sspr(0,20,12,12,self.x-2,self.y-2)
        end
    end
end