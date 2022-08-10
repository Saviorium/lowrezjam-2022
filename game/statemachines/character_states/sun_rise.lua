local State = require "game.statemachines.state"

local SunRise = Class {
    __includes = State,
    init = function(self)
        State.init(self)
        self.name = "sun_rise"
        self.nextState = "sun_down"
        self.timeout = 0.3

        self.timerToLeave = 10

    end
}

function SunRise:onEnter(entity, params)
end

function SunRise:update(entity, dt)
    local stateMachine = entity:getComponentByName("StateMachine")
    local position = entity:getComponentByName("Position")
    position.position.y = math.clamp(64, position.position.y - dt*config.sun.speed, 256) 

    self.timerToLeave = self.timerToLeave - dt
    if self.timerToLeave < 0 then
        stateMachine:goToState(self.nextState, params)
    end
end
return SunRise