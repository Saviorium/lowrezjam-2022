local CharacterState = require "game.statemachines.default_character_state"
local State = require "game.statemachines.state"

local StartCombo = Class {
    __includes = State,
    init = function(self)
        State.init(self)
        self.name = "start_combo"
        self.timeout = 5
        self.timeoutInBeats = 5
        self.nextState = "idle"

        self.inputController = nil
        self.beat = 0
    end
}

function StartCombo:onEnter(entity, params)
    -- local animator = entity:getComponentByName("Animator").animator
    -- animator:setVariable("state", "dash_back_active")
    self.beatsToNextDanceMove = params.beatsToNextDanceMove
    self.nextDanceMove = params.nextDanceMove
    self.input = params.input

    self.inputController = entity:getComponentByName('Controlled')
    self.beatControlled = entity:getComponentByName("BeatControlled")
end

function StartCombo:update(entity, dt)
    --print(self.beatControlled.beatsFromLastInput)
    local stateMachine = entity:getComponentByName("StateMachine")

    if self.inputController.inputSnapshot[self.input] == 1 and self:checkIfInputNearBeat(self.beat, self.beatsToNextDanceMove) then
        stateMachine:goToState(self.nextDanceMove, params)
    end 

    if self.beatControlled.beatsFromLastInput > self.timeoutInBeats then
        stateMachine:goToState(self.nextState, params)
    end
    self.beat = self.beatControlled.beatsFromLastInput or 0

end

function StartCombo:checkIfInputNearBeat(curBeat, targetBeat)
    return math.abs(curBeat - targetBeat) < config.music.rhythmHitTolerance
end

return StartCombo