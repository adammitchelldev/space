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