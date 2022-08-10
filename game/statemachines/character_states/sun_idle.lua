local State = require "game.statemachines.state"

local SunIdle = Class {
    __includes = State,
    init = function(self)
        State.init(self)
        self.name = "sun_idle"
        self.nextState = "sun_rise"
        self.timeout = 0.3

        self.timerToLeave = 1

    end
}

function SunIdle:onEnter(entity, params)
end

function SunIdle:update(entity, dt)
    local stateMachine = entity:getComponentByName("StateMachine")

    self.timerToLeave = self.timerToLeave - dt
    if self.timerToLeave < 0 then
        stateMachine:goToState(self.nextState, params)
    end
end
return SunIdle