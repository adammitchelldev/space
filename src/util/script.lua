function wait(...)
    local t = 0
    for arg in all({...}) do
        local ty = type(arg)
        if ty == "number" then
            while t < arg do
                yield()
                t += 1
            end
        elseif ty == "thread" then
            while active_scripts[arg] != nil do
                bump_step(arg)
                yield()
                t += 1
            end
        elseif ty == "function" then
            while not arg(t) do
                yield()
                t += 1
            end
        end
    end
end

function script_step(script, ...)
    local active, exception = coresume(script, ...)
    if exception then
        printh(trace(script, exception))
        stop("script err: "..exception)
    end
    return costatus(script) != "dead"
end

-- put this straight onto the add method
function script_add_listener(e, ...)
    local scripts = e.scripts
    if scripts then
        local active_scripts = {}
        e.active_scripts = active_scripts
        for f in all(scripts) do
            local script = cocreate(f)
            if (script_step(script, e, ...)) add(active_scripts, script)
        end
    end
end

function update_scripts(e)
    local active_scripts = e.active_scripts
    if active_scripts then
        for i=#active_scripts,1,-1 do
            local script = active_scripts[i]
            if (not script_step(script)) deli(active_scripts, i)
        end
    end
end

-- need to be careful about play timing, if we play scripts
-- on another instance, it may get played twice on the first frame
function class:play(f, ...)
    local script = cocreate(f)
    if script_step(script, self, ...) then
        local active_scripts = self.active_scripts
        if not active_scripts then
            self.active_scripts = {script}
        else
            add(active_scripts, script)
        end
    end
end
