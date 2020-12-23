active_level_scripts = {}

function lplay(func)
    return add(active_level_scripts, play(func))
end

function level(func)
    return function() lplay(func) end
end

function no_enemies()
    return next(collision_layers["enemy"]) == nil
end

function player_up()
    return next(collision_layers["player"]) != nil
end

level_extra_enemy = level(function()
    repeat
        wait(flr(rnd(150)) + 200)
        enemy_green:new{x=rnd(120),y=-8}
    until false
end)

level_simple = level(function()
    local diff = 0
    local wave_size = 0
    wait(120)
    repeat
        for c = 1, 4 do
            local dx = rnd(4) - 2
            dx *= min(0.5 + (diff * 0.25), 1.5)
            for i = 0, wave_size do
                local val = flr((diff + 2) / 4) + 1
                enemy_normal:new{
                    x = ((i + ((7 - wave_size) / 2)) * 16) + 4,
                    dx = dx,
                    dy = 1 + (diff * 0.1) - (abs(dx * i) / 16),
                    health = val,
                    value = val * 10
                }
            end
            if diff < 3 then
                wait(no_enemies)
                wait(40)
            else
                wait(180)
                wait(player_up)
            end
            
            if (wave_size < 7) wave_size += 1
        end
        wait(no_enemies, player_up)
        wait(60)

        for i = 1, 1 + diff do
            enemy_green:new{x=rnd(120),y=-8}
            wait(max(4, 30 - (i * 2)))
        end
        wait(no_enemies, player_up)
        wait(100)

        if diff > 0 and (diff & 1) == 0 then
            enemy_big:new{ x = 60, y = -16, dx = 0.5, health = 25 + (12.5 * diff), value = 1000 * diff }
            lives += 1
            wait(no_enemies)
            wait(180)
            wait(player_up)
            level_extra_enemy()
        end

        diff += 1
    until false
end)

level_test = level(function()
    lplay(function()
        repeat
            wait(1)
            if btnp(5) then
                powerup_make({x=rnd(120), y=60})
            end
        until false
    end)
    local wave = 1
    repeat
        wait(180)
        enemy_shielder:new{ x = -7, y = 0, dx = 1, dy = 1 }
        enemy_shielder:new{ x = 127, y = 0, dx = 1, dy = 1 }
        enemy_shielder:new{ x = 60, y = -7, dx = 1, dy = 1 }
        -- enemy_big:new{ x = 60, y = -16, dx = 0.5, health = 20 }
        for i = 1,wave do
            local x
            if (flr(rnd(2)) == 0) x = -7 else x = 127
            enemy_hunter:new{ x = x, y = (i - 1) * 8 }
            wait(flr(rnd(30))+30)
        end
        wave += 1
        wait(no_enemies)
    until false
end)

function level_stop()
    for s in all(active_level_scripts) do
        cancel(s)
    end
    active_level_scripts = {}
end