-- boxplot for years
local passengers = AirPassengers.passengers
local s = 12

-- split passengers into groups of size 12
for i = 1, #passengers, s do
    year_month = AirPassengers.months[i]
    year = string.sub(year_month, 1, 4)

    tex.print("\\addplot[boxplot] table[row sep=newline,y index=0] {")
    for j = 1, s do
        if i + j - 1 <= #passengers then
            tex.print(passengers[i + j - 1])
        end
    end
    tex.print("};")
end
