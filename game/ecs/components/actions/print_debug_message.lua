return {
    name = "PrintDebugMessage",
    type = "Action",
    oneShot = true, -- run on the first frame of input or every frame
    input = 'startMove',
    entity = nil,
    staminaNeeded = 0,

    canUse = function(self)
        return true
    end,

    onActive = function(self)
        -- print("Beat!")
    end
}