local CharacterState = require "game.statemachines.default_character_state"
local State = require "game.statemachines.state"

local MoveInRandomDirection = Class {
    __includes = State,
    init = function(self)
        State.init(self)
        self.name = "move_in_center"
        self.nextState = "idle"

        self.randomMoveDistance = config.randomMoveDistance
        self.direction = nil
        self.inputController = nil
        self.center = Vector(config.worldSize.x/2, config.positions.houseFloorLevel - 16)
        self.dist = love.math.random(50)
    end
}

function MoveInRandomDirection:onEnter(entity, params)
    -- local animator = entity:getComponentByName("Animator").animator
    -- animator:setVariable("state", "dash_back_active")

    local position = entity:getComponentByName("Position")
    self.direction = Vector(self.center.x - position.position.x , self.center.y - position.position.y)
    self.inputController = entity:getComponentByName('Controlled')
    self.beatControlled = entity:getComponentByName("BeatControlled")
end

function MoveInRandomDirection:onExit(entity)
end

function MoveInRandomDirection:update(entity, dt)
    local stateMachine = entity:getComponentByName("StateMachine")
    local velocity = entity:getComponentByName("Velocity")
    local position = entity:getComponentByName("Position")

    if position.position.x > config.positions.yardWidth/2 - 8 and position.position.x < config.positions.yardWidth or
       position.position.x > config.positions.yardWidth + config.positions.houseWidth and position.position.x < config.positions.yardWidth + config.positions.houseWidth - 1 + config.positions.rampWidth then
        self.inputController.inputSnapshot.move.y = (self.direction.y > 0 and 1 or -1) 
    end

    if math.abs(self.center.x - position.position.x) > self.dist  then
        self.inputController.inputSnapshot.move.x = (self.direction.x > 0 and 1 or -1) 
    end

    stateMachine:goToState(self.nextState, params)

end

return MoveInRandomDirection