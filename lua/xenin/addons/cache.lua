local CacheDataModel
do
  local _class_0
  local _base_0 = {
    __name = "CacheDataModel",
    createTables = function(self)
      sql.Begin()
      self:createVersionTable()
      self:createFileTable()
      sql.Commit()
    end,
    createVersionTable = function(self)
      sql.Query([[ 
      CREATE TABLE IF NOT EXISTS xenin_core_libs_version (
        addon_name VARCHAR(255),
        version VARCHAR(16),

        PRIMARY KEY (addon_name, version)
      );
    ]])
    end,
    createFileTable = function(self)
      sql.Query([[
      CREATE TABLE IF NOT EXISTS xenin_core_libs_version_file (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        addon_name VARCHAR(255) NOT NULL,
        version VARCHAR(16) NOT NULL,
        directory VARCHAR(511) NOT NULL,
        file_name VARCHAR(255) NOT NULL,
        file_contents TEXT NOT NULL,

        FOREIGN KEY (addon_name, version)
          REFERENCES xenin_core_libs_version(addon_name, version)
          ON DELETE CASCADE
      )
    ]])
    end,
    __type = function(self)
      return self.__name
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self)
      self:createTables()
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
  CacheDataModel = _class_0()
end
do
  local _class_0
  local _base_0 = {
    __name = "Xenin.Libs.Cache.Repository",
    getNewestVersion = function(self, name)
      local version = self.versionDAO:getNewestVersion(name)
      if (!version) then return end
      local files = self.fileDAO:getFiles(name, version)

      return Xenin.Libs.Library(version, files)
    end,
    getVersion = function(self, name, version)
      local files = self.fileDAO:getFiles(name, version)
      if (!files) then return end

      return Xenin.Libs.Library(version, files)
    end,
    __type = function(self)
      return self.__name
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self)
      self.versionDAO = Xenin.Libs.Cache.DAO.VersionDAO()
      self.fileDAO = Xenin.Libs.Cache.DAO.FileDAO()
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
  Xenin.Libs.Cache.Repository = _class_0
end
do
  local _class_0
  local _base_0 = {
    __name = "Xenin.Libs.Cache.Service",
    getNewestVersion = function(self, name)
      sql.Begin()
      local library = repository:getNewestVersion(name)
      sql.Commit()

      return library
    end,
    getVersion = function(self, name)
      sql.Begin()
      local library = repository:getNewestVersion(name)
      sql.Commit()

      return library
    end,
    setVersion = function(self, name) end,
    __type = function(self)
      return self.__name
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self)
      self.repository = Xenin.Libs.Cache.Repository
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
  Xenin.Libs.Cache.Service = _class_0()
end
do
  local _class_0
  local _base_0 = {
    __name = "Xenin.Libs.Cache.DAO|Xenin.Libs.Cache.DAO.FileDAO",
    getFiles = function(self, name, version)
      return sql.Query(string.format([[
          SELECT 
            directory,
            file_name AS fileName,
            file_contents AS fileContents
          FROM xenin_core_libs_version_file
          WHERE addon_name = '%s' AND version = '%s'
        ]], sql.SQLStr(name), sql.SQLStr(version)))
    end,
    insertFile = function(self, addonName, version, directory, fileName, fileContents)
      sql.Query(string.format([[
          INSERT INTO xenin_core_libs_version_file (addon_name, version, directory, file_name, file_contents)
          VALUES ('%s', '%s', '%s', '%s', '%s')
        ]], sql.SQLStr(addonName), sql.SQLStr(version), sql.SQLStr(directory), sql.SQLStr(fileName), sql.SQLStr(fileContents)))
    end,
    __type = function(self)
      return self.__name
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self) end,
    __base = _base_0
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  Xenin.Libs.Cache.DAO.Xenin.Libs.Cache.DAO.FileDAO = _class_0
end
do
  local _class_0
  local _base_0 = {
    __name = "Xenin.Libs.Cache.DAO|Xenin.Libs.Cache.DAO.VersionDAO",
    getNewestVersion = function(self, name)
      return sql.QueryRow(string.format([[
          SELECT 
            addon_name AS addonName,
            version AS version
          FROM xenin_core_libs_version
          WHERE addon_name = '%s'
          ORDER BY version DESC
          LIMIT 1
        ]], sql.SQLStr(name)))
    end,
    insertVersion = function(self, addonName, version)
      sql.Query(string.format([[
          INSERT INTO xenin_core_libs_version (addon_name, version)
          VALUES ('%s', '%s')
        ]], sql.SQLStr(addonName), sql.SQLStr(version)))
    end,
    __type = function(self)
      return self.__name
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self) end,
    __base = _base_0
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  Xenin.Libs.Cache.DAO.Xenin.Libs.Cache.DAO.VersionDAO = _class_0
end
