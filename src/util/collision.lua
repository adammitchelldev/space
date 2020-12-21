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

-- collision_index = setmetatable({}, {
--     __mode = "kv"
-- })

-- function collision_on(a, b, handler)
--     local layer_a = layer(a)
--     local layer_b = layer(b)
-- end
