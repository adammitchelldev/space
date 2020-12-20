active_level_scripts = {}

function level(func)
    return function() add(active_level_scripts, play(func)) end
end

function no_enemies()
    return layer_each(enemies)() == nil
end

function player_up()
    return layer_each(players)() != nil
end

level_extra_enemy = level(function()
    repeat
        wait(flr(rnd(150)) + 200)
        enemy_green_make()
    until false
end)

level_simple = level(function()
    local diff = 0
    local wave_size = 0
    repeat
        for c = 1, 4 do
            local dx = rnd(4) - 2
            dx *= min(0.5 + (diff * 0.25), 1.5)
            for i = 0, wave_size do
                enemy_make { x = ((i + ((7 - wave_size) / 2)) * 16) + 4, dx = dx, dy = 1 + (diff * 0.1) - (abs(dx * i) / 16)}
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
            enemy_green_make()
            wait(max(4, 30 - (i * 2)))
        end
        wait(no_enemies, player_up)
        wait(100)

        if diff > 2 then
            level_extra_enemy()
        end

        if diff > 0 and (diff & 1) == 0 then
            enemy_big_make({ x = 60, y = -16, dx = 0.5, health = 25 + (25 * diff) })
            wait(no_enemies)
            lives += 1
            wait(180)
            wait(player_up)
        end

        diff += 1
    until false
end)

level_test = level(function()
    repeat
        enemy_big_make({ x = 60, y = -16, dx = 0.5, health = 20 })
        wait(no_enemies)
        wait(180)
    until false
end)

function level_stop()
    for s in all(active_level_scripts) do
        cancel(s)
    end
    active_level_scripts = {}
end