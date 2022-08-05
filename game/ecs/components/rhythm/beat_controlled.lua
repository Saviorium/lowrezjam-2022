return {
    name = "BeatControlled",
    type = "InputSource",

    beatTypeToListen = "beat1",
    inputToSend = "jump",

    updateAndGetInputs = function(self, dt)
        -- do nothing, but control system resets inputs in Controlled
    end,
}