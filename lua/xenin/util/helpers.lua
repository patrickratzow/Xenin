function Xenin:Filter(input, func)
  local tbl = {}

  for i, v in pairs(input) do
    local output = func(v, i)
    if output then
      tbl[#tbl + 1] = v
    end
  end

  return tbl
end
function Xenin:Map(input, func)
  local tbl = {}

  for i, v in pairs(input) do
    tbl[#tbl + 1] = func(v, i)
  end

  return tbl
end
function Xenin:Some(input, func)
  for i, v in pairs(tbl) do
    local output = func(v, i)
    if output then
      return true
    end
  end

  return false
end
