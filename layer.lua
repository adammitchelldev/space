function layer(t)
    setmetatable(t, {
        __index = function(layer, key)
            return function(...)
                for item in layer_each(layer) do
                    item[key](item, ...)
                end
            end
        end
    })
    return t
end

function class:add()
    if self.layer != nil then
        self.layer[self] = self
    end
end

function class:remove()
    if self.layer != nil then
        self.layer[self] = nil
    end
end

function layer_foreach(func)
	for k, v in pairs(layer) do
		func(v)
    end
end

function layer_each(layer)
    local orig_iter, state, cv = pairs(layer)
    return function()
        local k, v = orig_iter(state, cv)
        cv = k
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