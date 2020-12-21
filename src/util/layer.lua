layer_index = setmetatable({}, {
    __mode = "kv"
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

function layer(key)
    local existing = layer_index[key]
    if (existing) return existing

    local t = {}
    if (key == nil) key = t
    layer_index[key] = t

    setmetatable(t, {
        __index = function(layer, key)
            return function(...)
                -- TODO rethink firing
                update_layer(layer, key, ...)
            end
        end
    })
    return t
end

function layer_each(layer)
    local orig_iter, state, cv = pairs(layer)
    local done = false
    return function()
        if (not orig_iter) return nil
        local k, v = orig_iter(state, cv)
        cv = k
        if v == nil then
            orig_iter = nil
            state = nil
            cv = nil
        end
        return v
    end 
end

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
