local CharacterState = require "game.statemachines.default_character_state"
local State = require "game.statemachines.state"

local FlyInRandomDirection = Class {
    __includes = State,
    init = function(self)
        State.init(self)
        self.name = "teleport_in_random_direction"
        self.timeout = 5 * FRAME
        self.timeoutInBeats = 2
        self.nextState = "idle"

        self.randomMoveDistance = config.randomMoveDistance

        self.teleportDistance = co
    end
}

function FlyInRandomDirection:onEnter(entity, params)
    -- local animator = entity:getComponentByName("Animator").animator
    -- animator:setVariable("state", "dash_back_active")

    self.beatControlled = entity:getComponentByName("BeatControlled")
end

function FlyInRandomDirection:update(entity, dt)
    local stateMachine = entity:getComponentByName("StateMachine")
    local position = entity:getComponentByName("Position")

    position.x = math.clamp(-config.worldSize.x, position.x + love.math.random(-1,1) * config.teleportDistance, config.worldSize.x)

    if self.beatControlled.beatsFromLastInput > self.timeoutInBeats then
        stateMachine:goToState(self.nextState, params)
    end
end

return FlyInRandomDirection