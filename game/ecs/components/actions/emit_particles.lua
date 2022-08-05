return {
    name = "EmitParticles",
    type = "Action",
    oneShot = true, -- run on the first frame of input or every frame
    input = 'startMove',
    entity = nil,
    staminaNeeded = 0,

    particleType = "spark",
    emitAmount = 100,

    canUse = function(self)
        return true
    end,

    onActive = function(self)
        local particles = self.entity:getComponentByName("ParticleEmitter").particles
        particles[self.particleType].spawn = self.emitAmount
    end
}