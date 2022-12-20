-- Change the path to the path of your workplace  (current path: Androids storage)
local path = '/storage/emulated/0/Github/AdventofCode/2022/inputs/' 

---@param inputs String the filename of the file 
function getHighestCal(inputs) 
    local f = io.open(path..inputs, 'r') 
    local inputs = f:lines() 
    local data = {}      -- a table to index elf data
    local prefix = 'no'  -- elf prefix id
    local currentID = 1  -- current active id
    
    
    for line in inputs do 
        -- create a data for new elf if it's key don't exist
        local id = string.format('%s%s', prefix, currentID) 
        data[id] = data[id] or {id = currentID, cal = 0} 
    
        -- check if the current line was a number
        local number = tonumber(line)
        if number then
            -- sum up the calories if true
            data[id].cal = data[id].cal + number
        else
            -- increase id to create new data if not
            currentID = currentID + 1
        end
    end 
    
    -- Sort the data into a new table
    local sorted = {} 
    for k, v in pairs(data) do 
        table.insert(sorted, v) 
    end
    table.sort(sorted, function (a, b) return a.cal > b.cal end) 
    
    --print whose elf got the highest calories [Puzzle 1]
    print(string.format('Puzzle1: elf NO-%s carried %s of calories', sorted[1].id, sorted[1].cal))
    -- Puzzle 2
    print(
        string.format(
            'Puzzle2: total calories of top 3 elves was %s',
            sorted[1].cal + sorted[2].cal + sorted[3].cal
        )
    )
end 

-- Use the function inputs:[test_input_day1.txt || input_day1.txt]
getHighestCal ('input_day1.txt')