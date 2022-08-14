return {
    name = "ScoreCounter",
    score = 0,
    scorePerSucessInput = 1,
    scoreScale = 2,
    input = "startMove",

    addNextScore = function(self, entity)
        self.inputHit = true
        self.increaseMultiplier = true
    end,
    keepScore = function(self, entity)
        self.inputHit = true
    end,

    dropScoreMultiplyer = function(self)
        self.inputLose = true 
    end
}