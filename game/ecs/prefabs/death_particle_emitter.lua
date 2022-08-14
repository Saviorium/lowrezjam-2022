return function(entity)
    entity:addComponent('OnDeathDo', {onDeathTrigger = function(component, entity)
        local pos = entity:getComponentByName('Position').position
        entity.globalSystem:newEntity()
        :addComponent('Position', {position = pos})
        :addComponent('ParticleEmitter', {particles = {darkWave = {spawn = 100}}})
        :addComponent('DeathByTimer', {timer = 5})
    end})

    return entity
end