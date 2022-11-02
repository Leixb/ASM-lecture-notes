function mean(t)
    local sum = 0
    for i = 1, #t do
        sum = sum + t[i]
    end
    return sum/#t
end

function variance(t)
    local m = mean(t)
    local sum = 0
    for i = 1, #t do
        sum = sum + (t[i] - m)^2
    end
    return sum/(#t - 1)
end

local passengers = AirPassengers.passengers
local s = 12

tex.print("\\addplot coordinates {")

-- split passengers into groups of size 12
nodes = {}
for i = 1, #passengers, s do
    group = {}
    year_month = AirPassengers.months[i]
    year = string.sub(year_month, 1, 4)
    for j = 1, s do
        if i + j - 1 <= #passengers then
            table.insert(group, passengers[i + j - 1])
        end
    end
    local m = mean(group)
    local v = variance(group)
    tex.print("    (" .. m .. ", " .. v .. ")")
    table.insert(nodes, {x = m, y = v, year = year})
end
tex.print("};")

for i = 1, #nodes do
    tex.print("\\node[blue,above left] at (" .. nodes[i].x .. ", " .. nodes[i].y .. ") {" .. nodes[i].year .. "};")
end
