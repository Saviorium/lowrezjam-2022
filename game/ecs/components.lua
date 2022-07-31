local Component = Class {
    init = function(self, params)
        self:addParams(self.defaultParams)
        if params then
            self:addParams(params)
        end
    end,
    name = "Component",
    type = nil,
    defaultParams = {},
    __tostring = function(self)
        return {
            name = self.name,
            type = self.type
        }
    end
}

function Component:addParams(params)
    for k, v in pairs(params) do
        self[k] = v
    end
    return self
end

local function loadComponent(componentOverrides) -- creates new Class with overrided name, defaultParams and etc.
    local newComponentType = Class {
        __includes = Component,
        init = function(self, params)
            Component.init(self, params)
        end
    }
    return newComponentType:addParams(componentOverrides)
end

local function importComponentsRecursively(path, resultList)
    local lfs = love.filesystem
    local files = lfs.getDirectoryItems(path)
    resultList = resultList or {}
    for _, file in ipairs(files) do
        if file and file ~= ''  then -- packed .exe finds "" for some reason
            local path_to_file = path..'/'..file
            if love.filesystem.getInfo(path_to_file).type == 'file' then
                local requirePath = path_to_file:gsub('/', '.'):gsub('%.lua$', '')
                local newComponent = loadComponent(require(requirePath))
                local componentName = newComponent.name
                assert(not resultList[componentName], "Component name conflict: " .. componentName .. " " .. requirePath)
                resultList[componentName] = newComponent
            elseif love.filesystem.getInfo(path_to_file).type == 'directory' then
                importComponentsRecursively(path_to_file, resultList)
            end
        end
    end
    return resultList
end

return importComponentsRecursively("game/ecs/components")