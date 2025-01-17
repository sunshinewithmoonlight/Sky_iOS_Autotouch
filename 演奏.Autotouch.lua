musicScorePath =  debug.getinfo(1).source:match('@?(.*/)') .. 'SkyMusicScore/'
io.popen('mkdir ' .. musicScorePath)
local musicScoreP1 = io.popen('ls ' .. musicScorePath .. '| sed "s/\\.txt$//"', 'r')
local musicScoreP2 = musicScoreP1:read('*a') -- 读取文件夹中的全部曲谱
musicScoreP1:close()

if musicScoreP2 == '' then
	alert("empty")
	os.exit()
end

local musicScoreList = {}
for i in string.gmatch(musicScoreP2, "[^\n]+") do
    table.insert(musicScoreList, i)
end

function compareByLengthAndType(a, b)
    -- 获取首字母是否为中文
    local aIsChineseFirst = string.byte(a, 1) >= 128
    local bIsChineseFirst = string.byte(b, 1) >= 128

    -- 如果一个是中文开头,一个是英文开头,则将英文开头的排在后面
    if aIsChineseFirst ~= bIsChineseFirst then
        return aIsChineseFirst
    end

    -- 如果都是中文开头,则按照字符串长度排序
    if aIsChineseFirst then
        return string.len(a) < string.len(b)
    end

    -- 如果都是英文开头,则首先按照首字母排序,然后按照字符串长度排序
    local aFirst = string.lower(string.sub(a, 1, 1))
    local bFirst = string.lower(string.sub(b, 1, 1))
    if aFirst ~= bFirst then
        return aFirst < bFirst
    else
        return string.len(a) < string.len(b)
    end
end

table.sort(musicScoreList, compareByLengthAndType)

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

function play(a, b)

    if a == nil then
        return;
        end

    local v = text2table(a)
    local playableTable = table2playable(v)
    local gap = 81000000 // b
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


local scorePicker = {type=CONTROLLER_TYPE.PICKER, title="选择乐谱文件:", key="Picker", value="---选择乐谱文件---", options=musicScoreList}
local btn1 = {type=CONTROLLER_TYPE.BUTTON, title="开始", color=0x0960FF, width=1.0, flag=1, collectInputs=true}
local btn2 = {type=CONTROLLER_TYPE.BUTTON, title="不弹了", color=0x0960FF, width=1.0, flag=2, collectInputs=true}
local controls = {scorePicker, btn1, btn2}
local result = dialog(controls);

if (result == 1) then

	local scoreP1 = io.open(musicScorePath .. scorePicker.value .. '.txt', 'rb') -- 以二进制模式打开文件
	local scoreP2 = scoreP1:read("*a") -- 读取整个文件内容为字节字符串
	scoreP1:close()
	local scoreContent = "" -- 存储最终的UTF-8字符串
	for i = 1, #scoreP2, 2 do
	  local scoreP3 = string.unpack("<I2", scoreP2, i) -- 以小端序读取一个 UTF-16 码位
	  scoreContent = scoreContent .. utf8.char(scoreP3) -- 将码位转换为 UTF-8 字符并拼接到结果字符串中
	end
	
	local firstLine = scoreContent:match("(.*)\n") -- 获取第一行
	local speed = firstLine:gmatch("%S+%s+(%S+)")() -- 获取速度
	local scoreABC = scoreContent:match("\n(.*)")  -- 获取ABC谱

	play(scoreABC, tonumber(speed))
	
end
