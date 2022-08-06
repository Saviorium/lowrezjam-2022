local animator = require "game.ecs.prefabs.dancer_animator"

return function(globalSystem)
    local animatorInstance = animator:newInstance(AssetManager:getAnimation("test-pulsing-cube"))
    animatorInstance:setVariable("state", "idle")

    local ent =  globalSystem:newEntity()
        :addComponent('Position', {position = Vector(-10, -20)})
        :addComponent('Animator', {animator = animatorInstance})
        :addComponent('DrawAnimation', {center = Vector(4, 7)})
        :addComponent('SyncAnimationToBeat')
        :addComponent('Controlled')
        :addComponent('Velocity', {velocity = Vector(0,0)})
        :addComponent('DoOnBeat')

    return ent
end