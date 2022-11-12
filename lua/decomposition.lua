local data = io.open("data/AirPassengers.csv", "r")

local months = {}
local passengers = {}
local i = 0
for line in data:lines() do
    month, pass = line:match("([^,]+),([^,]+)")
    if i > 0 then
        table.insert(months, month)
        passengers[i] = tonumber(pass)
    end
    i = i + 1
end
data:close()

AirPassengers = {
    months = months,
    passengers = passengers
}

-- trend
local trend = {}
local s = 12
i = 1
for t = s/2+1, #months-s/2 do
    local sum = 0
    for j = 1, s do
        sum = sum + passengers[t-s/2+j]
    end
    trend[i] = sum/s
    i = i + 1
end

-- mean
local sum = 0
for i = 1, #trend do
    sum = sum + trend[i]
end
local mean = sum/#trend

-- seasonal
local seasonal = {}
for i = 1, s do
    local sum = 0
    for j = 1, #months/s do
        sum = sum + passengers[(j-1)*s+i]
    end
    table.insert(seasonal, sum/#months*s - mean)
end

-- fit
local fit = {}
for i = 1, #trend do
    -- table.insert(residual, passengers[i] - trend[math.floor((i-1)/s)+1] - seasonal[i%s+1])
    j = ((i + s/2) % s) + 1
    table.insert(fit, trend[i] + seasonal[j])
end

local residual = {}
for i = 1, #fit do
    table.insert(residual, passengers[i + s/2] - fit[i])
end

-- plot
tex.print("\\addplot[mark=o, mark size=1pt, color=black] coordinates {")
for i = 1, #passengers do
    tex.print("        (" .. months[i] .. ", " .. passengers[i] .. ")")
end
tex.print("};")
tex.print("\\addplot[mark=none, color=blue] coordinates {")
for i = 1, #trend do
    tex.print("    (" .. months[i+s/2] .. ", " .. trend[i] .. ")")
end
tex.print("};")
tex.print("\\addplot[mark=none, color=red] coordinates {")
for i = 1, #passengers do
    j = (i % #seasonal) + 1
    tex.print("    (" .. months[i] .. ", " .. seasonal[j] .. ")")
end
tex.print("};")
tex.print("\\addplot[mark=none, color={green!70!black}] coordinates {")
for i = 1, #residual do
    tex.print("    (" .. months[i+s/2] .. ", " .. fit[i] .. ")")
end
tex.print("};")
tex.print("\\addplot[mark=none, color=orange] coordinates {")
for i = 1, #residual do
    tex.print("    (" .. months[i+s/2] .. ", " .. residual[i] .. ")")
end
tex.print("};")
