function collision_pairs(layer1, layer2, func)
    layer_foreach(layer1, function(i1)
        layer_foreach(layer2, function(i2)
            -- i1.col.l
            -- i1.col.r
            -- i1.col.u
            -- i1.col.d
            -- i1.x
            -- ir.y

            local l1 = i1.x + i1.col.l
            local r1 = i1.x + i1.col.r
            local u1 = i1.y + i1.col.u
            local d1 = i1.y + i1.col.d

            local l2 = i2.x + i2.col.l
            local r2 = i2.x + i2.col.r
            local u2 = i2.y + i2.col.u
            local d2 = i2.y + i2.col.d

            if l1 < r2 and
                r1 > l2 and
                u1 < d2 and
                d1 > u2 then
                func(i1, i2)
            end
        end)
    end)
end
