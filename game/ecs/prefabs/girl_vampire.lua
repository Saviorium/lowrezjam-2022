local animator = require "game.ecs.prefabs.dancer_animator"
local stateMachine = require "game.statemachines.character_states"

return function(globalSystem, position)
    local width, height = 7,14
    local physicsCollider = globalSystem.HC:rectangle(0, 0, width, height)
    physicsCollider.type = 'Unit'

    local animatorInstance = animator:newInstance(AssetManager:getAnimation("vamp-girl"))
    animatorInstance:setVariable("state", "idle")

    local ent =  globalSystem:newEntity()
        :addComponent('Position', {position = position})
        :addComponent('Velocity', {velocity = Vector(0,0)})

        :addComponent('Walking', {maxSpeed = config.speed.average})
        :addComponent('Falling')
        :addComponent('Friction', {airFriction = 3})
        :addComponent('Jumping', {maxSpeed = 200, jumpForce = 1000})
        :addComponent('Animator', {animator = animatorInstance})
        :addComponent('SyncAnimationToBeat')
        :addComponent('PhysicsCollider', {collider = physicsCollider})
        :addComponent('DrawAnimation', {center = Vector(10, 7)})
        
        :addComponent('BeatControlled', {beatMap = {
                                                    {listen = "beat2",send = "startMove"},
                                                   }
                                        })
        :addComponent('UserControlled')
        :addComponent('Controlled')

        :addComponent('ParticleEmitter', {particles = {darkSpark = {spawn = 0}}})
        :addComponent('EmitParticles', {particleType = "darkSpark", emitAmount = 100})

        :addComponent('StateMachine', {states = stateMachine()})
        --:addComponent('MoveInRandomDirection')
        :addComponent('GirlCombo')
        :addComponent('GoToCenter')

        :addComponent('PrintDebugMessage')

    return ent
end