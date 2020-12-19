do
    local _active_scenes = {}

    function scene_update()
        for _, scene in pairs(_active_scenes) do
            if costatus(scene) == 'suspended' then
                assert(coresume(scene))
            else
                _active_scenes[scene] = nil
            end
        end
    end

    function scene_play(script)
        local scene
        scene = cocreate(script)
        _active_scenes[scene] = scene
        assert(coresume(scene)) --TODO add proper error handling which is now available
    end
end

function scene_multitask(scripts)
    local tasks={}
    for script in all(scripts) do
        add(tasks,cocreate(script))
    end
    repeat
        local complete = true
        for task in all(tasks) do
            if coresume(task) then
                complete = false
            end
        end
        if complete then
            return
        else
            yield()
        end
    until false
end

function scene_wait(t)
	for i=1,t do
		yield()
	end
end