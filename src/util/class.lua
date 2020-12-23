-- simple prototype-based inheritence

-- cache metatables for some memory efficiency
_mts = {}

function class_extend(base, child)
    local mt = _mts[base]
    if not mt then
        mt = {
            __index = base,
            __call = class_extend
        }
        _mts[base] = mt
    end
    setmetatable(child, mt)
    return child
end

class = setmetatable({}, { __call = class_extend })
