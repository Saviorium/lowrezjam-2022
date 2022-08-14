return {
    name = "OnDeathDo",
    type = "DeathTrigger",
    cause = "any",
    onDeathTrigger = function(self, entity)
        print("I'am dead!")
    end,

    update = nil,
}