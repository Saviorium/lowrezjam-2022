local CharacterState = require "game.statemachines.default_character_state"
local State = require "game.statemachines.state"

local MoveInRandomDirection = Class {
    __includes = State,
    init = function(self)
        State.init(self)
        self.name = "move_in_random_direction"
        self.timeout = 15 * FRAME
        self.timeoutInBeats = 2
        self.nextState = "idle"

        self.randomMoveDistance = config.randomMoveDistance
        self.direction = nil
        self.inputController = nil
    end
}

function MoveInRandomDirection:onEnter(entity, params)
    -- local animator = entity:getComponentByName("Animator").animator
    -- animator:setVariable("state", "dash_back_active")
    self.timeoutInBeats = params and params.timeoutInBeats or 2

    self.direction = nil
    self.inputController = entity:getComponentByName('Controlled')
    self.beatControlled = entity:getComponentByName("BeatControlled")
end

function MoveInRandomDirection:onExit(entity)
end

function MoveInRandomDirection:update(entity, dt)
    local stateMachine = entity:getComponentByName("StateMachine")
    self.direction = self.direction or Vector(love.math.random(-1,1), 0)
    self.inputController.inputSnapshot.move.x = self.direction.x
    -- self.inputController.inputSnapshot.move.y = directionVector:normalized().y

    if self.beatControlled.beatsFromLastInput > self.timeoutInBeats then
        stateMachine:goToState(self.nextState, params)
    end
end

return MoveInRandomDirection