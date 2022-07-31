local serpent = require "lib.serpent.serpent"

local Storage = Class {
    init = function(self, file, default)
        self.file = file or "storage.lua"
        self.values = {}
        for k, v in pairs(default) do -- shallow copy of default - use flat tables plz
            self.values[k] = v
        end
    end
}

function Storage:get(key)
    if not self.values[key] then
        print("Unknown setting " .. key)
        return
    end
    return self.values[key]
end

function Storage:set(key, value)
    self.values[key] = value
end

function Storage:setAndSave(key, value)
    self:set(key, value)
    self:save()
end

function Storage:load()
    if love.filesystem.getInfo(self.file) then
        local storageString, err = love.filesystem.read(self.file)
        if not storageString then
            error("Failed to read storage file: " .. err)
        end
        local ok, storageFile = serpent.load(storageString)
        if ok then
            for k, v in pairs(self.values) do
                if storageFile[k] then
                    self.values[k] = storageFile[k]
                end
            end
        else
            self:save()
        end
    else
        self:save()
    end
end

function Storage:save()
    local storageString = serpent.block(self.values, {comment = false})
    if Debug and Debug.storage == 1 then
        vardump("saving to storage:", storageString)
    end
	love.filesystem.write(self.file, storageString)
end

return Storage
