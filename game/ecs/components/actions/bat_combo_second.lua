return { -- abstract action
    name = "BatComboSecond",
    type = "Action",
    oneShot = true, -- run on the first frame of input or every frame
    input = 'startMove',
    entity = nil,
    beatsToNextDanceMove = 1,

    canUse = function(self)
        local condition = self.entity:getComponentByName("StateMachine").currentState.name == 'bat_combo_first' 
                      and self.entity:getComponentByName("BeatControlled").beatsBeforeInput == self.beatsToNextDanceMove 
        if not condition then
            self.entity:getComponentByName('ScoreCounter'):dropScoreMultiplyer()
        end
        return condition    
    end,

    onActive = function(self)
        local stateMachine = self.entity:getComponentByName("StateMachine")

        if stateMachine.currentState then
            self.entity:getComponentByName("ScoreCounter"):addNextScore(self.entity)
            stateMachine:goToState("bat_combo_second", {input = self.input})
        end
    end
}