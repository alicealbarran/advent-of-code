function class(init, base)
  local c,mt = {},{}
  c.__index = c
  c._init = init
  mt.__call = function(class_tbl, ...)
    local obj = {}
    setmetatable(obj,c)
    init(obj,...)
    return obj
  end
  if base ~= nil then
    mt.__index = base
    c.super = base._init
  end
  setmetatable(c, mt)
  return c
end
