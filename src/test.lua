local function rnd_input(x)
    if x then
        return rnd() < 0.5
    else
        return flr(rnd(0x40))
    end
end

local old_init = _init
function _init()
    test = stat(6) == "test"

    if test then
        btn = rnd_input
        btnp = rnd_input
    end

    old_init()
end

local old_update = _update60
function _update60()
    old_update()

    if test and time() > 1 then
		printh("TEST SUCCESS")
		stop()
	end
end
