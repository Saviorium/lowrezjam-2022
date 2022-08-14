return { -- abstract action
    name = "NormCombo",
    type = "Action",
    oneShot = true, -- run on the first frame of input or every frame
    input = 'startMove',
    entity = nil,
    beatsToNextDanceMove = 1,

    canUse = function(self)
        local condition = self.entity:getComponentByName("StateMachine").currentState.name == 'idle'
        if not condition then
            self.entity:getComponentByName('ScoreCounter'):dropScoreMultiplyer()
        end
        return condition
    end,

    onActive = function(self)
        local stateMachine = self.entity:getComponentByName("StateMachine")
        if stateMachine.currentState then
            -- self.entity:getComponentByName('ScoreCounter'):addNextScore(self.entity)
            self.entity:getComponentByName('ScoreCounter'):keepScore(self.entity)
            stateMachine:goToState("norm_vamp_combo_first", {input = self.input})
        end
    end
}