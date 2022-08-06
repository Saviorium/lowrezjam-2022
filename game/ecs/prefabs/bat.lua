local animator = require "game.ecs.prefabs.dancer_animator"
local stateMachine = require "game.statemachines.character_states"

return function(globalSystem)
    local animatorInstance = animator:newInstance(AssetManager:getAnimation("bat-char"))
    animatorInstance:setVariable("state", "idle")

    local ent =  globalSystem:newEntity()
        :addComponent('Position', {position = Vector(10, 10)})
        :addComponent('Animator', {animator = animatorInstance})
        :addComponent('DrawAnimation', {center = Vector(4, 7)})
        :addComponent('Controlled')
        :addComponent('DummyControlled') -- to get normal inputs from ControlSystem
        :addComponent('Velocity', {velocity = Vector(0,0)})
        :addComponent('StateMachine', {states = stateMachine()})
        :addComponent('FlyInRandomDirection', {input="jump"})
        :addComponent('ActionToBeat')
        :addComponent('Flying')
        :addComponent('Friction')
        :addComponent('ParticleEmitter', {particles = {darkSpark = {spawn = 0}}})
        :addComponent('EmitParticles', {particleType = "darkSpark", emitAmount = 100, input="jump"})

    return ent
end