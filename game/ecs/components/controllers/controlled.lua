return {
    name = "Controlled",
    inputSnapshot = {},

    getBlankInputs = function()
        return {
            move = Vector(0, 0),
            attack1 = 0,
            jump = 0,
            startMove = 0,
        }
    end,

    reset = function(self)
        self.inputSnapshot = self.getBlankInputs()
    end,

    setInputs = function(self, snapshot)
        if not snapshot then return end

        for k, v in pairs(self.inputSnapshot) do
            local newValue = snapshot[k]
            if type(newValue) == "table" then
                self.inputSnapshot[k] = (self.inputSnapshot[k] + newValue):normalized()
            elseif type(newValue) == "number" then
                self.inputSnapshot[k] = self.inputSnapshot[k] + math.clamp(0, newValue, 1)
            end
        end
    end,
}