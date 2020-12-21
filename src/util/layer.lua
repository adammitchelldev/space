layer_index = setmetatable({}, {
    __mode = "k"
})

local function layer_add_if_exists(key, obj)
    local l = layer_index[key]
    if (l) l[obj] = obj
end

local function layer_remove_if_exists(key, obj)
    local l = layer_index[key]
    if (l) l[obj] = nil
end

function layer_reg(obj, func)
    local c = obj
    while c != nil do
        -- class layer
        func(c, obj)

        -- tag layer
        local tag = c.tag
        if (tag) func(tag, obj)

        local tags = c.tags
        if tags then
            for tag in all(tags) do
                func(tag, obj)
            end
        end

        c = getmetatable(c)
        if (c) c = c.__index
    end
    return obj
end

function layer_add(obj)
    return layer_reg(obj, layer_add_if_exists)
end
class.add = layer_add

function layer_remove(obj)
    return layer_reg(obj, layer_remove_if_exists)
end
class.remove = layer_remove

do
    local layer_mt = {
        __index = function(layer, key)
            return function(...)
                -- TODO rethink firing
                update_layer(layer, key, ...)
            end
        end
    }

    function layer_is(obj)
        return getmetatable(obj) == layer_mt
    end

    function layer(key)
        if (layer_is(key)) return key
        local existing = layer_index[key]
        if (existing) return existing

        local t = {}
        if (key == nil) key = t
        layer_index[key] = t

        setmetatable(t, layer_mt)
        return t
    end
end

-- TODO probably don't need this
function layer_each(layer)
    local k, v, done
    return function()
        if (done) return nil
        k, v = next(layer, k)
        if (k == nil) done = true
        return v
    end 
end

-- TODO make stateless
function layer_pairs(layer1, layer2)
    local iter1 = layer_each(layer1)
    local iter2 = layer_each(layer2)

    local v1 = iter1()
    local v2 = nil
    return function()
        if v1 == nil then return nil end
        v2 = iter2()
        if v2 == nil then
            repeat
                v1 = iter1()
                if v1 == nil then return nil end
                v2 = iter2()
            until v2 != nil
        end
        return v1, v2
    end
end

function layer_empty(layer)
    return next(layer) == nil
end