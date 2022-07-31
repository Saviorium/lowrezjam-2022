local System = require "game.ecs.systems.system"

local SoundSystem = Class {
    __includes = System,
    init = function(self, globalSystem)
        System.init(self, {'Sound'})
        self.globalSystem = globalSystem
    end
}

function SoundSystem:handleUpdateEntityFunc(dt, entityId, entity)
    entity:getComponentByName('Sound'):update(dt)
end

function SoundSystem:draw()
end

return SoundSystem