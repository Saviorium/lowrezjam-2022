local System = require "game.ecs.systems.system"

local TriggerSystem = Class {
    __includes = System,
    init = function(self, globalSystem)
        System.init(self, {'DeathTrigger'})
        self.globalSystem = globalSystem
    end
}

function TriggerSystem:handleUpdateEntityFunc(dt, entityId, entity)
    for _, trigger in pairs(entity:getComponentsByType('DeathTrigger')) do
        if trigger.update then
            local result = trigger:update(dt, entity)
            if result then
                entity:remove()
                if trigger.onDeathTrigger and not trigger.cause == "any" then
                    trigger:onDeathTrigger(entity)
                end
                break
            end
        end
    end
end

function TriggerSystem:handleRemoveComponent(component)
    if component.type == "DeathTrigger" and component.onDeathTrigger and component.cause == "any" then
        component:onDeathTrigger(component.entity)
    end
end

return TriggerSystem