local animator = require "game.ecs.prefabs.dancer_animator"
local stateMachine = require "game.statemachines.character_states"
local addDeathParticleEmitter = require "game.ecs.prefabs.death_particle_emitter"

return function(globalSystem, position)
    local width, height = 12,5

    local physicsCollider = globalSystem.HC:rectangle(0, 0, width, height)
    physicsCollider.type = 'Unit'

    local animatorInstance = animator:newInstance(AssetManager:getAnimation("bat-char"))
    animatorInstance:setVariable("state", "idle")

    local ent =  globalSystem:newEntity()
        :addComponent('Position', {position = position})
        :addComponent('Velocity', {velocity = Vector(0,0)})
        :addComponent('Flying', {maxSpeed = config.speed.fast})
        :addComponent('Friction')

        :addComponent('Animator', {animator = animatorInstance})
        :addComponent('DrawAnimation', {center = Vector(4, 7)})
        :addComponent('SyncAnimationToBeat')
        :addComponent('PhysicsCollider', {collider = physicsCollider})

        :addComponent('Controlled')
        :addComponent('UserControlled')
        :addComponent('BeatControlled', {beatMap = {
                                                    {listen = "beat3",send = "startMove"},
                                                   }
                                        })
        :addComponent('ParticleEmitter', {particles = {redSpark = {spawn = 0}}})
        :addComponent('EmitParticles', {particleType = "redSpark", emitAmount = 100})

        :addComponent('StateMachine', {states = stateMachine()})
        -- :addComponent('FlyInRandomDirection', {input="startMove"})
        :addComponent('BatCombo', {entity = ent})
        :addComponent('BatComboSecond', {entity = ent})
        :addComponent('GoToCenter')

        :addComponent('ScoreCounter')
        :addComponent('OnSunriseDieOutdoors')
    addDeathParticleEmitter(ent)

    return ent
end