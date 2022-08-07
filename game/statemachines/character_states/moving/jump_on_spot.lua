local CharacterState = require "game.statemachines.default_character_state"
local State = require "game.statemachines.state"

local JumpOnSpot = Class {
    __includes = State,
    init = function(self)
        State.init(self)
        self.name = "jump_on_spot"
        self.timeout = 5 * FRAME
        self.nextState = "idle"

        self.inputController = nil
    end
}

function JumpOnSpot:onEnter(entity, params)
    -- local animator = entity:getComponentByName("Animator").animator
    -- animator:setVariable("state", "dash_back_active")
    self.inputController = entity:getComponentByName('Controlled')
end

function JumpOnSpot:onExit(entity)
end

function JumpOnSpot:update(entity, dt)
    local stateMachine = entity:getComponentByName("StateMachine")
    self.inputController.inputSnapshot.move.y = -1

    self:tryToSwitchByTimeout(entity)
end

return JumpOnSpot