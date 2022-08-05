local System = require "game.ecs.systems.system"

local EventSystem = Class {
    __includes = System,
    init = function(self, globalSystem)
        System.init(self, {'Event'})
        self.globalSystem = globalSystem
    end
}

function EventSystem:handleUpdateEntityFunc(dt, entityId, entity)
    for id, event in pairs(entity:getComponentsByType("Event")) do
		event.timer = event.timer - dt
	end
end

function EventSystem:handleDrawEntityFunc(entityId, entity)
end

return EventSystem