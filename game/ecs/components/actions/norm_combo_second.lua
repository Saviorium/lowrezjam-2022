return { -- abstract action
    name = "NormComboSecond",
    type = "Action",
    oneShot = true, -- run on the first frame of input or every frame
    input = 'startMove',
    entity = nil,
    beatsToNextDanceMove = 2,

    canUse = function(self)
        local condition = self.entity:getComponentByName("StateMachine").currentState.name == 'norm_vamp_combo_first' 
                      and self.entity:getComponentByName("BeatControlled").beatsBeforeInput == self.beatsToNextDanceMove 
        if not condition then
            self.entity:getComponentByName('ScoreCounter'):dropScoreMultiplyer()
        end
        return condition
    end,

    onActive = function(self)
        local stateMachine = self.entity:getComponentByName("StateMachine")
        if stateMachine.currentState then
            self.entity:getComponentByName('ScoreCounter'):addNextScore(self.entity)
            stateMachine:goToState("norm_vamp_combo_second", {input = self.input})
        end
    end
}