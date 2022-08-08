local CharacterState = require "game.statemachines.default_character_state"
local State = require "game.statemachines.state"

local JumpInRandomDirection = Class {
    __includes = State,
    init = function(self)
        State.init(self)
        self.name = "jump_in_random_direction"
        self.timeout = 5 * FRAME
        self.timeoutInBeats = 2
        self.nextState = "idle"

        self.randomMoveDistance = config.randomMoveDistance
        self.direction = nil
        self.inputController = nil
    end
}

function JumpInRandomDirection:onEnter(entity, params)
    -- local animator = entity:getComponentByName("Animator").animator
    -- animator:setVariable("state", "dash_back_active")
    self.timeoutInBeats = params.timeoutInBeats or 2

    self.direction = nil
    self.inputController = entity:getComponentByName('Controlled')
    self.beatControlled = entity:getComponentByName("BeatControlled")
end

function JumpInRandomDirection:onExit(entity)
end

function JumpInRandomDirection:update(entity, dt)
    local stateMachine = entity:getComponentByName("StateMachine")
    self.direction = self.direction or Vector(love.math.random(-1,1), -1)
    self.inputController.inputSnapshot.move.x = self.direction.x
    self.inputController.inputSnapshot.move.y = self.direction.y

    if self.beatControlled.beatsFromLastInput > self.timeoutInBeats then
        stateMachine:goToState(self.nextState, params)
    end
end

return JumpInRandomDirection