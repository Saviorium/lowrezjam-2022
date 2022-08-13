local animator = require "game.ecs.prefabs.dancer_animator"
local stateMachine = require "game.statemachines.character_states"

return function(globalSystem)
    local animatorInstance = animator:newInstance(AssetManager:getAnimation("sun"))
    animatorInstance:setVariable("state", "dancing")

    local ent =  globalSystem:newEntity()
        :addComponent('Position', {position = Vector(32, 256)})
        :addComponent('Velocity', {velocity = Vector(0,0)})
        :addComponent('Animator', {animator = animatorInstance})
        :addComponent('DrawAnimation', {center = Vector(22, 22)})
        :addComponent('SyncAnimationToBeat')
        :addComponent('Controlled')
        :addComponent('DrawOrder', {order = config.draw.layers.bgSun})
        :addComponent('MoveWithSun', {speed = config.sun.speed})

    globalSystem:newEntity() -- hehe, sneaky extra entity
        :addComponent('Position', {position = Vector(32, 256)})
        :addComponent('Velocity', {velocity = Vector(0,0)})
        :addComponent('Image', {image = AssetManager:getImage("sun-flare"), center = Vector(31, 30)})
        :addComponent('ColorBlendModifier', {blendMode = "add", blendAlphaMode = "alphamultiply"})
        :addComponent('DrawOrder', {order = config.draw.layers.bgSun})
        :addComponent('MoveWithSun', {speed = config.sun.speed})

    return ent
end