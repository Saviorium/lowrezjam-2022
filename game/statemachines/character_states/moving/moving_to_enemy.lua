local CharacterState = require "game.statemachines.default_character_state"

local MoveToEnemy = Class {
    __includes = CharacterState,
    init = function(self)
        CharacterState.init(self)
        self.name = "move_to_enemy"
        self.timeout = 3 * FRAME
        self.nextState = "first_attack_startup"
        self.canBlock = true
        self.canAttack = true
        self.recoverStamina = true

        self.enemy = nil
        self.minLen = config.minDistanceBetweenCharacters
        self.inputController = nil

    end
}

function MoveToEnemy:onEnter(entity, params)
    local animator = entity:getComponentByName("Animator").animator
    animator:setVariable("state", "dash_forward_active")

    self.enemy = entity:getComponentByName('Enemy').enemy
    self.inputController = entity:getComponentByName('Controlled')
end

function MoveToEnemy:onExit(entity)
end

function MoveToEnemy:update(entity, dt)
    local stateMachine = entity:getComponentByName("StateMachine")
    -- print(entity.id, stateMachine.name, stateMachine.timeInState)
    local directionVector = self.enemy:getComponentByName("Position").position - entity:getComponentByName("Position").position
    self.inputController.inputSnapshot.move.x = directionVector:normalized().x
    if directionVector:len() < self.minLen then
        local dirStr = "forward"
        if directionVector:normalized().x < 0
        or directionVector:normalized().x > 0 and entity:getComponentByName("Flipped").flipped then
            dirStr = "back"
        end
        stateMachine:goToState(self.nextState, {direction = dirStr})
    end
end

return MoveToEnemy