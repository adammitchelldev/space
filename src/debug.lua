-- debug menus and display

debug = false
debug_stat = true
debug_coll = true

function collision_grid_draw_debug(g)
    for x, y, c in cells(g) do
        rect(x * 16, y * 16, (x+1) * 16, (y+1) * 16)
    end
end

test_enemylist = {}
test_enemymap = {}
function build_enemymap()
    for k, v in pairs(_ENV) do
        if sub(k,1,6) == "enemy_" and type(v) == "table" and v.draw then
            local name = sub(k,7)
            add(test_enemylist,name)
            test_enemymap[name] = v
        end
    end
end

test_spawnlist = {}
level_test = level(function(self)
    repeat
        for s in all(test_spawnlist) do
            local v = test_enemymap[s.name]
            v:spawn{x=s.x,y=s.y}
        end
        wait(no_enemies)
        wait(60)
    until false
end)

-- Should have a whole true debug menu
-- Could do it by suppressing pause?
local old_init = _init
function _init()
    test_mode = @0x4300 == 1

    if test_mode then
        poke(0x5f2d,1) -- enable devkit
        cartdata("spacetest")
        cartdata = function() end
        build_enemymap()
        local old_start = start
        function start()
            old_start()
            active_level = level_test:spawn{}
        end
    end

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
    menuitem(3, "toggle stats", function()
        debug = not debug
    end)

    if test_mode then
        menuitem(4, "normal mode", function()
            poke(0x4300, 0)
            run()
        end)
    else
        menuitem(4, "test mode", function()
            poke(0x4300, 1)
            run()
        end)
    end
end

local old_update = _update60
function _update60()
    old_update()

    if test_mode then
        mouse_x = stat(32)
        mouse_y = stat(33)

        if stat(34) == 1 then
            if not mouse_last then
                if mouse_x < 8 and mouse_y < 8 then
                    test_spawnlist = {}
                    reset()
                else
                    local x = 8
                    local selecting = false
                    for k in all(test_enemylist) do
                        local v = test_enemymap[k]
                        if mouse_x >= x and mouse_x < x+v.w and
                                mouse_y >= 0 and mouse_y < v.h then
                            test_enemy_select = k
                            selecting = true
                            break
                        end
                        x += v.w
                    end
                    if not selecting and test_enemy_select then
                        add(test_spawnlist, {name=test_enemy_select,x=mouse_x,y=mouse_y})
                    end
                end
            end
            mouse_last = true
        else
            mouse_last = nil
        end

        if btnp(5) then
            for p in pairs(players) do
                p.shot_delay -= 3
                if p.shot_delay < 1 then
                    p.shot_delay = 1
                end
            end
        end
    end
end

local old_draw = _draw
local old_cls = cls
function cls() end
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

    if test_mode then
        rectfill(0,0,128,14,0)
        print("test mode",0,123,7)
        print("X",2,1,7)
        local x = 8
        for k in all(test_enemylist) do
            local v = test_enemymap[k]
            v.x,v.y = x,y
            v:draw()
            if test_enemy_select == k then
                rect(x,0,x+v.w-1,v.h,7)
            end
            x+=v.w
        end
        print("+",mouse_x-1,mouse_y-2,7)
    end
end