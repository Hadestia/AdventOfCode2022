-- Change the path to the path of your workplace  (current path: Androids storage) 
local path = '/storage/emulated/0/Github/AdventofCode/2022/inputs/' 

local letters = { 
    'a', 'b', 'c', 
    'd', 'e', 'f', 
    'g', 'h', 'i', 
    'j', 'k', 'l', 
    'm', 'n', 'o', 
    'p', 'q', 'r', 
    's', 't', 'u', 
    'v', 'w', 'x', 
    'y', 'z' 
} 
local LetterValue = {} 

-- make a corresponding value for lowercase & upper case 
for i = 1, #letters do -- lowercase (1 to 26) 
    LetterValue[letters[i]] = i 
end 

for i = 1, #letters do -- uppercase (27 to 26*2) 
    local upper = string.upper(letters[i]) 
    LetterValue[upper] = 26 + i 
end 

function getSimilarTerm(A, B, C)
    local simA, simB, simC = {}, {}, {}
    for i = 1, #A do
        local char = A:sub(i, i)
        simA[char] = true
    end
    
    for i = 1, #B do
        local char = B:sub(i, i)
        simB[char] = true
    end
    
    if C then
        for i = 1, #C do
            local char = C:sub(i, i)
            simC[char] = true
        end
    end
    
    for k1 in pairs(simA) do
        for k2 in pairs(simB) do
            if C then
                for k3 in pairs(simC) do
                    if k1 == k2 and k1 == k3 and k2 == k3 then
                        return k1
                    end
                end
            else
                if k1 == k2 then
                    return k1
                end
            end
        end
    end
end

---@param inputs String the name of the file 
function getRepeatedCharacter(inputs) 
    -- open the file & read 
    local f = io.open(path..inputs, 'r') 
    local inputs = f:lines() 
    local total1, total2 = 0, 0
    local sets = {}
    local space, index = 0, 1
    
    for line in inputs do
        local itemA, itemB = '', ''
        local rLetters = {}
        
        if space < 3 then
            sets[index] = sets[index] == nil and {} or sets[index]
            table.insert(sets[index], line)
            space = space + 1
        else
            index = index + 1
            space = 1
            sets[index] = sets[index] == nil and {} or sets[index]
            table.insert(sets[index], line)
        end
        
        
        for i = 1, #line do
            local char = line:sub(i, i)
            
            if i > #line/2 then
                itemB = itemB..char
            else
                itemA = itemA..char
            end
        end
        
        total1 = total1 + LetterValue[getSimilarTerm(itemA, itemB)]
    end
    
    -- PART 2
    for _, value in pairs(sets) do
        total2 = total2 + LetterValue[getSimilarTerm(value[1], value[2], value[3])]
    end
    
    
    -- get total 
    print(string.format('Part1 Sum: %s', total1))
    print(string.format('Part2 Sum: %s', total2))
end

-- Find Out 
getRepeatedCharacter('input_day3.txt') 
    