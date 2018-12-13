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


--makes the array of size h x w  with 0 instances of use for each square
function start_array(h, w)
  ret = {}
  for height = 1, h do
  ret[height] = {}
    for width = 1, w do
      ret[height][width] = 0
    end
  end
  return ret
end


--increments all uses of the locations
function populate_array(arr, loch, locw, lenh, lenw)
  size = 0
  for height = loch, loch+lenh-1 do
    for width = locw, locw+lenw-1 do
      print("incrementing num " .. arr[height+1][width+1] .. " at " .. height .. ", " .. width)
      size = size + 1
      arr[height+1][width+1] = arr[height+1][width+1] + 1
    end
  end
  print(size)
  return arr
end


--looks for (amount) of overlap
function check_overlap(arr, amount)
  overlaps = 0
  for height = 1, #arr do
    for width = 1, #arr do
      if(arr[height][width] >= amount) then
        overlaps = overlaps + 1
      end
    end
  end
  return overlaps
end


--check section for no overlap(entire section is 1s)
function check_for_unique_section(arr, loch, locw, lenh, lenw)
  isUnique = true
  for height = loch, loch+lenh-1 do
    for width = locw, locw+lenw-1 do
      if arr[height+1][width+1] ~=  1 then
        isUnique = false
      end
    end
  end
  return isUnique
end


--actual stuff now
--
--
--gets input
input = lines_from('input3.txt')

--makes the grid
grid = start_array(1000,1000)

--parses input
for i=1, #input do
  currentLineAsArray = split(input[i], " ")
  currentLocation = split(currentLineAsArray[3], ",")
  currentLocation[2] = currentLocation[2]:sub(0,#currentLocation[2]-1)
  currentSize = split(currentLineAsArray[4], "x")

  grid = populate_array(grid, currentLocation[1], currentLocation[2], currentSize[1], currentSize[2])
  print(" - at " .. currentLocation[1] .. "," .. currentLocation[2] .. " with " .. currentSize[1] .. "x" .. currentSize[2])
end

print(check_overlap(grid, 2))

for i=1, #input do
  currentLineAsArray = split(input[i], " ")
  currentLocation = split(currentLineAsArray[3], ",")
  currentLocation[2] = currentLocation[2]:sub(0,#currentLocation[2]-1)
  currentSize = split(currentLineAsArray[4], "x")

  if check_for_unique_section(grid, currentLocation[1], currentLocation[2], currentSize[1], currentSize[2]) then
    print(i .. " is the unique id")
  end
end
