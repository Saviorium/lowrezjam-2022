local System = require "game.ecs.systems.system"

local RotateSystem = Class {
    __includes = System,
    init = function(self, globalSystem)
        System.init(self, {'Rotation'})
    end
}


function RotateSystem:handleUpdateEntityFunc(dt, entityId, entity)
    for _, comp in pairs(entity:getComponentsByType('Rotation')) do
        if comp.update then
            comp:update(dt, entity)
        end
    end
end

function RotateSystem:draw()
    -- do nothing
end

return RotateSystem