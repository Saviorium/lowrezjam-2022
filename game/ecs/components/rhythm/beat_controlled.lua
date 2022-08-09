return {
    name = "BeatControlled",
    type = "InputSource",

    beatMap = {listen = "beat1", send = "jump"},

    updateAndGetInputs = function(self, dt)
        -- do nothing, but control system resets inputs in Controlled
    end,
}