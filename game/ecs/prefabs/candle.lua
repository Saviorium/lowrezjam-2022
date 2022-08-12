local animator = require "game.ecs.prefabs.dancer_animator"

return function(globalSystem, position)
    local animatorInstance = animator:newInstance(AssetManager:getAnimation("bg-candle"))
    animatorInstance:setVariable("state", "dancing")

    local ent =  globalSystem:newEntity()
        :addComponent('Position', {position = position})
        :addComponent('Animator', {animator = animatorInstance})
        :addComponent('DrawAnimation', {center = Vector(4, 8)})
        :addComponent('SyncAnimationToBeat')
        :addComponent('Controlled')

    return ent
end