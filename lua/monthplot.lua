--
-- for each month
local passengers = AirPassengers.passengers

local data = {}

for i = 1, #passengers do
    local year_month = AirPassengers.months[i]
    local month = tonumber(year_month:sub(6,7))

    if not data[month] then
        data[month] = {}
    end

    table.insert(data[month], tonumber(passengers[i]))
end

for i = 1, #data do
    local m = mean(data[i])
    tex.print("\\addplot[mark=none] coordinates {")
    for j = 1, #data[i] do
        tex.print("(" .. i+j/12 .. "," .. data[i][j] .. ")")
    end
    tex.print("};")
    tex.print("\\draw[red] (" .. i .. "," .. m .. ") -- (" .. i+1 .. "," .. m .. ");")
end

AirPassengersByMonth = data
