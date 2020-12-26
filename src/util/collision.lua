-- collision

-- TODO:
-- * Add ray casting and collision sorting (most/first intersected)
-- so that bullets don't penetrate things randomly.
-- * Avoid duplicate collision (via better grid?)
-- * Add simple collision layer queries

-- TODO review collision types
function collision_check(i1, i2)
    return i1.x + i1.coll_l < i2.x + i2.coll_r and
            i1.x + i1.coll_r > i2.x + i2.coll_l and
            i1.y + i1.coll_u < i2.y + i2.coll_d and
            i1.y + i1.coll_d > i2.y + i2.coll_u
end

function collision_grid(layer)
    local g = {}

    for _, i in pairs(layer) do
        if i.coll then
            local l = (i.x + i.coll_l) \ 16
            local r = (i.x + i.coll_r - 1) \ 16
            local u = (i.y + i.coll_u) \ 16
            local d = (i.y + i.coll_d - 1) \ 16

            for ix = l, r do
                local column = g[ix] or {}
                g[ix] = column
                for iy = u, d do
                    local cell = column[iy] or {}
                    column[iy] = cell
                    add(cell, i)
                end
            end
        end
    end

    return g
end

function collision_grid_pairs_foreach(g1, g2, func)
    for x, col1 in pairs(g1) do
        local col2 = g2[x]
        if col2 then
            for y, cell1 in pairs(col1) do
                local cell2 = col2[y]
                if cell2 then
                    for i1 in all(cell1) do
                        for i2 in all(cell2) do
                            if (collision_check(i1, i2)) func(i1, i2)
                        end
                    end
                end
            end
        end
    end
end
