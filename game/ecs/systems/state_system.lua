local System = require "game.ecs.systems.system"

local StateSystem = Class {
    __includes = System,
    init = function(self, globalSystem)
        System.init(self, {'StateMachine'})
        self.globalSystem = globalSystem
        self.freezeTime = 10 * FRAME
    end
}

function StateSystem:handleUpdateEntityFunc(dt, entityId, entity)
    local stateMachine = entity:getComponentByName("StateMachine")
    local freezeComp = entity:getComponentByName("Freezable")
    local timeComp = entity:getComponentByName("TimeDistortion")
    if freezeComp and freezeComp.freezeTimer > 0 then
        freezeComp.freezeTimer = freezeComp.freezeTimer - dt
        return
    end
    if timeComp and timeComp.timeSpeed then
        dt = dt * timeComp.timeSpeed
    end
    if stateMachine.__nextState then
        stateMachine:__switchState(stateMachine.__nextState.state, stateMachine.__nextState.params)
        stateMachine.__nextState = nil
    end
    stateMachine:update(dt)
    if freezeComp and freezeComp.freezed then
        freezeComp.freezeTimer = self.freezeTime
        freezeComp.freezed = false
    end
end

function StateSystem:draw()
end

return StateSystem