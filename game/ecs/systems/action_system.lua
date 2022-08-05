local System = require "game.ecs.systems.system"

local ActionSystem = Class {
    __includes = System,
    init = function(self, globalSystem)
        System.init(self, {'Action', 'Controlled'})
        self.globalSystem = globalSystem
    end
}

function ActionSystem:handleUpdateEntityFunc(dt, entityId, entity)
    local controls = entity:getComponentByName("Controlled")
    local inputSnapshot = controls.inputSnapshot
    local actions = entity:getComponentsByType("Action")
    for _, action in pairs(actions) do
        if action.update then
            action:update(dt)
        end
        local input = inputSnapshot[action.input]
        if input and input == 1 then
            if action:canUse() and not action._activated or not action.oneShot then
                action:onActive()
                action._activated = true
            end
        else
            action._activated = false
        end
    end
end

function ActionSystem:draw()
end

return ActionSystem