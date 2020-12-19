do
    local mts = {}
    local get_mt

    function class_extend(base, child)
        setmetatable(child, get_mt(base))
        return child
    end

    get_mt = function(base)
        local mt = mts[base]
        if mt == nil then
            mt = {
                __index = base,
                __call = class_extend
            }
            mts[base] = mt
        end
        return mt
    end

    class = {}
    setmetatable(class, { __call = class_extend })

    -- TODO create hook/delegates for init
end
