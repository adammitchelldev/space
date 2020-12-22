do
    -- TODO replace with the efficient ordered buffer
    -- TODO integrate this with update ticking?
    local active_scripts = {}
    local global_step = 0

    local function step_inner(script, ...)
        local active, exception = coresume(script, ...)
        if costatus(script) == "dead" then
            active_scripts[script] = nil
        else
            active_scripts[script] = global_step
        end
        if exception then
            printh(trace(script, exception))
            stop("script err: "..exception)
        end
    end

    local function bump_step(script)
        if (active_scripts[script] != global_step) step_inner(script)
    end

    function play(func, ...)
        local script = cocreate(func)
        step_inner(script, ...)
        return script
    end

    function cancel(script)
        bump_step(script)
        active_scripts[script] = nil
    end

    function script_update()
        global_step += 1
        for script, current_step in pairs(active_scripts) do
            if (current_step != global_step) step_inner(script)
        end
    end

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

    function script(func)
        return function(...) return play(func, ...) end
    end

    local function step(script, ...)
        local active, exception = coresume(script, ...)
        if exception then
            printh(trace(script, exception))
            stop("script err: "..exception)
        end
        return costatus(script) != "dead"
    end

    function script_add_listener(e, ...)
        local scripts = e.scripts
        if scripts then
            local active_scripts = {}
            e.active_scripts = active_scripts
            for f in all(scripts) do
                local script = cocreate(f)
                if (step(script, e, ...)) add(active_scripts, script)
            end
        end
    end

    function update_scripts(e)
        local active_scripts = e.active_scripts
        if active_scripts then
            for i=#active_scripts,1,-1 do
                local script = active_scripts[i]
                if (not step(script)) deli(active_scripts, i)
            end
        end
    end

    -- need to be careful about play timing, if we play scripts
    -- on another instance, it may get played twice on the first frame
    function class:play(f, ...)
        local script = cocreate(f)
        if step(script, self, ...) then
            local active_scripts = self.active_scripts
            if not active_scripts then
                active_scripts = {}
                self.active_scripts = active_scripts
            end
            add(active_scripts, script)
        end
    end
end