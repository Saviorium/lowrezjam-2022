local System = require "game.ecs.systems.system"

local AnimationSystem = Class {
    __includes = System,
    init = function(self, globalSystem)
        System.init(self, {'Animator'})
    end
}

function AnimationSystem:handleUpdateEntityFunc(dt, entityId, entity)
    local animator = entity:getComponentByName('Animator')
    animator.variablesUpdater(animator, entity)
    if entity:getComponentByName('Flipped') then
        animator.animator:setVariable("flipH", entity:getComponentByName('Flipped').flipped)
    end
    animator.animator:update(dt)
end

return AnimationSystem