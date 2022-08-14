local animator = require "game.ecs.prefabs.dancer_animator"
local stateMachine = require "game.statemachines.character_states"
local addDeathParticleEmitter = require "game.ecs.prefabs.death_particle_emitter"

return function(globalSystem, position)
    local width, height = 7,7
    local physicsCollider = globalSystem.HC:rectangle(0, 0, width, height)
    physicsCollider.type = 'Unit'

    local animatorInstance = animator:newInstance(AssetManager:getAnimation("small-vamp-char"))
    animatorInstance:setVariable("state", "idle")

    local ent =  globalSystem:newEntity()
        :addComponent('Position', {position = position})
        :addComponent('Velocity', {velocity = Vector(0,0)})

        :addComponent('Walking', {maxSpeed = config.speed.fast})
        :addComponent('Falling')
        :addComponent('Friction')
        :addComponent('Jumping', {maxSpeed = 15, jumpForce = 1000})

        -- :addComponent('DrawRectangle', {size = Vector(width, height)})
        :addComponent('Animator', {animator = animatorInstance})
        :addComponent('SyncAnimationToBeat')
        :addComponent('PhysicsCollider', {collider = physicsCollider})
        :addComponent('DrawAnimation', {center = Vector(5, 5)})

        :addComponent('BeatControlled', {beatMap = {
                                                    {listen = "beat2",send = "startMove"},
                                                   }
                                        })
        :addComponent('UserControlled')
        :addComponent('Controlled')

        :addComponent('ParticleEmitter', {particles = {greenSpark = {spawn = 0}}})
        :addComponent('EmitParticles', {particleType = "greenSpark", emitAmount = 100})

        :addComponent('StateMachine', {states = stateMachine()})
        :addComponent('SmallCombo')
        :addComponent('SmallComboSecond')
        :addComponent('SmallComboThird')
        :addComponent('GoToCenter')
        :addComponent('ScoreCounter')

        :addComponent('PrintDebugMessage')
        :addComponent('OnSunriseDieOutdoors')
    addDeathParticleEmitter(ent)

    return ent
end