function vec_dist2(a, b)
    return (a.x - b.x) ^ 2 + (a.y - b.y) ^ 2
end

function vec_normalize(a, len)
    local current = sqrt(a.x ^ 2 + a.y ^ 2)
    len = len or 1
    a.x = a.x / current * len
    a.y = a.y / current * len
end