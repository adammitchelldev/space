active_level_scripts = {}

function level(func)
    return function() add(active_level_scripts, play(func)) end
end

function wait_layer_empty(layer)
    wait(function()
        return layer_each(layer)() == nil
    end)
end

level_extra_enemy = level(function()
    repeat
        wait(flr(rnd(150)) + 200)
        enemy_green_make()
    until false
end)

level_simple = level(function()
    local diff = 0
    repeat
        for c = 1, 6 do
            local dx = rnd(4) - 2
            for i = 0, 7 do
                enemy_make { x = (i * 16) + 4, dx = dx, dy = 1 + (diff * 0.1) - (abs(dx * i) / 16)}
            end
            if diff < 3 then
                wait_layer_empty(enemies)
                wait(40)
            else
                wait(180)
            end
        end
        wait_layer_empty(enemies)
        wait(60)

        for i = 1, 1 + (diff * 3) do
            enemy_green_make()
            wait(max(4, 30 - (i * 2)))
        end
        wait_layer_empty(enemies)
        wait(100)

        if (diff > 1) level_extra_enemy()
        diff += 1
    until false
end)

function level_stop()
    for s in all(active_level_scripts) do
        cancel(s)
    end
    active_level_scripts = {}
end