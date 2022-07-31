local System = require "game.ecs.systems.system"

local ControlSystem = Class {
    __includes = System,
    init = function(self, globalSystem)
        System.init(self, {'Controlled', 'InputSource'})
    end
}

function ControlSystem:handleUpdateEntityFunc(dt, entityId, entity)
    local controller = entity:getComponentByName("Controlled")
    controller:reset()

    local inputSources = entity:getComponentsByType("InputSource")
    for k, inputSource in pairs(inputSources) do
        local inputs = inputSource:updateAndGetInputs(dt)
        controller:setInputs(inputs)
    end
end

return ControlSystem