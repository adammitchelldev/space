function vec_dist2(a, b)
    return (a.x - b.x) ^ 2 + (a.y - b.y) ^ 2
end

function vec_len2(x, y)
    return x ^ 2 + y ^ 2
end

function vec_normalize(a, len)
    a.x, a.y = vec_xy_normalize(a.x, a.y, len)
end

function vec_xy_normalize(x, y, len)
    local current = sqrt(x ^ 2 + y ^ 2)
    len = len or 1
    return x / current * len, y / current * len
end