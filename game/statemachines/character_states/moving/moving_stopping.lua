local CharacterState = require "game.statemachines.default_character_state"

local GettingUp = Class {
    __includes = CharacterState,
    init = function(self)
        CharacterState.init(self)
        self.name = "moving_stopping"
        self.timeout = 10 * FRAME
        self.nextState = "idle"
        self.priority = 5

        self.invincible = false
        self.canBlock = true
        self.canAttack = true
        self.recoverStamina = true
    end
}

function GettingUp:onEnter(entity, params)
    local animator = entity:getComponentByName("Animator").animator
    if params and params.direction then
        animator:setVariable("state", "dash_"..params.direction.."_recovery")
    end
end

function GettingUp:update(entity, dt)
    self:tryToSwitchByTimeout(entity)
end

return GettingUp