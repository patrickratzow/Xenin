Xenin = Xenin || {}

local function LoadFile(fileDir)
  AddCSLuaFile(fileDir)
  return include(fileDir)
end

local function Load(dir)
  local files, folders = file.Find(tostring(dir) .. "/*.lua", "LUA")

  for i, v in ipairs(files) do
    LoadFile(tostring(dir) .. "/" .. tostring(v))
  end

  for i, v in ipairs(folders) do
    Load(tostring(dir) .. "/" .. tostring(v))
  end
end

Load("xenin")
