init("0", 0);
luaExitIfCall(true);
setVolumeLevel(0.4)
mSleep(500);
-- x
-- 90
-- 220
-- 350

-- y
-- 810
-- 690
-- 570
-- 450
-- 330
function m6_table_lenth(a_table)

  local table_lenth=0
  for _ in pairs(a_table) do
    table_lenth=table_lenth+1
    end
  return table_lenth
  end


function m5_path2text(a_path)
  if nil== a_path then
    a_path= '/res/'
    end
  
  local s= io.popen("ls "..userPath()..a_path);
  local s2= {}
  for i in s:lines() do
    table.insert(s2, userPath()..a_path..i)
    end
  s:close()

  s2_lenth = m6_table_lenth(s2)
  if s2_lenth >0 then
    playlist={};
    playlist_lenth=0
    toast("歌曲文件必须是utf-8格式的ABC谱")
    local choice=1
    choice= dialogRet("全部随机播放？","是","否","",5)
    if choice==0 then
      playlist=s2
      for i= s2_lenth,2,-1 do
        local s5= math.random(1, i);
        playlist[i], playlist[s5] = playlist[s5], playlist[i]
        end
      playlist_lenth=s2_lenth
    else
      for i= 1,s2_lenth,1 do
        if string.sub(s2[i], -4)==".txt" then
          choice=1
          choice= dialogRet(s2[i].." 需要播放吗？","是","否","",3)
          if choice==0 then
            table.insert(playlist, s2[i])
            playlist_lenth=playlist_lenth+1
            end
          end
        end
      end

    else
      toast("请把需要播放的txt文件放置在"..a_path.."文件夹")
      lua_exit()
      mSleep(300)
    end

  if playlist_lenth >0 then
    for i= 1,playlist_lenth,1 do
      if string.sub(playlist[i], -4)==".txt" then
        local f = io.open(playlist[i], 'r');
        local s4={};
        if f then
          for i2 in f:lines() do
            table.insert(s4, i2)
            end
          f:close()
          local s3= {};
          for i2 in (s4[1].." "):gmatch("(.-)".." ") do
            table.insert(s3, i2)
            end
          gap=60000/s3[2]
          m(s4[2])
          end
        end
      end
    else
      toast("暂无播放任务")
      lua_exit()
      mSleep(300)
    end
  end


function m4_table2playable(a_table)

  local s= {};
  for i,i2 in ipairs(a_table) do

    if (string.len(i2)==1) then
      table.insert(s, -1)
    elseif (string.len(i2)>1) then
      for i3= 1, string.len(i2)/2 do
        local s3_x, s4_y= m2(string.sub(i2, 2*i3-1, 2*i3))
        table.insert(s, tonumber(s3_x))
        table.insert(s, tonumber(s4_y))
        end
      table.insert(s, -1)
      end
    end
  return s;
  end


function m3_text2table(a)
  local s3= {};
  for i in (a.." "):gmatch("(.-)".." ") do
    table.insert(s3, i)
    end
  return s3;
  end


function m2(a)
  -- 接收单个的如“b3”
  local s= string.sub(a, 1, 1)
  local s2= string.sub(a, 2, 2)

  -- 810
  -- 690
  -- 570
  -- 450
  -- 330
  if (s2==1) then
    s4_y=810
  elseif (s2==2)  then
    s4_y=690
  elseif (s2==3)  then
    s4_y=570
  elseif (s2==4)  then
    s4_y=450
  elseif (s2==5)  then
    s4_y=330
    end
  local s3_x=0
  local s4_y=330+120*(5-s2)
  if (s=="A") then
    s3_x= 90
  elseif (s=="B") then
    s3_x= 220
  elseif (s=="C") then
    s3_x= 350
    end
  return s3_x,s4_y;
  end
  


function m(a)

  local is_skip= false
  if a == nil then
    return;
    end
  local s= m3_text2table(a)
  local s2= m4_table2playable(s)
  for i, i2 in ipairs(s2) do
    repeat
      if (is_skip==true) then
        is_skip=false
        break
        end
      if (i2==-1) then
        mSleep(gap);
      else
        mSleep(55);
        -- 如果需要可以移除这里的mSleep
        touchDown(s2[i], s2[i+1]);
        mSleep(55);
        -- 如果需要可以移除这里的mSleep
        touchUp(s2[i], s2[i+1]);
        is_skip=true
      end
    until true
    end
  end


gap=200
m(m5_path2text("/lua/"))
--m("A5 B3 B4 A4C2 . . A5 . . B3 . . A2B2 . . . . . . . . . . . . . . . . . . . . . . . . . . B3 B2 A1B1 . . A4B2 . . B1B3 . . A5B2 . . . . . . . . . . . . . . . . . . . . . . . . . C3 . C4 . B3B5C5 . . C4 . B5 . . . C2 . . . A4B1C2 . . . . . B3 . . . A5B2B4 . . . B3 . B4 . . . C2 . . . A5B3B5 . . . . . . C3 . . C4 . . . B3B5C5 . . C4 . B5 . . . C2 . . . A4B1C2 . . . . . B3 . . . . . A5B2B4C2 . . . . . . . . . . . . . . . . . . . B3 . . B4 . . A5B3B5 . . . . . B3 . . B2 . . A1B1 . . A4B2 B3 . B1 . . B5 . . A5B2B4 . . . . . B2 . . B1 . . A3A5 . . B1 . B2 A5 . . B4 . . A3B1B3 . . . . . . . . . B3 B2 . A3A5B3 . . . . . . B1 B1 . B2 . A2A4B3 . . B2 . . B1B3 . . A5B2B4C2 . . . . . . . B3 . . B4 . . A1B5 . . A5 . . B3 . . B2 . . A1B1 . . A4B2 B3 . B1 . . B5 . . A2B4 . . A5 . . B2 . . B1 . . A3B2 . . C1 . . B2B5 . . B2 B3 . A3B1 . . A3 . . A3C3 C4 . B1C5 . . A3A5C4 . . . . . . . . B1 B3 . A1C1 . . B5 B3 . C1 . . B5 B3 . B3 . . . . . A1A4 . . B1 B3 . A2A4B4 . . B4 . B4 . . . B5 . . . A4B1C1 . . . . B5 . . . . B3 . . A2A5B4 . . . . . . . . . . . . . . . C2 . . C3 . . C4 . . A3C5 . . B1C4 . B5 B3 . C2 . . C2 . A4 . . A1C3 . . A4B4 . . B3 . . A2B4 . . A5B3 . B4 B2 . C2 . . B5 A1 . . A5C2 . . B3C3 . . A5C4 . . A3C5 . . B1C4 . B5 B3 . C2 . . C2 . A4 . . A1C3 . . A4B4 . . B3 . . A2B4 . . B3 B2 . A5 . B3 . . B3 A1 . . A5C2 . . B3C3 . . A5C4 . . A3C5 . . B1C4 . B5 B3 . C2 . . C2 . A4 . . A1C3 . . A4B4 . . B3 . . A2B4 . . A5B3 . B4 B2 . C2 . . B5 A1 . . A5C2 . . B3C3 . . A5C4 . . A3C5 . . B1C4 . B5 B3 . C2 . . C2 . A4 . . A1 . . A4B5 . C2 . . C2 . A2 . . A5 . . B2B4C2 . . . . . C1 . B5 . . B4 . . . . B3 . . B3 ")