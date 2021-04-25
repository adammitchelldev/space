debris = entity {
    layer = bg_fx,
}

function debris:scatter(base)
    local sw, sh, sx, sy =
        self.sprite_w or 1, self.sprite_h or 1,
        base.sprite % 16 * 8, base.sprite \ 16 * 8

    for i = 1, 5 do
        local ox, oy = flr(rnd(sw * 8 - 3)), flr(rnd(sh * 8 - 3))
        self:spawn{
            x = base.x + ox,
            y = base.y + oy,
            sx = sx + ox,
            sy = sy + oy,
            dx = base.dx / 2 + (ox - sw / 2) / 4,
            dy = base.dy / 2 + (oy - sh / 2) / 4,
            ttl = flr(rnd(10)) + 25
        }
        -- color(7)
        -- stop(ox .. oy)
    end
end

function debris:draw()
    sspr(self.sx, self.sy, 3, 3, self.x, self.y)
end
