local CharacterState = require "game.statemachines.default_character_state"
local State = require "game.statemachines.state"

local GirlVampCombo = Class {
    __includes = State,
    init = function(self)
        State.init(self)
        self.name = "girl_vamp_combo_first"
        self.timeout = 5 * FRAME
        self.timeoutInBeats = 4
        self.nextState = "idle"

        self.randomMoveDistance = config.randomMoveDistance
        self.direction = nil
        self.inputController = nil
    end
}

function GirlVampCombo:onEnter(entity, params)
    local animator = entity:getComponentByName("Animator").animator
    animator:setVariable("state", "jump")
    self.beat = 0
    self.direction = Vector(love.math.random(-1,1), -1)
    self.inputController = entity:getComponentByName('Controlled')
    self.beatControlled = entity:getComponentByName("BeatControlled")

    self.inputController.inputSnapshot.move.x = self.direction.x
    self.inputController.inputSnapshot.move.y = self.direction.y

    entity:getComponentByName('Falling').isGrounded = false

    self.scoreCounter = entity:getComponentByName("ScoreCounter")
    self.scoreCounter:addNextScore(entity)
end

function GirlVampCombo:onExit(entity)
    local animator = entity:getComponentByName("Animator").animator
    animator:setVariable("state", "idle")
end

function GirlVampCombo:update(entity, dt)
    local stateMachine = entity:getComponentByName("StateMachine")
    local beatsFromLastInput = self.beatControlled.beatsFromLastInput or 0

    if self.beat > self.timeoutInBeats then
        stateMachine:goToState(self.nextState)
    end

    self.beat = self.beat + (self.beatControlled.beatDelta or 0)
end

return GirlVampCombo