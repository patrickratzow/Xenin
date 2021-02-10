do
  local _class_0
  local _base_0 = {
    __name = "Xenin.AddonBuilder",
    setName = function(self, name)
      self.name = name
      return self
    end,
    setLibs = function(self, libs)
      local __laux_type = (istable(libs) and libs.__type and libs:__type()) or type(libs)
      assert(__laux_type == "table", "Expected parameter `libs` to be type `table` instead of `" .. __laux_type .. "`")
      self.libs = libs

      return self
    end,
    build = function(self)
      return Xenin.Addon(self.addon, self.name, self.libs)
    end,
    __type = function(self)
      return self.__name
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, tbl)
      local __laux_type = (istable(tbl) and tbl.__type and tbl:__type()) or type(tbl)
      assert(__laux_type == "table", "Expected parameter `tbl` to be type `table` instead of `" .. __laux_type .. "`")
      self.addon = tbl
    end,
    __base = _base_0
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  Xenin.AddonBuilder = _class_0
end
do
  local _class_0
  local _base_0 = {
    __name = "Xenin.Addon",
    getAddon = function(self)
      return self.addon
    end,
    getName = function(self)
      return self.name
    end,
    getLibs = function(self)
      return self.libs
    end,
    __type = function(self)
      return self.__name
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, addon, name, libs)
      self.addon = addon
      self.name = name
      self.libs = libs
    end,
    __base = _base_0,
    build = function(addon)
      return Xenin.AddonBuilder(addon)
    end
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  Xenin.Addon = _class_0
end
do
  local _class_0
  local _parent_0 = Xenin.Container
  local _base_0 = {
    __name = "Xenin.Addons",
    __base = Xenin.Container.__base,
    __type = function(self)
      return self.__name
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__index)
  _class_0 = setmetatable({
    __init = function(self) end,
    __base = _base_0,
    __parent = _parent_0
  }, {
    __index = function(cls, parent)
      local val = rawget(_base_0, parent)
      if val == nil then local _parent = rawget(cls, "__parent")
        if _parent then return _parent[parent]
        end
      else
        return val
      end
    end,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  if _parent_0.__inherited then _parent_0.__inherited(_parent_0, _class_0)
  end
  Xenin.Addons = _class_0()
end
