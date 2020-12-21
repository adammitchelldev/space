do
    local grid3_mt = {
        __index = function(gridt, x)
            return setmetatable({}, {
                __index = function(rowt, y)
                    return setmetatable({}, {
                        __newindex = function(cellt, z, v)
                            rawset(gridt, x, rowt)
                            rawset(rowt, y, cellt)
                            rawset(cellt, z, v)
                            setmetatable(cellt, nil)
                        end
                    })
                end
            })
        end
    }

    function grid3()
        return setmetatable({}, grid3_mt)
    end
end

function cells3(g)
    local x, y, z, col, cell, v
    return function()
        repeat
            if v == nil then
                repeat
                    if cell == nil then
                        x, col = next(g, x)
                        if (col == nil) return nil
                    end
                    y, cell = next(col, y)
                until cell != nil
            end
            z, v = next(cell, z)
        until v != nil
        return x, y, z, v
    end
end

function rawget_cell3(g, x, y, z)
    local row = rawget(g, x)
    if row != nil then
        local cell = rawget(row, y)
        if (cell != nil) return rawget(cell, z)
    end
end