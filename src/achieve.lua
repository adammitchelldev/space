-- achievements

-- TODO replace this with an achieve class so that
-- achievements can be referred to as global variables
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

-- this loop should be run in a global script
-- it displays any achievements unlocked asynchronously
function achieve_display_loop()
    repeat
        local i = deli(achievement_queue, 1)
        if i then
            sfx(13)
            local lines = split(achievements[i],"\n")
            -- TODO put this in the GUI when the gui is a proper layer
            -- TODO replace with ttl or scripts
            -- TODO make a multi-line text box?
            text:new(lines[1], 64, 1, 0).ttl = 300
            text:new(lines[2], 64, 7, 0).ttl = 300
            wait(300)
        else yield() end
    until false
end

-- TODO probably better to use achievement objects
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
