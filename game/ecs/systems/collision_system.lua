local System = require "game.ecs.systems.system"

local CollisionSystem = Class {
    __includes = System,
    init = function(self, globalSystem)
        System.init(self, {'PhysicsCollider', 'Position', 'Velocity'})
        self.globalSystem = globalSystem
    end
}

function CollisionSystem:update(dt)
    for entityId, entity in pairs(self.pool) do
        local colliderComp = entity:getComponentByName("PhysicsCollider")
        colliderComp.collisions = self.globalSystem.HC:collisions(colliderComp.collider)
    end
end

return CollisionSystem