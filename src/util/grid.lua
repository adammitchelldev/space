-- grid class

function grid()
    return setmetatable({}, {
        __index = function(t, k)
            local v = {}
            t[k] = v
            return v
        end
    })
end

function cells(g)
    local x, y, col, v
    return function()
        repeat
            if v == nil then
                x, col = next(g, x)
                if (col == nil) return nil
            end
            y, v = next(col, y)
        until v != nil
        return x, y, v
    end
end

function rawget_cell(g, x, y)
    local row = rawget(g, x)
    if (row != nil) return rawget(row, y)
end
