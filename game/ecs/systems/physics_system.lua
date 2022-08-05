local System = require "game.ecs.systems.system"

local PhysicsSystem = Class {
    __includes = System,
    init = function(self, globalSystem)
        System.init(self, {'PhysicsCollider', 'Position', 'Velocity'})
        self.globalSystem = globalSystem
    end
}

function PhysicsSystem:handleUpdateEntityFunc(dt, entityId, entity)

    --self:handleEventSystemIncomes()

    for entityId, entity in pairs(self.pool) do
        local collider = entity:getComponentByName("PhysicsCollider").collider
        local pos      = entity:getComponentByName("Position").position
        local vel      = entity:getComponentByName("Velocity").velocity

        for shape, delta in pairs(self.globalSystem.HC:collisions(collider)) do
            if shape.type == 'Environment' then
                pos.x = pos.x + delta.x
                pos.y = pos.y + delta.y
                vel = vel + Vector(delta.x, delta.y)*10
            end
        end
        entity:getComponentByName("Velocity").velocity = vel
    end

end

function PhysicsSystem:handleDrawEntityFunc(entityId, entity)
end

function PhysicsSystem:handleEventSystemIncomes()
    local events = EventManager:getEvents("PhysicsSystem")
    for _, event in pairs(events) do
        local entity = self.globalSystem.objects[event.entityId]
        for _, collider in pairs(entity:getComponentByType("Collider")) do
            self.globalSystem.HC:remove(collider.collider)
        end
    end
end

return PhysicsSystem