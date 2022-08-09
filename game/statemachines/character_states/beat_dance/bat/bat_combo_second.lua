local CharacterState = require "game.statemachines.default_character_state"
local State = require "game.statemachines.state"

local BatCombo = Class {
    __includes = State,
    init = function(self)
        State.init(self)
        self.name = "bat_combo_second"
        self.timeoutInBeats = 5
        self.nextState = "idle"

    end
}

function BatCombo:onEnter(entity, params)
    -- local animator = entity:getComponentByName("Animator").animator
    -- animator:setVariable("state", "dash_back_active")
    self.beat = 0
    self.input = params.input

    self.inputController = entity:getComponentByName('Controlled')
    self.beatControlled = entity:getComponentByName("BeatControlled")
end

function BatCombo:update(entity, dt)
    
    local stateMachine = entity:getComponentByName("StateMachine")

    self.direction = self.direction or Vector(love.math.random(-1,1), love.math.random(-1,1))
    self.inputController.inputSnapshot.move.x = self.direction.x
    self.inputController.inputSnapshot.move.y = self.direction.y

    if self.beat > self.timeoutInBeats then
        stateMachine:goToState(self.nextState, params)
    end

    self.beat = self.beat + (self.beatControlled.beatDelta or 0)

end

return BatCombo