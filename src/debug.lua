-- debug menus and display

debug = false
debug_stat = true
debug_coll = true

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
local old_cls = cls
function cls() end

local f = true
function _draw()
    old_cls()

    if debug and debug_coll then
        clip(0, 128-screen_h, 128, 128)
        camera(0, screen_h-128)
        -- fillp(0b0111101111011110)
        -- poke(0x5f33, 1)
        color(1)
        collision_grid_draw_debug(grid_enemies)
        color(2)
        collision_grid_draw_debug(grid_player_bullets)
        color(3)
        collision_grid_draw_debug(grid_players)
        color(4)
        collision_grid_draw_debug(grid_enemy_bullets)
        color(5)
        collision_grid_draw_debug(grid_powerups)
        fillp(0)
        clip()
        camera()
    end

    old_draw()

    if debug and debug_stat then
        cursor(50,1)
        print(stat(0))
        print(stat(1))
        print(stat(2))
    end
end