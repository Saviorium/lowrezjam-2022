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
        if stateMachine.currentState then
            stateMachine:goToState("start_combo", {beatsToNextDanceMove = 2, nextDanceMove = 'move_in_random_direction', input = self.input})
        end
    end
}