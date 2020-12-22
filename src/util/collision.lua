-- TODO replace with better check, should be able to do 2
-- axis distance check for more efficient AABB
function collision_check(i1, i2)
    local l1 = i1.x + i1.col.l
    local r1 = i1.x + i1.col.r
    local u1 = i1.y + i1.col.u
    local d1 = i1.y + i1.col.d

    local l2 = i2.x + i2.col.l
    local r2 = i2.x + i2.col.r
    local u2 = i2.y + i2.col.u
    local d2 = i2.y + i2.col.d

    return l1 < r2 and r1 > l2 and u1 < d2 and d1 > u2
end

do
    function collision_grid(layer)
        local g = grid()

        for i in pairs(layer) do
            local col = i.col
            if col then
                local x, y = i.x, i.y
                local l = (x + col.l) \ 16
                local r = ((x + col.r - 1) \ 16)
                local u = (y + col.u) \ 16
                local d = ((y + col.d - 1) \ 16)

                for ix = l, r do
                    for iy = u, d do
                        local cell = rawget_cell(g, ix, iy)
                        if cell == nil then
                            cell = {i}
                            g[ix][iy] = cell
                        else
                            add(cell, i)
                        end
                    end
                end
            end
        end

        return g
    end

    function collision_list_pairs_foreach(list1, list2, func)
        if (not (list1 and list2)) return
        for _, i1 in ipairs(list1) do
            for _, i2 in ipairs(list2) do
                if (collision_check(i1, i2)) func(i1, i2)
            end
        end
    end
    
    function collision_grid_pairs_foreach(grid1, grid, func)
        for x, y, c1 in cells(grid1) do
            local c2 = rawget_cell(grid, x, y)
            if (c2) collision_list_pairs_foreach(c1, c2, func)
        end
    end
end

do
    collision_handlers = {}

    local function add_collision_handler(ia, tagb, hname)
        local list = ia[tagb]
        if list == nil then
            ia[tagb] = {hname}
        else
            add(list, hname)
        end
    end

    function collision_handler(taga, tagb, hname)
        local ia = collision_handlers[taga]
        if ia then
            add_collision_handler(ia, tagb, hname)
        else
            local ib = collision_handlers[tagb]
            if ib then
                add_collision_handler(ib, taga, hname)
            else
                ia = {}
                add_collision_handler(ia, tagb, hname)
                collision_handlers[taga] = ia
            end
        end
    end

    collision_layers = setmetatable({}, {
        __index = function(t, k)
            local nt = {}
            t[k] = nt
            return nt
        end
    })

    local grids_mt = {
        __index = function(t, k)
            layer = collision_layers[k]
            if (next(layer) == nil) return
            local g = collision_grid(layer)
            t[k] = g
            return g
        end
    }

    collision_grids = {}
    function collision_update()
        collision_grids = setmetatable({},grids_mt)

        for taga, index in pairs(collision_handlers) do
            local ga = collision_grids[taga]
            if ga then
                for tagb, handlers in pairs(index) do
                    if #handlers > 0 then
                        local gb = collision_grids[tagb]
                        if gb then
                            -- TODO pick smaller layer first
                            collision_grid_pairs_foreach(ga, gb, function(a, b)
                                for hname in all(handlers) do
                                    local h = a[hname]
                                    if (h) h(a, b)
                                    h = b[hname]
                                    if (h) h(b, a)
                                end
                            end)
                        end
                    end
                end
            end
        end
    end

    function collision_add_listener(item)
        local tag = item.tag
        if tag then
            collision_layers[tag][item] = item
        end
    end

    function collision_remove_listener(item)
        local tag = item.tag
        if tag then
            collision_layers[tag][item] = nil
        end
    end
end
