-- Change the path to the path of your workplace  (current path: Androids storage) 
local path = '/storage/emulated/0/Github/AdventofCode/2022/inputs/' 

local supply = {}
local reset = { 
    s1 = 'QWPSZRHD', 
    s2 = 'VBRWQHF', 
    s3 = 'CVSH', 
    s4 = 'HFG', 
    s5 = 'PGJBZ', 
    s6 = 'QTJHWFL', 
    s7 = 'ZTWDLVJN', 
    s8 = 'DTZCJGHF', 
    s9 = 'WPVMBH' 
} 

---# A recursive function 
---@param amount Number the amount of move going to take 
---@param from Number the section number where to get the stack 
---@param to Number the section where to put the stack 
function move_v1(amount, from, to) 
   if amount == 0 then return end 
   amount = amount - 1 

   -- get the involved section keys 
   local f, t = 's'..from, 's'..to 
   local fLen = #supply[f] -- length of section A 
   local taken_supp = supply[f]:sub(fLen, fLen) 

   -- remove the taken stack from the origin section 
   supply[f] = supply[f]:sub(1, -2) 

   -- index the stack into the second section 
   supply[t] = (supply[t])..taken_supp 

   -- recuse 
   move_v1(amount, from, to) 
end 

function move_v2(amount, from, to) 
    -- get involved sections section's key 
    local f, t = 's'..from, 's'..to 
    local taken_crates = '' 

        --move_v1(amount, from, to) 
        for i = 1, amount do 
            local ind = ((#supply[f] - amount) + i) + 0 
            taken_crates = taken_crates..(supply[f]:sub(ind, ind)) 
        end 
        --print(amount, taken_crates) 
        -- remove moved crates 
        supply[f] = supply[f]:sub(1, -(1 + amount)) 

        -- index taken crates to second section 
        supply[t] = (supply[t])..(taken_crates) 
    return 
end 

-- Part 1 
---@param inputs String the name of the file 
function arrangeStackV1(inputs) 
    -- reset table first 
    for k, v in pairs(reset) do 
        supply [k] = v 
    end 
    local f = io.open(path..inputs, 'r') 
    local lines = f:lines() 
    for line in lines do 
        -- check if line was a move input 
        local f_char = line:sub(1, 1) 
        if f_char == 'm' then 
            local _, _, amount, from, to = string.find(line, 'move%s(%d+)%sfrom%s(%d+)%sto%s(%d+)') 
            move_v1(amount, from, to) 
        end 
    end 
    f:close() 
    print('Part1', 'New stacks are:') 
    print(1, supply.s1:sub(#supply.s1, #supply.s1)) 
    print(2, supply.s2:sub(#supply.s2, #supply.s2)) 
    print(3, supply.s3:sub(#supply.s3, #supply.s3)) 
    print(4, supply.s4:sub(#supply.s4, #supply.s4)) 
    print(5, supply.s5:sub(#supply.s5, #supply.s5)) 
    print(6, supply.s6:sub(#supply.s6, #supply.s6)) 
    print(7, supply.s7:sub(#supply.s7, #supply.s7)) 
    print(8, supply.s8:sub(#supply.s8, #supply.s8)) 
    print(9, supply.s9:sub(#supply.s9, #supply.s9)) 
end 

-- Part 2 
---@param inputs String the name of the file 
function arrangeStackV2(inputs) 
    -- reset table first 
    for k, v in pairs(reset) do 
        supply [k] = v 
    end 
    local f = io.open(path..inputs, 'r') 
    local lines = f:lines() 
    for line in lines do 
        -- check if line was a move input 
        local f_char = line:sub(1, 1) 
        if f_char == 'm' then 
            local _, _, amount, from, to = string.find(line, 'move%s(%d+)%sfrom%s(%d+)%sto%s(%d+)') 
            move_v2(tonumber(amount), from, to) 
        end 
    end 
    f:close() 
    print('Part2', 'New stacks are:') 
    print(1, supply.s1:sub(#supply.s1, #supply.s1)) 
    print(2, supply.s2:sub(#supply.s2, #supply.s2)) 
    print(3, supply.s3:sub(#supply.s3, #supply.s3)) 
    print(4, supply.s4:sub(#supply.s4, #supply.s4)) 
    print(5, supply.s5:sub(#supply.s5, #supply.s5)) 
    print(6, supply.s6:sub(#supply.s6, #supply.s6)) 
    print(7, supply.s7:sub(#supply.s7, #supply.s7)) 
    print(8, supply.s8:sub(#supply.s8, #supply.s8)) 
    print(9, supply.s9:sub(#supply.s9, #supply.s9)) 
end 

arrangeStackV1('input_day5.txt') 
arrangeStackV2('input_day5.txt') 