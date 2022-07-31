local System = Class {
    init = function(self, conditions)
        self.pool = {}
        self.conditions = conditions
        self.eventHandlers = {}
    end
}

function System:addAndPrune(entity)
    for ind, condition in pairs(self.conditions) do
        if table.getn(entity:getComponentsByType(condition)) == 0 and not entity:getComponentByName(condition) then
            self.pool[entity.id] = nil
            return
        end
    end
    self.pool[entity.id] = entity
end

function System:update(dt)
    for entityId, entity in pairs(self.pool) do
        prof.push("EntityId = "..entityId)
        self:handleUpdateEntityFunc(dt, entityId, entity)
        prof.pop()
    end
end

function System:handleUpdateEntityFunc(dt, entityId, entity)
    -- do nothing
end

function System:handleRemoveComponent(component)
    -- do nothing
end

function System:handleDrawEntityFunc(entityId, entity)
    -- do nothing
end

function System:draw()
    for entityId, entity in pairs(self.pool) do
        prof.push("EntityId = "..entityId)
        self:handleDrawEntityFunc(entityId, entity)
        prof.pop()
    end
end

return System