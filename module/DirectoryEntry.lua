local Dir = {}
Dir.meta = { __index = Dir }
Dir.all = {}

---Create new Directory
---@param dirParent DirectoryEntry [optional, nil by default]
---@param name String name of the directory
---@return Directory[]
function Dir.new(dirParent, name)
    local directory = {}
    directory.files = {}
    directory.name = name
    
    -- index new dir if has a parent dir
    setmetatable(directory, Dir.meta)
    if dirParent then
        dirParent:addFile(directory)
        directory.parent = dirParent
    end
    return directory
end

---Adds a file in this directoru
---@param File Object[] a FileEntry
function Dir:addFile(File)
    self.files[File.name] = File
end

function Dir:delDir(name)
    self.files[name] = nil
end

---Get the file of this directory
---@param filterFunc Function() a filter function
---@return Table[]
function Dir:getFiles(filterFunc)
    if not filterFunc then return self.files end
    
    local filtered = {}
    for name, file in pairs(self.files) do
        if filterFunc(file) then
            filtered[name] = file
        end
    end
end

---Get the size of the directory, since directory has no size.
---This will count the total size of all file inside.
---@return Number
function Dir:getSize()
    local total = 0
    for _, file in pairs(self.files) do
        total = total + (file:getSize())
    end
    return total
end

function Dir:getParent()
    if not self.parent then
        return self
    end
    return self.parent
end

function Dir:getDir(name)
    local dir = self.files[name]
    if dir then
        if dir:type() == 'dir' then
            return dir
        else
            error(string.format('Name %s was not a directory', name))
        end
    end
    error(string.format('No such directory found named %s', name))
end


function Dir:type()
    return 'dir', self:getSize()
end

return Dir