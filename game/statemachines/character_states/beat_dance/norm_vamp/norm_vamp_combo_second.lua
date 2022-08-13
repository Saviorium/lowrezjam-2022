local CharacterState = require "game.statemachines.default_character_state"
local State = require "game.statemachines.state"

local SmallVampCombo = Class {
    __includes = State,
    init = function(self)
        State.init(self)
        self.name = "norm_vamp_combo_second"
        self.timeoutInBeats = config.beatsForMove - 2
        self.nextState = "idle"
    end
}

function SmallVampCombo:onEnter(entity, params)
    self.beat = 0
    self.inputController = entity:getComponentByName('Controlled')
    self.beatControlled = entity:getComponentByName("BeatControlled")

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
end

function SmallVampCombo:update(entity, dt)

    local stateMachine = entity:getComponentByName("StateMachine")

    if self.beat > self.timeoutInBeats then
        stateMachine:goToState(self.nextState, params)
    end

    self.beat = self.beat + (self.beatControlled.beatDelta or 0)

end
return SmallVampCombo