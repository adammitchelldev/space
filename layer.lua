function layer_add(system, ent)
	system[ent] = ent
end

function layer_remove(system, ent)
	system[ent] = nil
end

function layer_foreach(system, func)
	for k, v in pairs(system) do
		func(v)
	end
end