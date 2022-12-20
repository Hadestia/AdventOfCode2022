-- Change the path to the path of your workplace  (current path: Androids storage) 
local path = '/storage/emulated/0/Github/AdventofCode/2022/inputs/' 

---@param filename String the name of the file 
function countDominantPairs(filename) 
    local f = io.open(path..filename, 'r') 
    local inputs = f:lines() 
    local total, pairs_v1, pairs_v2 = 0, 0, 0
    
    for line in inputs do 
        local _, _, l1, h1, l2, h2 = string.find(line, '(%d+)-(%d+),(%d+)-(%d+)')

        l1 = tonumber(l1)
        l2 = tonumber(l2)
        h1 = tonumber(h1)
        h2 = tonumber(h2)

        if ((l1 <= l2 and h1 >= h2) or (l1 >= l2 and h1 <= h2)) then 
            pairs_v1 = pairs_v1 + 1
        end
        
        if (l1 > h2) then
            pairs_v2 = pairs_v2 + 1
        elseif (l2 > h1) then
            pairs_v2 = pairs_v2 + 1
        end 

        total = total + 1
    end 
    f:close()
    print('Part 1', string.format('Total pairs: %s', pairs_v1)) 
    print('Part 2', string.format('Total pairs: %s', (total - pairs_v2)))
end 

-- Find out 

countDominantPairs('test_input_day4.txt') 
countDominantPairs('input_day4.txt') 