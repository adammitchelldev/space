function collision_pairs(layer1, layer2)
    local iter = layer_pairs(layer1, layer2)
    return function()
        local i1, i2
        repeat
            i1, i2 = iter()
            if i1 == nil then return nil end

            local l1 = i1.x + i1.col.l
            local r1 = i1.x + i1.col.r
            local u1 = i1.y + i1.col.u
            local d1 = i1.y + i1.col.d

            local l2 = i2.x + i2.col.l
            local r2 = i2.x + i2.col.r
            local u2 = i2.y + i2.col.u
            local d2 = i2.y + i2.col.d
        until l1 < r2 and r1 > l2 and u1 < d2 and d1 > u2
        return i1, i2
    end
end
