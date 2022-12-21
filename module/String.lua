local String = {}
String.meta = { __index = SA }

function String.char(line)
    local chars = {}
    for i = 1, #line do
        local char = line:sub(i, i)
        chars[#chars + 1] = char
    end
    return chars
end

function String.split(inputString, sep)
    sep = sep == nil and '%s' or sep
    local t = {}
    for str in string.gmatch(inputString, "([^"..sep.."]+)") do
        table.insert(t, str)
    end
    return t
end

return String