local CharacterState = require "game.statemachines.default_character_state"
local State = require "game.statemachines.state"

local SmallVampCombo = Class {
    __includes = State,
    init = function(self)
        State.init(self)
        self.name = "small_vamp_combo_first"
        self.timeout = 5
        self.timeoutInBeats = 5
        self.nextState = "idle"

        self.beatsToNextDanceMove = 1
        self.nextDanceMove = 'small_vamp_combo_second'

        self.inputController = nil
        self.beat = 0
    end
}

function SmallVampCombo:onEnter(entity, params)
    self.input = params.input
    self.inputController = entity:getComponentByName('Controlled')
    self.beatControlled = entity:getComponentByName("BeatControlled")

end

function SmallVampCombo:update(entity, dt)

    local stateMachine = entity:getComponentByName("StateMachine")

    if self.inputController.inputSnapshot[self.input] == 1 and self:checkIfInputNearBeat(self.beat, self.beatsToNextDanceMove) then
        local position = entity:getComponentByName("Position")
        position.position.x = math.clamp(-config.worldSize.x, position.position.x + love.math.random(-1,1) * config.teleportDistance, config.worldSize.x)

        stateMachine:goToState(self.nextDanceMove, {input = self.input})
    end 

    if self.beatControlled.beatsFromLastInput > self.timeoutInBeats then
        stateMachine:goToState(self.nextState, params)
    end
    self.beat = self.beatControlled.beatsFromLastInput or 0

end

function SmallVampCombo:checkIfInputNearBeat(curBeat, targetBeat)
    return math.abs(curBeat - targetBeat) < config.music.rhythmHitTolerance
end

return SmallVampCombo