local animator = require "game.ecs.prefabs.dancer_animator"
local stateMachine = require "game.statemachines.character_states"
local addDeathParticleEmitter = require "game.ecs.prefabs.death_particle_emitter"

return function(globalSystem, position)
    local width, height = 7,14
    local physicsCollider = globalSystem.HC:rectangle(0, 0, width, height)
    physicsCollider.type = 'Unit'

    local animatorInstance = animator:newInstance(AssetManager:getAnimation("vlad-char"))
    animatorInstance:setVariable("state", "idle")

    local ent =  globalSystem:newEntity()
        :addComponent('Position', {position = position})
        :addComponent('Velocity', {velocity = Vector(0,0)})

        :addComponent('Animator', {animator = animatorInstance})
        :addComponent('PhysicsCollider', {collider = physicsCollider})
        :addComponent('DrawAnimation', {center = Vector(5, 7)})
        :addComponent('BeatControlled', {beatMap = {
                                                    {listen = "beat1",send = "startMove"},
                                                   }
                                        })

        :addComponent('Controlled')
        :addComponent('UserControlled')
        :addComponent('ParticleEmitter', {particles = {blueSpark = {spawn = 0}}})
        :addComponent('EmitParticles', {particleType = "blueSpark", emitAmount = 100})

        :addComponent('Walking', {maxSpeed = config.speed.fast})
        :addComponent('Falling')
        :addComponent('Friction')
        :addComponent('Jumping', {maxSpeed = 10, jumpForce = 1000})

        :addComponent('StateMachine', {states = stateMachine()})
        :addComponent('NormCombo')
        :addComponent('NormComboSecond')
        :addComponent('GoToCenter')

        :addComponent('CameraToObjects')
        :addComponent('PrintDebugMessage')
        :addComponent('SyncAnimationToBeat')
        :addComponent('ScoreCounter')
        :addComponent('OnSunriseDieOutdoors')
    addDeathParticleEmitter(ent)

    return ent
end