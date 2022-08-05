return {
    name = "PrintDebugMessage",
    type = "MovingManager", -- TODO: action system

    update = function (self, dt, entity)
        local inputs = entity:getComponentByName("Controlled").inputSnapshot
        local keysPressed = Utils.count(inputs, function(v) return type(v) == "number" and v>0 end)
        if keysPressed < 1 then return end

        print("Beat!")
    end
}