require 'class'

Tree = class(function(self, data)
  self.children = {}
  self.parents = {}
  self.data = data
end)

Tree.addChild = function(self, childTree)
  self.children[#self.children+1] = childTree
end

Tree.addParent = function(self, parentNode)
  self.parents[#self.parents+1] = parentNode
end

Tree.removeParent = function(self, parentNode)
  for i, v in pairs(self.parents) do
    if v == parentNode then
      table.remove(self.parents, i)
    end
  end
end
