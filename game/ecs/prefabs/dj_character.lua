local animator = require "game.ecs.prefabs.dancer_animator"

return function(globalSystem)
    local animatorInstance = animator:newInstance(AssetManager:getAnimation("dj-char"))
    animatorInstance:setVariable("state", "idle")

    local ent =  globalSystem:newEntity()
        :addComponent('Position', {position = Vector(123, 196-32)})
        :addComponent('Animator', {animator = animatorInstance})
        :addComponent('DrawAnimation', {center = Vector(11, 12)})
        :addComponent('SyncAnimationToBeat')
        :addComponent('Controlled')

    return ent
end