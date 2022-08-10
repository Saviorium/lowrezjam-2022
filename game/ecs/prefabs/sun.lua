local animator = require "game.ecs.prefabs.dancer_animator"
local stateMachine = require "game.statemachines.character_states"

return function(globalSystem)
    -- local animatorInstance = animator:newInstance(AssetManager:getAnimation("disco-ball"))
    -- animatorInstance:setVariable("state", "dancing")

    local ent =  globalSystem:newEntity()
        :addComponent('Position', {position = Vector(32, 256)})
        :addComponent('DrawRectangle', {size = Vector(16, 16)})
        -- :addComponent('DrawAnimation', {center = Vector(14, 14)})
        :addComponent('Controlled')
        :addComponent('StateMachine', {states = stateMachine()})
        :addComponent('DrawOrder', {order = config.draw.layers.bg})

        local stateMachine = ent:getComponentByName("StateMachine")
        stateMachine:goToState("sun_idle")

    return ent
end