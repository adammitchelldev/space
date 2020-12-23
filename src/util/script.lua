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
            while costatus(arg) != "dead" do
                yield()
                t += 1
            end
        elseif ty == "function" then
            while not arg(t) do
                yield()
                t += 1
            end
        elseif ty == "table" then
            while not arg.dead do
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

function script_update(self)
    local active_scripts = self.active_scripts
    if active_scripts then
        for i=#active_scripts,1,-1 do
            local script = active_scripts[i]
            if (not script_step(script)) deli(active_scripts, i)
        end
    end
end

-- TODO be careful about play timing, if we play scripts
-- on another instance, it may get played twice on the first frame
function script_play(self, f, ...)
    local script = cocreate(f)
    if script_step(script, self, ...) then
        if (self.active_scripts) add(self.active_scripts, script) else self.active_scripts = {script}
    end
end
