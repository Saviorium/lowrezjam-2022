return {
    name = "ScoreCounter",
    score = 0,
    scorePerSucessInput = 1,
    scoreScale = 2,
    input = "startMove",

    addNextScore = function(self, entity)
        -- self.scorePerSucessInput = self.scorePerSucessInput * self.scoreScale
        -- self.score = self.score + math.floor(self.scorePerSucessInput)
        -- local color = config.colors.red
        -- if self.entity:getComponentByName('NormCombo') then
        --     color = config.colors.blue
        -- elseif self.entity:getComponentByName('GirlCombo') then 
        --     color = config.colors.purple
        -- elseif self.entity:getComponentByName('SmallCombo') then
        --     color = config.colors.green
        -- end
        -- self.inputHit = true
        self.inputHit = true
        -- require "game.ecs.prefabs.score_points" (entity.globalSystem, entity:getComponentByName("Position").position, self.scorePerSucessInput, color)
    end,

    dropScoreMultiplyer = function(self)
        self.inputLose = true 
    end
}