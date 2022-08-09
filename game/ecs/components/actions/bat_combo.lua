return { -- abstract action
    name = "BatCombo",
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
            stateMachine:goToState("bat_combo_first", {input = self.input})
        end
    end
}