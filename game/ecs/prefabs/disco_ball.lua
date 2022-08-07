local animator = require "game.ecs.prefabs.dancer_animator"

return function(globalSystem)
    local animatorInstance = animator:newInstance(AssetManager:getAnimation("disco-ball"))
    animatorInstance:setVariable("state", "dancing")

    local ent =  globalSystem:newEntity()
        :addComponent('Position', {position = Vector(126, 74)})
        :addComponent('Animator', {animator = animatorInstance})
        :addComponent('DrawAnimation', {center = Vector(14, 14)})
        :addComponent('SyncAnimationToBeat')
        :addComponent('Controlled')

    return ent
end