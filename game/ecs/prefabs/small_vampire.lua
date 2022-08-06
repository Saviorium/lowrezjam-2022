local animator = require "game.ecs.prefabs.dancer_animator"
local stateMachine = require "game.statemachines.character_states"

return function(globalSystem)
    local width, height = 7,14
    local physicsCollider = globalSystem.HC:rectangle(0, 0, width, height)
    physicsCollider.type = 'Unit'

    local animatorInstance = animator:newInstance(AssetManager:getAnimation("vlad-char"))
    animatorInstance:setVariable("state", "idle")

    local ent =  globalSystem:newEntity()
        :addComponent('Position', {position = Vector(1, 1)})
        :addComponent('Animator', {animator = animatorInstance})
        :addComponent('PhysicsCollider', {collider = physicsCollider})
        :addComponent('DrawAnimation', {center = Vector(5, 7)})
        :addComponent('BeatControlled', {beatTypeToListen = "beat1", inputToSend = "startMove"})
        :addComponent('Controlled')
        :addComponent('Velocity', {velocity = Vector(0,0)})
        :addComponent('ParticleEmitter', {particles = {darkSpark = {spawn = 0}}})
        :addComponent('PrintDebugMessage')
        :addComponent('EmitParticles', {particleType = "darkSpark", emitAmount = 100})
        :addComponent('Walking', {maxSpeed = 50})
        :addComponent('Falling')
        :addComponent('Friction')
        :addComponent('Jumping', {maxSpeed = 1000, jumpForce = 1000})
        :addComponent('StateMachine', {states = stateMachine()})
        :addComponent('MoveInRandomDirection')
        :addComponent('Velocity', {velocity = Vector(0,0)})

    return ent
end