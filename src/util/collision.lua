-- collision

-- TODO:
-- * Add ray casting and collision sorting (most/first intersected)
-- so that bullets don't penetrate things randomly.
-- * Avoid duplicate collision (via better grid?)
-- * Add simple collision layer queries

-- TODO review collision types
function collision_check(i1, i2)
    local col1,col2=i1.col,i2.col
    return i1.x + col1.l < i2.x + col2.r and
            i1.x + col1.r > i2.x + col2.l and
            i1.y + col1.u < i2.y + col2.d and
            i1.y + col1.d > i2.y + col2.u
end

function collision_grid(layer)
    local g = {}

    for _, i in pairs(layer) do
        local collider = i.col
        if collider then
            local l = (i.x + collider.l) \ 16
            local r = (i.x + collider.r - 1) \ 16
            local u = (i.y + collider.u) \ 16
            local d = (i.y + collider.d - 1) \ 16

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
