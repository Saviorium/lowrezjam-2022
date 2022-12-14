local CharacterState = require "game.statemachines.default_character_state"
local State = require "game.statemachines.state"

local SmallVampCombo = Class {
    __includes = State,
    init = function(self)
        State.init(self)
        self.name = "small_vamp_combo_third"
        self.timeoutInBeats = config.beatsForMove - 3
        self.nextState = "idle"
    end
}

function SmallVampCombo:onEnter(entity, params)
    -- local animator = entity:getComponentByName("Animator").animator
    -- animator:setVariable("state", "dash_back_active")
    self.beat = 0
  
    self.direction = nil
    self.inputController = entity:getComponentByName('Controlled')
    self.beatControlled = entity:getComponentByName("BeatControlled")
end


function SmallVampCombo:update(entity, dt)
    local stateMachine = entity:getComponentByName("StateMachine")

    self.direction = self.direction or Vector(love.math.random(-1,1), 0)
    self.inputController.inputSnapshot.move.x = self.direction.x

    if self.beat > self.timeoutInBeats then
        stateMachine:goToState(self.nextState, params)
    end

    self.beat = self.beat + (self.beatControlled.beatDelta or 0)
end

return SmallVampCombo