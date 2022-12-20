-- Change the path to the path of your workplace  (current path: Androids storage) 
local path = '/storage/emulated/0/Github/AdventofCode/2022/inputs/' 

-- create a basic hash set size
function HashSize(table) 
    local new = {} 
    local hash = {} 
    for k, v in pairs(table) do 
        if (not hash[v]) then 
            new[#new+1] = v 
            hash[v] = true 
        end 
    end 

    return #new
end 

-- characters extractor 
---@param line String 
function Chars(line) 
    local chars = {} 
    for i = 1, #line do 
        table.insert(chars, line:sub(i, i)) 
    end 
    return chars 
end 

---Main function 
---@param inputs String filename 
function main(inputs, distinct_char) 
    local f = io.open(path..inputs, 'r') 
    local lines = f:lines() 
    for line in lines do 
        local characters = Chars(line) 
        local index = 0 
        local buffer = {} 
        for _, s in pairs(characters) do
            if (#buffer > (distinct_char - 1)) then 
                if (#buffer == HashSize(buffer)) then 
                    break 
                end 
                table.insert(buffer, s) 
                table.remove(buffer, 1) 
            else 
                table.insert(buffer, s) 
            end 
            index = index + 1
        end 
        print('first marker after character', index) 
    end 
    f:close() 
end 

print('Part 1')
main('input_day6.txt', 4)
print('Part 2')
main('input_day6.txt', 14)