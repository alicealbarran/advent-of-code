--imports input file
function lines_from(file)
  local lines = {}
  for line in io.lines(file) do
    lines[#lines +1] = line
  end
  return lines
end


--misc splitter for w/e
function split(inputstr, sep)
        if sep == nil then
                sep = "%s"
        end
        local t={} ; i=1
        for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
                t[i] = str
                i = i + 1
        end
        return t
end

function parse(input)
  ret = {}
  for i = 1, #input do
    currentLineAsArray = split(input[i], ' ')
    yearMonthDay = currentLineAsArray[1]
    hourMin = currentLineAsArray[2]
    actionSwitch = currentLineAsArray[3]
    possibleID = currentLineAsArray[4]

    yearMonthDay = split(yearMonthDay, '[')
    yearMonthDay = split(yearMonthDay[1], '-')
    year, month, day = yearMonthDay[1], yearMonthDay[2], yearMonthDay[3]

    hourMin = split(hourMin, ']')
    hourMin = split(hourMin[1], ':')
    hour, min = hourMin[1], hourMin[2]

    if actionSwitch:sub(1,1) == 'G' then
      actiontype = 1
      id = possibleID:sub(2, #possibleID)
    elseif actionSwitch:sub(1,1) == 'f' then
      actiontype = 2
      id = nil
    else
      actiontype = 3
      id = nil
    end

    ret[i] = {year, month, day, hour, min, actiontype, id}
  end
  return ret
end

function mergesort(a, comparator)
  return _mergesort(a, comparator, 1, #a)
end

function _mergesort(a, comparator, start_idx, end_idx)
  if start_idx == end_idx then
    return {a[start_idx]} --it's sorted already!
  end
  local mid = start_idx + math.floor((end_idx - start_idx ) / 2)
  local first_half = _mergesort(a, comparator, start_idx, mid)
  local second_half = _mergesort(a, comparator, mid + 1, end_idx)
  return _merge(first_half, second_half, comparator)
end

function _merge(left, right, comparator)
  local ret = {}
  local left_len = #left
  local left_idx = 1
  local right_len = #right
  local right_idx = 1
  while left_idx <= left_len and right_idx <= right_len do
    if comparator(left[left_idx], right[right_idx]) then
      ret[#ret + 1] = left[left_idx]
      left_idx = left_idx + 1
    else
      ret[#ret + 1] = right[right_idx]
      right_idx = right_idx + 1
    end
  end
  while left_idx <= left_len do
    ret[#ret + 1] = left[left_idx]
    left_idx = left_idx + 1
  end
  while right_idx <= right_len do
    ret[#ret + 1] = right[right_idx]
    right_idx = right_idx + 1
  end
  return ret
end

comp = function(a, b)
  if a < b then
    return true
  end
  return false
end






input = lines_from('input4.txt')

input = mergesort(input,comp)

for i=1, #input do
  print(input[i])
end

actions = parse(input)

sleepingMins = {}
totalMins = {}

checkSleep = false

for i = 1, #actions do -- (1=year, 2=month, 3=day, 4=hour, 5=min, 6=type(1 for new guard, 2 for sleep, 3 for wake), 7=id if guard)
  if actions[i][6] == 1 then
    currentID = actions[i][7]
    print('new guard - '..currentID)
    if sleepingMins[currentID] == nil then
      sleepingMins[currentID] = {}
    end
  elseif actions[i][6] == 2 then
    asleepTime = actions[i][5]
    print("fell asleep")
  else
    awakeTime = actions[i][5]
    checkSleep = true
    print("woke up")
  end

  if checkSleep then
    if totalMins[currentID] == nil then totalMins[currentID] = 0 end
    sleepTable = sleepingMins[currentID]
    for f = asleepTime, awakeTime -1 do
      if sleepTable[f] == nil then sleepTable[f] = 0 end
      sleepTable[f] = sleepTable[f]+1
      totalMins[currentID] = totalMins[currentID] + 1
    end
    print("guard #"..currentID.." at sleepingmins = "..totalMins[currentID])
    checkSleep = false
  end
end

sleepiestID, sleepTime = 0, 0
for id,m in pairs(totalMins) do
  print("guard #"..id.." is asleep #"..m.." mins")
  if totalMins[id] > sleepTime then
    sleepiestID, sleepTime = id,m
  end
end

sleepiestMin, sleepiestMinsAsleep = 0, 0
tableForGuard = sleepingMins[sleepiestID]
for k,v in pairs(tableForGuard) do
  print(k .. " ------------------------------ " .. v)
  if tableForGuard[k] > sleepiestMinsAsleep then
    sleepiestMin, sleepiestMinsAsleep = k, v
  end
end

guardID, sleepMin, sleepMinTotal = 0,0,0
for id,t in pairs(sleepingMins) do
  for min,tmin in pairs(t) do
    if tmin > sleepMinTotal then
      guardID, sleepMinTotal, sleepMin = id,tmin,min 
      print("new guard is "..guardID.." and sleeps "..sleepMinTotal.." at min:"..sleepMin)
    end
  end
end














print(sleepiestID .. "ID is asleep most at min"..sleepiestMin.." and sleeps "..sleepiestMinsAsleep)
