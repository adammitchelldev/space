starfield = {
    star_count = 70,
    dust_count = 50
}

do
    local stars
    local dust

    function starfield:init()
        local n

        stars = {}
        n = starfield.star_count
        for i = 1, n do
            stars[i] = {
                x = rnd(128),
                y = rnd(screen_h + 8) - 8,
                speed = ((i / (n*2)) ^ 3) + 0x0.1,
                colour = flr(rnd(2)) + 5
            }
        end

        dust = {}
        n = starfield.dust_count
        for i = 1, n do
            dust[i] = {
                x = rnd(128),
                y = rnd(screen_h + 8) - 8,
                speed = ((i / n) ^ 2) + 1
            }
        end
    end

    local function update_field(field)
        for i in all(field) do
            i.y += i.speed
            if i.y > 128 then
                i.y = rnd(8) - 8
                i.x = rnd(128)
            end
        end
    end

    function starfield:update()
        update_field(stars)
        update_field(dust)
    end

    function starfield:draw()
        for s in all(stars) do
            color(s.colour)
            pset(s.x, s.y)
        end
        for d in all(dust) do
            color(1)
            pset(d.x, d.y)
        end
    end
end