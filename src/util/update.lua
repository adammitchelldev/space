-- Coroutine powered update methods

do
    local automap
    automap = function()
        return setmetatable({}, {
            __index = function(t, k, v)
                local n = automap()
                t[k] = n
                return n
            end
        })
    end

    local secret_keys = automap()

    local function updater(self, item, iter, funcname, secret_key, ...)
        repeat
            local f = item[funcname]
            if type(f) == "function" then
                local co = item[secret_key]
                if not co then
                    item[secret_key] = self
                    item[funcname](item, ...)
                    item[secret_key] = nil
                else
                    local active, exception = coresume(co, co, item, iter, funcname, secret_key, ...)
                    if exception then
                        printh(trace(script, exception))
                        stop("script err: "..exception)
                    end
                end
            end
            item = iter()
        until not item
    end

    function update_layer(layer, funcname, ...)
        local secret_key = secret_keys[funcname]

        local iter = layer_each(layer)

        local item = iter()
        if (not item) return

        local co = cocreate(updater)
        local active, exception = coresume(co, co, item, iter, funcname, secret_key, ...)
        if exception then
            printh(trace(script, exception))
            stop("script err: "..exception)
        end
    end
end

function scriptable(obj)
    local old_mt = getmetatable(obj)
    local scripts = setmetatable({}, old_mt)
    local mt = {}
    for key, value in pairs(test) do
        mt[key] = value
    end
    mt.__index = scripts
    function mt:__newindex(key, value)
        if type(value) == "function" then
            local existing = scripts[key]
            if existing then
                add(existing, value)
            else
                scripts[key] = {value}
            end
        else
            if old_mt.__newindex then
                old_met.__newindex(self, key, value)
            else
                rawset(self, key, value)
            end
        end
    end
end
