function math.clamp(min, value, max)
    if min > max then min, max = max, min end
    return math.max(min, math.min(max, value))
end

function math.lerp(a, b, t)
    if type(a) == "table" and type(b) == "table" and a.x and a.y and b.x and b.y then
        return Vector(
            math.lerp(a.x, b.x, t),
            math.lerp(a.y, b.y, t)
        )
    end
    return a + t * (b - a)
end

local serpent = require "lib.serpent.serpent"
vardump = function(...)
    local args = {...}
    print("================VARDUMP=====================")
    if #args == 1 then
        print(serpent.block(args))
    else
        for key, value in pairs(args) do
            if key then print(key..':') end
            print(serpent.block(value))
        end
    end
    print("============================================")
end

local Utils = {}

Utils.importRecursively = function (path, resultList)
    local lfs = love.filesystem
    local files = lfs.getDirectoryItems(path)
    resultList = resultList or {}
    for _, file in ipairs(files) do
        if file and file ~= ''  then -- packed .exe finds "" for some reason
            local path_to_file = path..'/'..file
            if love.filesystem.getInfo(path_to_file).type == 'file' then
                local requirePath = path_to_file:gsub('/', '.'):gsub('%.lua$', '')
                local newFile = require(requirePath)
                table.insert(resultList, newFile)
            elseif love.filesystem.getInfo(path_to_file).type == 'directory' then
                Utils.importRecursively(path_to_file, resultList)
            end
        end
    end
    return resultList
end

Utils.mergeAndClone = function (from, to) -- shallow copy of 'to' with replased values from 'from' table
    local result = {}
    if not from then from = {} end
    for k, v in pairs(to) do
        result[k] = v
    end
    for k, v in pairs(from) do
        result[k] = v
    end
    return result
end

function Utils.count(table, condition)
    local result = 0
    for k, v in pairs(table) do
        if condition(v) then
            result = result + 1
        end
    end
    return result
end

-- see Object.assign() in JS
-- example: Utils.assign({foo = 1, baz = 2}, {foo = 2, fooz = 3}, {foo = 5, ff = 11}) => {foo = 5, baz = 2, fooz = 3, ff = 11}
-- shallow copy, target can be {} to not modify it
Utils.assign = function (target, ...)
    local sources = {...}
    if not target then target = {} end
    for _, source in pairs(sources) do
        for k, v in pairs(source) do
            target[k] = v
        end
    end
    return target
end

Utils.colorFromHex = function (hex, value)  -- s-walrus/hex2color
    return {tonumber(string.sub(hex, 1, 2), 16)/256, tonumber(string.sub(hex, 3, 4), 16)/256, tonumber(string.sub(hex, 5, 6), 16)/256, value or 1}
end

return Utils