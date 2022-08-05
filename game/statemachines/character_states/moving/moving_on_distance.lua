local CharacterState = require "game.statemachines.default_character_state"

local MoveOnDistance = Class {
    __includes = CharacterState,
    init = function(self)
        CharacterState.init(self)
        self.name = "move_on_distance"
        self.timeout = 3 * FRAME
        self.nextState = "idle"
        self.canBlock = true
        self.canAttack = true
        self.recoverStamina = true

        self.target = nil
        self.minLen = 50
    end
}

function MoveOnDistance:onEnter(entity, params)
    local animator = entity:getComponentByName("Animator")
    -- set animator state

    self.inputController = entity:getComponentByName('Controlled')
    self.target = entity:getComponentByName("Position").position + params.distance
end

function MoveOnDistance:onExit(entity)
end

function MoveOnDistance:update(entity, dt)
    local stateMachine = entity:getComponentByName("StateMachine")
    local directionVector = self.target - entity:getComponentByName("Position").position
    self.inputController.inputSnapshot.move.x = directionVector:normalized().x

    if directionVector:len() < self.minLen then
        stateMachine:goToState(self.nextState)
    end
end

return MoveOnDistance