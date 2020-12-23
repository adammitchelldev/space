function level(...)
    return entity {
        scripts = {...}
    }
end

-- TODO refactor into helpers, along with other useful stuff
function no_enemies()
    return next(enemies) == nil
end

function player_up()
    return next(players) != nil
end

function is_dead(e)
    return function() return e.dead end
end

level_simple = level(function(self)
    local diff = 0
    local wave_size = 0
    wait(120)
    local minion_health = 1
    repeat
        for c = 1, 4 do
            local dx = rnd(4) - 2
            dx *= min(0.5 + (diff * 0.25), 1.5)
            for i = 0, wave_size do
                enemy_normal:spawn{
                    x = ((i + ((7 - wave_size) / 2)) * 16) + 4,
                    dx = dx,
                    dy = 1 + (diff * 0.1) - (abs(dx * i) / 16),
                    health = minion_health,
                    value = minion_health * 10
                }
            end
            wait(no_enemies)
            wait(40)
            
            if (wave_size < 7) wave_size += 1
        end
        wait(no_enemies, player_up)
        wait(60)

        for i = 1, 1 + flr(diff/2) do
            enemy_green:spawn{x=rnd(screen_w-8),y=-8}
            wait(max(4, 30 - (i * 2)))
        end
        wait(no_enemies, player_up)
        wait(100)

        if diff > 0 and (diff & 1) == 0 then
            enemy_big:spawn{ x = 60, y = -16, dx = 0.5, health = 25 + (12.5 * diff), value = 1000 * diff }
            wait(no_enemies)
            wait(180)
            wait(player_up)
            if diff % 8 == 0 then
                self:play(function()
                    repeat
                        wait(flr(rnd(300)+1200))
                        local x
                        if (flr(rnd(2)) == 0) x = -7 else x = 127
                        local e = enemy_hunter:spawn{x=x,y=flr(rnd(4))*8}
                        wait(is_dead(e))
                    until false
                end)
            elseif diff % 4 == 0 then
                self:play(function()
                    repeat
                        wait(flr(rnd(600)+1500))
                        local e = enemy_shielder:spawn{x=rnd(screen_w-8),y=-8}
                        wait(is_dead(e))
                    until false
                end)
            else
                self:play(function()
                    repeat
                        wait(flr(rnd(150)) + 200)
                        enemy_green:spawn{x=rnd(screen_w-8),y=-8}
                    until false
                end)
            end

            minion_health += 1
        end

        diff += 1
    until false
end)

-- level_test = level(function(self)
    
-- end)
