return { -- abstract action
    name = "ChangeColorSecond",
    type = "Action",
    oneShot = false, -- run on the first frame of input or every frame
    input = 'startMove',
    entity = nil,
    color = {1,1,1,1},

    canUse = function(self)
        return true
    end,

    onActive = function(self)
        local colored = self.entity:getComponentByName("Colored")
        colored.color = self.color
    end
}