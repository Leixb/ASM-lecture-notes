local function seasonal_difference(s, data)
    local result = {}
    local i = 1
    for j = s, #data do
        result[i] = math.log(data[j]) - math.log(data[j-s+1])
        i = i + 1
    end
    return result
end

local function to_decimal_year(year_month)
    local year = tonumber(year_month:sub(1,4))
    local month = tonumber(year_month:sub(6,7))
    return year + (month-1)/12
end

local s = 12
local diff = seasonal_difference(s, AirPassengers.passengers)

for i = 1, #diff do
    local j = i + s - 1
    local decimal_year = to_decimal_year(AirPassengers.months[j])

    tex.print("(" .. decimal_year .. "," .. diff[i] .. ")")
end
