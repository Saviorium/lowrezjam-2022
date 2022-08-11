local System = require "game.ecs.systems.system"

local ScoreSystem = Class {
    __includes = System,
    init = function(self, globalSystem)
        System.init(self, {'ScoreCounter'})
        self.overallScore = 0
        self.globalSystem = globalSystem
    end
}

function ScoreSystem:handleUpdateEntityFunc(dt, entityId, entity)
    local score = entity:getComponentByName("ScoreCounter")
    -- score:update(dt)
    self.overallScore = self.overallScore + score.score
end

function ScoreSystem:draw()
end

return ScoreSystem