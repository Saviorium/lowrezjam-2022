local animator = require "game.ecs.prefabs.dancer_animator"

return function(globalSystem)
    local animatorInstance = animator:newInstance(AssetManager:getAnimation("vlad-char"))
    animatorInstance:setVariable("state", "idle")

    local ent =  globalSystem:newEntity()
        :addComponent('Position', {position = Vector(1, 1)})
        :addComponent('Animator', {animator = animatorInstance})
        :addComponent('DrawAnimation', {center = Vector(4, 7)})
        :addComponent('BeatControlled', {beatTypeToListen = "beat1", inputToSend = "startMove"})
        :addComponent('Controlled')
        :addComponent('Velocity', {velocity = Vector(0,0)})
        :addComponent('ParticleEmitter', {particles = {darkSpark = {spawn = 0}}})
        :addComponent('PrintDebugMessage')
        :addComponent('EmitParticles', {particleType = "darkSpark", emitAmount = 100})

    return ent
end