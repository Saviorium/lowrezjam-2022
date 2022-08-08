local CharacterState = require "game.statemachines.default_character_state"
local State = require "game.statemachines.state"

local SmallVampCombo = Class {
    __includes = State,
    init = function(self)
        State.init(self)
        self.name = "small_vamp_combo_third"
        self.timeout = 5
        self.timeoutInBeats = 2
        self.nextState = "idle"

        self.inputController = nil
        self.beat = 0
    end
}

function SmallVampCombo:onEnter(entity, params)
    self.inputController = entity:getComponentByName('Controlled')
    self.beatControlled = entity:getComponentByName("BeatControlled")
end

function SmallVampCombo:update(entity, dt)

    if self.beatControlled.beatsFromLastInput > self.timeoutInBeats then
        stateMachine:goToState(self.nextState, params)
    end
    self.beat = self.beatControlled.beatsFromLastInput or 0

end


return SmallVampCombo