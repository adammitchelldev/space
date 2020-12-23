-- green enemy

enemy_green = enemy {
    draw = draw_sprite(4),
    explosion = explosion,
    die_sfx = 8,
    value = 50,
    dy = 1,
    scripts = {
        function(self)
            local p
            repeat
                yield()
                p = next(players)
            until p and vec_dist2(self, p) < (50 * 50)

            local dx, dy = vec_xy_normalize(p.x - self.x, p.y - self.y, 4)
            self.dx, self.dy = 0, 0
            for i = 1,20 do
                sfx(4)
                yield()
            end
            self.dx, self.dy = dx, dy
            repeat
                sfx(4) -- TODO make this an actual sound loop
                yield()
            until false
        end
    }
}