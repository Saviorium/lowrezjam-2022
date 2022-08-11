local CharacterState = require "game.statemachines.default_character_state"
local State = require "game.statemachines.state"

local SmallVampCombo = Class {
    __includes = State,
    init = function(self)
        State.init(self)
        self.name = "small_vamp_combo_first"
        self.timeoutInBeats = 5
        self.nextState = "idle"

        self.inputController = nil
        self.beatsFromLastInput = 0
    end
}

function SmallVampCombo:onEnter(entity, params)
    -- local animator = entity:getComponentByName("Animator").animator
    -- animator:setVariable("state", "dash_back_active")
    self.beat = 0
    self.beatsToNextDanceMove = 1
    self.nextDanceMove = "small_vamp_combo_second"
    self.input = params.input

    self.inputController = entity:getComponentByName('Controlled')
    self.beatControlled = entity:getComponentByName("BeatControlled")
    self.scoreCounter = entity:getComponentByName("ScoreCounter")
    self.scoreCounter:addNextScore(entity)
end

function SmallVampCombo:update(entity, dt)

    local stateMachine = entity:getComponentByName("StateMachine")
    local beatsFromLastInput = self.beatControlled.beatsFromLastInput or 0

    if self.inputController.inputSnapshot[self.input] == 1 and self:checkIfInputNearBeat(self.beatsFromLastInput, self.beatsToNextDanceMove) then

        self.scoreCounter:addNextScore(entity)
        stateMachine:goToState(self.nextDanceMove, {input = self.input})
    elseif self.inputController.inputSnapshot[self.input] == 1 then
        self.scoreCounter:dropScoreMultiplyer()
    end 

    if self.beat > self.timeoutInBeats then
        stateMachine:goToState(self.nextState, params)
    end
    self.beatsFromLastInput = self.beatControlled.beatsFromLastInput or 0
    self.beat = self.beat + (self.beatControlled.beatDelta or 0)

end

return SmallVampCombo