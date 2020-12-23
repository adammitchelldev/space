-- collision

-- TODO:
-- * Add ray casting and collision sorting (most/first intersected)
-- so that bullets don't penetrate things randomly.
-- * Avoid duplicate collision (via better grid?)
-- * Add simple collision layer queries

-- TODO replace with better check, should be able to do 2
-- axis distance check for more efficient AABB, optimize tokens
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

function collision_grid(layer)
    local g = grid()

    for _, i in pairs(layer) do
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

function collision_grid_pairs_foreach(g1, g2, func)
    for x, y, c1 in cells(g1) do
        local c2 = rawget_cell(g2, x, y)
        for i1 in all(c1) do
            for i2 in all(c2) do
                if (collision_check(i1, i2)) func(i1, i2)
            end
        end
    end
end
