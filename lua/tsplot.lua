local data = AirPassengersByMonth 

for i = 1, 12 do
    tex.print("\\addplot+[mark=none] coordinates {")
    for j = 1, #data do
        tex.print("(" .. j .. "," .. data[j][i] .. ")")
    end
    tex.print("};")
end
