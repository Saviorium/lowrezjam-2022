local State = require "game.statemachines.state"

local Idle = Class {
    __includes = State,
    init = function(self)
        State.init(self)
        self.name = "idle"
        self.timeout = 0.3

        self.timerToLeave = 10

    end
}

function Idle:onEnter(entity, params)
    -- self:changeCollider(entity)
    -- local animator = entity:getComponentByName("Animator").animator
    -- animator:setVariable("state", "idle")
    -- -- Find enemy
    -- for ind, obj in pairs(entity.globalSystem.objects) do
    --     local selfTeam, otherTeam = entity:getComponentByName('Team'), obj:getComponentByName('Team')
    --     if (selfTeam and otherTeam) and selfTeam.team ~= otherTeam.team then
    --         self.enemy = obj
    --     end
    -- end

    -- self.origin = entity:getComponentByName('Origin').position
end

function Idle:update(entity, dt)
    self:tryToSwitchByTimeout(entity)
end
return Idle