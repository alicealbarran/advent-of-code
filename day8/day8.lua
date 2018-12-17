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

function getMD(numbers)
  ret = 0
  local subnodes = numbers[1]
  local metadatas = numbers[2]
  table.remove(numbers, 1)
  table.remove(numbers, 1)

  print("has "..subnodes.." subnodes, running them")
  if subnodes ~= nil then
    for i=1, subnodes do
      print("recurring "..i)
      ret = ret + getMD(numbers)
    end
  end
  if metadatas ~=nil then
    for i=1, metadatas do
      print("getting metadatas")
      ret = ret + numbers[1]
      table.remove(numbers, 1)
    end
  end
  return ret
end

function getValue(numbers)
  local ret = 0
  local subnodes = numbers[1]
  local metadatas = numbers[2]
  table.remove(numbers, 1)
  table.remove(numbers, 1)
  local totals = {}

  subnodes = tonumber(subnodes)
  if subnodes == 0 then
    print("no subnodes")
    for i=1, metadatas do
      ret = ret + numbers[1]
      table.remove(numbers, 1)
    end
    return ret

  end



  if subnodes ~= 0 then
    print("this has "..subnodes.." subnodes, continue that many times")
    for i=1, subnodes do
      totals[i] = getValue(numbers)
    end

    print("finished building table, size is "..#totals)

    for i=1, metadatas do
      local index = numbers[1]
      table.remove(numbers, 1)
      index = tonumber(index)

      print("metadatas with a table, index is "..index)


      if totals[index] == nil then
        print("index isn't in totals")
        ret = ret+0
      else
        print("index exists, adding "..totals[index])
        ret = ret + totals[index]
      end
    end


  end

  return ret

end






input = lines_from('input8.txt')

numbers = split(input[1], ' ')

ans = 0
while #numbers > 0 do

  ans = ans + getValue(numbers)
  print(ans)





--  ans = ans + getMD(numbers)
--  print(ans)








end
