
do
    local world_index = {}

    function world_index:add(item)
        self.ents[item] = item
        for l in all(self.add_listeners) do
            l(item)
        end
    end

    function world_index:remove(item)
        self.ents[item] = nil
        for l in all(self.remove_listeners) do
            l(item)
        end
    end

    function world_index:process(systems, ...)
        for s in all(systems) do
            for _, i in pairs(self.ents) do
                s(i, ...)
            end
        end
    end

    function world(add_listeners, remove_listeners)
        return setmetatable({
            add_listeners = add_listeners,
            remove_listeners = remove_listeners,
            ents = {}
        }, {__index=world_index})
    end
end
