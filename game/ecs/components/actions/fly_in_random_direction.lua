return { -- abstract action
    name = "FlyInRandomDirection",
    type = "Action",
    oneShot = false, -- run on the first frame of input or every frame
    input = 'startMove',
    entity = nil,
    staminaNeeded = 0,

    canUse = function(self)
        return true
    end,

    onActive = function(self)
        local stateMachine = self.entity:getComponentByName("StateMachine")
        if stateMachine.currentState then
            stateMachine:goToState("fly_in_random_direction")
        end
    end
}