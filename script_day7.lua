local DirectoryEntry = require'module/DirectoryEntry' 
local FileEntry = require'module/FileEntry' 
local String = require'module/String' 

-- Change the path to the path of your workplace  (current path: Androids storage) 
local PATH = '/storage/emulated/0/Github/AdventofCode/2022/inputs/'


---@param inputs String filename 
function main(inputs) 
    local f = io.open(PATH..inputs, 'r') 
    -- instantiate root directory 
    local ROOT = DirectoryEntry.new(nil, '/') 
    local currentDir = ROOT
    local allDir = {}
    
    for line in f:lines() do 
        local lineArr = String.split(line) 
        local prefix = lineArr[1] 
        
        if ('$' == prefix) then -- Handle command 
            if ('cd' == lineArr[2]) then 
                local cmd = lineArr[3] 
                
                if ('/' == cmd) then 
                    currentDir = ROOT -- return to root folder 
                elseif ('..' == cmd) then 
                    currentDir = currentDir:getParent() -- return to parent folder
                else 
                    currentDir = currentDir:getDir(cmd) 
                end 
            end
        elseif ('dir' == prefix) then 
            -- create new directory if prefix is dir command 
            local newDir = DirectoryEntry.new(currentDir, lineArr[2]) 
            currentDir:addFile(newDir)
            table.insert(allDir, newDir)
        else 
            -- create file if prefix is alpha numeric 
            local file = FileEntry.new(lineArr[2], lineArr[1]) 
            currentDir:addFile(file)
        end 
    end 
    f:close()
    
    local space = 70000000 - (ROOT:getSize())
    local freeUp = 30000000 - space
    
    local candidates = {}
    
    local total = 0
    for name, file in pairs(allDir) do
    
        if file:getSize() > freeUp then
            table.insert(candidates, file)
        end
        
        local size = file:getSize()
        if size < 100000 then
           total = total + size
        end
    end
    table.sort(candidates, function (a, b) return a:getSize() < b:getSize() end)
    
    print(string.format('Part 1: total: %s', total))
    print(string.format('Part 2: total: %s', candidates[1]:getSize()))
end 

main('input_day7.txt') 