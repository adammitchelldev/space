function process(items, systems, ...)
    for s in all(systems) do
        for _, i in pairs(items) do
            s(i, ...)
        end
    end
end
