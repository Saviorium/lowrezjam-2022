local State = Class {
    init = function(self)
        self.name = "UNNAMED STATE"
        self.priority = 0
    end
}

function State:onEnter(entity, params)
    -- print("Switching to state", self.name)
end

function State:onExit(entity)
    -- print("Switching from state", self.name)
end

function State:update(entity, dt)
    -- print("Update state", self.name)
end

function State:tryToSwitchByTimeout(entity, params)
    if not self.timeout or not self.nextState then
        return
    end
    local stateMachine = entity:getComponentByName("StateMachine")
    if stateMachine.timeInState > self.timeout then
        stateMachine:goToState(self.nextState, params)
    end
end

function State:checkIfInputNearBeat(curBeat, targetBeat)
    return math.abs(curBeat - targetBeat) < config.music.rhythmHitTolerance
end

return State