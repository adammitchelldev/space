do
    local grid_mt = {
        __index = function(gridt, x)
            return setmetatable({}, {
                __newindex = function(rowt, y, v)
                    rawset(gridt, x, rowt)
                    rawset(rowt, y, v)
                    setmetatable(rowt, nil)
                end
            })
        end
    }

    function grid()
        return setmetatable({}, grid_mt)
    end
end

function cells(g)
    local x, y, col, v
    return function()
        repeat
            if v == nil then
                x, col = next(g, x)
                if type(x) == "table" then
                    stop(trace())
                end
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
