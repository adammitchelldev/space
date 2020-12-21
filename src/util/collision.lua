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

function collision_pairs(layer1, layer2)
    local iter = layer_pairs(layer1, layer2)
    return function()
        local i1, i2
        repeat
            i1, i2 = iter()
            if i1 == nil then return nil end
        until collision_check(i1, i2)
        return i1, i2
    end
end

do
    function collision_grid(layer)
        local g = grid()

        for i in layer_each(layer) do
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
    local collision_handlers = setmetatable({},{__mode="k"})

    local function add_collision_on(ia, b, handler)
        local list = ia[b]
        printh("adding collision")
        if list == nil then
            ia[b] = {handler}
        else
            add(list, handler)
        end
    end

    function collision_on(a, b, handler)
        local la, lb = layer(a), layer(b)
        local ia = collision_handlers[la]
        if ia then
            add_collision_on(ia, lb, handler)
        else
            local ib = collision_handlers[b]
            if ib then
                add_collision_on(ib, la, handler)
            else
                local i = setmetatable({},{__mode="k"})
                add_collision_on(i, lb, handler)
                collision_handlers[a] = i
            end
        end
    end

    local grids_mt = {
        __index = function(t, k)
            if (layer_empty(k)) return
            local g = collision_grid(k)
            t[k] = g
            return g
        end
    }

    collision_grids = {}
    function collision_update()
        collision_grids = setmetatable({},grids_mt)

        for la, index in pairs(collision_handlers) do
            local ga = collision_grids[la]
            if ga then
                for lb, handlers in pairs(index) do
                    if #handlers > 0 then
                        local gb = collision_grids[lb]
                        if gb then
                            -- TODO pick smaller layer first
                            collision_grid_pairs_foreach(ga, gb, function(a, b)
                                for h in all(handlers) do
                                    h(a, b)
                                end
                            end)
                        end
                    end
                end
            end
        end
    end
end