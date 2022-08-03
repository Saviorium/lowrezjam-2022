local System = require "game.ecs.systems.system"

local PhysicsSystem = Class {
    __includes = System,
    init = function(self, globalSystem)
        System.init(self, {'PhysicsCollider', 'Position', 'Velocity'})
        self.globalSystem = globalSystem
    end
}

function PhysicsSystem:handleUpdateEntityFunc(dt, entityId, entity)
    local collider = entity:getComponentByName("PhysicsCollider")
    local pos      = entity:getComponentByName("Position").position
    local vel      = entity:getComponentByName("Velocity").velocity

    for ind, obj in pairs(collider.collisionsTable) do
        pos.x = pos.x + obj.deltaVector.x
        pos.y = pos.y + obj.deltaVector.y
        vel = vel + Vector(obj.deltaVector.x, obj.deltaVector.y)*10
    end
    entity:getComponentByName("Velocity").velocity = vel
end

function PhysicsSystem:handleDrawEntityFunc(entityId, entity)
end

return PhysicsSystem