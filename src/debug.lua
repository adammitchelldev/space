debug = false
debug_stat = true
debug_coll = false

function collision_grid_draw_debug(g)
    for x, y, c in cells(g) do
        rect(x * 16, y * 16, (x+1) * 16, (y+1) * 16)
    end
end

-- Should have a whole true debug menu
-- Could do it by suppressing pause?
local old_init = _init
function _init()
    old_init()
    
    menuitem(1, "clear achieves", function()
        for i = 32,63 do
            dset(i, 0)
        end
    end)
	menuitem(2, "clear hiscore", function()
		dset(0, 0)
		hiscore = 0
	end)
    menuitem(5, "toggle debug", function()
        debug = not debug
    end)
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
            local n = 0
            for k, v in pairs(collision_grids) do
                n += 1
            end
            print("grids:"..n)
        end

        -- if debug_coll then
        --     clip(0, 128-screen_h, 128, 128)
        --     camera(0, screen_h-128)
        --     color(9)
        --     collision_grid_draw_debug(grid_enemies)
        --     color(10)
        --     collision_grid_draw_debug(grid_player_bullets)
        --     color(11)
        --     collision_grid_draw_debug(grid_players)
        -- end
    end
end