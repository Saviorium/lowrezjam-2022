return { -- abstract action
    name = "GirlCombo",
    type = "Action",
    oneShot = true, -- run on the first frame of input or every frame
    input = 'startMove',
    entity = nil,

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
            self.entity:getComponentByName('ScoreCounter'):addNextScore(self.entity)
            stateMachine:goToState("girl_vamp_combo_first")
        end
    end
}