-- hunter enemy

enemy_hunter = enemy {
    sprite = 5,
    value = 200,
    bounce = {l=0,r=screen_w,u=0,d=16},
    dx = 2,
    explosion = explosion{size=15},
    die_sfx = 8,
    health = 3,
    scripts = {
        function(self)
            repeat
                wait(90)
                local p
                repeat
                    yield()
                    p = next(players)
                until p and abs(self.x - p.x) <= 8

                for i = 1, 3 do
                    wait(2)
                    sfx(11)
                    enemy_bullet:new(self, 3, 6).dy = 4
                end
                self.dx = -self.dx
            until false
        end,
        function(self)
            repeat
                wait(flr(rnd(100))+20)
                self.dx = -self.dx
            until false
        end
    }
}