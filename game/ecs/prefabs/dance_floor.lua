local animator = require "game.ecs.prefabs.dancer_animator"

return function(globalSystem)
    local animatorInstance = animator:newInstance(AssetManager:getAnimation("floor-lights"))
    animatorInstance:setVariable("state", "dancing")

    local ent =  globalSystem:newEntity()
        :addComponent('Position', {position = Vector(77, 223-32)})
        :addComponent('Animator', {animator = animatorInstance})
        :addComponent('DrawAnimation', {center = Vector(5, 7)})
        :addComponent('SyncAnimationToBeat')
        :addComponent('Controlled')
        :addComponent('DrawOrder', {order = config.draw.layers.characterBack})

    return ent
end