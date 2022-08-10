local CharacterState = require "game.statemachines.default_character_state"
local State = require "game.statemachines.state"

local SmallVampCombo = Class {
    __includes = State,
    init = function(self)
        State.init(self)
        self.name = "norm_vamp_combo_second"
        self.timeout = 5
        self.timeoutInBeats = 5
        self.nextState = "idle"

        self.beatsToNextDanceMove = 1
        self.nextDanceMove = 'norm_vamp_combo_third'

        self.inputController = nil
        self.beatsFromLastInput = 0
    end
}

function SmallVampCombo:onEnter(entity, params)
    self.beat = 0
    self.input = params.input
    self.inputController = entity:getComponentByName('Controlled')
    self.beatControlled = entity:getComponentByName("BeatControlled")
end

function SmallVampCombo:update(entity, dt)

    local stateMachine = entity:getComponentByName("StateMachine")

    if self.inputController.inputSnapshot[self.input] == 1 and self:checkIfInputNearBeat(self.beatsFromLastInput, self.beatsToNextDanceMove) then

        local houseFloorLevel = config.positions.houseFloorLevel
        local houseWidth = config.positions.houseWidth

        local yardLevel = config.positions.yardLevel
        local yardWidth = config.positions.yardWidth
        
        local unitHeight = 12
        local unistLevel = houseFloorLevel - unitHeight

        local position = entity:getComponentByName("Position")
        position.position.x = math.clamp(-config.worldSize.x + 2, position.position.x + love.math.random(-1,1) * config.teleportDistance, config.worldSize.x - 2)

        if position.position.x > yardWidth - 5 and position.position.x < houseWidth + yardWidth + 5 then
            position.position.y = unistLevel
        else
            position.position.y = yardLevel - unitHeight
        end

        stateMachine:goToState(self.nextDanceMove, {input = self.input})
    end 

    if self.beat > self.timeoutInBeats then
        stateMachine:goToState(self.nextState, params)
    end
    self.beatsFromLastInput = self.beatControlled.beatsFromLastInput or 0
    self.beat = self.beat + (self.beatControlled.beatDelta or 0)

end
return SmallVampCombo