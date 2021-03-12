-- shielder enemy

enemy_shielder = enemy {
    sprite = 6,
    value = 50,
    bounce = {l=0,r=screen_w,u=0,d=screen_h},
    explosion = explosion,
    die_sfx = 8,
    health = 10,
    no_shield = true,
    scripts = {
        function(self)
            repeat
                local tx,ty
                local target = self.shield_target
                if target then
                    tx,ty=target.x,target.y
                else
                    tx,ty=rnd(64)+32,rnd(32)+16
                end
                if (ty > 64) ty = 64

                local adx,ady=(tx-self.x)*0x0.008,(ty-self.y)*0x0.008

                local dur = flr(rnd(20)) + 20
                for i = 1, dur do
                    self.dx = (self.dx + adx) * 0x0.E
                    self.dy = (self.dy + ady) * 0x0.E
                    yield()
                end
            until false
        end,
        function(self)
            repeat
                local enemy_list = {}
                for e in pairs(enemies) do
                    if not e.shielded and
                            not e.shield_targeted and
                            not e.no_shield and
                            e != self.shield_target then
                        add(enemy_list, e)
                    end
                end
                local target
                if #enemy_list > 0 then
                    target = rnd(enemy_list)
                    target.shield_targeted = true
                    self.shield_target = target

                    local fx = shielding:spawn{
                        origin = self,
                        target = target
                    }
                    fx.shield_progress = 0
                    for i=1,9 do
                        fx.shield_progress += 1
                        wait(3)
                    end
                    target.shielded = true
                    for i=1,120 do
                        if (target.dead) break
                        yield()
                    end
                    fx:remove()

                    target.shielded, target.shield_targeted = nil
                else
                    self.shield_target = nil
                    wait(60)
                end
            until false
        end
    }
}

function enemy_shielder:remove()
    if self.shield_target then
        self.shield_target.shielded, self.shield_target.shield_targeted = nil
    end
    enemy.remove(self)
end
