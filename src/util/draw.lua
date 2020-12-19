function draw_sprite(n, x, y, ...)
    x = x or 0
    y = y or 0
    local args = pack(...)
    return function(obj)
        fillp(0)
        spr(n, obj.x + x, obj.y + y, unpack(args))
    end
end