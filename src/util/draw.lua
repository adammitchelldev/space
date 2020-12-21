function draw_sprite(n, x, y, ...)
    x = x or 0
    y = y or 0
    local args = pack(...)
    return function(self)
        fillp(0)
        if (self.iframes and self.iframes & 1 == 1) return
        spr(n, self.x + x, self.y + y, unpack(args))
    end
end