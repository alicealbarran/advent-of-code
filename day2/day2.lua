function lines_from(file)
  local lines = {}
  for line in io.lines(file) do
    lines[#lines +1] = line
  end
  return lines
end


input = lines_from('input2.txt')
for a = 1, #input -1 do
  for b = a + 1, #input do
    s1 = input[a]
    s2 = input[b]
    differences = 0
    for ch = 1, #s1 do
      if s1:sub(ch, ch) ~= s2:sub(ch, ch) then differences = differences + 1 end
      if differences >=2 then ch = #s1 end
    end
    if differences < 2 then ansA, ansB = s1, s2 end
  end
end

ans = ''
for ch = 1, #ansA do
  if ansA:sub(ch, ch) == ansB:sub(ch, ch) then ans = ans .. ansA:sub(ch, ch) end
end

print(ans)
print(#ansA)
print(#ans)







--[[part 1
input = lines_from('input2.txt')
ansA = 0
ansB = 0
for i = 1, #input do
  currentline = input[i]
  double, triple = false, false
  a, b = {} , {}
  for c = 1, #currentline do
    ch = currentline:sub(c,c)
    if(a[ch]) then
      double = true
      if(b[ch]) then
        triple = true
      else
        b[ch]=true
      end
    else
      a[ch]=true
    end
  end
  if double then ansA = ansA + 1 end
  if triple then ansB = ansB + 1 end
end
print(ansA*ansB)
]]--
