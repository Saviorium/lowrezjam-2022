local CharacterState = require "game.statemachines.default_character_state"
local State = require "game.statemachines.state"

local FlyInRandomDirection = Class {
    __includes = State,
    init = function(self)
        State.init(self)
        self.name = "fly_in_random_direction"
        self.timeout = 5 * FRAME
        self.nextState = "idle"

        self.randomMoveDistance = config.randomMoveDistance
        self.direction = nil
        self.inputController = nil
    end
}

function FlyInRandomDirection:onEnter(entity, params)
    -- local animator = entity:getComponentByName("Animator").animator
    -- animator:setVariable("state", "dash_back_active")
    self.direction = nil
    self.inputController = entity:getComponentByName('Controlled')
end

function FlyInRandomDirection:onExit(entity)
end

function FlyInRandomDirection:update(entity, dt)
    local stateMachine = entity:getComponentByName("StateMachine")
    self.direction = self.direction or Vector(love.math.random(-1,1), love.math.random(-1,1))
    self.inputController.inputSnapshot.move.x = self.direction.x
    self.inputController.inputSnapshot.move.y = self.direction.y

    self:tryToSwitchByTimeout(entity)
end

return FlyInRandomDirection