-- Change the path to the path of your workplace  (current path: Androids storage) 
local path = '/storage/emulated/0/Github/AdventofCode/2022/inputs/' 

---@param filename String the name of the file 
function countDominantPairs(filename) 
    local f = io.open(path..filename, 'r') 
    local inputs = f:lines() 
    local total_dominant_pair = 0 
    for line in inputs do 
        local _, _, l1, h1, l2, h2 = string.find(line, '(%d+)-(%d+),(%d+)-(%d+)') 
        if ((l1 <= l2 and h1 >= h2)) or ((l1 >= l2 and h1 <= h2)) then 
            total_dominant_pair = total_dominant_pair + 1 
           --print(l1,'-',h1,',',l2,'-',h2,'YES') 
        else 
            --print(l1,'-',h1,',',l2,'-',h2,'NO') 
        end 
    end 
    f:close() 
    print(string.format('Total pairs: %s', total_dominant_pair)) 
end 

-- Find out 

countDominantPairs('test_input_day4.txt') 
countDominantPairs('input_day4.txt')