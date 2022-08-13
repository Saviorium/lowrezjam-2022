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

    if score.inputLose and not score.inputHit then
        score.scorePerSucessInput = 1
    end
    score.inputHit = false
    score.inputLose = false

    if entity:getComponentByName("BeatControlled").offBeatHappened then
        score:dropScoreMultiplyer()
        entity:getComponentByName("BeatControlled").offBeatHappened = false
    end
end

function ScoreSystem:draw()
end

return ScoreSystem