function lines_from(file)
  local lines = {}
  for line in io.lines(file) do
    lines[#lines +1] = line
  end
  return lines
end

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

function buildGrid(x,y)
  ret = {}
  for height = 1, x do
    ret[height] = {}
    for width = 1, y do
      ret[height][width] = ''
    end
  end
  return ret
end






function distance(height, width, xy)
  dim1 = math.abs(height - xy.x)
  dim2 = math.abs(width - xy.y)
  return dim1+dim2
end

function findClosest(height, width, points, optimal)
  key = 0
  keydistance = 1000000000000
  sum = 0
  for k, xy in pairs(points) do
      sum = sum + distance(height, width, xy)
--    print("testing cloest to "..height..","..width.." with point "..xy.x..","..xy.y.." ==== key "..k)
    if keydistance == distance(height, width, xy) then
      key = -1
--      print(key.." is tied with "..k)
    elseif keydistance > distance(height, width, xy) then
--      print("replacing "..key.." with distance ".. keydistance.." ---->  "..k.." with distance "..distance(height, width, xy))
      keydistance = distance(height,width,xy)

      key = k
    end
  end

  if sum < 10000 then
    optimal = optimal + 1
--    print(height.." and "..width.." are optimal with distance to all "..sum)
  end

  return key,optimal
end


function calcDistances(grid, points)
  optimal = 0
  for height = 1, #grid do
    for width = 1, #(grid[height]) do
      grid[height][width],optimal = findClosest(height, width, points, optimal)
--      print("found "..height..","..width.." is closest to "..grid[height][width])
    end
  end
  print(optimal)
  return grid
end


function findBorder(grid,largestx,largesty)
  ret = {}
  for h = 1, #grid do
    ret[grid[h][1]] = true
    ret[grid[h][largesty]] = true
  end
  for w = 1, #(grid[1]) do
    ret[grid[1][w]] = true
    ret[grid[largestx][w]] = true
  end


  ret[-1] = false
  return ret
end


function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end







function sumOfEach(grid)
  sum={}
  for h = 1, #grid do
    for w = 1, #(grid[h]) do
      if sum[grid[h][w]] == nil then
        sum[grid[h][w]] = 0
    --    print("found key "..grid[h][w])
      end
      sum[grid[h][w]] = sum[grid[h][w]] + 1
    end
  end



  return sum
end

function findMaxExcept(sums, borderpoints)
  max = 0
  k = 0

  for i, v in pairs(sums) do
    if v > max then
      if borderpoints[i] ~= true then
        max = v
        k = i
      end
    end
  end
  print(k.." shows up "..max.." times")



end







input = lines_from("input6.txt")
points = {}
largestx = 0
largesty = 0

--saving xy into points array indexed by 'i' ->num of them
--grid is moved up 1 because lua lol, largest doesn't need to be +1 because its already modified by looking up the points x/y
for i=1, #input do
  xypair = split(input[i], ',')
  points[i] = {['x'] = tonumber(xypair[1])+1, ['y'] = tonumber(xypair[2])+1}
  --print(points[i].x.." and "..points[i].y)
  if largestx < points[i].x then largestx = points[i].x end
  if largesty < points[i].y then largesty = points[i].y end
end

--print("largest x is "..largestx.." and largest y is "..largesty)
grid = buildGrid(largestx, largesty)


grid = calcDistances(grid, points)


borderpoints = findBorder(grid,largestx,largesty)
--print(dump(borderpoints))

sums = sumOfEach(grid)
--print(dump(sums))

findMaxExcept(sums, borderpoints)









print()
