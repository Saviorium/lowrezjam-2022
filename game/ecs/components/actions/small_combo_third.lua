return { -- abstract action
    name = "SmallComboThird",
    type = "Action",
    oneShot = true, -- run on the first frame of input or every frame
    input = 'startMove',
    entity = nil,
    beatsToNextDanceMove = 1,

    canUse = function(self)
        local condition = self.entity:getComponentByName("StateMachine").currentState.name == 'small_vamp_combo_second' 
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
            stateMachine:goToState("small_vamp_combo_third", {input = self.input})
        end
    end
}