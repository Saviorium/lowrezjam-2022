local CharacterState = require "game.statemachines.default_character_state"
local State = require "game.statemachines.state"

local BatCombo = Class {
    __includes = State,
    init = function(self)
        State.init(self)
        self.name = "bat_combo_first"
        self.timeoutInBeats = 5
        self.beatsToNextDanceMove = 1
        self.nextDanceMove = "bat_combo_second"
        self.nextState = "idle"
        self.beatsFromLastInput = 0

    end
}

function BatCombo:onEnter(entity, params)
    -- local animator = entity:getComponentByName("Animator").animator
    -- animator:setVariable("state", "dash_back_active")
    self.beat = 0
    self.input = params.input

    self.inputController = entity:getComponentByName('Controlled')
    self.beatControlled = entity:getComponentByName("BeatControlled")
    self.scoreCounter = entity:getComponentByName("ScoreCounter")
    self.scoreCounter:addNextScore(entity)
end

function BatCombo:update(entity, dt)

    local stateMachine = entity:getComponentByName("StateMachine")

    if self.inputController.inputSnapshot[self.input] == 1 and self:checkIfInputNearBeat(self.beatsFromLastInput , self.beatsToNextDanceMove) then
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

return BatCombo