-- normal enemy

enemy_normal = enemy {
    draw = draw_sprite(3),
    bounce = {l=0,r=screen_w,u=0,d=50,sfx=3},
    value = 10,
    dy = 1,
    scripts = {
        function(self)
            sfx(3)
            repeat
                wait(flr(rnd(340)) + 40)
                sfx(11)
                enemy_bullet:new(self, 2, 4)
            until false
        end
    }
}