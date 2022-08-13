local animator = require "game.ecs.prefabs.dancer_animator"
local stateMachine = require "game.statemachines.character_states"

return function(globalSystem)
    -- local animatorInstance = animator:newInstance(AssetManager:getAnimation("disco-ball"))
    -- animatorInstance:setVariable("state", "dancing")

    local ent =  globalSystem:newEntity()
        :addComponent('Position', {position = Vector(32, 256)})
        :addComponent('Velocity', {velocity = Vector(0,0)})
        :addComponent('DrawRectangle', {size = Vector(16, 16)})
        :addComponent('Controlled')
        :addComponent('DrawOrder', {order = config.draw.layers.bgSun})
        :addComponent('MoveWithSun', {speed = config.sun.speed})

    return ent
end