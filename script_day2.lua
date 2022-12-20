-- Change the path to the path of your workplace  (current path: Androids storage) 
local path = '/storage/emulated/0/Github/AdventofCode/2022/' 

local shapes = { 
    A = 1, X = 1, 
    B = 2, Y = 2, 
    C = 3, Z = 3 
} 

---@param inputs String the filename of the file 
function getTotalScores(inputs) 
    local f = io.open(path..inputs, 'r') 
    local inputs = f:lines() 
    local totalScores1 = 0
    local totalScores2 = 0

    local draw, win, loss = 3, 6, 0
    
    for line in inputs do 
        local _, _, P1, P2 = string.find(line, '(%a)%s(%a)') 
        if P1 ~= nil and P2 ~= nil then 
            if shapes[P1] == shapes[P2] then 
                totalScores1 = totalScores1 + draw
                
            elseif shapes[P1] == 1 and shapes[P2] == 2 then 
                totalScores1 = totalScores1 + win 
                
            elseif shapes[P1] == 2 and shapes[P2] == 3 then 
                totalScores1 = totalScores1 + win
                
            elseif shapes[P1] == 3 and shapes[P2] == 1 then 
                totalScores1 = totalScores1 + win 
                
            else 
                totalScores1 = totalScores1 + loss
 
            end 
        end 
        totalScores1 = totalScores1 + shapes[P2]
        
        --- PART 2
        if P2 == 'X' then
            totalScores2 = totalScores2 + loss
            
            if shapes [P1] == 1 then -- if rock
                totalScores2 = totalScores2 + 3
                
            elseif shapes [P1] == 2 then -- if paper
                totalScores2 = totalScores2 + 1
                
            elseif shapes [P1] == 3 then -- if scissors
                totalScores2 = totalScores2 + 2
                
            end
            
        elseif P2 == 'Y' then
            totalScores2 = totalScores2 + draw
            totalScores2 = totalScores2 + shapes[P1]
            
        elseif P2 == 'Z' then
            totalScores2 = totalScores2 + win
            
            if shapes [P1] == 1 then -- if rock
                totalScores2 = totalScores2 + 2
                
            elseif shapes [P1] == 2 then -- if paper
                totalScores2 = totalScores2 + 3
                
            elseif shapes [P1] == 3 then -- if scissors
                totalScores2 = totalScores2 + 1
                
            end
        end
        
        
    end 

    print(string.format('Part1: total scores: %s', totalScores1))
    
    print(string.format('Part2: total scores: %s', totalScores2)) 
end 

-- Find out 
getTotalScores('input_day2.txt')