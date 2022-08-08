local CharacterState = require "game.statemachines.default_character_state"
local State = require "game.statemachines.state"

local GirlVampCombo = Class {
    __includes = State,
    init = function(self)
        State.init(self)
        self.name = "girl_vamp_combo"
        self.timeout = 5 * FRAME
        self.timeoutInBeats = 4
        self.nextState = "idle"

        self.randomMoveDistance = config.randomMoveDistance
        self.direction = nil
        self.inputController = nil
    end
}

function GirlVampCombo:onEnter(entity, params)
    -- local animator = entity:getComponentByName("Animator").animator
    -- animator:setVariable("state", "dash_back_active")
    self.direction = Vector(love.math.random(-1,1), 1)
    self.inputController = entity:getComponentByName('Controlled')
    self.beatControlled = entity:getComponentByName("BeatControlled")
end

function GirlVampCombo:onExit(entity)
end

function GirlVampCombo:update(entity, dt)
    local stateMachine = entity:getComponentByName("StateMachine")

    self.inputController.inputSnapshot.move.x = self.direction.x
    self.inputController.inputSnapshot.move.y = self.direction.y

    if self.beatControlled.beatsFromLastInput > self.timeoutInBeats then
        stateMachine:goToState(self.nextState)
    end
end

return GirlVampCombo