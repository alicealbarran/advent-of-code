function lines_from(file)
  local lines = {}
  for line in io.lines(file) do
    lines[#lines +1] = line
  end
  return lines
end

function trim(input)
  changes = 0
  for i=2, #input do
    if input:sub(i, i):upper() == input:sub(i-1,i-1) or input:sub(i,i):upper() == input:sub(i-1,i-1) or input:sub(i,i):lower() == input:sub(i-1,i-1) or input:sub(i,i):lower() == input:sub(i-1,i-1)then
      if input:sub(i,i) ~= input:sub(i-1,i-1) then
        ret = input:sub(1, i-2) .. input:sub(i+1, #input)
        print('removing '..input:sub(i-1, i))
        return ret
      end
    end
  end
  running = false
  return input
end

function removeLetter(input,letter)
  ret = ""
  for i =1, #input do
    if input:sub(i,i):lower() ~= letter then
      ret = ret..input:sub(i,i)
    end
  end
  return ret
end














input = lines_from("input5.txt")

input = input[1]

running = true
while running do
  input = trim(input)
  print(#input)
end





trimmed = input
letterAns = ''
lengthAns = #input

alphabet = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q','r','s','t','u','v','w','x','y','z'}
for i=1, #alphabet do
  print("removing "..alphabet[i])
  letterRemoved = trimmed
  letterRemoved = removeLetter(letterRemoved,alphabet[i])

  print("trimming again")
  running = true
  while running do
    letterRemoved = trim(letterRemoved)
  end
  print(alphabet[i].." removed leaves length "..#letterRemoved)

  if lengthAns > #letterRemoved then
    letterAns=alphabet[i]
    lengthAns = #letterRemoved
  end
end



print("smallest is removing "..letterAns.." leaving length of "..lengthAns)
