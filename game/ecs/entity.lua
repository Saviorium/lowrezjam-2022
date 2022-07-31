local Entity = Class {
    init = function(self, id, globalSystem)
        self.id = id
        self.globalSystem = globalSystem

        self.components = {}
        self.componentTypes = {}
    end
}

function Entity:addComponent(componentName, args)
    self.globalSystem:registerComponent(self, componentName, args)
    return self
end

function Entity:__doAddComponent(component)
    self.components[component.name] = component
    local type = component.type
    if type then
        if not self.componentTypes[type] then
            self.componentTypes[type] = {}
        end
        table.insert(self.componentTypes[type], component)
    end
    component.entity = self
end

function Entity:getComponentByName(componentName)
    return self.components[componentName]
end

function Entity:getComponentsByType(componentType)
    return self.componentTypes[componentType] or {}
end

function Entity:setVariable(componentName, variable, value) -- safely
    local comp = self:getComponentByName(componentName)
    if comp then
        comp[variable] = value
        return true
    end
    return false
end

function Entity:removeComponent(name)
    local component = self.components[name]
    self.globalSystem:markComponentToRemove(component)
end

function Entity:__doRemoveComponent(name)
    local component = self.components[name]
    if not component then return end
    self.components[name] = nil
    if component.type then
        for ind, comp in pairs(self.componentTypes[component.type]) do
            if name == comp.name then
                self.componentTypes[component.type][ind] = nil
            end
        end
    end
end

function Entity:remove()
    if not self.globalSystem then
        print("Entity "..self.id.." was removed twice")
        return
    end
    self.globalSystem:markEntityToRemove(self)
end

function Entity:listComponents()
    local description = "Entity #" .. self.id .. " components: {"
    for _, component in pairs(self.components) do
        description = description .. component.name .. ", "
    end
    return description .. "}"
end

function Entity:__tostring()
    return {
        id = self.id,
        components = self.components
    }
end

return Entity