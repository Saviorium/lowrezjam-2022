return { -- abstract action
    name = "GirlCombo",
    type = "Action",
    oneShot = false, -- run on the first frame of input or every frame
    input = 'startMove',
    entity = nil,

    canUse = function(self)
        return true
    end,

    onActive = function(self)
        local stateMachine = self.entity:getComponentByName("StateMachine")
        if stateMachine.currentState and stateMachine.currentState.name == 'idle' then
            stateMachine:goToState("girl_vamp_combo_first")
        end
    end
}