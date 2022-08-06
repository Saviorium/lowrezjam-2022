return {
    name = "DoOnBeat",
    type = "SyncToBeat",

    everyBeat = { 0 }, -- { 0, 0.5 } for 2 times every beat for exapmle
    barPoints = nil, -- { 1, 3 }

    onBeat = function(component, entity)
        print("I'm dancing!")
    end,
}