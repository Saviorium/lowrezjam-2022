return function(globalSystem)
    local ent =  globalSystem:newEntity()
        :addComponent('Position', {position = Vector(1, 1)})
        :addComponent('DrawRectangle', {size = Vector(5, 5), color = {1,1,0}})
        :addComponent('BeatControlled', {beatTypeToListen = "beat1", inputToSend = "jump"})
        :addComponent('Controlled')
        :addComponent('Velocity', {velocity = Vector(0,0)})
        -- :addComponent('ParticleEmitter', {particles = {darkSpark = {spawn = 0}}})
        :addComponent('PrintDebugMessage')

    return ent
end