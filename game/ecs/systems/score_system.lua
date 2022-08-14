local System = require "game.ecs.systems.system"

local ScoreSystem = Class {
    __includes = System,
    init = function(self, globalSystem)
        System.init(self, {'ScoreCounter'})
        self.overallScore = 0
        self.globalSystem = globalSystem
        self.currentScore = 1
        self.scoreMultiplyer = 2
        self.scoreIncrease = 1
    end
}

function ScoreSystem:update(dt)

    local needToRiseScore = false
    -- local currentMulti = 1
    local currentIncrease = 0
    local needToDropMulti = false
    for _, entity in pairs(self.pool) do
        local score = entity:getComponentByName("ScoreCounter")

        if score.inputLose and not score.inputHit then
            needToDropMulti = true
        elseif score.inputHit then
            needToRiseScore = true

            if score.increaseMultiplier then
                -- currentMulti = self.scoreMultiplyer
                currentIncrease = self.scoreIncrease
            end
            local color = config.colors.red
            if entity:getComponentByName('NormCombo') then
                color = config.colors.blue
            elseif entity:getComponentByName('GirlCombo') then 
                color = config.colors.purple
            elseif entity:getComponentByName('SmallCombo') then
                color = config.colors.green
            end

            require "game.ecs.prefabs.score_points" (entity.globalSystem, entity:getComponentByName("Position").position, self.currentScore, color)
        
            self.overallScore = self.overallScore + math.floor(( self.currentScore ))
        end
        score.inputHit = false
        score.inputLose = false
        score.increaseMultiplier = false

        if entity:getComponentByName("BeatControlled").offBeatHappened then
            score:dropScoreMultiplyer()
            entity:getComponentByName("BeatControlled").offBeatHappened = false
        end
    end
    if needToRiseScore then
        self.currentScore = self.currentScore + currentIncrease--* currentMulti
        -- currentMulti = 1
        currentIncrease = 0
    elseif needToDropMulti then
        self.currentScore = 1
    end
end

function ScoreSystem:draw()
end

return ScoreSystem