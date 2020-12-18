function layer_add(layer, ent)
	layer[ent] = ent
end

function layer_remove(layer, ent)
	layer[ent] = nil
end

function layer_foreach(layer, func)
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