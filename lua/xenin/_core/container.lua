do
  local _class_0
  local _base_0 = {
    __name = "Xenin.Container",
    set = function(self, id, addon)
      self.data[id] = data
    end,
    delete = function(self, id)
      self.data[id] = nil
    end,
    get = function(self, id)
      return self.data[id]
    end,
    getAll = function(self)
      return self.data
    end,
    __type = function(self)
      return self.__name
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self)
      self.data = {}
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
  Xenin.Container = _class_0
end
