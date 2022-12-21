local File = {}
File.meta = { __index = File }

---Create a new File
---@param name String name of the file
---@param size Number size of the file
function File.new(name, size)
    local file = {}
    file.name = name
    file.size = (type(size) == 'string') and tonumber(size) or size
    
    setmetatable(file, File.meta)
    return file
end

---Get the size of this file
---@return Number
function File:getSize()
    return self.size
end

function File:type()
    return 'file'
end

return File