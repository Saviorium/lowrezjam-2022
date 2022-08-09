return { -- abstract action
    name = "NormCombo",
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
            stateMachine:goToState("norm_vamp_combo_first", {input = self.input})
        end
    end
}