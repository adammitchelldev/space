achievements = {
    "first blood!\nkILL YOUR FIRST ENEMY.",
    "killing spree!\n50 KILLS IN ONE RUN.",
    "like a boss!\ndEFEAT THE FIRST BOSS.",
    "genocide!\n1000 KILLS IN ONE RUN.",
    "max power!\ngET MAX GUN UPGRADES.",
    "deicide!\n5 BOSS KILLS IN ONE RUN.",
    "hot stuff!\n200 THOUSAND POINTS.",
    "mega cool!\n500 THOUSAND POINTS.",
    "millionaire!\n1 MILLION POINTS.",
}

achievement_queue = {}

-- TODO make this better
play(function()
    repeat
        local i = deli(achievement_queue, 1)
        if i then
            sfx(13)
            local lines = split(achievements[i],"\n")
            -- TODO put this in the GUI when the gui is a proper layer
            -- TODO replace with ttl or scripts
            -- TODO make a multi-line text box?
            local t1 = text_box(lines[1], 64 - (#lines[1] * 2), 1)
            local t2 = text_box(lines[2], 64 - (#lines[2] * 2), 7)
            wait(300)
            t1:remove()
            t2:remove()
        else yield() end
    until false
end)

-- TODO probably better to do this as global achievement objects
function achieve(i)
    local real_i = i - 1
    local addr = ((real_i & 0b1111100000) >> 5) + 32
    local bit = 1 << (real_i & 0b11111)
    local old = dget(addr)
    if bit & old == 0 then
        dset(addr, bit | dget(addr))
        add(achievement_queue, i)
    end
end

function clear_achievements()
    for i = 32,63 do
        dset(i, 0)
    end
end