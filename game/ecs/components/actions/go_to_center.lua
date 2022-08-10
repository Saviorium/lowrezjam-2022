return { -- abstract action
    name = "GoToCenter",
    type = "Action",
    oneShot = false, -- run on the first frame of input or every frame
    input = 'hide',
    entity = nil,

    canUse = function(self)
        return true
    end,

    onActive = function(self)
        local stateMachine = self.entity:getComponentByName("StateMachine")
        if stateMachine.currentState then
            stateMachine:goToState("move_in_center")
        end
    end
}