local CharacterState = require "game.statemachines.default_character_state"

local MoveFromEnemy = Class {
    __includes = CharacterState,
    init = function(self)
        CharacterState.init(self)
        self.name = "move_to_origin"
        self.timeout = 3 * FRAME
        self.nextState = "idle"
        self.canBlock = true
        self.canAttack = true
        self.recoverStamina = true

        self.enemy = nil
        self.origin = nil
        self.minLen = config.minDistanceBetweenCharacters
        self.inputController = nil
    end
}

function MoveFromEnemy:onEnter(entity, params)
    local animator = entity:getComponentByName("Animator").animator
    animator:setVariable("state", "dash_back_active")

    self.enemy = entity:getComponentByName('Enemy').enemy
    self.inputController = entity:getComponentByName('Controlled')

    self.origin = entity:getComponentByName('Origin').position
end

function MoveFromEnemy:onExit(entity)
end

function MoveFromEnemy:update(entity, dt)
    local stateMachine = entity:getComponentByName("StateMachine")
    local directionVector = self.origin - entity:getComponentByName("Position").position
    self.inputController.inputSnapshot.move.x = directionVector:normalized().x

    if directionVector:len() < self.minLen then
        stateMachine:goToState(self.nextState)
    end
end

return MoveFromEnemy