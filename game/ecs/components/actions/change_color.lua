return { -- abstract action
    name = "ChangeColor",
    type = "Action",
    oneShot = false, -- run on the first frame of input or every frame
    input = 'startMove',
    entity = nil,
    color = {1,1,1,1},

    canUse = function(self)
        return true
    end,

    onActive = function(self)

        local inputController = self.entity:getComponentByName('Controlled')

        local colored = self.entity:getComponentByName("Colored")

        if inputController.inputSnapshot.beat1 == 1 then
            colored.color = config.colors.blue
        elseif inputController.inputSnapshot.beat2 == 1 then
            colored.color = config.colors.green
        elseif inputController.inputSnapshot.beat3 == 1 then
            colored.color = config.colors.red
        elseif inputController.inputSnapshot.beat4 == 1 then
            colored.color = config.colors.purple
        end
    end
}