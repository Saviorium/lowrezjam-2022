local System = require "game.ecs.systems.system"
local ParticleManager = require "engine.particles.particle_manager"

local ParticleSystem = Class {
    __includes = System,
    init = function(self, globalSystem)
        System.init(self, {'ParticleEmitter', 'Position'})
        self.globalSystem = globalSystem
        self.particleManager = ParticleManager(require "data.particles")
        -- EventManager:subscribe("ParticleSystem", "entityDestroyed")
    end
}


function ParticleSystem:update(dt)
    for entityId, entity in pairs(self.pool) do
        prof.push("ParticleSystem entityId = "..entityId)
        local component = entity:getComponentByName('ParticleEmitter')
        for particleName, emitterData in pairs(component.particles) do
            if emitterData.initialized ~= true then
                self:addEmitter(entity, component, particleName)
            end
            self.particleManager:setIntensity(entityId, particleName, emitterData.intensity)
            if emitterData.spawn > 0 then
                self.particleManager:spawn(entityId, particleName, emitterData.spawn)
                emitterData.spawn = 0
            end
        end
        prof.pop()
    end
    self.particleManager:update(dt)
end

local getRotationDefaultFunc = function()
    return 0
end

function ParticleSystem:addEmitter(entity, particleEmitterComponent, particleName)
    local rotationComp = entity:getComponentByName('Rotation')
    local getRotationFunc
    if rotationComp then
        getRotationFunc = function()
            return rotationComp.rotation
        end
    else
        getRotationFunc = getRotationDefaultFunc
    end
    local posComp = entity:getComponentByName('Position')
    local getPositionFunc = function()
        return posComp.position
    end
    if particleEmitterComponent.particles[particleName] then
        local emitterData = particleEmitterComponent.particles[particleName]
        if not emitterData.spawn then
            emitterData.spawn = 0
        end
        if not emitterData.intensity then
            emitterData.intensity = 0
        end
    else
        particleEmitterComponent.particles[particleName] = { spawn = 0, intensity = 0 }
    end
    self.particleManager:addEmitter(entity.id, particleName, getPositionFunc, getRotationFunc)
    particleEmitterComponent.parentEntityId = entity.id -- remember for deletion
    particleEmitterComponent.particles[particleName].initialized = true
end

function ParticleSystem:handleRemoveComponent(component)
    if component.type == "ParticleEmitter" then
        self:removeEmitter(component.parentEntityId)
    end
end

function ParticleSystem:removeEmitter(entityId)
    self.particleManager:removeEmitter(entityId)
end

function ParticleSystem:draw()
    self.particleManager:draw("world")
end

return ParticleSystem