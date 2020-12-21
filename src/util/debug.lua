debug = false
debug_stat = true
debug_coll = false

function collision_grid_draw_debug(g)
    for x, y, c in cells(g) do
        rect(x * 16, y * 16, (x+1) * 16, (y+1) * 16)
    end
end

local old_init = _init
function _init()
    old_init()
    menuitem(5, "toggle debug", function() debug = not debug end)
end

local old_draw = _draw
function _draw()
    old_draw()

    if debug then
        if debug_stat then
            cursor(50,1)
            print(stat(0))
            print(stat(1))
            print(stat(2))
        end

        if debug_coll then
            clip(0, 128-screen_height, 128, 128)
            camera(0, screen_height-128)
            color(9)
            collision_grid_draw_debug(grid_enemies)
            color(10)
            collision_grid_draw_debug(grid_player_bullets)
            color(11)
            collision_grid_draw_debug(grid_players)
        end
    end
end