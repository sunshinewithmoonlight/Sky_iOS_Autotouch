
-- x
-- 280
-- 430
-- 570
-- 710
-- 850
-- 
-- y
-- 130
-- 270
-- 410

function text2table(a)
    local s3= {};
    for i in (a.." "):gmatch("(.-)".." ") do
      table.insert(s3, i)
      end
    return s3;
    end

function table2playable(a_table)

    local s= {};
    local i4=-1
    for i,i2 in ipairs(a_table) do
    
        if (string.len(i2)==1) then
        table.insert(s, {})
        elseif (string.len(i2)>1) then
            local currentPoints = {}
            for i3= 1, string.len(i2)/2 do
                i4 = (i4 + 1) % 10 
                local currentPoint = {}
                local currentPointX, currentPointY = touchPoint(string.sub(i2, 2*i3-1, 2*i3))
                currentPoint.id = i4
                currentPoint.x = tonumber(currentPointX)
                currentPoint.y = tonumber(currentPointY)
                table.insert(currentPoints, currentPoint)
            end
            table.insert(s, currentPoints)
        end
    end
return s;
end

function touchPoint(a)
    -- 接收单个的如“b3”
    local s= string.sub(a, 1, 1)
    local s2= string.sub(a, 2, 2)
    
    -- 810
    -- 690
    -- 570
    -- 450
    -- 330

    -- 280
    -- 430
    -- 570
    -- 710
    -- 850
    local s3=0
    local s4=0
    if (s2=="1") then
        s4=280
    elseif (s2=="2")  then
        s4=430
    elseif (s2=="3")  then
        s4=570
    elseif (s2=="4")  then
        s4=710
    elseif (s2=="5")  then
        s4=850
        end
    --local s4=math.floor(330+120*(5-s2))
    if (s=="A") then
        s3 = 130
    elseif (s=="B") then
        s3 = 270
    elseif (s=="C") then
        s3 = 410
        end
    return s4, s3;
    end

function main(a)

    if a == nil then
        return;
        end

    local v = text2table(a)
    local playableTable = table2playable(v)
    local gap = 30000000 // 300
    log(table.tostring(playableTable))
    local currentPointsStack = {{}, {}}
    local i_currentPointsStack = 1
    for _, i in ipairs(playableTable) do
        if currentPointsStack[i_currentPointsStack] ~= {} then
            for _, i3 in ipairs(currentPointsStack[i_currentPointsStack]) do
                touchUp(i3.id, i3.x, i3.y)
            end
            currentPointsStack[i_currentPointsStack] = {}
        end
        if i ~= {} then
            i_currentPointsStack = (i_currentPointsStack+1)%2 +1
            currentPointsStack[i_currentPointsStack] = i
            for _, i2 in ipairs(i) do
                touchDown(i2.id, i2.x, i2.y) 
            end
            
        end
        
        usleep(gap)

    end
    if currentPointsStack[i_currentPointsStack] ~= {} then
        for _, i3 in ipairs(currentPointsStack[i_currentPointsStack]) do
            touchUp(i3.id, i3.x, i3.y)
        end
        currentPointsStack[i_currentPointsStack] = {}
    end

end


main("A5 B3 B4 A4C2 . . A5 . . B3 . . A2B2 . . . . . . . . . . . . . . . . . . . . . . . . . . B3 B2 A1B1 . . A4B2 . . B1B3 . . A5B2 . . . . . . . . . . . . . . . . . . . . . . . . . C3 . C4 . B3B5C5 . . C4 . B5 . . . C2 . . . A4B1C2 . . . . . B3 . . . A5B2B4 . . . B3 . B4 . . . C2 . . . A5B3B5 . . . . . . C3 . . C4 . . . B3B5C5 . . C4 . B5 . . . C2 . . . A4B1C2 . . . . . B3 . . . . . A5B2B4C2 . . . . . . . . . . . . . . . . . . . B3 . . B4 . . A5B3B5 . . . . . B3 . . B2 . . A1B1 . . A4B2 B3 . B1 . . B5 . . A5B2B4 . . . . . B2 . . B1 . . A3A5 . . B1 . B2 A5 . . B4 . . A3B1B3 . . . . . . . . . B3 B2 . A3A5B3 . . . . . . B1 B1 . B2 . A2A4B3 . . B2 . . B1B3 . . A5B2B4C2 . . . . . . . B3 . . B4 . . A1B5 . . A5 . . B3 . . B2 . . A1B1 . . A4B2 B3 . B1 . . B5 . . A2B4 . . A5 . . B2 . . B1 . . A3B2 . . C1 . . B2B5 . . B2 B3 . A3B1 . . A3 . . A3C3 C4 . B1C5 . . A3A5C4 . . . . . . . . B1 B3 . A1C1 . . B5 B3 . C1 . . B5 B3 . B3 . . . . . A1A4 . . B1 B3 . A2A4B4 . . B4 . B4 . . . B5 . . . A4B1C1 . . . . B5 . . . . B3 . . A2A5B4 . . . . . . . . . . . . . . . C2 . . C3 . . C4 . . A3C5 . . B1C4 . B5 B3 . C2 . . C2 . A4 . . A1C3 . . A4B4 . . B3 . . A2B4 . . A5B3 . B4 B2 . C2 . . B5 A1 . . A5C2 . . B3C3 . . A5C4 . . A3C5 . . B1C4 . B5 B3 . C2 . . C2 . A4 . . A1C3 . . A4B4 . . B3 . . A2B4 . . B3 B2 . A5 . B3 . . B3 A1 . . A5C2 . . B3C3 . . A5C4 . . A3C5 . . B1C4 . B5 B3 . C2 . . C2 . A4 . . A1C3 . . A4B4 . . B3 . . A2B4 . . A5B3 . B4 B2 . C2 . . B5 A1 . . A5C2 . . B3C3 . . A5C4 . . A3C5 . . B1C4 . B5 B3 . C2 . . C2 . A4 . . A1 . . A4B5 . C2 . . C2 . A2 . . A5 . . B2B4C2 . . . . . C1 . B5 . . B4 . . . . B3 . . B3 ")