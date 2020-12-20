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
    local inner_mt = {
        __index = function(t, k)
            local nt = {}
            t[k] = nt
            return nt
        end
    }
    local grid_mt = {
        __index = function(t, k)
            local nt = {}
            setmetatable(nt, inner_mt)
            t[k] = nt
            return nt
        end
    }

    function collision_grid(layer)
        local grid = setmetatable({}, grid_mt)

        for i in layer_each(layer) do
            local x = i.x
            local y = i.y
            local l = (x + i.col.l) \ 16
            local r = ((x + i.col.r - 1) \ 16)
            local u = (y + i.col.u) \ 16
            local d = ((y + i.col.d - 1) \ 16)

            for ix = l, r do
                for iy = u, d do
                    color(7)
                    add(grid[ix][iy], i)
                end
            end
        end

        return grid
    end

    local function rawget_cell(grid, x, y)
        local othercol = rawget(grid, x)
        if (not othercol) return
        return rawget(othercol, y)
    end

    function collision_list_pairs_foreach(list1, list2, func)
        if (not (list1 and list2)) return
        for _, i1 in ipairs(list1) do
            for _, i2 in ipairs(list2) do
                if (collision_check(i1, i2)) func(i1, i2)
            end
        end
    end
    
    function collision_grid_pairs_foreach(grid1, grid2, func)
        for x, column in pairs(grid1) do
            for y, inner in pairs(column) do
                local other = rawget_cell(grid2, x, y)
                if (not other) goto continue
                collision_list_pairs_foreach(inner, other, func)
                ::continue::
            end
        end
    end
end
