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

function gettime(ch)
  return string.byte(ch)-string.byte('A')+61
end

function removeFromQueue(queue, letter)
  for i, v in pairs(queue) do
    if v.data == letter then
      table.remove(queue, i)
      print("removing "..letter.." from the queue")
      break
    end
  end
end


function assignJobs(elfs, queue)
  for i, v in pairs(elfs) do
    if v.node == nil then
      if queue[1] ~= nil then
        print(queue[1].data.." is first in queue")
        print("assigning job to elf #"..i.." - "..queue[1].data)
        v.node = queue[1]
        v.time = gettime(v.node.data)
        removeFromQueue(queue, v.node.data)
      end
    end
  end
end



input = lines_from('input7.txt')

require 'tree'


function findRoot(tree)
  curr = tree
  while #(curr.parents) > 0 do
    curr = curr.parents[1]
  end
  return curr
end

nodes = {}

for i=1, #input do
  currentLine = split(input[i], ' ')
  prereq = currentLine[2]
  postreq = currentLine[8]
  preNode = nodes[prereq]
  postNode = nodes[postreq]
  if preNode == nil then
    preNode = Tree(prereq)
    nodes[prereq] = preNode
  end
  if postNode == nil then
    postNode = Tree(postreq)
    nodes[postreq] = postNode
  end
  preNode:addChild(postNode)
  postNode:addParent(preNode)
end

roots = {}
for i, v in pairs(nodes) do
  if #(v.parents) == 0 then
    roots[#roots +1] = v
  end
end





comp = function(a, b)
  if a.data < b.data then
    return true
  end
  return false
end

queue = roots
print(#roots)
table.sort(queue, comp)
curr = ''
ans = ''

--probably have each elf grab the node off the queue(deleting it) and then hold onto it until its finished, then add its children and remove it as a parent from those children
timer = 0
elfs = {{node=nil, time=0}, {node=nil, time=0}, {node=nil, time=0}, {node=nil, time=0}}





assignJobs(elfs, queue)
--initial elf work/jobs

running = true
while running do

  timer = timer + 1

  for i, v in pairs(elfs) do
    if v.node ~= nil then
      if v.time == 1 then --job finished means add children and remove it as a parent
        v.time = v.time - 1
        ans = ans..v.node.data
        for i2, v2 in pairs(v.node.children) do
          v2:removeParent(v.node)
          if #v2.parents == 0 then
            print("finished "..v.node.data.." - adding to queue - "..v2.data)
            table.insert(queue, v2)
          end
        end
        v.node = nil
        v.time = 0
      else
        v.time = v.time -1
      end
    end

    table.sort(queue, comp)

    assignJobs(elfs, queue)


  end


  running = false
  for i, v in pairs(elfs) do
    if v.node ~= nil then running = true end
  end

  if #queue >0 then running = true end



  --table of 4 elves, each one holding what its working on and the time remaining
  --each loop each free elf looks to see if it can work on one
  --when an elf finishes, it removesparent/addchildren/etc
  --decrement time first, then add/remove/sort, then pick up new jobs






end

print(timer-1)

--[[
while true do
  table.sort(queue, comp)
  curr = queue[1]
  print(curr.data)
  ans = ans..curr.data
  for i, v in pairs(curr.children) do
    v:removeParent(curr)
    if #v.parents == 0 then
      table.insert(queue, v)
    end
  end
  table.remove(queue, 1)
  print("finished round")
  if #queue == 0 then
    break
  end
  -- do whatever you need with curr's data
  -- grab the children of curr
  -- remove curr from their parents
  -- if child has no parents, add to queue
  -- sort the queue
  -- remove first node from queue and assign to curr
  -- loop
end

print(ans)
]]--
