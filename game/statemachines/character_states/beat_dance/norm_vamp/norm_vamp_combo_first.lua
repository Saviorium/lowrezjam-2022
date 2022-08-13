local CharacterState = require "game.statemachines.default_character_state"
local State = require "game.statemachines.state"

local SmallVampCombo = Class {
    __includes = State,
    init = function(self)
        State.init(self)
        self.name = "norm_vamp_combo_first"
        self.timeoutInBeats = config.beatsForMove - 1
        self.nextState = "idle"

    end
}

function SmallVampCombo:onEnter(entity, params)
    self.beat = 0
    self.beatControlled = entity:getComponentByName("BeatControlled")

    local animator = entity:getComponentByName("Animator").animator
    animator:setVariable("state", "action")
    self.scoreCounter = entity:getComponentByName("ScoreCounter")
    self.scoreCounter:addNextScore(entity)

end


function SmallVampCombo:onExit(entity, params)
    local animator = entity:getComponentByName("Animator").animator
    animator:setVariable("state", "idle")
end

function SmallVampCombo:update(entity, dt)

    local stateMachine = entity:getComponentByName("StateMachine")
    
    if self.beat > self.timeoutInBeats then
        stateMachine:goToState(self.nextState, params)
    end

    self.beat = self.beat + (self.beatControlled.beatDelta or 0)

end

return SmallVampCombo