local System = require "game.ecs.systems.system"

local CameraSystem = Class {
    __includes = System,
    init = function(self, globalSystem)
        System.init(self, {'CameraTarget', 'Position'})
        self.mainCamera = nil
    end
}

function CameraSystem:handleUpdateEntityFunc(dt, entityId, entity)
    -- local target = entity:getComponentsByType("CameraTarget")[1]
    -- if target.isMain then
    --     self.mainCamera = entity
    -- end
    -- if target.inGoingToBeMain then
    --     target.isMain = true
    --     target.inGoingToBeMain = false
    --     if self.mainCamera then
    --         self.mainCamera:getComponentsByName("CameraTarget")[1].isMain = false
    --     end
    --     self.mainCamera = entity
    -- end
    -- target:update(dt)

end

function CameraSystem:handleDrawEntityFunc(entityId, entity)
    -- local target = entity:getComponentsByType("CameraTarget")[1]
    -- if not target.isMain then
    --     return
    -- end

    love.graphics.push()
    local x, y = love.mouse.getPosition()
    x = math.clamp(-128, x/4 - 64, 128)
    y = math.clamp(-128, y/6 - 64, -16)
    love.graphics.scale(1, 1)
    love.graphics.translate(math.floor(-x), math.floor(-y))
end

return CameraSystem