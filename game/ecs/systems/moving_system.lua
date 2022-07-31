local System = require "game.ecs.systems.system"

local MovingSystem = Class {
    __includes = System,
    init = function(self, globalSystem)
        System.init(self, {'Velocity', 'Position'})
    end
}

function MovingSystem:handleUpdateEntityFunc(dt, entityId, entity)
    local managers = entity:getComponentsByType("MovingManager")
    for _, manager in pairs(managers) do
        manager:update(dt, entity)
    end

    local pos = entity:getComponentByName("Position").position
    local velocity = entity:getComponentByName("Velocity").velocity
    if entity:getComponentByName("BouncingOffWalls") then
        if pos.x + velocity.x * dt > config.arena.size.x and velocity.x > 0 or pos.x + velocity.x * dt < 0 and velocity.x < 0 then
            velocity.x = -velocity.x
        end
    end
    pos.x = (pos + velocity * dt).x
    pos.y = pos.y + velocity.y * dt
    for ind, component in pairs(entity:getComponentsByType("Collider")) do
        component.collider:moveTo(pos.x + component.center.x, pos.y + component.center.y)
    end
    entity:getComponentByName("Position").position = pos
    entity:getComponentByName("Velocity").velocity = velocity
end

function MovingSystem:draw()
    -- do nothing
end

return MovingSystem